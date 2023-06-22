Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CFF739D49
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjFVJdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjFVJcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:32:00 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24703422C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:23:19 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-988689a5f44so553342766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687425797; x=1690017797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F8M01lCnD4DiE1JI+G556h5bffwz8K8jNPJzf86AuQA=;
        b=cgsSLGlTpnmoG8TcZ0v2kHDCIvk6b85rdF0rJgakzsH1bYHaIvPW19LsvQt7FfqJjW
         rlmVPGUE+IFzQqa6eihJVj/7thEwLbihsHUqJ2QG0eZ1W7cOhii9hLANKxmfozLqF+Fh
         xjDnvEhM5aBLNlb//OZRx3Yj9aGO68aBK74QutqZMja7f/3BhAV+UtKxVIM93KyZtM8Z
         nyXRDOem10z3dTBNxab9QFw/h1PgTrNbNckOnvYvj+ukRA2HH8Cuphwf12RWGqFvu7wW
         Qf1Zc1YWMcd35Flg5ItO4QqW5PSiwZrF9HXdi9GPqKPNomZnNmk2CmgnswTUnKenam6u
         CFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687425797; x=1690017797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F8M01lCnD4DiE1JI+G556h5bffwz8K8jNPJzf86AuQA=;
        b=FIVASUiSAeSa9aIoV9t/p6C2iVtC/uSOr/Tup4CaVP1n+/dMpmOr0qgLS0pMYJjlE1
         IavAS8LBz3JkqTdPI1t3/EU6rpVCdf5/EddZ+Tj+e41bwniLWQvcru31WAzN3SX7H6+r
         dy4FiNv/IZHzG5iCmVbHH8p+HHLHgMpobPYDdijyEVF5YuPtmEhdjbvyeTNgV7L+ZBjw
         8wCoofQK4G4CG8AJ1qitW7F3eIMcw0vOha8Ot24mWfYY+jkzj2F+X7DCjdq8df/CrwWR
         3/c+Q6f7av1NgA7A98vLLGApsh99k1UPq4F5jU8qr8xWCLHDqKIX9gsH1QFrmiZtNPow
         C49Q==
X-Gm-Message-State: AC+VfDw31Auk4/CneSTy24b+cyacQaGrg2TfBsw7LtZJpEbMU35eHElC
        0Ub6HwEbYQQUkD3vGI1Cl0LSTg==
X-Google-Smtp-Source: ACHHUZ67N6RDSVlCAyezkx9e5tmGd7OPytl0GH6g/D0mbSUFF0qf7hIHMUksugkOYN96ZH2myVszaw==
X-Received: by 2002:a17:907:940f:b0:98d:4aa0:ffce with SMTP id dk15-20020a170907940f00b0098d4aa0ffcemr266872ejc.18.1687425797617;
        Thu, 22 Jun 2023 02:23:17 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id r20-20020a170906351400b009884035279bsm4348451eja.33.2023.06.22.02.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 02:23:17 -0700 (PDT)
Message-ID: <0d1b3c55-4b11-9e63-e388-191d39d88df1@linaro.org>
Date:   Thu, 22 Jun 2023 11:23:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] arch: arm64: configs: Enable UBI and UBIFS
To:     kah.jing.lee@intel.com, Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
References: <20230622085349.573942-1-kah.jing.lee@intel.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230622085349.573942-1-kah.jing.lee@intel.com>
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

On 22/06/2023 10:53, kah.jing.lee@intel.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
> 
> This patch is to enable UBI and UBIFS in Linux defconfig.

Why? Which board needs it? It's quite unusual to have this on arm64...

> 
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
> Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
> ---
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index a24609e14d50..23a6ebcb1a9e 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -470,6 +470,8 @@ CONFIG_IPMI_DEVICE_INTERFACE=m
>  CONFIG_IPMI_SI=m
>  CONFIG_HW_RANDOM=y
>  CONFIG_HW_RANDOM_VIRTIO=y
> +CONFIG_MTD_UBI=y
> +CONFIG_UBIFS_FS=y

Not modules?

Are you sure you added the lines in appropriate place (matching
savedefconfig)?


Best regards,
Krzysztof

