Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69ED26C1AEE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjCTQJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjCTQIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:08:38 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081AE2A6D2;
        Mon, 20 Mar 2023 08:58:15 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-17671fb717cso13478990fac.8;
        Mon, 20 Mar 2023 08:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679327893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8X5XJu7ZSmlXWJv7df3tWmayRZwNJIjgct+jX9CNF4=;
        b=XmZbEeMO0+JAm7P63ROWJ94IEAKKy0pcKRs3K0iaGFboKKx2VRo/D76MJjO8W4Nhe2
         x8pWdb6OR1fPrzO3IvlkAO7ezJpek+VK3A0fJFLTeNBSqxuLNqzvH2hJ1IlkftyzT0dg
         DP+e3VO/HDTR2XmQESHJwqmLttgpsNgrzqVmx1BYc05a90ONh5r8zpJjHZRrbPmIdVaV
         l/S/nPxvmNz7jhNawQkB8dYsEHJLEoF2SXj6xU/o13EggGYkJJ5CJhddihc6JfikZ/BF
         SKYGA/2QUF2jK2rR8R3aQGwuT+TCBlEK5sxNH3SUIrfmOexqiM67hLl+f8W2gQtsP1li
         fXLA==
X-Gm-Message-State: AO0yUKWmOObJkexlmWYmJO21nRLaRRJqW1kDfnjYUixboMC3PVDvvJ3y
        R98GRyaCeLJrBASuWalqWA==
X-Google-Smtp-Source: AK7set+FJqchAKh3aLkpaCyRS9ncCPb0CGLyZPm8rjBj3cImE2bhXeW/GwwFgbDKATBHmsueXL7IhQ==
X-Received: by 2002:a05:6870:7085:b0:17a:d1e6:5a09 with SMTP id v5-20020a056870708500b0017ad1e65a09mr5356989oae.59.1679327893498;
        Mon, 20 Mar 2023 08:58:13 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id vk10-20020a0568710e4a00b00172426ebe58sm3388588oab.27.2023.03.20.08.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 08:58:13 -0700 (PDT)
Received: (nullmailer pid 1758791 invoked by uid 1000);
        Mon, 20 Mar 2023 15:58:12 -0000
Date:   Mon, 20 Mar 2023 10:58:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
Message-ID: <20230320155812.GA1755078-robh@kernel.org>
References: <20230315114806.3819515-1-cristian.ciocaltea@collabora.com>
 <20230315114806.3819515-3-cristian.ciocaltea@collabora.com>
 <3679f2d0-55f0-1710-abc2-b268b6fc6969@linaro.org>
 <167904851367.26.16449705310108549543@mailman-core.alsa-project.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167904851367.26.16449705310108549543@mailman-core.alsa-project.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 12:21:41PM +0200, Cristian Ciocaltea via Alsa-devel wrote:
> Date: Fri, 17 Mar 2023 12:21:41 +0200
> From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Sudeep Holla
>  <sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>, Rob
>  Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
>  <krzysztof.kozlowski+dt@linaro.org>, Greg Kroah-Hartman
>  <gregkh@linuxfoundation.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
>  Brown <broonie@kernel.org>, Nicolas Frattaroli
>  <frattaroli.nicolas@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Jaroslav
>  Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Paul Walmsley
>  <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
>  <aou@eecs.berkeley.edu>, Daniel Drake <drake@endlessm.com>, Katsuhiro
>  Suzuki <katsuhiro@katsuster.net>
> CC: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
>  linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
>  alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org,
>  linux-riscv@lists.infradead.org, kernel@collabora.com
> Subject: Re: [PATCH 02/11] dt-bindings: serial: snps-dw-apb-uart: Relax
>  dma-names order constraint
> Message-ID: <8ae57fe3-56aa-7e50-3eaa-a12a40657baf@collabora.com>
> User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
>  Thunderbird/102.7.2

There is something strange going on with your mails as there are 2 
copies in the archives with the 2nd one getting the header twice. It's 
coming from the alsa-devel list.

> 
> On 3/17/23 10:31, Krzysztof Kozlowski wrote:
> > On 15/03/2023 12:47, Cristian Ciocaltea wrote:
> > > Commit 370f696e4474 ("dt-bindings: serial: snps-dw-apb-uart: add dma &
> > > dma-names properties") documented dma-names property to handle Allwiner
> > > D1 dtbs_check warnings, but relies on a strict rx->tx ordering, which is
> > > the reverse of what a different board expects:
> > > 
> > >    rk3326-odroid-go2.dtb: serial@ff030000: dma-names:0: 'rx' was expected
> > > 
> > > A quick and incomplete check shows the inconsistency is present in many
> > > other DT files:
> > 
> > Why not fixing the DTS? The properties should have fixed order.
> 
> I was initially concerned about the risk of a potential ABI breakage, but I
> think that's not really a problem since dma-names is not directly accessed
> in the driver and DT Kernel API doesn't rely on a particular order.
> 
> If there are no objections, I would switch the order in the binding to
> tx->rx, since that's what most of the DTS use, and fix the remaining ones.
> 
> > Best regards,
> > Krzysztof
> 
> Thanks,
> Cristian
