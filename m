Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A91713A51
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 17:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjE1PI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 11:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE1PIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 11:08:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAB8B1;
        Sun, 28 May 2023 08:08:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22A7360BA0;
        Sun, 28 May 2023 15:08:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F5BC433EF;
        Sun, 28 May 2023 15:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685286532;
        bh=yLY65D3lC0tV36WPq/3WNHSYiwt+E+smRjd0WJL9G7s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ihed7O23AluVfBTmTgPGc1bz8+pzAUzHrmq8mKzU+NAoLzS1YEJjtHEww4Dx2kzxO
         aC7VEGAOJQjD7HGpmg8jfS5iN4swC8zxDV4tBFuZuqfkIUtOFhCtdOuqVODhEoK9Sr
         81NFtiqCuU51WPehREiC1h+N5R8vCJGlVA5N5yoAhbx5kPmeH7rcd38MWxruVwq1jD
         zveXAfq29XhbpOH74kz+RxcHcSEJw5DkYmFzXbcjIL881jCiNkHd5F4G8hXgEO7jf8
         YoCX6/pEom+A4J0+Qa9/r4T1rd3Qh54Pu335ebcg99yhatftNJ2XZ9vz/hlWz/eAjs
         kuC4dB8UlQ0ZQ==
Date:   Sun, 28 May 2023 16:25:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Maxim Kiselev <bigunclemax@gmail.com>
Cc:     Andre Przywara <andre.przywara@arm.com>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Leonard =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH v1 0/4] Add support for Allwinner GPADC on
 D1/T113s/R329 SoCs
Message-ID: <20230528162507.144cfdf2@jic23-huawei>
In-Reply-To: <20230528162257.7e8932b9@jic23-huawei>
References: <20230524082744.3215427-1-bigunclemax@gmail.com>
        <20230524103431.50c6a2fd@donnerap.cambridge.arm.com>
        <CALHCpMh2sZSCrFMMT13kYbsu+C2bC2xY3coB_fv0mZom_g=oPQ@mail.gmail.com>
        <20230528162257.7e8932b9@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 May 2023 16:22:57 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 24 May 2023 14:36:28 +0300
> Maxim Kiselev <bigunclemax@gmail.com> wrote:
> 
> > Hi Andre,
> > 
> > thanks for you comments
> >   
> > > This may sound kind of obvious, but wouldn't it be easier to model this
> > > with one compatible string, and have the number of channels as a DT
> > > property?    
> > 
> > Yes, I completely agree that using separate config for each SoCs is looks
> > overcomplicated because the only difference is the number of channels.
> > I thought about a DT property with channels number but I didn't find
> > another ADC driver with the same approach (except i2c ADC's with child nodes).  
> If you are 100% sure that that devices are either
> 1) Detectable at runtime
> 2) Identical in functionality.
> 
> So that in neither case will any changes on driver support expose differences
> in the future then a single compatible is fine.
> 
> The back up is that you use fallback compatibles - list more than one.
> Whilst it doesn't matter (as no differences found) the driver can use
> the first one.  If differences become apparent later, others may be used.
> 
> I'm not however keen on a simple channel count parameter.  If you want
> to go that way, it's better to provide the fine control of individual channel
> child nodes (see Documentation/devicetree/bindings/iio/adc/adc.yaml)
> 
> That way the control is on which channels are wired to something useful, rather
> than whether the device can read them or not (which is pointless if no one
> wired them up.

Another thing to note is that with generic compatibles you loose the ability
to have the dt-schmema validate that sets of parameters make sense. If it's
just the channels available that may not matter however.


> 
> 
> >   
> > > Or, alternatively, using iio/multiplexer/io-channel-mux.yaml, since it's
> > > only one ADC anyway?    
> > I'm sorry, I didn't quite understand what you're suggesting.  
> 
> That's normally only used for a separate MUX where we need a separate driver
> to handle it.  If used on a device like this it would expose additional complexity
> to userspace with no benefits in generality etc.
> 
> >   
> > > And btw: it seems that the T507 (the H616 die with a different pinout) has
> > > the same IP, with four channels:
> > > http://dl.linux-sunxi.org/T507/    
> > 
> > Oh, thanks for pointing that. I'll add it to the list in the next version.  
> 

