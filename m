Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA08069CF1D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 15:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjBTOM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 09:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjBTOMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 09:12:25 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5C51F91F;
        Mon, 20 Feb 2023 06:11:58 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id d12so701681ioe.10;
        Mon, 20 Feb 2023 06:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EBElH3BvuvIrj3mnb9pXD0F6gHPRo5w0TtXJQc0FiP4=;
        b=pUdMMuHuTfgvF6A03N9mtScA294oFx8SIFeSDxSA7nMDIRSqEJnAHkOJePFc7uFewJ
         ZAT24BNgRxveVecxR8aEWhzQKBOrygtxdWguOyfd+4/n6cthVeeDYNnpRR22Z6b46o7o
         dnndLhcahfWD5MYOCyzZuSsAup1K1V/JdLSGi6Z/Zr4zbNFyBhrRsnawNXxQFqDCobrA
         a6yGUNcqI1YqEPbajJwigpa5CYB7LbDj2XibyglUzQ5KuFicVxuIlK4s1nCJihihT2oE
         5XMavM6yhdQplTQQLNzzw04SEPKZ8tuUMYqoVRefPixsBmuEPW12TjP6+pCa3gxXxslW
         WXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EBElH3BvuvIrj3mnb9pXD0F6gHPRo5w0TtXJQc0FiP4=;
        b=ibuDvnMcRjt6/a3HLLn1kq6hc0EkHfA4zRmx2ocQHSWhpYASF8lfg5mBhgxkkGLau7
         C5fGfUAGniF+ErnfqQubZ01Jn21PDcvRhCyqGqAvVCY70XPRqK1DE8zhNVjrvF+UjRqD
         HZKrqu4cqvOjkZCPRjYz7Fs4Fp8AkthBbyGNTekcRlQMvCurWI+VP7XSQY/DsrHHhn7J
         bnpyiQEbncpGmFjsL/7eAOCzD7VXYX95oz7x6IzgpSFpVOOTOadpha1Yb78wtPOKTFK7
         pqpCSL7lTgDFD8gNyN05nJESXWEjItZIN+EIDKCl5XWvGFXl/ZM9cwhXLuilJn73wuwS
         DxPg==
X-Gm-Message-State: AO0yUKVEcI0WCqKRa/Wt523hqecskmSoUi0/xa5D8BChBjyIKXdc/uyE
        6PPk0hHZ5/0B+SqOtCJE0BQ=
X-Google-Smtp-Source: AK7set8md893tbUHyyUdroilIrQeAp5tyUm4VXg2y5rHRmnUm1dzR6XrcjDghhciFTAXvJHZn0U1bA==
X-Received: by 2002:a6b:f205:0:b0:73c:137c:8ccc with SMTP id q5-20020a6bf205000000b0073c137c8cccmr7497275ioh.0.1676902316260;
        Mon, 20 Feb 2023 06:11:56 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e8-20020a5ed508000000b007407e365832sm4305174iom.23.2023.02.20.06.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 06:11:55 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 20 Feb 2023 06:11:54 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, rafael@kernel.org
Subject: Re: [PATCH v1 07/17] thermal/hwmon: Use the thermal API instead
 tampering the internals
Message-ID: <20230220141154.GB4009286@roeck-us.net>
References: <20230219143657.241542-1-daniel.lezcano@linaro.org>
 <20230219143657.241542-8-daniel.lezcano@linaro.org>
 <9ac3a59f-a3b7-4128-87d0-7b3310ce7828@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ac3a59f-a3b7-4128-87d0-7b3310ce7828@linaro.org>
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

On Mon, Feb 20, 2023 at 02:34:08PM +0100, Daniel Lezcano wrote:
> Hi Guenter,
> 
> my script should have Cc'ed you but it didn't, so just a heads up this patch
> ;)
> 
> On 19/02/2023 15:36, Daniel Lezcano wrote:
> > In this function, there is a guarantee the thermal zone is registered.
> > 
> > The sysfs hwmon unregistering will be blocked until we exit the
> > function. The thermal zone is unregistered after the sysfs hwmon is
> > unregistered.
> > 
> > When we are in this function, the thermal zone is registered.
> > 
> > We can call the thermal_zone_get_crit_temp() function safely and let
> > the function use the lock which is private the thermal core code.
> > 

Hmm, if you say so. That very same call used to cause a crash in
Chromebooks, which is why I had added the locking.

Guenter

> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---
> >   drivers/thermal/thermal_hwmon.c | 10 +---------
> >   1 file changed, 1 insertion(+), 9 deletions(-)
> > 
> > diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
> > index bc02095b314c..15158715b967 100644
> > --- a/drivers/thermal/thermal_hwmon.c
> > +++ b/drivers/thermal/thermal_hwmon.c
> > @@ -77,15 +77,7 @@ temp_crit_show(struct device *dev, struct device_attribute *attr, char *buf)
> >   	int temperature;
> >   	int ret;
> > -	mutex_lock(&tz->lock);
> > -
> > -	if (device_is_registered(&tz->device))
> > -		ret = tz->ops->get_crit_temp(tz, &temperature);
> > -	else
> > -		ret = -ENODEV;
> > -
> > -	mutex_unlock(&tz->lock);
> > -
> > +	ret = thermal_zone_get_crit_temp(tz, &temperature);
> >   	if (ret)
> >   		return ret;
> 
> -- 
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
