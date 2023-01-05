Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3AD65F24C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbjAERLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbjAERK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:10:29 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A18A5F490
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 09:05:37 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso1825261wmp.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 09:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FJixlQ1GykoHqS8SHplQyhydOL3TdEyk4X1Yp5oXx/g=;
        b=cMIwsyHRXIBkAdjHf9+poHxuHOnaua5emRDrEAudv/yjwWAxp2y3BDsgyepO7Bp/08
         UHcq/FF8GWUeYcPIeCclK+7hq/INaA/HKS2TlD5hXM405G81kkn+XWH1uW0P6e4MJipw
         7/cL+qb7eNfMIgf7lkjZY4XzPW7u6zH05tUAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FJixlQ1GykoHqS8SHplQyhydOL3TdEyk4X1Yp5oXx/g=;
        b=BfBCxS8096VwBEy4/ymKlR1PT8jyVbkhpkC4rk0C93o5cypyW83DA8pJtkmCLJAbM0
         OiYJ65bCll5w/GxpmOejNPnHK32eBCklpUvpqaSzEN1H+UDE+yiO+8stZ4SHJBbBrbsO
         IRl7/JIUj6p/00CyXOSHG7AY/WQhObZ4cxBTM12PuEzlKA21dhLMBxKL7jz87kphSg1t
         CNDEtKvFqMi4g3Fh27GcBuHcM9dcxBXRmBDTpQN4YKBQkZ1nccVBj9nZQo7JsRYCqDzy
         5MrquuGhukgV7tNXhl37o+pfizAiTf5Q9J3k/MVd4tcdrSdILoV6DjCblKtkIGpCibw4
         thGA==
X-Gm-Message-State: AFqh2krzbjU675tnxHlLpumJcPcljZ8m8NKWcQzbXFL4grJAckv6Rxl0
        xXmFQMqqINRsYVEOSRzud1WqlA==
X-Google-Smtp-Source: AMrXdXulm3e6OwSGP668gcm3GCIaP8TAxPpVjcWVNEDD2xvbKADT1Z3pfjuK1SXnyymhM84G8leJ9Q==
X-Received: by 2002:a05:600c:1da3:b0:3d0:965f:63ed with SMTP id p35-20020a05600c1da300b003d0965f63edmr37048312wms.23.1672938316522;
        Thu, 05 Jan 2023 09:05:16 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:990c:167e:ef8f:7586? ([2001:8b0:aba:5f3c:990c:167e:ef8f:7586])
        by smtp.gmail.com with ESMTPSA id u3-20020adff883000000b002423edd7e50sm37741054wrp.32.2023.01.05.09.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 09:05:16 -0800 (PST)
Message-ID: <edbb150d390bfe9b379593bfb02b010a13183d67.camel@linuxfoundation.org>
Subject: Re: [PATCH 01/27] ARM: pxa: remove unused board files
From:   Richard Purdie <richard.purdie@linuxfoundation.org>
To:     Dmitry Baryshkov <dbaryshkov@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Ales Bardorfer <ales@i-tech.si>,
        Ales Snuparek <snuparek@atlas.cz>,
        Alex Osborne <ato@meshy.org>,
        Alex Osborne <bobofdoom@gmail.com>,
        Dirk Opfer <dirk@opfer-online.de>, Ian Molton <spyro@f2s.com>,
        Lennert Buytenhek <kernel@wantstofly.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Michael Petchkovsky <mkpetch@internode.on.net>,
        Nick Bane <nick@cecomputing.co.uk>,
        Paul Parsons <lost.distance@yahoo.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Tomas Cech <sleep_walker@suse.cz>
Date:   Thu, 05 Jan 2023 17:05:14 +0000
In-Reply-To: <CALT56yPGbMZ7=2=wKzwjBCEtikE+2JmLzWeZgE9QxU5NSSmTyw@mail.gmail.com>
References: <20230105134622.254560-1-arnd@kernel.org>
         <20230105134622.254560-2-arnd@kernel.org>
         <CALT56yPGbMZ7=2=wKzwjBCEtikE+2JmLzWeZgE9QxU5NSSmTyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-01-05 at 17:50 +0200, Dmitry Baryshkov wrote:
> =D1=87=D1=82, 5 =D1=8F=D0=BD=D0=B2. 2023 =D0=B3. =D0=B2 15:46, Arnd Bergm=
ann <arnd@kernel.org>:
> >=20
> > From: Arnd Bergmann <arnd@arndb.de>
> >=20
> > The majority of all pxa board files has not been touched in a long time=
,
> > and no users have spoken up in favor of keeping them around. This leave=
s
> > only support for the platforms that were already converted to DT, as
> > well as the gumstix and spitz/akita/borzoi machines that work in qemu
> > and can still be converted to DT later.
>=20
> Well, tosa also works in qemu.
> Nevertheless:
> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

I'm kind of sad to see corgi at this point but it isn't really
surprising. The hardware is old/slow and likely not used by many
anymore, things have moved on and the systems ended up being heavily
kernel size footprint limited.

I'd just note that corgi (and shepherd/husky) are strongly related to
spitz/akita/borzoi, the difference is basically pxa25x vs pxa27x
processor and pin changes. We chose just to emulate one set in qemu but
the others would be relatively trivial.

tosa and poodle have much less in common with the other Zaurus devices.

I guess what I'm saying is that if spitz is remaining it might make
sense to have corgi with it.

Cheers,

Richard
