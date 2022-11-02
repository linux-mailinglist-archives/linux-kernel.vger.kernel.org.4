Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B336616486
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 15:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiKBOKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 10:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiKBOKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:10:33 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747F91CFE5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 07:10:31 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id e15so7439584qts.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 07:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r3baLHNRjybhUwz1VU0EpNO+mXmWZFbwxaMY2qdvCTY=;
        b=DjhE16/tTUTVdFjgcA3BT/LtmSUuv28pvQFIpl8ORPofZEozhGnObHSwmFZBGObNSi
         hzZnR9IRHQEJYRfxDXJhI/YyjT04AnAq879/iczPm3+pr8+yKiNmP5yDXpFp32k5+ZAs
         O8M70dWjOzVfoF3c2vfzHE3lg39oneXBo3w0jrE5NFlvyPx4mxkZ89jQiWQX9a9qmyKc
         hA7tGLgXHI8MU1645wPN0iHjeTtd3N4wfLjierTYe49bPwE+EyBV4qw/tnkIKYPH3soO
         ZZGjcRoTzwLAyfVaNwKZ0Gg3P/weB5NYm9DWga6U7cSAOQGdYmAhdkyDuwvpma9kycDz
         cvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r3baLHNRjybhUwz1VU0EpNO+mXmWZFbwxaMY2qdvCTY=;
        b=wLuMLdl3HfJXnEECbueYEZiR51wGVFGWJJ3utqgYyFgKtBSDAtVmhv21RcQSavjPQx
         H5lPgIjtbn4e1wWoxSUna7JsKv336D4s+M3UZU+NoP7QU+UyFOUnpPNczLLHFYim10S+
         zPV+DFFfvJ1+BvNFvV5z5zMFHzEp8iaiZsee4LYGFNrg9u6UNiyZeu6keMksN+azbHRV
         GepeN3ivr49zUWLr2FGgZp9YQyF0tap+xOYOngUE+VlAVXtl8dox34ki8uLoqEnHmeVl
         lNauUp5xlycfa547G5IaOZGj6rNzdzWEkP5tZGmEJCmHoo/IBrAUvgxjrPx3vk8ERZY8
         UAvQ==
X-Gm-Message-State: ACrzQf3ChREzToufjoaUKQfzT1WRtJIP6ef3K+ml9KZYPs29dwixkF6D
        YHUvjeB63Z8DPdD3mR30sMOUUg==
X-Google-Smtp-Source: AMsMyM7AK3jlPObOnz/rPlu+Up2ji8ZFVw+pIdHlReQDzjpBxb2W96SkuyWtnj/IOe72KUZ9Bx+5tQ==
X-Received: by 2002:ac8:5d89:0:b0:3a4:f465:9434 with SMTP id d9-20020ac85d89000000b003a4f4659434mr19797213qtx.459.1667398230631;
        Wed, 02 Nov 2022 07:10:30 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:28d9:4790:bc16:cc93? ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id bs6-20020a05620a470600b006b61b2cb1d2sm8623326qkb.46.2022.11.02.07.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 07:10:30 -0700 (PDT)
Message-ID: <69d57d4e-8a43-f8f5-f491-916197f6f4a8@linaro.org>
Date:   Wed, 2 Nov 2022 10:10:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4 08/11] mfd: qcom-pm8xxx: drop unused PM8018 compatible
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andy Gross <agross@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220928-mdm9615-dt-schema-fixes-v4-0-dac2dfaac703@linaro.org>
 <20220928-mdm9615-dt-schema-fixes-v4-8-dac2dfaac703@linaro.org>
 <Y1/qnCyav/S35mRo@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y1/qnCyav/S35mRo@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2022 11:32, Lee Jones wrote:
> On Fri, 21 Oct 2022, Neil Armstrong wrote:
> 
>> The PM8018 compatible is always used with PM8921 fallback, so PM8018
>> compatible can be safely removed from device ID table
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Tags should appear chronologically.
> 

I would assume that as well, but `b4 trailers` disagrees. It documents
even this behavior (the chain of custody) here:
https://b4.docs.kernel.org/en/latest/config.html

So while I agree with you, I also prefer the tools to make the decision
instead of humans (to follow the process, assuming the tool implements
the process). Either the tool should be fixed or the tool's decision is
correct.

Best regards,
Krzysztof

