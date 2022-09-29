Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4D45EF765
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbiI2OVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiI2OVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:21:52 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDB58E469;
        Thu, 29 Sep 2022 07:21:49 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l18so2439443wrw.9;
        Thu, 29 Sep 2022 07:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=6/3S4SqDN7s02eu32dMD8zSI0cpG/EMn6+nA5mGI7Ig=;
        b=fohR4TTWFo+aKaHOU80z8jlxlGze8JyK+FrBc031T77KQZjIKD1kcmlEfNLLQNy7sJ
         jn2LrXu1f+AoDZ+Yu/xeKVa/kCtmmoLudUJnRNawU4you7Rcx/9qKudGs+Nr98N83all
         g1AKVIpjsD5zcWDt1G5WOARNrDPde4Y4CPAL9XL+MW2SPguZbGEL6a3bfNseR3Q0oBK0
         4MsLhSRQB7tKe7xv6SajZ2mKlS+liv05/aAU9BSN5Du07jR+fLACrr7EO5TBoAoxyLx8
         DVwVdErCAmq4op/49bnX3LTJeZNqYe7wdYYh3NrwA8L4gAD/K292M4249UM+a2AhC8bP
         5kjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=6/3S4SqDN7s02eu32dMD8zSI0cpG/EMn6+nA5mGI7Ig=;
        b=FcjBlZz4BbneiFmakQtTJUFVgfN72f1WbI6nPrhNfFbHB8x7LRTuZ7CUE657I9UvVj
         aDEapFg94tBHRcCgHIU1LZu/N3F2IXpOC0xiSW9YFBDyLSaJHv6Zidu5I0HKYe2xc1r6
         PnCnzbZ/Ge7i+VToBHjhMbiXsiK8pF+Ts2aksk9sWHT7a3/OghD1SxaoKkLkJwL8p7kT
         dgleDfLHin6J09IGsDyCyc8vhk8sNWj2KPj8nkwcQaaq68lr2Ckcy5j/QiG6zEMwXAzg
         rJoBYiB60IKM0fuNzBaaBkzwM2Z9LTRUNV8xdDp3ebLaSrgKUX5jx/xV5E8znQcCBFhr
         q8mg==
X-Gm-Message-State: ACrzQf0jcs0PWIre37tdpXOw924rYANl7iqj5VR/+8cL5HmUxiiTNUYy
        daT/ZR3OF5SHdk1N7N7JhNg=
X-Google-Smtp-Source: AMsMyM5uPhqI7tGH6OtYXpZMFPVOnRLcTvo3E6MDWHWjwFtaNwwoHyK6OOkdOq6PXfjMjY2YrxcDag==
X-Received: by 2002:a05:6000:78e:b0:22a:7e99:da93 with SMTP id bu14-20020a056000078e00b0022a7e99da93mr2484830wrb.20.1664461307820;
        Thu, 29 Sep 2022 07:21:47 -0700 (PDT)
Received: from localhost ([2a03:b0c0:1:d0::dee:c001])
        by smtp.gmail.com with ESMTPSA id z14-20020adff74e000000b002205a5de337sm3856422wrp.102.2022.09.29.07.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 07:21:47 -0700 (PDT)
Date:   Thu, 29 Sep 2022 14:21:46 +0000
From:   Stafford Horne <shorne@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH] openrisc: update config files
Message-ID: <YzWp+p+1V1UmCAb3@oscomms1>
References: <20220929101458.32434-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929101458.32434-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 12:14:58PM +0200, Lukas Bulwahn wrote:
> Clean up config files by:
>   - removing configs that were deleted in the past
>   - removing configs not in tree and without recently pending patches
>   - adding new configs that are replacements for old configs in the file
> 
> For some detailed information, see Link.
> 
> Link: https://lore.kernel.org/kernel-janitors/20220929090645.1389-1-lukas.bulwahn@gmail.com/
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Hello,

Thanks for the patch this looks fine to me.  Usually I just generate this
defcnfigs using make savedefconfig.  If there is some better way which
doesn't generate the file with the # comment's I haven't found it.

I will queue this.

-Stafford

> ---
>  arch/openrisc/configs/or1ksim_defconfig    | 5 -----
>  arch/openrisc/configs/simple_smp_defconfig | 4 ----
>  2 files changed, 9 deletions(-)
> 
> diff --git a/arch/openrisc/configs/or1ksim_defconfig b/arch/openrisc/configs/or1ksim_defconfig
> index 6e1e004047c7..af1164807206 100644
> --- a/arch/openrisc/configs/or1ksim_defconfig
> +++ b/arch/openrisc/configs/or1ksim_defconfig
> @@ -19,9 +19,6 @@ CONFIG_NET=y
>  CONFIG_PACKET=y
>  CONFIG_UNIX=y
>  CONFIG_INET=y
> -# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> -# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> -# CONFIG_INET_XFRM_MODE_BEET is not set
>  # CONFIG_INET_DIAG is not set
>  CONFIG_TCP_CONG_ADVANCED=y
>  # CONFIG_TCP_CONG_BIC is not set
> @@ -34,7 +31,6 @@ CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
>  # CONFIG_PREVENT_FIRMWARE_BUILD is not set
>  # CONFIG_FW_LOADER is not set
> -CONFIG_PROC_DEVICETREE=y
>  CONFIG_NETDEVICES=y
>  CONFIG_ETHOC=y
>  CONFIG_MICREL_PHY=y
> @@ -52,4 +48,3 @@ CONFIG_SERIAL_OF_PLATFORM=y
>  # CONFIG_DNOTIFY is not set
>  CONFIG_TMPFS=y
>  CONFIG_NFS_FS=y
> -# CONFIG_ENABLE_MUST_CHECK is not set
> diff --git a/arch/openrisc/configs/simple_smp_defconfig b/arch/openrisc/configs/simple_smp_defconfig
> index ff49d868e040..84ca3203af9c 100644
> --- a/arch/openrisc/configs/simple_smp_defconfig
> +++ b/arch/openrisc/configs/simple_smp_defconfig
> @@ -27,9 +27,6 @@ CONFIG_NET=y
>  CONFIG_PACKET=y
>  CONFIG_UNIX=y
>  CONFIG_INET=y
> -# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> -# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> -# CONFIG_INET_XFRM_MODE_BEET is not set
>  # CONFIG_INET_DIAG is not set
>  CONFIG_TCP_CONG_ADVANCED=y
>  # CONFIG_TCP_CONG_BIC is not set
> @@ -60,5 +57,4 @@ CONFIG_SERIAL_OF_PLATFORM=y
>  CONFIG_TMPFS=y
>  CONFIG_NFS_FS=y
>  CONFIG_XZ_DEC=y
> -# CONFIG_ENABLE_MUST_CHECK is not set
>  # CONFIG_RCU_TRACE is not set
> -- 
> 2.17.1
> 
