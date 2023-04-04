Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890B56D5809
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 07:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjDDFd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 01:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjDDFdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 01:33:54 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8318519BD
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 22:33:52 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b20so125860856edd.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 22:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680586431;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LSfvMCOrdSCg0KsTlmNTzh+wJyyn32F7jBR5XEIQXfs=;
        b=SZwSkMwcEttyesUKzaZlZS4UGLFXMY126tr9woNXYKUhFfJvL2DW/VmdxbXEZVKhq4
         Q8Pq5qlwwDErfIgKXJUIy0niHLAaBewg0qiRIG2Ea3WpDIcEC3HIHc1IACXyEIQcUvyO
         c2Zr8YwvcOOX6aVTroi7AImN1zOILzZ4YqJrVM/HXHIeJqxbaLqixzQTiaPy3uI4KW8z
         fWMLNaSOfu++mTiApTEXBctIvp/0ILa/2KaPKUr3ZGCLFKd7tQabv28XBN7YezNEXm6w
         dx/m0ehD2NIiIW7DwzPLa2F+gqKklDNfN+rcYmZAnyu7BNPoZGwWJLn+fvo1lxCE/umF
         vHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680586431;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LSfvMCOrdSCg0KsTlmNTzh+wJyyn32F7jBR5XEIQXfs=;
        b=M6VCIKHXU86du2p0wVqM1MJO4tjXVHJB333s8OYPHjphTplrH0xSI5q1Uwb81b5Yl6
         9nxPXNCbWz+fBeuCyO5Ji0PMoloqBngDljqQ8bA1WLbAEO9XGyQLQtnBmBoBTHZIRIUM
         x7Gg22sA2hFpbfwSlGVMkrwfJ8cWrTA7b64g2ckLt86v+jXQRGWO8Di9VHSNqaSEDtDz
         b+PVs7U02UOQEUgPO6hgpvAJOmgq1LJ/WDeg+jjjtcs/Zc9fX9JjiYej/Tc7p3p6ZP0J
         yEiAhy2T5/seIwLCImXoliy2thvf+/obWMltn5CsBinaVdFRbrMgSExGnvA6V3v+WpgV
         8ZFQ==
X-Gm-Message-State: AAQBX9cunWLpM9D0uTYcmCSgXKe3vqje6ASVRUk0P03sNggK35bPdvC4
        gkQL29o3mqEMPBrHE/VXMYpdEQ==
X-Google-Smtp-Source: AKy350a40YXsaP1RgtMOL5a6WR77TS6ARlPJXWLmm7+/lgqUoQ15z5r6n8YquYLchK+7NxQM/Zfl/Q==
X-Received: by 2002:aa7:cad9:0:b0:502:4875:721 with SMTP id l25-20020aa7cad9000000b0050248750721mr1233965edt.15.1680586430958;
        Mon, 03 Apr 2023 22:33:50 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:233a:5c18:b527:381e? ([2a02:810d:15c0:828:233a:5c18:b527:381e])
        by smtp.gmail.com with ESMTPSA id 28-20020a508e5c000000b004c13fe8fabfsm5387403edx.84.2023.04.03.22.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 22:33:50 -0700 (PDT)
Message-ID: <9c49e4a9-0792-bcae-506f-77b5874d4d19@linaro.org>
Date:   Tue, 4 Apr 2023 07:33:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V4 04/10] dt-bindings: timestamp: Add
 nvidia,gpio-controller
Content-Language: en-US
To:     Dipen Patel <dipenp@nvidia.com>, Rob Herring <robh@kernel.org>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        timestamp@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
        brgl@bgdev.pl, corbet@lwn.net, gregkh@linuxfoundation.org
References: <20230323012929.10815-1-dipenp@nvidia.com>
 <20230323012929.10815-5-dipenp@nvidia.com>
 <20230324171329.GA2062332-robh@kernel.org>
 <7f2dc5cf-78b5-81c6-0012-26b1adce1c86@nvidia.com>
 <19b71fef-614a-d678-2e73-95db8f226e61@linaro.org>
 <df00404e-96a8-bf33-cbc7-25dbb09c89c7@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <df00404e-96a8-bf33-cbc7-25dbb09c89c7@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2023 06:24, Dipen Patel wrote:
> On 3/25/23 4:09 AM, Krzysztof Kozlowski wrote:
>> On 24/03/2023 19:51, Dipen Patel wrote:
>>> On 3/24/23 10:13 AM, Rob Herring wrote:
>>>> On Wed, Mar 22, 2023 at 06:29:23PM -0700, Dipen Patel wrote:
>>>>> Introducing nvidia,gpio-controller property from Tegra234 SoCs onwards.
>>>>> This is done to help below case.
>>>>>
>>>>> Without this property code would look like:
>>>>> if (of_device_is_compatible(dev->of_node, "nvidia,tegra194-gte-aon"))
>>>>> 	hte_dev->c = gpiochip_find("tegra194-gpio-aon",
>>>>> 				   tegra_get_gpiochip_from_name);
>>>>> else if (of_device_is_compatible(dev->of_node, "nvidia,tegra234-gte-aon"))
>>>>> 	hte_dev->c = gpiochip_find("tegra234-gpio-aon",
>>>>> 				   tegra_get_gpiochip_from_name);
>>>>> else
>>>>> 	return -ENODEV;
>>>>
>>>> Or you just put the name in match data.
>>>
>>> Not sure I have understood this comment, but "name" the first argument is
>>> already there to supply to callback to match data. Also, this if else is
>>> needed to know which "name" to provide.
>>
>> The point is that of_device_is_compatible() do not really scale and make
>> code more difficult to read. Your variant-customization should in
>> general entirely come from match/driver data.
> 
> Perhaps I should not have mentioned driver related details here about how
> this property will help, that detail will go in driver patch. In the next
> patch series I will remove this commit and just focus on what this property
> is.

Regardless of this commit, driver match data is the way to go, not
of_device_is_compatible().



Best regards,
Krzysztof

