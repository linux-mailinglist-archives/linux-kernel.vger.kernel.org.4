Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F25673C14
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjASOdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjASOc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:32:56 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E0F4A201;
        Thu, 19 Jan 2023 06:32:29 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so3714672wmb.2;
        Thu, 19 Jan 2023 06:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wS7HSylCm9otocOdYBhDnMFqnI4PKH4nfYFHOFNvW3g=;
        b=ZyeibTCU3dHPBSQm3WEHymYSJKlzsLGwKkfHxwUW+zHH042eB7+IP/Sj0sEQFz6Jcj
         qu4v3JFderI0jEofEgqUdNuzs2JAeJgMZqswIkfxy32njBcZthC3qWipijH92mL4KqFr
         +8sdV/pFoM6gcD4xk1Ql6rKYxJr19dAPyeJDJYd/yqx93L/crHwkdHENThnjCJptZ4u+
         uk5ORYgoPKm7KD0QUqFC276bwEUOnYm7ap9lWdW3bEFX77L55hRkf02Z68of/uzFMdal
         eoUdH52gXk0xreepJohtwXGYXwkv5zX4/k7+HKFW6/RuO7awltBN5yy01HaDHG4Iv5Sw
         79jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wS7HSylCm9otocOdYBhDnMFqnI4PKH4nfYFHOFNvW3g=;
        b=EsQzahXpVbQ1GqOYoZ+YVyFxxA1E/VYytUHWR/k4glZGkoQqTe8rvKhHW+Anafpv8y
         ntrqj8IQmKJXhf5PDVWzEujrBArehMf/T1Lb8eNrWrHm0nT8rlYJro5kcWyRbHGBszyI
         SEAbHuv8JXbXilyhM8ImsGUyg8mNFmR2TJyGaciFuV/EPNQG80u7EFyfPgUVc11tFkYm
         gtUZqjHlskp7lepdEFGVWp3cg4kGW6cS+IjIvC086zM7O6sSLGrNfQxuM2Ys0ZYkk0u/
         nvI9o953ZoM/2yH2qEdeEPCAV81Kmnr40fgbvSYvY3bzlHp2QGqmWeni+4r6oI6zyDQ4
         qDag==
X-Gm-Message-State: AFqh2kq9tOHtPF0WkALmTTIru2dcRL7GALsA6+zjfWeXIsQHBB4ZMkem
        ORO1Z+dFq18OE+wKocNtmlE=
X-Google-Smtp-Source: AMrXdXsk3J0ufP1mfd0P9SekZ3FFkzaf0xCJj0h4j/1DCaEarvPaz9ltTd8g8lO+rl2wWrcKN7nq4A==
X-Received: by 2002:a05:600c:1e19:b0:3da:2ba4:b97 with SMTP id ay25-20020a05600c1e1900b003da2ba40b97mr17848869wmb.19.1674138748164;
        Thu, 19 Jan 2023 06:32:28 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z4-20020a1cf404000000b003da2932bde0sm5701400wma.23.2023.01.19.06.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 06:32:27 -0800 (PST)
Date:   Thu, 19 Jan 2023 17:32:24 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RFC PATCH 1/4] staging: vc04_services: vchiq_core: Drop custom
 logging
Message-ID: <Y8lUeDjGZfe+/Ap3@kadam>
References: <20230118115810.21979-1-umang.jain@ideasonboard.com>
 <20230118115810.21979-2-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118115810.21979-2-umang.jain@ideasonboard.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 05:28:07PM +0530, Umang Jain wrote:
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> index 4e705a447a62..7b3c57326d28 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> @@ -227,10 +227,11 @@ static const char *msg_type_str(unsigned int msg_type)
>  static inline void
>  set_service_state(struct vchiq_service *service, int newstate)
>  {
> -	vchiq_log_info(vchiq_core_log_level, "%d: srv:%d %s->%s",
> -		       service->state->id, service->localport,
> -		       srvstate_names[service->srvstate],
> -		       srvstate_names[newstate]);
> +	struct vchiq_state *state = service->state;
> +
> +	dev_info(state->dev, "%d: srv:%d %s->%s", state->id,
> +		 service->localport, srvstate_names[service->srvstate],
> +		 srvstate_names[newstate]);

This should be a debug level printk.  Don't spam dmesg in the success
path.  Success should not be noteworthy.

>  	service->srvstate = newstate;
>  }

regards,
dan carpenter

