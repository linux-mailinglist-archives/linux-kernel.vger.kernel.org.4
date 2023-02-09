Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2FC690F8E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 18:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjBIRuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 12:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjBIRuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 12:50:06 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA17466EE3;
        Thu,  9 Feb 2023 09:50:03 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id t5so2321969oiw.1;
        Thu, 09 Feb 2023 09:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JUmPEXG2VuMuFoU/wyedYPRe8F6+umYR6krkjNR0xv4=;
        b=bnQHojBdUEw55oXqicBCehGlJrxaEUIrVuhWlIJHKVwjNbqk6raR2FlwossfjPghmu
         51thQBL12cAQpPp2X17/D/UcA9rtYRc1PHY7TStPhrQBWmoSyKEm4P1MYP8tohx6zMYo
         Ms/VvsYqs3tDtdS/SXB4t913Y4qphy4O9oCy/yXLLjd3E2l64VVUySvfeTkOcmbTzQmY
         O1jeap5a+9CyBkk5U8GjZKDgVCdqjucxbPTClYhSslcQF18FVt6NLZyryn1uMrvm5BFj
         12NX9ggV9953eOa34Xi0t3ZL5ouuL6orYteHt3zBvXRjHaVa5BMbzuMGMspZ/gj2eL2g
         ydhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUmPEXG2VuMuFoU/wyedYPRe8F6+umYR6krkjNR0xv4=;
        b=DWZt2Ruay/ykH9rjnbvGcJkL3cEBUvIIibQ8jBo0NZVK1xzLas1P0oGCMSowAzcmee
         syubV/mEyoB4qZ3VNunsRNcpj2/tlK/S1ZyeTEPHo1GfesmzAnC4EoYMAbpUEOXmsI3M
         v93W1LKXgNm30G4PcSLuaHFLV0BiwYK275blTsfdAqtQaSxj6eOgCI5FLhB/ZckSw5QL
         xBChceZtcBBt9THpXEIz5tmrMrJal3n1T9aFmXXPOKX6KI4Vc/V3r81XVNiOREdwoqa1
         46LNXNI9uEwtCuFWCfVmRJYYGoItBNn3XsEXPGSF6R3xogknSl99NfRH3CfBeCNY+x5R
         9XzQ==
X-Gm-Message-State: AO0yUKUyWgEbMavlXDcEZj2CScJlDjqlBM4219nZeJ4IjEQ0xP3PyUtJ
        On6jfhh/K6qi5zgDyYojnq4=
X-Google-Smtp-Source: AK7set9NTGeaamp6UxQT4WSW3nDL5+j2RR9BpVi5+7fySkof0KyEVaBX+tjL9yAynsT4Lx1dl7XIzg==
X-Received: by 2002:a05:6808:6c5:b0:35e:9b84:bf35 with SMTP id m5-20020a05680806c500b0035e9b84bf35mr5250841oih.6.1675965003031;
        Thu, 09 Feb 2023 09:50:03 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f21-20020a056830205500b0068bdca29f97sm957351otp.52.2023.02.09.09.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 09:50:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 9 Feb 2023 09:50:01 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Iwona Winiarska <iwona.winiarska@intel.com>,
        openbmc@lists.ozlabs.org, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [RFC PATCH] hwmon: (peci/cputemp) Number cores as seen by host
 system
Message-ID: <20230209175001.GA667937@roeck-us.net>
References: <20230209011632.32668-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209011632.32668-1-zev@bewilderbeest.net>
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_AS_SEEN autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 05:16:32PM -0800, Zev Weiss wrote:
> While porting OpenBMC to a new platform with a Xeon Gold 6314U CPU
> (Ice Lake, 32 cores), I discovered that the core numbering used by the
> PECI interface appears to correspond to the cores that are present in
> the physical silicon, rather than those that are actually enabled and
> usable by the host OS (i.e. it includes cores that the chip was
> manufactured with but later had fused off).
> 
> Thus far the cputemp driver has transparently exposed that numbering
> to userspace in its 'tempX_label' sysfs files, making the core numbers
> it reported not align with the core numbering used by the host system,
> which seems like an unfortunate source of confusion.
> 
> We can instead use a separate counter to label the cores in a
> contiguous fashion (0 through numcores-1) so that the core numbering
> reported by the PECI cputemp driver matches the numbering seen by the
> host.
> 

I don't really have an opinion if this change is desirable or not.
I suspect one could argue either way. I'l definitely want to see
feedback from others. Any comments or thoughts, anyone ?

> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
> 
> Offhand I can't think of any other examples of side effects of that
> manufacturing detail (fused-off cores) leaking out in
> externally-visible ways, so I'd think it's probably not something we
> really want to propagate further.
> 
> I've verified that at least on the system I'm working on the numbering
> provided by this patch aligns with the host's CPU numbering (loaded
> each core individually one by one and saw a corresponding temperature
> increase visible via PECI), but I'm not sure if that relationship is
> guaranteed to hold on all parts -- Iwona, do you know if that's
> something we can rely on?
> 
> This patch also leaves the driver's internal core tracking with the
> "physical" numbering the PECI interface uses, and hence it's still
> sort of visible to userspace in the form of the hwmon channel numbers
> used in the names of the sysfs attribute files.  If desired we could
> also change that to keep the tempX_* file numbers contiguous as well,
> though it would necessitate a bit of additional remapping in the
> driver to translate between the two.

I don't really see the point or benefit of doing that.

Thanks,
Guenter

> 
>  drivers/hwmon/peci/cputemp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/peci/cputemp.c b/drivers/hwmon/peci/cputemp.c
> index 30850a479f61..6b4010cbbfdf 100644
> --- a/drivers/hwmon/peci/cputemp.c
> +++ b/drivers/hwmon/peci/cputemp.c
> @@ -400,14 +400,15 @@ static int init_core_mask(struct peci_cputemp *priv)
>  static int create_temp_label(struct peci_cputemp *priv)
>  {
>  	unsigned long core_max = find_last_bit(priv->core_mask, CORE_NUMS_MAX);
> -	int i;
> +	int i, corenum = 0;
>  
>  	priv->coretemp_label = devm_kzalloc(priv->dev, (core_max + 1) * sizeof(char *), GFP_KERNEL);
>  	if (!priv->coretemp_label)
>  		return -ENOMEM;
>  
>  	for_each_set_bit(i, priv->core_mask, CORE_NUMS_MAX) {
> -		priv->coretemp_label[i] = devm_kasprintf(priv->dev, GFP_KERNEL, "Core %d", i);
> +		priv->coretemp_label[i] = devm_kasprintf(priv->dev, GFP_KERNEL,
> +							 "Core %d", corenum++);
>  		if (!priv->coretemp_label[i])
>  			return -ENOMEM;
>  	}
> -- 
> 2.39.1.236.ga8a28b9eace8
> 
