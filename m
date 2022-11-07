Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D25161EFEA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiKGKGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiKGKGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:06:49 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4894F178BA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 02:06:48 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id x21so15392407ljg.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 02:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q2t/IRH3FU2z4DLn2lUIQsd3+AJ/93+PFAgIWkFQYFo=;
        b=fw3TPKkzGwx0H8Qw2Rirj2E5FQYLwcbehEkxLCd4RFCCXvAfnFwyUHTOjjXdgngxrK
         JDdOCp4udZABjlk9NgeevE/vFAa4ZvkRadyHprWNfScm7iyMS12LyUhlB1oVrQlDVCcf
         zOPS7Parn5kClzmREe4AvA46xWj1WtQvgSf/tmNdNpSPSlNB9eG7WrtqYA3HfwxgPCOh
         YltCDK1Rc3jWSgsAmMO2eYdHUWxmxvS++xuMytTy+KvMVX3+0Zmc9oagaqzkuyOPKf+C
         xvMGY/EyVv8aZiY4SfnCNpwQlCv/i2Jxz1uccMn29e8dHXjH8vtn1qqniGbUFsRZrS1W
         Nrmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q2t/IRH3FU2z4DLn2lUIQsd3+AJ/93+PFAgIWkFQYFo=;
        b=rdo6IZvSaewE1zCnD0QfRTTgLg8b5kb65n9ISYRVs3bGT5qiItHjP3SwVSHVc6h/XJ
         Rl45j8ky2cFZ7ag1ci9uYUOEu6nr0cab89JcO7d+0OqhiCIyUSumXD7wbpdkLdPO5PTF
         XhFV3ZeIb2i5yhYpUQ4Jwnbubw/ig2jwBLpylsfacTov1VBD2YsPakiEwpNsX4LZchPH
         v8NQx0uAtphf31o42WHuGUK3RWIMo+jHuKes3jxZhU9J57muc6xq9u1brhXD5fkaP9jj
         hAocYsQJh0htDbai1uX13/OI9BchH9aQLJQ4YEwRvmE4A2pw6VtuaFtSKIyiyTTu86T9
         iI+A==
X-Gm-Message-State: ACrzQf1fuUEfHlBPIvUugonItRIR6EMnaBMaTeK9nx8oZvmkqR36vbog
        rPLbpQIzBA+rmxuhZseddAT85A==
X-Google-Smtp-Source: AMsMyM6FCksyiqn6bhFeKSn2j/rKLgmrtcp0FYcK5IEzv0PW2r9h+gwVEvvUyZ5QhzUcMeiAICFFJA==
X-Received: by 2002:a2e:b163:0:b0:277:6bc:2ab0 with SMTP id a3-20020a2eb163000000b0027706bc2ab0mr4874111ljm.142.1667815606667;
        Mon, 07 Nov 2022 02:06:46 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id j9-20020a056512108900b004ab0f2a8acdsm1155833lfg.212.2022.11.07.02.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 02:06:46 -0800 (PST)
Message-ID: <caeccd9f-432c-d029-da9d-8dca27c02a9b@linaro.org>
Date:   Mon, 7 Nov 2022 11:06:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 1/2] dt-bindings: PCI: xilinx-pcie: Convert to YAML
 schemas of Xilinx AXI PCIe Root Port Bridge
Content-Language: en-US
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     bhelgaas@google.com, michals@xilinx.com, robh+dt@kernel.org,
        nagaradhesh.yeleswarapu@amd.com, bharat.kumar.gogada@amd.com
References: <20221107095408.924778-1-thippeswamy.havalige@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221107095408.924778-1-thippeswamy.havalige@amd.com>
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

On 07/11/2022 10:54, Thippeswamy Havalige wrote:
> Convert to YAML dtschemas of Xilinx AXI PCIe Root Port Bridge
> dt binding.
> 
> 

Just one blank line before SoB.

With commit fixes:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---



Best regards,
Krzysztof

