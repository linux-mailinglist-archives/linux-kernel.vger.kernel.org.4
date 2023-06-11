Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3F572B2CB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 18:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjFKQIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 12:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjFKQIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 12:08:35 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F843DA;
        Sun, 11 Jun 2023 09:08:34 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f7378a74faso24730475e9.0;
        Sun, 11 Jun 2023 09:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686499713; x=1689091713;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zs3DLomxIFzr5qN9jyuKOzT/qBtYRneb/f83TZYlMhQ=;
        b=JbOBqn+FSBz6c7Dxef2qMKuuBGapPzGGSt+EhmqQuLqlSia5KP46v0Fyuevc9q8dG6
         Fnmhy7nCqlfM7RTGDxoO4nyLC8ZqBa9PIMaM7GasBmCC2L+OsEBmNfykkj3dIgxr735H
         iZALnsIc6KrkDVHFDhJOASIsn1duvc4QQa9skhuVB741T8TH+7s4pldaou9PKT7OwrXh
         zHq3nncI9oYuKnHPDPQDPC/mxACmbnQk9EI67+dvp5Yd0NDEurUprfQOHm0o95de1ee9
         NBbHSL8TgrPsn9uLNlh2UKaRmONpZNYi3nF8Nn+8uMD3gg0j6QSo1L/V7SsO4fep1sMp
         s4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686499713; x=1689091713;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zs3DLomxIFzr5qN9jyuKOzT/qBtYRneb/f83TZYlMhQ=;
        b=K53rkTPoi3SCJyadevZSb5vL0josUpSu1RupAr5WxeyXLfRvaysvBiO1lGDZ3ZSUhY
         jcv2Q5gc9HjVM4EaL+o3olKlja0i24IKfqFNYd/AAhsfa2Goa8tmEGYy4DVSmQWgUxC/
         KoOIKWI6OHuuChvn37UZ8ztt1Abi0elxR3Hyp0HxAnoVYAmyhqFxXCMMYe80VvSJtfJG
         FCzl6eT7BGLEs0qWN/2iOW80KYFHJkmj8dzvKmZ4O333YeGcNv/+Vb0zeIgH67UsENbK
         F8MQ85cWd/ZR5LI4zH575Vo3gLo1U8FIUtg/EANSw1re96Jv8/0jSykv+Pe0IT5K2sMA
         UkUg==
X-Gm-Message-State: AC+VfDxTsYrjJK2B0YEh5RXysQbXVq9esQ+67/r+P49urkRBh9ZGIrLn
        Jku4LFuCXRxsEeTCEzf2iFs=
X-Google-Smtp-Source: ACHHUZ6zQs4ICcroWCavb87/AreeqtATFAIo8cwnU9nQgdIoGsuiwefdLLwnpUMw8ZdNksNTlth5lA==
X-Received: by 2002:a1c:6a0b:0:b0:3f6:da2:bc83 with SMTP id f11-20020a1c6a0b000000b003f60da2bc83mr4193248wmc.33.1686499712646;
        Sun, 11 Jun 2023 09:08:32 -0700 (PDT)
Received: from Ansuel-xps. (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.gmail.com with ESMTPSA id y3-20020a5d6203000000b003062c0ef959sm10000506wru.69.2023.06.11.09.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 09:08:32 -0700 (PDT)
Message-ID: <6485f180.5d0a0220.31c81.a179@mx.google.com>
X-Google-Original-Message-ID: <ZIV9xMax++69T0+c@Ansuel-xps.>
Date:   Sun, 11 Jun 2023 09:54:44 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] leds: trigger: netdev: add additional specific
 link duplex mode
References: <20230610041616.21141-1-ansuelsmth@gmail.com>
 <20230610041616.21141-3-ansuelsmth@gmail.com>
 <bc342289-5008-490d-b98f-6826a11574b3@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc342289-5008-490d-b98f-6826a11574b3@lunn.ch>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 11, 2023 at 06:01:46PM +0200, Andrew Lunn wrote:
> >  static ssize_t device_name_show(struct device *dev,
> > @@ -230,6 +241,7 @@ static int set_device_name(struct led_netdev_data *trigger_data,
> >  
> >  	trigger_data->carrier_link_up = false;
> >  	trigger_data->link_speed = 0;
> > +	trigger_data->duplex = 0;
> 
> /* Duplex, half or full. */
> #define DUPLEX_HALF		0x00
> #define DUPLEX_FULL		0x01
> #define DUPLEX_UNKNOWN		0xff
> 
> You probably want to initialise it to DUPLEX_UNKNOWN, not DUPLEX_HALF.
> 
> There is also SPEED_UNKNOWN, which might be good to use, rather than
> 0.
>

Nice catch!

Fun this for SPEED_UNKNOWN. The value is -1 but the speed type is
unsigned (I used the same definition from ksettings)

So from what I can see ksettings report 0 (I assume) but other struct
(link_mode_info) use speed as int and correctly use SPEED_UNKNOWN.

So I guess for speed we should stick to 0?

-- 
	Ansuel
