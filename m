Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183C366548E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 07:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbjAKG2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 01:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbjAKG1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 01:27:41 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D9D9FC3;
        Tue, 10 Jan 2023 22:27:41 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id n8so12057608oih.0;
        Tue, 10 Jan 2023 22:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ixmkmHu8NTp7dK6kZhsdW/K/uaPlSDSm0glmOx3Ooes=;
        b=F5aQiBqRGZdfteP7EcdMzz494/16uhwEd3KRi66+cDHYaYMmUyLJ6my49+y7zZHL7d
         W1Q/UhK6QhI/vKeY0MHQp0uab6AFHeX1ahtM5qSIbCpJZJT6VoSl5zDvS7ga0H7Gt94+
         yJGuXz8bGcxDzsdKp6aeW79LrNPlb2Gw5mLVIsx2LE8p+Nbc/j11GddVAAzPFrds87hn
         fVLkJxuGKxtjKnNFlTVG9C1r09WKQispi0WvMnSMfciKolM0QcfKe6ayCMT/j5/+tTuN
         Iq+d9kZtEng/3nWIWaRDti+Cy+haSKWK68DzU2moJjdWyIUWL53FaWInK4jyEN0xdWWJ
         +NSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ixmkmHu8NTp7dK6kZhsdW/K/uaPlSDSm0glmOx3Ooes=;
        b=Tz9iZkey+e81jeKBlwEZPIvsNtuR41D9HOtv5WuUU/Czi5WlOr8vmV8io/WVAyfB4h
         smnGbtrmR1+L9ngxldmxQNjlOepNGXxQHQRph4fm4zdB4diQb+P6tWHYXf2W+26fCXCo
         p3WHA83hp+C4E8YX+JWLrvYBkchJi6fL9cOoptf4ev6UrZVumORSnQhtFh9Pj+iviQYO
         ZLDbB14l4euUDozqOAcLKHFUmhTj6UJLKZGCbjdRjeqBVKWg5ckVa1YXmYWWh0WZgUYS
         1QOHlrQhTiHGW1qpGZkRHkaxJucSmgggaB3jhoqdJjSF85N00A99rJwG5XQTvnZo3QI0
         mKwA==
X-Gm-Message-State: AFqh2kpgn9VY23MOvc/31JPmDp4Nps1kGBG3P3wUgV4/8MekDRvDbTDR
        OtnGqPAkG8eF/03TS2iQz90=
X-Google-Smtp-Source: AMrXdXu6zyOBEi1Ixq0o6TD4uHh2swPzGFv5DkgyLIFG2wrpAKCbtEi6V23VAEts1ET8NQ6BGPyliw==
X-Received: by 2002:aca:908:0:b0:363:ab67:ee35 with SMTP id 8-20020aca0908000000b00363ab67ee35mr453360oij.56.1673418460355;
        Tue, 10 Jan 2023 22:27:40 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s4-20020a056808008400b0035028730c90sm6305366oic.1.2023.01.10.22.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 22:27:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 10 Jan 2023 22:27:37 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     XU pengfei <xupengfei@nfschina.com>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 1/1] hwmon: powr1220: remove unnecessary (void*)
 conversions
Message-ID: <20230111062737.GA2257783@roeck-us.net>
References: <20230111043729.3792-1-xupengfei@nfschina.com>
 <efbc4e6f-b583-239b-439b-6ebc01ffe44d@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <efbc4e6f-b583-239b-439b-6ebc01ffe44d@gnuweeb.org>
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

On Wed, Jan 11, 2023 at 01:15:17PM +0700, Ammar Faizi wrote:
> On 1/11/23 11:37 AM, XU pengfei wrote:
> > Pointer variables of void * type do not require type cast.
> > 
> > Signed-off-by: XU pengfei <xupengfei@nfschina.com>
> > ---
> >   drivers/hwmon/powr1220.c | 2 +-
> >   1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/hwmon/powr1220.c b/drivers/hwmon/powr1220.c
> > index f77dc6db31ac..501337ee5aa3 100644
> > --- a/drivers/hwmon/powr1220.c
> > +++ b/drivers/hwmon/powr1220.c
> > @@ -174,7 +174,7 @@ static umode_t
> >   powr1220_is_visible(const void *data, enum hwmon_sensor_types type, u32
> >   		    attr, int channel)
> >   {
> > -	struct powr1220_data *chip_data = (struct powr1220_data *)data;
> > +	struct powr1220_data *chip_data = data;
> 
> Broken:
> 
>   CC [M]  drivers/hwmon/powr1220.o
> drivers/hwmon/powr1220.c: In function ‘powr1220_is_visible’:
> drivers/hwmon/powr1220.c:177:43: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
>   177 |         struct powr1220_data *chip_data = data;
>       |                                           ^~~~
> cc1: all warnings being treated as errors
> make[2]: *** [scripts/Makefile.build:249: drivers/hwmon/powr1220.o] Error 1
> make[1]: *** [scripts/Makefile.build:465: drivers/hwmon] Error 2
> make: *** [Makefile:1853: drivers] Error 2
> 

Thanks for catching. Sigh. Wouldn't it be nice if submitters would
at least build test their patches ?

Guenter
