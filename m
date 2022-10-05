Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADB55F59CB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 20:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiJESWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 14:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiJESWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:22:18 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D133F1D0DB;
        Wed,  5 Oct 2022 11:22:17 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d24so16086175pls.4;
        Wed, 05 Oct 2022 11:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=ew1KzaMZB2UQ5VucTvfss7Xr/U7zQI7sIMbCwguxP34=;
        b=JMNKBLKoL9+FHH/alpZW0Hn0gW7sQBArMd7BWn8bJFiK72mZ94mMf6v16joMgfr3Vq
         H2Sh3uq9+tTK+AHe2KSrMzu6FrMv4BxtPQ3AbMiXv573rKRdcmc9DReJePEHa+PNVlCx
         Jn4AYl7rot5NtJ8gK/SHY0pzEftHyddFZa36NnbAa/82KGo/6fz6ppaMF1mHHzyEmoP4
         oG5KuoPnLComhCMrUQm83FCXq1UvPU0eVFZEe7shvD59TXedsVeurGlrWMCc3F8MZmx6
         BuB5T+qBOH5awmXHKc7pS0GCZQ/1jlpJ3sncx9FelWz8aIAE1wufJ0sMXN7D0LucQsIW
         DCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ew1KzaMZB2UQ5VucTvfss7Xr/U7zQI7sIMbCwguxP34=;
        b=jIqHyHlcc3vbL82jTeOnDHP0KqbDuHYobP9xsw8ZJIgFFQP6v8S6fvVb8a2wQDYfgu
         heVclvKHJdFUPMtIm+9+lVBFKCcqvPGTpg+62CcrBy5tyIzZIKd9YtZNcJGQ0rPiUWrN
         46j6T2R0GwfHai4fQ/3+Ng0q98LF6B2J5miZNmEj1huvV9bZCp+Llaws4/+Uhl678zp+
         8BhdojfCBjP5/3WF+7tIsIJrwcc96Ds4LmGlp+JFBl4wsSHZbB3lQThxEJIO+SgC3xzO
         iWiKcXi8uXjccmfVZuoyUsa0kTJ0p5zUUzefwYpBukrCs0QKI+7sG/52XauOV6ysrlC8
         EjcQ==
X-Gm-Message-State: ACrzQf0XH/5X6D2YEIS7LI6DguSy5awn3RX3ca2+E1TLDc9b5q2F0fTT
        JkMj7ghAnJGWaVeLCiRSNc4=
X-Google-Smtp-Source: AMsMyM7/H7xXF23O4LlfdFiUbevSnzBIi4oBC0c6gbSnE+eX4uX3QUh6kKxXuvvYtBHQHCFEbboqTQ==
X-Received: by 2002:a17:90b:3a88:b0:209:f35d:ad53 with SMTP id om8-20020a17090b3a8800b00209f35dad53mr6419802pjb.102.1664994137363;
        Wed, 05 Oct 2022 11:22:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r38-20020a635166000000b0043c22e926f8sm25510pgl.84.2022.10.05.11.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 11:22:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 5 Oct 2022 11:22:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: corsair-psu: fix typo in USB id description
Message-ID: <20221005182215.GA2626047@roeck-us.net>
References: <Yzql13NOvQLlrye1@monster.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yzql13NOvQLlrye1@monster.localdomain>
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

On Mon, Oct 03, 2022 at 09:05:27AM +0000, Wilken Gottwalt wrote:
> Fixes: 0cf46a653bda ("hwmon: (corsair-psu) add USB id of new revision of the HX1000i psu")
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>

Applied. In the future, please add some description (subject is
insufficient).

Thanks,
Guenter

> ---
>  drivers/hwmon/corsair-psu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> index 345d883ab044..c1c27e475f6d 100644
> --- a/drivers/hwmon/corsair-psu.c
> +++ b/drivers/hwmon/corsair-psu.c
> @@ -820,7 +820,7 @@ static const struct hid_device_id corsairpsu_idtable[] = {
>  	{ HID_USB_DEVICE(0x1b1c, 0x1c0b) }, /* Corsair RM750i */
>  	{ HID_USB_DEVICE(0x1b1c, 0x1c0c) }, /* Corsair RM850i */
>  	{ HID_USB_DEVICE(0x1b1c, 0x1c0d) }, /* Corsair RM1000i */
> -	{ HID_USB_DEVICE(0x1b1c, 0x1c1e) }, /* Corsaur HX1000i revision 2 */
> +	{ HID_USB_DEVICE(0x1b1c, 0x1c1e) }, /* Corsair HX1000i revision 2 */
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(hid, corsairpsu_idtable);
