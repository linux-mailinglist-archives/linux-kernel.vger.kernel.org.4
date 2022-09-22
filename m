Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E385E5B98
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiIVGpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiIVGpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:45:02 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E628DAB4CB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:45:00 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id b24so9788350ljk.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=lcMW9siO2K9k/7GoNIgCs128fwRhCIapUnYqKZjd/gk=;
        b=OfihJXUC4knLJVa+tCuvlyrXZ9whUMTHqErbH9kQ1QPD59CMktcZ4DxqyXPKq3MB/p
         wmRr89DwBakmVmalUIafzeMWW7vX34VJ/APAsAvQwAkgjgbLJWiDUqxH4/X+ovhPNmFF
         wMrzGDL/mipZBmfRX0rcuamtX9f9rUjqxDi6ZzvF8tup1zdrGYR6dtiEU9Ll//yJr4HV
         GjM7rwGh62YvnSGARDy6Gt4FDwg0h7YX20efC+wTlZ3BogM3k+4KjWamar3eeyah43fn
         A2Y7hTCqoNz2XoSHBUP+4FMfe/+xNEzA/x3ZW2QLLIOILFxBmzZRlPv4U8Vz0hrrHip/
         yuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lcMW9siO2K9k/7GoNIgCs128fwRhCIapUnYqKZjd/gk=;
        b=Vkcr1xrBgpfEvnPofhn8nzLth753+RKiPXLtHslWZwHHMoL1LJ35on3XFgLK37EYfi
         +CO7RSWlQZzQK8fhLtlBouUvHeBfoEBrawYB+q+/1L/2R2cyVF+FLkpwfiieQOWXBGx2
         hS0m1am3CY+I1SCrJUmunmcAa4o9JnmEpwggBveEJ11ZK5bAL8KZ27Azhu6GHtB7pvwu
         LLKMZa5kqHdj8C5/gGBmIhFrakDR+iasWn6ZFt/guIzbt0wwZqRypkvTv6JDyZVP3JQE
         cyXng1lUhQaDmjaT+Qg0GxB+vIs/Yf/rjU0s7hKPSy4hUu8AhLrQwqVe8XKSRs4wxslU
         Sc0A==
X-Gm-Message-State: ACrzQf3HaTv34xtQ9eCqi4fH9bTjX5gVfEM86/VmFHglEz1SF2L1IAZJ
        efdu0OvnQlL8gZt+DT44WPUkaQ==
X-Google-Smtp-Source: AMsMyM7zWnZz/7l4MiTD0GTeyoF1xr4RWtfp/Vh3ScwD/gEMWe/ecm5XNt9kuwES+WAG17pd1VJWcw==
X-Received: by 2002:a2e:b4ad:0:b0:26c:24f:b260 with SMTP id q13-20020a2eb4ad000000b0026c024fb260mr512009ljm.173.1663829099119;
        Wed, 21 Sep 2022 23:44:59 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id m23-20020ac24297000000b00499019c34a3sm776473lfh.184.2022.09.21.23.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 23:44:58 -0700 (PDT)
Message-ID: <e412810f-fd3e-1be9-3904-a684bfbeb9e2@linaro.org>
Date:   Thu, 22 Sep 2022 08:44:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 3/3] ARM: dts: qcom: msm8974: switch TCSR mutex to MMIO
Content-Language: en-US
To:     Alexey Minnekhanov <alexeymin@postmarketos.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220920150414.637634-1-krzysztof.kozlowski@linaro.org>
 <20220920150414.637634-4-krzysztof.kozlowski@linaro.org>
 <37ebdd21-e46a-fac9-7e87-57042ab67d5c@postmarketos.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <37ebdd21-e46a-fac9-7e87-57042ab67d5c@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 22:55, Alexey Minnekhanov wrote:
> Hi,
> 
> On 20.09.2022 18:04, Krzysztof Kozlowski wrote:
> 
>> -	tcsr_mutex: tcsr-mutex {
>> -		compatible = "qcom,tcsr-mutex";
>> -		syscon = <&tcsr_mutex_block 0 0x80>;
> 
> I'm looking and don't understand where does this information go, is it 
> lost in the conversion? I mean those "0 0x80" parameters to syscon 
> reference.

This compatible is using:
of_msm8226_tcsr_mutex
.stride = 0x80,

Best regards,
Krzysztof

