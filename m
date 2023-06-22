Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9A373A13B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjFVMvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFVMvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:51:21 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB0F193
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:51:20 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-988a2715b8cso111216166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687438279; x=1690030279;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qPLLdjKr1T1TMeOs9HNgAHkxnOJhuqDp1+6ZK+CYadQ=;
        b=AxYBSkHxNyDe50EWSXFM1fxxf1J7CxUzZEqYwfyCdT/uPQt1wfiCqfF5gYrj9k9GDb
         LyQIFjW5Yt4uUy3She0fPGidJgdnKLJ+oThp0fUpLV3hqxEV4zMK9GQzly7WNWUMF5rQ
         Lyj46mTbtjrTgdAfI0II43GjmbSR1p6PFkw495LHWUSj9C2WHJvLnQ596JgMdI/KZQsB
         NIHb/I82nL9rKrMMIGY2K9GcpPXnpd9Aw84eT5Zzskd3HchbYBk7yab6ZnMU5+82bSsU
         XEq2UWrOzGxLPga/QWWrWBjN55f5mKGDmfoKDmXw3ud4Of7LwSjvrPz7p0Q+xWc1KmVv
         xqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687438279; x=1690030279;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qPLLdjKr1T1TMeOs9HNgAHkxnOJhuqDp1+6ZK+CYadQ=;
        b=gK1sr9gw+NArGzw7Wqgva3YAP79WXVcF0F5O6ntziIenoKxdRu4WOPkAddYBb8yxc2
         C+LseBPIWpkEB/UeLAA3c3lW6DTmLtwq96wBOAcUsUmvGuP/gqrXv8fiJ7i3rdkOxtpF
         2ylUKRJN0RWqAVZFWyXnIDnKZmNFizSofU/LnNYu9/u0TbsGr/n6Xek1cYBI3Ck4O+AY
         MDD9gw2QKyP8o2NC5iwh5/SEWMUzhhqBDWA5GX6iFNnNSojYHJi4Ew/oX0Z0i/0fLv+v
         FB25JrUOGUJfH/9ZzWxqoS/850JZ/U7Dj9mz2yJP/7+vYbUSLRQzaKfZM6bPWPZwXuk0
         zyUw==
X-Gm-Message-State: AC+VfDxnjAW/ZNtZ+e9zBr9b8RNKcNPmc8k+nEYc7XgWJAKvLYqYpxHn
        o92zMMEhRF43nikn1TCZbDQfWw==
X-Google-Smtp-Source: ACHHUZ4S14WYYw+6K1MYEB5KsPu0/dxQvijq6/XJjgxA0XHHUU/L/wZUPjlCOF3E5GPHIQyPmh+fOg==
X-Received: by 2002:a17:907:7209:b0:989:1a52:72a1 with SMTP id dr9-20020a170907720900b009891a5272a1mr6933542ejc.28.1687438279198;
        Thu, 22 Jun 2023 05:51:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id n19-20020a17090625d300b009890e402a6bsm4686348ejb.221.2023.06.22.05.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 05:51:18 -0700 (PDT)
Message-ID: <73b33d5c-e363-cd0a-0790-6764f42a6ada@linaro.org>
Date:   Thu, 22 Jun 2023 14:51:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/2] arm64: defconfig: Enable UBI and UBIFS
Content-Language: en-US
To:     kah.jing.lee@intel.com, Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
References: <20230622123254.593308-1-kah.jing.lee@intel.com>
 <20230622123657.593719-1-kah.jing.lee@intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230622123657.593719-1-kah.jing.lee@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2023 14:36, kah.jing.lee@intel.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
> 
> This patch is to enable UBI and UBIFS in Linux defconfig for socfpga
> Agilex and Stratix10 platform.
> 
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
> Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
> ---
> v2: Update subject prefix and align defconfig config place
> ---
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index a24609e14d50..8c3c6fd20d77 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -267,6 +267,7 @@ CONFIG_MTD_NAND_BRCMNAND=m
>  CONFIG_MTD_NAND_FSL_IFC=y
>  CONFIG_MTD_NAND_QCOM=y
>  CONFIG_MTD_SPI_NOR=y
> +CONFIG_MTD_UBI=y

=m

(and wait till discussion finished)

>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_BLK_DEV_NBD=m
>  CONFIG_VIRTIO_BLK=y
> @@ -1444,6 +1445,7 @@ CONFIG_TMPFS_POSIX_ACL=y
>  CONFIG_HUGETLBFS=y
>  CONFIG_CONFIGFS_FS=y
>  CONFIG_EFIVAR_FS=y
> +CONFIG_UBIFS_FS=y

Also =m



Best regards,
Krzysztof

