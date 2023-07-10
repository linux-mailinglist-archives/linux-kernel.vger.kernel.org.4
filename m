Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C5D74DD91
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 20:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjGJSs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 14:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjGJSsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 14:48:55 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256E9DA;
        Mon, 10 Jul 2023 11:48:54 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5703cb4bcb4so52787987b3.3;
        Mon, 10 Jul 2023 11:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689014933; x=1691606933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GW8Zl4kk1oZplF17p+2Ty/rk3SdPb4UucAzAmcm23zo=;
        b=BTiYct5HXr4yOeUewK5g49sxYBCPUie8CPoW1V/5b47nV2Z7iMoqNa7p2SAKRWVX3D
         enwLKHhh8/ePzUvXf1c1CPZkj7DNSxgdoVK0wYTzjFode2cagpbLJGSOiZdIVNrMYkO9
         zvg4IPKhWZrVMM1bFFrQQZYrwFah3vNG/QvvJ/Qh/+z8DRnYD4F22bnqamRDqbodXV+l
         5CmsBcNIRuVUjnIT56m7irUNRZFT1Mf11jBJX3A7QZwUk2WbYaeqeTPeXWL+0rAU3NwN
         jerdip8xObUDLcrweyL8aUN1Ctt05Bf+8DZW3ybOnsFbyIfkg74yVEBq+e/6+ChOiPJW
         D7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689014933; x=1691606933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GW8Zl4kk1oZplF17p+2Ty/rk3SdPb4UucAzAmcm23zo=;
        b=IRx49gRajDf+1DegDsCM28aDPBWajndGY7W3KBXQV4n6lKloxJ1wodo6ZikRry/hh/
         JR/b0hLmM3Sk6VrOYl84Y6YB7RNyh6eK+oZQjm1zDpi235nCoAw2+uf3kbR71cZGTcZz
         7n8J62t15P5hp2bC8sC4aTuEIb24SePCGzyXaub4AApUfIEX/NC2yg4Nuxun19xOm+7B
         krS87awJXAVNE/puvxWhTGTKm7JKvv0vJCMGf6B7iB6wKP320Fwcq/DL33tjnBhHdEJT
         VJ8fRG39iRcPdGnL7GwUgla1KynKYjAbXMuYqSw/Fv34PUV8wDEyULCkFDSz+Kq8VRCA
         vd9g==
X-Gm-Message-State: ABy/qLbd4KL6jvKSEKJQm2FTk61Yj/dnST8UsCoP7/+gFq8FejagPFPf
        DvgLxBl1XJ0+LoimLa63IoOKoiCRlk0=
X-Google-Smtp-Source: APBJJlG/7d98UtVbsIqr0sUScPW2yGf04sETkZFHKfsfiVrVdw9TTaKbW0v3BRxQG0vUZiIkNzaMGg==
X-Received: by 2002:a0d:d5c7:0:b0:579:ecfd:bb90 with SMTP id x190-20020a0dd5c7000000b00579ecfdbb90mr13116303ywd.1.1689014933281;
        Mon, 10 Jul 2023 11:48:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z62-20020a816541000000b0055a931afe48sm122890ywb.8.2023.07.10.11.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 11:48:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 10 Jul 2023 11:48:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH 2/2] hwmon: (dimmtemp) Add Sapphire Rappids support
Message-ID: <a307e9d6-bdd3-4fff-bf9b-f8919b6b0d69@roeck-us.net>
References: <20230710164705.3985996-1-Naresh.Solanki@9elements.com>
 <20230710164705.3985996-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710164705.3985996-2-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 06:47:04PM +0200, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> This patch extends the functionality of the hwmon (dimmtemp) to include
> support for Sapphire Rappids platform.
> 
> Sapphire Rappids can accommodate up to 8 CPUs, each with 16 DIMMs. To
> accommodate this configuration, the maximum supported DIMM count is
> increased, and the corresponding Sapphire Rappids ID and threshold code
> are added.
> 
> The patch has been tested on a 4S system with 64 DIMMs installed.
> Default thresholds are utilized for Sapphire Rappids, as accessing the
> threshold requires accessing the UBOX device on Uncore bus 0, which can
> only be achieved using MSR access. The non-PCI-compliant MMIO BARs are
> not available for this purpose.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>

Does this patch depend on the other patch, the one introducing
Sapphire Rappids to peci/cputemp ?

Guenter

> ---
>  drivers/hwmon/peci/dimmtemp.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/peci/dimmtemp.c b/drivers/hwmon/peci/dimmtemp.c
> index ce89da3937a0..ea4ac5a023cf 100644
> --- a/drivers/hwmon/peci/dimmtemp.c
> +++ b/drivers/hwmon/peci/dimmtemp.c
> @@ -30,8 +30,10 @@
>  #define DIMM_IDX_MAX_ON_ICX	2
>  #define CHAN_RANK_MAX_ON_ICXD	4
>  #define DIMM_IDX_MAX_ON_ICXD	2
> +#define CHAN_RANK_MAX_ON_SPR	128
> +#define DIMM_IDX_MAX_ON_SPR	2
>  
> -#define CHAN_RANK_MAX		CHAN_RANK_MAX_ON_HSX
> +#define CHAN_RANK_MAX		CHAN_RANK_MAX_ON_SPR
>  #define DIMM_IDX_MAX		DIMM_IDX_MAX_ON_HSX
>  #define DIMM_NUMS_MAX		(CHAN_RANK_MAX * DIMM_IDX_MAX)
>  
> @@ -534,6 +536,15 @@ read_thresholds_icx(struct peci_dimmtemp *priv, int dimm_order, int chan_rank, u
>  	return 0;
>  }
>  
> +static int
> +read_thresholds_spr(struct peci_dimmtemp *priv, int dimm_order, int chan_rank, u32 *data)
> +{
> +	/* Use defaults */
> +	*data = (95 << 16) | (90 << 8);
> +
> +	return 0;
> +}
> +
>  static const struct dimm_info dimm_hsx = {
>  	.chan_rank_max	= CHAN_RANK_MAX_ON_HSX,
>  	.dimm_idx_max	= DIMM_IDX_MAX_ON_HSX,
> @@ -576,6 +587,13 @@ static const struct dimm_info dimm_icxd = {
>  	.read_thresholds = &read_thresholds_icx,
>  };
>  
> +static const struct dimm_info dimm_spr = {
> +	.chan_rank_max	= CHAN_RANK_MAX_ON_SPR,
> +	.dimm_idx_max	= DIMM_IDX_MAX_ON_SPR,
> +	.min_peci_revision = 0x40,
> +	.read_thresholds = &read_thresholds_spr,
> +};
> +
>  static const struct auxiliary_device_id peci_dimmtemp_ids[] = {
>  	{
>  		.name = "peci_cpu.dimmtemp.hsx",
> @@ -601,6 +619,10 @@ static const struct auxiliary_device_id peci_dimmtemp_ids[] = {
>  		.name = "peci_cpu.dimmtemp.icxd",
>  		.driver_data = (kernel_ulong_t)&dimm_icxd,
>  	},
> +	{
> +		.name = "peci_cpu.dimmtemp.spr",
> +		.driver_data = (kernel_ulong_t)&dimm_spr,
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(auxiliary, peci_dimmtemp_ids);
> -- 
> 2.41.0
> 
