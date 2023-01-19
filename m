Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBB2673610
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjASKvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjASKvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:51:03 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE88717BE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:50:31 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id e3so1410474wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cf7yICQO9NaAanq9Gf/a43Gbk/UV6UR1wALLIkbHGrw=;
        b=cR4nbnwlqsEA/NcHSP1YnS80mXVK+nQgb3VrQuZcccEcQxPZEyKt7ZtLkv0UDGGojh
         cYYDC0HPnWbE8gvK2QZjxb2rn4UF3xrDs1r1C/uSjDNSanRD6V0BU+wXolKci2iGJlbm
         C8jVyAf1YZi/oNNMHTnMbD/7j4L/2YS63F0XIT7HeMky0o43mX4CdUcB5FVC23Y+vd7G
         BTRaqZ6awjew/6HY5Zyrkdi1oNL7A+Oj4rAIVafQqrMI/z8JPTnUd1DhQr9IyQRXrWmm
         /u+9ADfL/rfd/Lm/47g+lj67XSaan8/8ACc/IxXy0s0oxsB11OLQhZdVdZXACoHHq76G
         Sbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cf7yICQO9NaAanq9Gf/a43Gbk/UV6UR1wALLIkbHGrw=;
        b=DyfkAr6Z8GnAioG6aBg7QjT3NfZtyvEMuJSQTlvwVt71Mv7hFOt7UHJIEjUOYjfM+6
         ZKmVZxq6G6v3ZbYd6ivzAvGQCE7+uoHuznKv7vhCvCmpDie8uxU2PXn5QVuIROgWkL1i
         gA7kHTRcV1Gd6cdf3BJJuqz13Pnx4PwONu8lkvCV//+c3NZ5T3IgXQD368LCwH8NxRJN
         K4ImpiZ8Kpw+UBGEk7XWrsjIkaND9m6KcLy+WApsLzZrD3xW1uRROzsgH3Zk5PZMDonJ
         F9hiCs1cXEpjsxB7WWLfCWZzGdcGTEpaRTVV/uqDem6uOeyNRJq2+qnd57XbOV22lI7B
         /DtA==
X-Gm-Message-State: AFqh2kpZ0CnP+2F0r+Zv5K2NPEj2RmGEEFIEnxufgDWI/kQMM408Tk4I
        cEDy9v1lGJYDv512zhE3QaFe2Q==
X-Google-Smtp-Source: AMrXdXs26D5JmZyw8QpqvpCU4DEz1mdnfomAHI/Qw37hNyTda9/pEjzWEsXixDvMSOMkrJV+gcBZRQ==
X-Received: by 2002:a5d:4588:0:b0:2bb:f255:6bb4 with SMTP id p8-20020a5d4588000000b002bbf2556bb4mr4607855wrq.25.1674125430385;
        Thu, 19 Jan 2023 02:50:30 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q11-20020adf9dcb000000b00268aae5fb5bsm34065801wre.3.2023.01.19.02.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 02:50:30 -0800 (PST)
Message-ID: <41b0c0cc-3ef5-362c-a09e-97a2ffca8e1f@linaro.org>
Date:   Thu, 19 Jan 2023 11:50:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v1] arm64: dts: qcom: sm8350: Use 2 interconnect cells
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>, agross@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@linaro.org,
        rfoss@kernel.org
Cc:     robert.foss@linaro.org
References: <20230117115712.1054613-1-rfoss@kernel.org>
 <167408614052.2989059.12874514471754492819.b4-ty@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <167408614052.2989059.12874514471754492819.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 00:55, Bjorn Andersson wrote:
> On Tue, 17 Jan 2023 12:57:11 +0100, rfoss@kernel.org wrote:
>> From: Robert Foss <robert.foss@linaro.org>
>>
>> Use two interconnect cells in order to optionally
>> support a path tag.
>>
>>
> 
> Applied, thanks!
> 
> [1/1] arm64: dts: qcom: sm8350: Use 2 interconnect cells
>       commit: 4f287e31ff5f464526651ee3cb3fd3e96b2e5746


I don't think this is correct patch. We talked that this must be rebased
on my interconnect cells change and I think it wasn't :(

Best regards,
Krzysztof

