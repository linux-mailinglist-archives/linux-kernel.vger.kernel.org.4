Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211575FCBB4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 21:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJLTq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 15:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJLTqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 15:46:21 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA16C9DD92
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 12:46:20 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id u71so8885082pgd.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 12:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ziKrp+EXj/Jcjg6bjdAH2WyjL4ZEXqf7YYoBHqSFhQk=;
        b=ORTJzoSxjClvoDX83+uN7SHaBapCwExOHeh1Cxp6DnZ9utVinBgs8SVRoanOe+++yg
         Rhr9CHl6v7dlKsbwL265HCg/w21Q+58HzSGamqfMx10DzbbjO3CKZqMqHPe6czkstBAH
         ESdDm8LuM0V6LXXDQNr7jLnZdIPTm/sehLUUBbkE1m4oudsVrRIiCDFxJZSHNs3SwYNY
         qU5S05lcuO2No1hbejiwFCWmng2aKGYZDLUToTibteK7E533n76mUIbAtcAJTWkIpp7M
         fHJlSqFabtcSg8awywfjYwWC4t9cnx1bGl6tHoyJRJ75JMMeA/DFQ3n7Q0FJev84mhOr
         1Dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ziKrp+EXj/Jcjg6bjdAH2WyjL4ZEXqf7YYoBHqSFhQk=;
        b=HJ+oZvu+7IvMiAbVBtmREe8EtXGlSIsQ8aFufRoKB6TXrR4HonPVJljfoXZ58LkjeI
         BRTDSaWPyG8H8OYjr2oj+x9vhfYpa1b8QNTH4gp6tUCbhMeF7Y2/0uOGvnXaFj06FUO3
         f4/C52iF+AgKeolHNyFW2lJyOJWh8vQ5SjBskB4y8Eou4v9PjwdpSxRmD/PPujZ0WwgV
         01h5Tt1a2g9YyPwLA4JbUKbYhLJLo1ylK5whqhygtGpU8yWRJC2OboBprEfW7cOD1Rkh
         dhnbm18b9+wQhU/TzWCcgbuP7TTxqZaf1hqbWdsyRNXRE2m8EsvsEd+5qfXKnPUoQD8G
         d6ww==
X-Gm-Message-State: ACrzQf0d5+tOo8stY+vXYUfJOmf+oUTFBSy7P3l6Y5UkYJ+6Xx+AzT5G
        ei/eiydcYpfUfbSUemK9xBM=
X-Google-Smtp-Source: AMsMyM4GjpZuBejJX+/vGwjbNwT4SsamzhcGKVe7m2t5LjPiAUR+eH1y2XidbbErA7WYOFkRLzgzfQ==
X-Received: by 2002:a63:191d:0:b0:434:4bb3:e016 with SMTP id z29-20020a63191d000000b004344bb3e016mr27467827pgl.133.1665603979945;
        Wed, 12 Oct 2022 12:46:19 -0700 (PDT)
Received: from [172.30.1.63] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id e13-20020a170902784d00b00180a7ff78ccsm9301489pln.126.2022.10.12.12.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 12:46:19 -0700 (PDT)
Message-ID: <995fc676-0c16-cc8c-ce2d-01fd38a1300e@gmail.com>
Date:   Thu, 13 Oct 2022 04:46:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drivers/extcon: use simple i2c probe
Content-Language: en-US
To:     Stephen Kitt <steve@sk2.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-kernel@vger.kernel.org
References: <20221012141846.3916480-1-steve@sk2.org>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20221012141846.3916480-1-steve@sk2.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Looks good to me. Could you change the patch title as following:
-  extcon: Use simple i2c probe

