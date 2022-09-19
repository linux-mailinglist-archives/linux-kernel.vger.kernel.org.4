Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED475BCB45
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiISL4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiISLzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:55:55 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534FD10AB
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:54:43 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id s6so35299648lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=bkOwhrrpc8oNDRuCmeCroBT1LYn4wRBl1NlqNZPhnbs=;
        b=fWiVCUymJp+oJEz4l+Kbz77BMlrliE/LcR5Ct+Trh9KuDUfs4XnX1vBgJkgjspbK/l
         JnxJkD03w60UB72e+JCe9PLffiZ+gb6dGBvLIFMKPyjy3qg0kXzB1usQfyicmCvU+lsn
         Jircj9RYJioFRE2Dpdi5pEwpLkesINNNQpLEPXvkKk1p32uEB4UzeXqqWIbwN32L09Rt
         FYgkFvVO9rcBsihr/q7g/0ZuGpV4R3KdwpqfIcNwz0s5zYVA1il0eRJXjwvOHn1V8M8D
         ImpeWz0f1Vk5q3ibw50b/LmlPUK2xjRIeqRahZqhZ+rI0WdaCQPdrUQjGgbifRa2ujes
         sOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=bkOwhrrpc8oNDRuCmeCroBT1LYn4wRBl1NlqNZPhnbs=;
        b=RjqGEtJKWoyWk90NdJe+y7ETdmLAlykGR1uSTCqr6D1FuCm3ZHpt6DYDX7X/GIzLvG
         4z24Nw2KWLzH0ZCMjLbOuT341SNzD0hVYqEgCH+eDA5Q75Yzqh4fld/jZJaoWUCnHf33
         YeZJPU2DzDfRRYPJupAPB9AwbmWGpahOr6B3j8Kyz+LYvZveE3XSIHnTgIadY+egFX/m
         h4LGeNk06joruvI4h7CCTs5BqF45eQveMOs0BgXLT++d+G3Yk9sinSZ06XvHh1IeiVQt
         c9gkpEXK2HmzZ15mpm/yhZ2vb0oGOxNFT9OtcvxqCqhR+PqapdgrlMIDVMO15ufKSe1Z
         2ZUw==
X-Gm-Message-State: ACrzQf1cK8DRBDKUoWxc8Gtk4esqX2KokvsR5OQiaz/eadDHBfMU8jZQ
        jeiBaTBuYnwKOZqbuqRXIhu0iA==
X-Google-Smtp-Source: AMsMyM5MhT3J95QrmGZ+gBmGOKTUMIN+6t28HzIOd9swgQf7w/3rvVotRvY7LkF1iCmxyo0bPAzn6Q==
X-Received: by 2002:a05:6512:1107:b0:49a:d211:bb3c with SMTP id l7-20020a056512110700b0049ad211bb3cmr5668318lfg.423.1663588481849;
        Mon, 19 Sep 2022 04:54:41 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id bq25-20020a056512151900b00492eb7205b0sm5152086lfb.210.2022.09.19.04.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 04:54:41 -0700 (PDT)
Message-ID: <e7a54dc0-0f4d-b4d9-ebe3-e6aaf1696ae1@linaro.org>
Date:   Mon, 19 Sep 2022 13:54:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH RFT v2 1/4] dt-bindings: soc: qcom: smd-rpm: add PMIC
 regulators nodes
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20220901093243.134288-1-krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220901093243.134288-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2022 11:32, Krzysztof Kozlowski wrote:
> The Qualcomm RPM over SMD contains devices for one or two PMIC
> regulators - already used in several DTS files.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

Hi Bjorn,

I guess no more tests/reviews will happen, so how about applying the
entire set?

Best regards,
Krzysztof
