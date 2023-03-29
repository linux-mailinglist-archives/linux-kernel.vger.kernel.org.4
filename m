Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B8C6CD84E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjC2LSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjC2LSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:18:36 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553C13C04
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:18:31 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id c29so19658922lfv.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680088709;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YE63NidFx/yTtTPvk37Lal5nBv6wxm6QBZTGRvkCvTg=;
        b=kqKLm9hEPjbAaiMW/vA3n3rLJ4Yz9F+d0e3MQudZxAzG/W4VgSnqhaz0X/s9K5TF4w
         UYLkkCjhgdGeVNkJdwjmm49QMobU9w4KviYlUkmeuOCFn1edv8IUtWaZnMgwVsYvV46m
         yL+14ogo6UGTe/FOm1IRJBkJnYUm3dZ0YvMKaW3qbs96QKFdn7z6IRjgJCdrtIFPNdKM
         9tHz/nxfmTKu+Pk8sQ0Xi/Rgi2u8zvkBrnHFXqqgyJRd+QZ3h4irDYNK1NGM/FrUkY5q
         HYuXvyoIucRt7lVfsE9s1db9UzBfSUvJWDURujO/pWCoqR1PgHNvEDsgyxSC2UoYDBwo
         Zwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680088709;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YE63NidFx/yTtTPvk37Lal5nBv6wxm6QBZTGRvkCvTg=;
        b=Z2fnIczAFlqE4w3A7RVH75N1Q+VYAeDlFl+eP4EGNk28nj+WiXQflroaSsyjL0I9N8
         8mEdmvZNC7l6FW5tLU//vfluW3ux0AtFniHCP15u3Bhbjj1UPEH1JZBrOxmF3gES+qUN
         C/VUlRT1IRiDJWH9gxmfhN8FeWyjud8pdhK883EFQXqaFxaE+afspiee2OfJR3JmRHo6
         7WZHoiyiMMwthLVjYkWhceCA7p/nz0eK7l54I4Lv3L9CUg5Jlz7Pj0CzDzhkAh9ci9kG
         ClfuJ4eRgG1KimInEwvGYWbCO+ssREQ2oAmjm76a7vP/2EOBAdWkTj9O7d53UjsOJbCj
         6Kog==
X-Gm-Message-State: AAQBX9etxbNilOT8IluvISRtr5sdd6WkYIfg1bt0bJC0L4SwnfpnXFWO
        zLjOlgxbOEt2ZvJJph7lb/AFow==
X-Google-Smtp-Source: AKy350Z8GKU4AU2KdYCK1slcantNvVo90kWFW6iZ4ZEr22+Djr/xSjIBarBjALD6mStuql2HM0fjXw==
X-Received: by 2002:ac2:5a4c:0:b0:4dd:a7ab:b148 with SMTP id r12-20020ac25a4c000000b004dda7abb148mr4794210lfn.49.1680088709555;
        Wed, 29 Mar 2023 04:18:29 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id n27-20020ac2491b000000b00498f67cbfa9sm5449770lfi.22.2023.03.29.04.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 04:18:29 -0700 (PDT)
Message-ID: <203a4b25-05ab-e12d-9fba-8bda385dda1b@linaro.org>
Date:   Wed, 29 Mar 2023 13:18:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/2] Resolve MPM register space situation
Content-Language: en-US
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230328-topic-msgram_mpm-v1-0-1b788a5f5a33@linaro.org>
 <20230329035859.GD3554086@dragon>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230329035859.GD3554086@dragon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.03.2023 05:58, Shawn Guo wrote:
> On Tue, Mar 28, 2023 at 12:02:51PM +0200, Konrad Dybcio wrote:
>> The MPM (and some other things, irrelevant to this patchset) resides
>> (as far as the ARM cores are concerned, anyway) in a MMIO-mapped region
>> that's a portion of the RPM (low-power management core)'s RAM, known
>> as the RPM Message RAM. Representing this relation in the Device Tree
>> creates some challenges, as one would either have to treat a memory
>> region as a bus, map nodes in a way such that their reg-s would be
>> overlapping, or supply the nodes with a slice of that region.
>>
>> This series implements the third option, by adding a qcom,rpm-msg-ram
>> property, which has been used for some drivers poking into this region
>> before. Bindings ABI compatibility is preserved through keeping the
>> "normal" (a.k.a read the reg property and map that region) way of
>> passing the register space.
>>
>> Example representation with this patchset:
>>
>> / {
>> 	[...]
>>
>> 	mpm: interrupt-controller {
>> 		compatible = "qcom,mpm";
>> 		qcom,rpm-msg-ram = <&apss_mpm>;
>> 		[...]
>> 	};
>>
>> 	[...]
>>
>> 	soc: soc@0 {
>> 		[...]
>>
>> 		rpm_msg_ram: sram@45f0000 {
>> 			compatible = "qcom,rpm-msg-ram", "mmio-sram";
>> 			reg = <0 0x045f0000 0 0x7000>;
>> 			#address-cells = <1>;
>> 			#size-cells = <1>;
>> 			ranges = <0 0x0 0x045f0000 0x7000>;
>>
>> 			apss_mpm: sram@1b8 {
>> 				reg = <0x1b8 0x48>;
> 
> Per "vMPM register map" in the driver, the slice size should be 0x44
> instead of 0x48.  Is there one register missing from the driver
> comment?
Yeah we should be using 0x44..

> 
> PS. It seems the "n" formula in the driver comment should be corrected
> as below.
> 
>   n = DIV_ROUND_UP(pin_cnt, 32) - 1
Or since we're counting from zero, the ENABLEn should become
ENABLE(n-1) etc.

Konrad

> 
> Shawn
> 
>> 			};
>> 		};
>> 	};
>> };
