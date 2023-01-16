Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8822C66B878
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 08:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjAPHxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 02:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjAPHxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 02:53:33 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23F910A98
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 23:53:30 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id vw16so2911784ejc.12
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 23:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DmseeIxSoeTPNwAIYNdzjE6VKFzUfpsrISNk1TCIZ+w=;
        b=bThObufnnsl9N/5BExSiFUJZ0MnNBEK6P7AN5C98Dv/hfLATkDTY+MJF870bfHaQc/
         q4Qc1cdHSki6H0VGYZ23r9CAJVnzBF7yS3I2+JjGDquoHCZBSLCd2//+2AkObiIDtlEj
         3qp9vrolhzGPymZfgjsZkqI0XLqdo0HmzHL+FllsceQqw7SA54FgjLn5wC3Xk+3ARqi5
         yjmFIejdpHeFeKFezwQ1TyE6Ns1FXJ4nxVenEVZRM6upeLI0FUSGB4V4mJ4kUrov9NVp
         tbiAJUKZqpJrKbNl42mIIK+kFJ30oM41wk72KAJBDyXgD+btdUgBZ3InUlP+PdJYfWuH
         fKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DmseeIxSoeTPNwAIYNdzjE6VKFzUfpsrISNk1TCIZ+w=;
        b=WZiN1tpKgxGBgqBFhSBCFhgJHXAGDfYEDkKY8Zm7NY7fQw+aQfje9UMM0Ael0LrVag
         sg8eitoMeu55hDfVPVL3I07OMwSD8pTBgF5akDyXY+bMqd3gCQmAGgkeaofPqkf8DcB3
         mFW4FMIi96MJh4rzb7eWOnucCn30ozzlJVPQeu7YxEwsxVcNb9VR3OhCURJbUZwwHV5Z
         9BOcgFP8bXJrZ0b0mra3Tfa6ptZH0+/Gt+gy0pBmzo4tCdrir24icSnryF5yYsTKaiFn
         y0KxA+kugCQctJakZsHs0nzl92o46dJrjwlDx1EpxrkwtLiySGLvpogfDcNOJJXHVtrU
         jmgQ==
X-Gm-Message-State: AFqh2koQF5XSyrleYhIpSaPnConGQgPoKjbgSSC569rSbn+HYbJwz1ry
        r4D9ewlWccG0jf9TIWC/GDnxNg==
X-Google-Smtp-Source: AMrXdXsS61ABxahoG31xtx/AEi2XlUhGE0qIujWZxAIZoNlNlMbdpp8yAH63Loy0hTuZ425CCwdoMQ==
X-Received: by 2002:a17:907:6f09:b0:7c1:37:6d5e with SMTP id sy9-20020a1709076f0900b007c100376d5emr58478284ejc.2.1673855609156;
        Sun, 15 Jan 2023 23:53:29 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v17-20020a170906293100b007be301a1d51sm11430078ejd.211.2023.01.15.23.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 23:53:28 -0800 (PST)
Message-ID: <b9aa6d30-5fe8-57a9-e478-c99bca70d185@linaro.org>
Date:   Mon, 16 Jan 2023 08:53:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] dt-bindings: qcom: geni-se: Fix '#address-cells' &
 '#size-cells' related dt-binding error
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
References: <20230113201038.267449-1-bhupesh.sharma@linaro.org>
 <aef753a5-e8b1-5b7b-1b9e-e92a84de15bd@linaro.org>
 <CAH=2Ntx5rLWu4jzXV8DwKj+yweHPRqb4+Rv8uZpDn_brWDxyJg@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAH=2Ntx5rLWu4jzXV8DwKj+yweHPRqb4+Rv8uZpDn_brWDxyJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/2023 22:33, Bhupesh Sharma wrote:
> On Sun, 15 Jan 2023 at 20:57, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 13/01/2023 21:10, Bhupesh Sharma wrote:
>>> Fix the following '#address-cells' & '#size-cells' related
>>> dt-binding error:
>>>
>>>    $ make dtbs_check
>>>
>>>    From schema: Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
>>>         arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dtb: geniqup@4ac0000:
>>>               #address-cells:0:0: 2 was expected
>>>       From schema: Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
>>
>> Don't we want rather to unify the soc address range?
> 
> Well, the assumption in the original dt-bindings was that every reg
> variable is 4 * u32 wide (as most new qcom SoCs set #address- and
> #size-cells to <2>). However, that is not the case for all of the
> SoCs.

Hm, which device of that SoC cannot be used with address/size cells 2?
> 
> So, ideally we shouldn't set the  "#address-cells" and  "#size-cells":
> as const: 2 in the bindings.
> 
> See as an example:
> https://www.kernel.org/doc/Documentation/devicetree/bindings/usb/usb-device.yaml


How USB device - so entirely different device, not MMIO! - is related here?

Best regards,
Krzysztof

