Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8C46B68E0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 18:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCLRmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 13:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCLRmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 13:42:19 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C49423C65;
        Sun, 12 Mar 2023 10:42:18 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id g73-20020a9d12cf000000b006943a7df072so5590445otg.11;
        Sun, 12 Mar 2023 10:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678642937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWwfbTYkHpRW+P4l0UQFLedahpqjBIiVvNL5iHmrB0s=;
        b=AQa0/1Gg5AlhSsdPdIHlPTe2gr4Qqixfu4DDPEsWRGGVNo/7GLfrzQyA/F0f+fTrcB
         bbhPJmrWW2aK6H+ptHIht6TfODXUxkPsGqFlRiWh3X7UnjBn8bauUaA1R5cVK8jlMoZW
         sQpW3jTFqendZTRfAMG5pV0tKaxRqOT6Hy8GlOfBdBHkB1rxnn3Pe1Udg/IqZ54oladL
         fIsGVX7f1NXS8rmE2yngTLBK4kLNng5+jg/hyeO+zmaGglFQ+5lTF//GFtsjG2McpOO6
         Tv3WAScec/yrmesXvyXG8A/BcE5yN8FXDCK4Pr+Sbb+amtcNH8UqCijRHDsJAstK9E/B
         kmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678642937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWwfbTYkHpRW+P4l0UQFLedahpqjBIiVvNL5iHmrB0s=;
        b=mwAoMM1AXV2nyaqO+J8qqBy0JM6VSdw2MbA6as4LkVvyxm0R78wl2mse7KX/JJkxtd
         HVYwZg4lRMuotd1M0U/1H+KdBjC8pU2RLy5/NDIo3a4J64QjhQd89/QQ5PHEQhd6uP+o
         wDq+whSIzmrzcmAHB88r/aM1RCQAX48HQtrc2Pnt25Qe/QWxAIXBZZhP3PuAP4I7WQFW
         3w/n9TlfBltpJq6ICHPI0b5mFjTFYG5+NehiQ8Lxk4IgYTsgryvPct/1AM8Z2OXf8nm+
         o0fKfhNWHZEb2r0jtnfeyTAZUV3NYMt/+pgS+oPCSgQRNz2uvWqgmHYD1MkW+m3iGccX
         L92w==
X-Gm-Message-State: AO0yUKUzjkkd2nb6bcoRjLg/Z7AEO2vZfU1qxYiLT4aZR0r19lPAnnuI
        oZA8DSPUXn6lc7sYx0vncNk=
X-Google-Smtp-Source: AK7set8BKsfL44lYMLBbcfleHx3YDFblAFyIshBYAploe09NQzsywV4e7G3OpsdWsF2vtSNqdOl0Qw==
X-Received: by 2002:a9d:2a9:0:b0:693:d9a5:c5d with SMTP id 38-20020a9d02a9000000b00693d9a50c5dmr15157567otl.3.1678642937395;
        Sun, 12 Mar 2023 10:42:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c26-20020a9d615a000000b0068bbc9e7cc9sm2315725otk.53.2023.03.12.10.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 10:42:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 12 Mar 2023 10:42:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Leonard Anderweit <leonard.anderweit@gmail.com>
Cc:     linux-hwmon@vger.kernel.org,
        Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] hwmon: (aquacomputer_d5next) Support writing
 multiple control values at once
Message-ID: <1f75ef1e-6efa-4148-a387-c4b10783b477@roeck-us.net>
References: <20230214220221.15003-1-leonard.anderweit@gmail.com>
 <20230214220221.15003-3-leonard.anderweit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214220221.15003-3-leonard.anderweit@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 11:02:17PM +0100, Leonard Anderweit wrote:
> Add new function aqc_set_ctrl_vals() to support changing multiple control
> values at once while sending only one control report.
> 
> Signed-off-by: Leonard Anderweit <leonard.anderweit@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/aquacomputer_d5next.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> index babfd998e70c..f0c036d38e91 100644
> --- a/drivers/hwmon/aquacomputer_d5next.c
> +++ b/drivers/hwmon/aquacomputer_d5next.c
> @@ -574,9 +574,9 @@ static int aqc_get_ctrl_val(struct aqc_data *priv, int offset, long *val, int ty
>  	return ret;
>  }
>  
> -static int aqc_set_ctrl_val(struct aqc_data *priv, int offset, long val, int type)
> +static int aqc_set_ctrl_vals(struct aqc_data *priv, int *offsets, long *vals, int *types, int len)
>  {
> -	int ret;
> +	int ret, i;
>  
>  	mutex_lock(&priv->mutex);
>  
> @@ -584,15 +584,17 @@ static int aqc_set_ctrl_val(struct aqc_data *priv, int offset, long val, int typ
>  	if (ret < 0)
>  		goto unlock_and_return;
>  
> -	switch (type) {
> -	case AQC_BE16:
> -		put_unaligned_be16((s16)val, priv->buffer + offset);
> -		break;
> -	case AQC_8:
> -		priv->buffer[offset] = (u8)val;
> -		break;
> -	default:
> -		ret = -EINVAL;
> +	for (i = 0; i < len; i++) {
> +		switch (types[i]) {
> +		case AQC_BE16:
> +			put_unaligned_be16((s16)vals[i], priv->buffer + offsets[i]);
> +			break;
> +		case AQC_8:
> +			priv->buffer[offsets[i]] = (u8)vals[i];
> +			break;
> +		default:
> +			ret = -EINVAL;
> +		}
>  	}
>  
>  	if (ret < 0)
> @@ -605,6 +607,11 @@ static int aqc_set_ctrl_val(struct aqc_data *priv, int offset, long val, int typ
>  	return ret;
>  }
>  
> +static int aqc_set_ctrl_val(struct aqc_data *priv, int offset, long val, int type)
> +{
> +	return aqc_set_ctrl_vals(priv, &offset, &val, &type, 1);
> +}
> +
>  static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u32 attr, int channel)
>  {
>  	const struct aqc_data *priv = data;