On 22. 10. 12. 23:18, Stephen Kitt wrote:
> All these drivers have an i2c probe function which doesn't use the
> "struct i2c_device_id *id" parameter, so they can trivially be
> converted to the "probe_new" style of probe with a single argument.
> 
> This is part of an ongoing transition to single-argument i2c probe
> functions. Old-style probe functions involve a call to i2c_match_id:
> in drivers/i2c/i2c-core-base.c,
> 
>          /*
>           * When there are no more users of probe(),
>           * rename probe_new to probe.
>           */
>          if (driver->probe_new)
>                  status = driver->probe_new(client);
>          else if (driver->probe)
>                  status = driver->probe(client,
>                                         i2c_match_id(driver->id_table, client));
>          else
>                  status = -EINVAL;
> 
> Drivers which don't need the second parameter can be declared using
> probe_new instead, avoiding the call to i2c_match_id. Drivers which do
> can still be converted to probe_new-style, calling i2c_match_id
> themselves (as is done currently for of_match_id).
> 
> This change was done using the following Coccinelle script, and fixed
> up for whitespace changes:
> 
> @ rule1 @
> identifier fn;
> identifier client, id;
> @@
> 
> - static int fn(struct i2c_client *client, const struct i2c_device_id *id)
> + static int fn(struct i2c_client *client)
> {
> ...when != id
> }
> 
> @ rule2 depends on rule1 @
> identifier rule1.fn;
> identifier driver;
> @@
> 
> struct i2c_driver driver = {
> -       .probe
> +       .probe_new
>                 =
> (
>                    fn
> |
> -                  &fn
> +                  fn
> )
>                 ,
> };
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
>  drivers/extcon/extcon-fsa9480.c      | 5 ++---
>  drivers/extcon/extcon-rt8973a.c      | 5 ++---
>  drivers/extcon/extcon-usbc-tusb320.c | 5 ++---
>  3 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-fsa9480.c b/drivers/extcon/extcon-fsa9480.c
> index 7cff66c29907..e8b2671eb29b 100644
> --- a/drivers/extcon/extcon-fsa9480.c
> +++ b/drivers/extcon/extcon-fsa9480.c
> @@ -257,8 +257,7 @@ static irqreturn_t fsa9480_irq_handler(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> -static int fsa9480_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int fsa9480_probe(struct i2c_client *client)
>  {
>  	struct fsa9480_usbsw *info;
>  	int ret;
> @@ -370,7 +369,7 @@ static struct i2c_driver fsa9480_i2c_driver = {
>  		.pm		= &fsa9480_pm_ops,
>  		.of_match_table = fsa9480_of_match,
>  	},
> -	.probe			= fsa9480_probe,
> +	.probe_new		= fsa9480_probe,
>  	.id_table		= fsa9480_id,
>  };
>  
> diff --git a/drivers/extcon/extcon-rt8973a.c b/drivers/extcon/extcon-rt8973a.c
> index e6e448f6ea2f..afc9b405d103 100644
> --- a/drivers/extcon/extcon-rt8973a.c
> +++ b/drivers/extcon/extcon-rt8973a.c
> @@ -548,8 +548,7 @@ static void rt8973a_init_dev_type(struct rt8973a_muic_info *info)
>  	}
>  }
>  
> -static int rt8973a_muic_i2c_probe(struct i2c_client *i2c,
> -				 const struct i2c_device_id *id)
> +static int rt8973a_muic_i2c_probe(struct i2c_client *i2c)
>  {
>  	struct device_node *np = i2c->dev.of_node;
>  	struct rt8973a_muic_info *info;
> @@ -696,7 +695,7 @@ static struct i2c_driver rt8973a_muic_i2c_driver = {
>  		.pm	= &rt8973a_muic_pm_ops,
>  		.of_match_table = rt8973a_dt_match,
>  	},
> -	.probe	= rt8973a_muic_i2c_probe,
> +	.probe_new = rt8973a_muic_i2c_probe,
>  	.remove	= rt8973a_muic_i2c_remove,
>  	.id_table = rt8973a_i2c_id,
>  };
> diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
> index 6ba3d89b106d..ca752ddf7763 100644
> --- a/drivers/extcon/extcon-usbc-tusb320.c
> +++ b/drivers/extcon/extcon-usbc-tusb320.c
> @@ -230,8 +230,7 @@ static const struct regmap_config tusb320_regmap_config = {
>  	.val_bits = 8,
>  };
>  
> -static int tusb320_extcon_probe(struct i2c_client *client,
> -				const struct i2c_device_id *id)
> +static int tusb320_extcon_probe(struct i2c_client *client)
>  {
>  	struct tusb320_priv *priv;
>  	const void *match_data;
> @@ -313,7 +312,7 @@ static const struct of_device_id tusb320_extcon_dt_match[] = {
>  MODULE_DEVICE_TABLE(of, tusb320_extcon_dt_match);
>  
>  static struct i2c_driver tusb320_extcon_driver = {
> -	.probe		= tusb320_extcon_probe,
> +	.probe_new	= tusb320_extcon_probe,
>  	.driver		= {
>  		.name	= "extcon-tusb320",
>  		.of_match_table = tusb320_extcon_dt_match,
> 
> base-commit: 833477fce7a14d43ae4c07f8ddc32fa5119471a2


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
