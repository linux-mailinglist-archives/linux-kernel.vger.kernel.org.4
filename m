Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C608F738984
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbjFUPgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbjFUPg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:36:27 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A426410D2;
        Wed, 21 Jun 2023 08:36:01 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6687466137bso2198781b3a.0;
        Wed, 21 Jun 2023 08:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687361755; x=1689953755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/VLyHKxS+lH/Fue6XmqBO/Tpruco+NZkj5IzkvO/H/A=;
        b=ixIcm9YgMHpHuG6PX0p2ttszK5ATZpcE5fHf7NLlE99PK6ileRl4ixJLdqQnvYbxQG
         yEpOECtg7epSzcDoVRW7tE4KRkWpdbioLUT+4/OkwiJOZoRa3JxG7b+Y/HgmwCgpPJwS
         tj+OKiojM3Wum14Vq73Lh6+k+kHGTK00/iD1TVU99f/vbotMAOjznmlxb9Xu3SogIvTr
         2OtS95bxu2I+sxvIso2Mlpg0mIkjh54RLQolb5I61895LhEIHYNj9FgoZKMKIqSiCO8y
         nHtDufvicrjVIee7SqAYCRFgI0+5ahHUr3ARpxuvILpB2K3H4Kt74MtMIqA+NFqyyAcW
         NPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687361755; x=1689953755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/VLyHKxS+lH/Fue6XmqBO/Tpruco+NZkj5IzkvO/H/A=;
        b=QMp1yOSCxPLCs2KG4rw1y9TFtKM+F4/T5jaVMZ4TGsJzMbFlCcZVCV3webolDr3ulO
         m45UVT9rTg23Y564r+HcR5Q85QDFQwsnRIP7RpQsw7OdN4emB1VUzRLySxGlkfJo9Fwc
         gHF0OsCuxzlOXyiJMrmY8h0/nfBXgrnkK9KKXu0sbGKnTnR1DNhj6KwgrVhLLL4hOMBK
         DdaAU96oTia32yRsKijBKtjo2sLK2pjdh/7ouUyFTZxr1PY6KcAGhSfbRsS+eoj2eRKn
         2QPe3hmV5h6y4C5//D/M4Z+32EP1dTyH5IKLmj7lCh3yUaIzNo9QT3oqUUi+w91G4ZhN
         gYjA==
X-Gm-Message-State: AC+VfDwYieg5AwbLqIuqBamr1Y64jedDWILOCHlZNPltzeb/7xrEz4ds
        JT40o1QmKmHHigW9ojd9iVOo7HGVi8I=
X-Google-Smtp-Source: ACHHUZ7AKJiw6/b1SiHTwE6EOrMO+Ol1BOWipmyfA+Th0QGtP2sCbKf6NTxDo8CMLUo4aVwacs82Tg==
X-Received: by 2002:a17:90a:c08b:b0:25e:83a7:abab with SMTP id o11-20020a17090ac08b00b0025e83a7ababmr10508156pjs.8.1687361755067;
        Wed, 21 Jun 2023 08:35:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a1a5300b0025de9b9542dsm1275973pjl.39.2023.06.21.08.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:35:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 21 Jun 2023 08:35:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     JuenKit Yip <JuenKit_Yip@hotmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] hwmon: (sht3x) add device-tree support
Message-ID: <6673f3d4-b6d6-4024-8d44-2f120649d937@roeck-us.net>
References: <20230621035937.58721-1-JuenKit_Yip@hotmail.com>
 <DB4PR10MB62611629FD3764FB7FF61D24925DA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB4PR10MB62611629FD3764FB7FF61D24925DA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 11:59:37AM +0800, JuenKit Yip wrote:
> add "compatible" property for supporting device-tree
> 
> Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>
> ---
>  drivers/hwmon/sht3x.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
> index 31013b5b6..edcf6820c 100644
> --- a/drivers/hwmon/sht3x.c
> +++ b/drivers/hwmon/sht3x.c
> @@ -923,8 +923,18 @@ static const struct i2c_device_id sht3x_ids[] = {
>  
>  MODULE_DEVICE_TABLE(i2c, sht3x_ids);
>  
> +/* devicetree ID table */
> +static const struct of_device_id sht3x_of_match[] = {
> +	{ .compatible = "sensirion,sht3x" },
> +	{ .compatible = "sensirion,sts3x" },

Also needs a separate patch addding the two devices
to Documentation/devicetree/bindings/trivial-devices.yaml.

> +	{},
> +};
> +
>  static struct i2c_driver sht3x_i2c_driver = {
> -	.driver.name = "sht3x",
> +	.driver = {
> +		.name = "sht3x",
> +		.of_match_table = of_match_ptr(sht3x_of_match),
> +	},
>  	.probe       = sht3x_probe,
>  	.id_table    = sht3x_ids,
>  };
> -- 
> 2.30.2
> 
