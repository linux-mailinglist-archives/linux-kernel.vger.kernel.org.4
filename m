Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD61B679ABA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 14:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbjAXN4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 08:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbjAXN4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:56:33 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE9BA244;
        Tue, 24 Jan 2023 05:55:55 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id s124so13357350oif.1;
        Tue, 24 Jan 2023 05:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iOxy8nRrMl9o1+5fkSajeQlg6uVJJoMX8dNBYKvIR8c=;
        b=KNAzVcKodXMPvsTLkJxFgMDhm6fzJsUTyS1WwRHcxlA3g5B2dMtS7Yz5e4j4RE0ehH
         Lz2XuEwDX5TPKBZ891DDLUTZrN4MzzB5/ZiATrmMH5PamCSvUfiWZaLNWjE6Y1ntkpHf
         Q+ipcNDXZhGRJVYFkrJZoa0I9zERTLMOzjVK+XBonIzkMQ9LjqWt0IhOUlwPDaqVGfWb
         Le61dgfgUR3bx8DPrbBrcG15ul5hMNiaR+2MgUNgazq69Y9oE1K9SSAuqtmylsOwpxBv
         GCbVKn9IY01waQ5rcTykOuZGP8lbZycvIVe7RgGjdOI0ibwn/C/91od52PTFyxQsprsK
         Ogsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOxy8nRrMl9o1+5fkSajeQlg6uVJJoMX8dNBYKvIR8c=;
        b=FbQyrRgR9nko1URYkWwgu7tZ/V78nIjTU86MtptVOPWdfXnVX8mp/Gq1b0Zwx2z0aN
         n1tB7iSPGl6+nYkbxzfMGGfs5JzumavJ7Pj2XQjByHPpopk0t4BgEZ+1THPQvfdDaGNF
         Px9Kv7uk0RcbBgiZuGEAtFs7fcrsoox8P5S/XfZaZXKS1uvBmb5MOAX8a8RlBVHY/3g5
         mFbYXnNYWGVZFsOPqCIXxj/Ggobdq/X7TmMDxXueeTurJizEuXqCLMfACIWsqEczlYRl
         DB8YUUoO8fqLEdlLi59APoVT0qtITpUcUnleYiw50rI3EeRWKECJaKkQm+hQ7jAJ0FpE
         R/hg==
X-Gm-Message-State: AFqh2krR/EOcUxx9nYtpD6hhhbVXnV+VxJVEvCLr1y4inehMaLoG54YR
        SWCW+H7vrsyUuoq0HkF430M=
X-Google-Smtp-Source: AMrXdXvMIz+0euvOP4Hw+9t0VHiqasYsVJb8Ude+av3K42nOrbeJdLFUKaKzZ73SMFge/F7ptLDfYg==
X-Received: by 2002:aca:f09:0:b0:36e:f396:b8fb with SMTP id 9-20020aca0f09000000b0036ef396b8fbmr1525249oip.29.1674568525803;
        Tue, 24 Jan 2023 05:55:25 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s5-20020a9d7585000000b006865246ace0sm929730otk.53.2023.01.24.05.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 05:55:25 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 24 Jan 2023 05:55:24 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] hwmon: (asus-ec-sensors) add missing mutex path
Message-ID: <20230124135524.GA36884@roeck-us.net>
References: <20230121111728.168514-1-eugene.shalygin@gmail.com>
 <20230121111728.168514-2-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230121111728.168514-2-eugene.shalygin@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 12:17:28PM +0100, Eugene Shalygin wrote:
> Add missing mutex path for ProArt X570-CREATOR WIFI.
> 
> Fixes: de8fbac5 (hwmon: (asus-ec-sensors) implement locking via the ACPI global lock)
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied.

The abbreviated SHA in Fixes: tags should include 12 SHA letters/digits.
I fixed that up, but please keep it in mind for future patches.

Thanks,
Guenter

> ---
>  drivers/hwmon/asus-ec-sensors.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
> index a901e4e33d81..b4d65916b3c0 100644
> --- a/drivers/hwmon/asus-ec-sensors.c
> +++ b/drivers/hwmon/asus-ec-sensors.c
> @@ -299,6 +299,7 @@ static const struct ec_board_info board_info_pro_art_x570_creator_wifi = {
>  	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
>  		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CPU_OPT |
>  		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
> +	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
>  	.family = family_amd_500_series,
>  };
>  
