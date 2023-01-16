Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA94566C552
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjAPQEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjAPQEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:04:11 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADF026583
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 08:02:50 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id i1so6226671pfk.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 08:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FaETKaG4apaYn3PDAXtUpXH3jZsRNdmxFYcvGW8yOZQ=;
        b=vgonzpsOgYGL3UNEUE2LNFypkHIJVKzE/qJdlhQ641+/LU1oMJE2dPymzLjV/QgVdx
         wL8+xQW23Rdf7r6HMEO25fSw/tlokvE6H2nr1b6b6/Q/ppaD2+6Ih42mx03VAb3BMd3D
         xp0i5yryfMrByjgr+I+m6JBCh3JWn7xADU+lSqe14Tjjma0AeopBXEEe+2xbIcK5pEPg
         TfYRNUfw3BiVAC/5DfP495xbHgFyA8CYidRr7Cl2SJ33FV+TCZqP2FS6V8iHHggks9wx
         5b4etbCFpwcFCSOF8rkOP0KZHMl0aoQFAW3wQzcxD7tJY9QuR4/TDRNWgF9f69KxBemu
         ofjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FaETKaG4apaYn3PDAXtUpXH3jZsRNdmxFYcvGW8yOZQ=;
        b=ztGW3sGIaQFTqhJzLrhGBsJVdGCeaA8ThzYcJjJTh/LifPS+EF5XztKA3eJf6Tsho5
         73gpZPyhfZKE1wtvjt4hYOq4INC0GVupIN1TAfKPDOD40RA9DtpZVpXWWra0dt8prhuW
         fXc6MUGR75qgJlqrutjevFMvbw9Iajtnf3KjeNz4V6643KzwBtE7uiGTfOLw4JZzlQgt
         wpz61GXz72TFP02UR2sEI+bxKeb3udP2jSS1tdyq3GFqv1mAwY7N9+tqimCCM4nwRTta
         SirOjanQp1qvPUT+fhihKLNt1QQkMBRw1i017lQQrVL/ZOJ4b8e4g37CPw/6HqdOptvJ
         xPQw==
X-Gm-Message-State: AFqh2koLH4GOKNNhP6WH1U3nn9Ie16ZS76wBokY01RzINM8aTagDtjji
        0rXHBZi5MUsO3GPq5py9cYG3PA==
X-Google-Smtp-Source: AMrXdXuIUz9FhPEQSjOKJJcqt2/o7PMFPNB/mOFw2WRvIORt2QaCYxSahy6LtKrW56KNifLo22ENrA==
X-Received: by 2002:a62:2741:0:b0:58d:bce0:2bdb with SMTP id n62-20020a622741000000b0058dbce02bdbmr105317pfn.7.1673884969367;
        Mon, 16 Jan 2023 08:02:49 -0800 (PST)
Received: from ?IPV6:2401:4900:1c60:63d3:2d69:9f71:187e:f085? ([2401:4900:1c60:63d3:2d69:9f71:187e:f085])
        by smtp.gmail.com with ESMTPSA id w125-20020a626283000000b005815a371177sm17678922pfb.52.2023.01.16.08.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 08:02:48 -0800 (PST)
Message-ID: <6f08d466-9589-ebff-c38d-bf9015a0f6ad@linaro.org>
Date:   Mon, 16 Jan 2023 21:32:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] dt-bindings: qcom: geni-se: Fix '#address-cells' &
 '#size-cells' related dt-binding error
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, andersson@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
References: <20230113201038.267449-1-bhupesh.sharma@linaro.org>
 <aef753a5-e8b1-5b7b-1b9e-e92a84de15bd@linaro.org>
 <CAH=2Ntx5rLWu4jzXV8DwKj+yweHPRqb4+Rv8uZpDn_brWDxyJg@mail.gmail.com>
 <b9aa6d30-5fe8-57a9-e478-c99bca70d185@linaro.org>
 <CAH=2Nty2gUL3DufowzHavhUNdeht2dcX4EU7ooM+xzax2vP7uQ@mail.gmail.com>
 <23b4551c-db79-d859-c037-6ed3c8a11883@linaro.org>
Content-Language: en-US
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <23b4551c-db79-d859-c037-6ed3c8a11883@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/16/23 9:24 PM, Konrad Dybcio wrote:
> 
> 
> On 16.01.2023 16:43, Bhupesh Sharma wrote:
>> On Mon, 16 Jan 2023 at 13:23, Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> On 15/01/2023 22:33, Bhupesh Sharma wrote:
>>>> On Sun, 15 Jan 2023 at 20:57, Krzysztof Kozlowski
>>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>>
>>>>> On 13/01/2023 21:10, Bhupesh Sharma wrote:
>>>>>> Fix the following '#address-cells' & '#size-cells' related
>>>>>> dt-binding error:
>>>>>>
>>>>>>     $ make dtbs_check
>>>>>>
>>>>>>     From schema: Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
>>>>>>          arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dtb: geniqup@4ac0000:
>>>>>>                #address-cells:0:0: 2 was expected
>>>>>>        From schema: Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
>>>>>
>>>>> Don't we want rather to unify the soc address range?
>>>>
>>>> Well, the assumption in the original dt-bindings was that every reg
>>>> variable is 4 * u32 wide (as most new qcom SoCs set #address- and
>>>> #size-cells to <2>). However, that is not the case for all of the
>>>> SoCs.
>>>
>>> Hm, which device of that SoC cannot be used with address/size cells 2?
>>
>> As noted in the git log already the geniqup on sm6115 / sm4250 cannot
>> be used with address/size cells 2 (See:
>> https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/qcom/sm6115.dtsi#L795)
> SM6115 (and pretty much every other arm64 msm platform newer than 8916)
> should be using addr/size-cells = 2 along with (dma-)ranges of 36 bit, as
> that's what their smmus use and otherwise some addresses may get cut off
> in translation, or so the story went with 845 N years ago.. We can either
> pursue this patch or I can submit the 2-cell-ification if you don't plan on
> adding more nodes shortly


Have you tested this combination on SM6115 like SoCs with various IPs? I 
have tried a few experiments in the past and not all IPs work well with 
36-bit DMA ranges (atleast not on the boards I have).

So, I think it might lead to more breakage (unless we are sure of a 
well-tested fix). A simpler patch to fix the dt-bindings looks more 
useful IMO.

Thanks,
Bhupesh
