Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6C06C1B1D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjCTQRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjCTQR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:17:27 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086D930191;
        Mon, 20 Mar 2023 09:07:15 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-17ac5ee3f9cso13438324fac.12;
        Mon, 20 Mar 2023 09:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679328101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ycdbh/3im0d0MXCRS+MVRgOfUwsMwW5wd9W+JCKfV/o=;
        b=E+Pr8u9gmHBQZTNZQpUc9GvmZnrdszR9iS+GmECWvFOGiFG58/sXvKMBj66J9oYgrF
         Ax3wqSdk2q7Gv/Ewv0qKdreErNrtDXfMenESWsR5yB1b+hmUtAtq7ypozTdq0kMv5mHb
         SoTrRSsxM7BigWl6S73GK8jB/+JZATNbTt0hyjitN9HaLeaV/UjKXIsru+WJMcYfI6Qt
         bfMEn87SzBcSPYrQXaTDGP4oZf+vJDHOE8zOnYHAlKgzFElKGkvJpsXWNc6SKg6g5Ptd
         hYmAl/3pF6eXUa4UKxtjHhAJyVX+oSRvnTbUjWfkX8LZ0Kc2wVFhmvvnoJyoeqoCAn+I
         tLxA==
X-Gm-Message-State: AO0yUKVo/HF1Hy8w2GoV2jXcKIPAMujWIDZp7gTt9aC7TphY0Hcoqqxx
        L2qQfsN2L8uc33Qa1987vw==
X-Google-Smtp-Source: AK7set+BBHYnuq6OwVL9kjgfa2qix8lcrHAvO1bkzPcA8ohY9QPJdfChG4+hLAEfhyzub/UAI84YdA==
X-Received: by 2002:a05:6870:330a:b0:177:b026:3cda with SMTP id x10-20020a056870330a00b00177b0263cdamr5812793oae.37.1679328099533;
        Mon, 20 Mar 2023 09:01:39 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id tb7-20020a05687186c700b0017630fe87e5sm3404469oab.33.2023.03.20.09.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 09:01:39 -0700 (PDT)
Received: (nullmailer pid 1764454 invoked by uid 1000);
        Mon, 20 Mar 2023 16:01:37 -0000
Date:   Mon, 20 Mar 2023 11:01:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Drake <drake@endlessm.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH 02/11] dt-bindings: serial: snps-dw-apb-uart: Relax
 dma-names order constraint
Message-ID: <20230320160137.GB1755078-robh@kernel.org>
References: <20230315114806.3819515-1-cristian.ciocaltea@collabora.com>
 <20230315114806.3819515-3-cristian.ciocaltea@collabora.com>
 <3679f2d0-55f0-1710-abc2-b268b6fc6969@linaro.org>
 <8ae57fe3-56aa-7e50-3eaa-a12a40657baf@collabora.com>
 <80796828-7b38-184a-2e8e-3cfe9158b67f@linaro.org>
 <13cb8dbd-994c-4b38-b715-44a3bf3d278d@spud>
 <e81f02f2-e692-e4ef-1510-fdc285dd5964@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e81f02f2-e692-e4ef-1510-fdc285dd5964@collabora.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 07:43:53PM +0200, Cristian Ciocaltea wrote:
> On 3/17/23 18:26, Conor Dooley wrote:
> > On Fri, Mar 17, 2023 at 04:54:47PM +0100, Krzysztof Kozlowski wrote:
> > > On 17/03/2023 11:21, Cristian Ciocaltea wrote:
> > > > On 3/17/23 10:31, Krzysztof Kozlowski wrote:
> > > > > On 15/03/2023 12:47, Cristian Ciocaltea wrote:
> > > > > > Commit 370f696e4474 ("dt-bindings: serial: snps-dw-apb-uart: add dma &
> > > > > > dma-names properties") documented dma-names property to handle Allwiner
> > > > > > D1 dtbs_check warnings, but relies on a strict rx->tx ordering, which is
> > > > > > the reverse of what a different board expects:
> > > > > > 
> > > > > >     rk3326-odroid-go2.dtb: serial@ff030000: dma-names:0: 'rx' was expected
> > > > > > 
> > > > > > A quick and incomplete check shows the inconsistency is present in many
> > > > > > other DT files:
> > > > > 
> > > > > Why not fixing the DTS? The properties should have fixed order.
> > > > 
> > > > I was initially concerned about the risk of a potential ABI breakage,
> > > > but I think that's not really a problem since dma-names is not directly
> > > > accessed in the driver and DT Kernel API doesn't rely on a particular order.
> > > > 
> > > > If there are no objections, I would switch the order in the binding to
> > > > tx->rx, since that's what most of the DTS use, and fix the remaining ones.
> > > 
> > > Since we added the order recently, I rather assume it is the correct or
> > > preferred one.
> > 
> > IIRC I checked around the other serial bindings & there was not a
> > consistent order that all serial bindings used, so I picked the order that
> > was used across the various allwinner boards that do use dma-names.
> 
> Thanks for clarifying this, Conor! Would it be fine to switch to tx->rx
> order as it requires less changes to fix the inconsistencies?
> 
> > Before changing dts files, it's probably a good idea to make sure that
> > the dma-names are not used somewhere outside of Linux.
> 
> Right, that means we cannot exclude the ABI breakage concern. Not sure how
> easy would be to actually verify this. Hence I wonder if there is really no
> chance to allow the flexible order in the binding..

If it changes and someone complains, then yes we'll allow flexible 
order.

Rob
