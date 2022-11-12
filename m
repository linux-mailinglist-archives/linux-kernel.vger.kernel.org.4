Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D905626A3E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 16:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbiKLPcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 10:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiKLPcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 10:32:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8CB17403;
        Sat, 12 Nov 2022 07:32:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D5E1B8047E;
        Sat, 12 Nov 2022 15:32:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E036C433D6;
        Sat, 12 Nov 2022 15:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668267147;
        bh=8BM9F9sYUvzjeXMcVPaFfGV9i7+iE5d5xYABOJQRZ0E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VI5BJil+F+JDuD4pcSpDpsVn0hF5xZEDG5MkuBcB9Y0PrFoNRsmk2Vk8/19oYQhCQ
         /1Ef59u4Y28FjOHA3vJdAIVy4iRAPS/Xia4Q/ZCkV5sZJy9KXZTdjiEFA/enjbwgLX
         srhru1bgFj/PuriI9GpRFVzKC/oWoK7rZzkAYP8KWu/IKXtDyKpF9oJqk0tmrv52yc
         9n3RJGXUb//ssNB/ccPpwGR3Z+4xlArxaNYxa8XFmSFkx9xghYgE2V/K9IbQxfXWjt
         eZu+5RSOEA0/4BV0/bur11rfOeL9E9h0WipIYMCDWfA3g6r3XVZZnxsEQJpubTTW6+
         Gx0ty6SOekS0w==
Date:   Sat, 12 Nov 2022 15:44:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/13] Support more parts in LTC2983
Message-ID: <20221112154440.5fd1ef6e@jic23-huawei>
In-Reply-To: <20221106171458.0715a602@jic23-huawei>
References: <20221103130041.2153295-1-demonsingur@gmail.com>
        <20221106171458.0715a602@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Nov 2022 17:14:58 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu,  3 Nov 2022 15:00:28 +0200
> Cosmin Tanislav <demonsingur@gmail.com> wrote:
> 
> > Add support for the following parts:
> >  * LTC2984
> >  * LTC2986
> >  * LTM2985
> > 
> > The LTC2984 is a variant of the LTC2983 with EEPROM.
> > The LTC2986 is a variant of the LTC2983 with only 10 channels,
> > EEPROM and support for active analog temperature sensors.
> > The LTM2985 is software-compatible with the LTC2986.
> > 
> > Also, make bulk write buffer DMA-safe.
> > Besides that, refine the binding.  
> Replying at least partly so I can see I already looked at this...
> 
> Looks good to me.  Will pick up once DT bindings maintainers are
> happy.

Series applied to the togreg branch of iio.git and initially pushed out
as testing.  I tweaked patch 11 as requested whilst applying.

Thanks,

Jonathan
> 
> Thanks,
> 
> Jonathan
> 
> > 
> > V1 -> V2:
> >  * add Fixes tag
> >  * add patch that fixes the regmap_bulk_write() call with stack allocated
> >    buffer
> >  * add patch that refines the binding in preperation for adding new
> >    parts support to it
> >  * do not use stack allocated buffer for writing the EEPROM key
> > 
> > V2 -> V3:
> >  * drop minItems if equal to maxItems
> >  * drop adi,single-ended conditions because of recent dtschema
> >    restrictions (even though they're valid in jsonschema and the last
> >    dtschema tag)
> >  * drop "allocate iio channels once" patch since it's been picked as a fix
> > 
> > V3 -> V4:
> >   * add pipe for 'adi,mux-delay-config-us' description
> >   * add pipe for 'adi,rtd-curve' description
> >   * keep newlines after descriptions
> >   * move 'adi,current-rotate' to conditional
> >   * put 'adi,custom-steinhart' in the original place
> >   * keep 'minItems' for 'adi,custom-steinhart'
> >   * override 'enum' to forbid auto-range in 'adi,excitation-current-nanoamp'
> >     when using custom thermistors
> >   * split refine patch into multiple patches
> >     - use generic node name in example
> >     - describe broken mux delay property
> >     - refine descriptions
> >     - change default excitation for custom thermistors
> >     - require 4 wire rtd for current rotate
> >     - require custom sensor tables
> >     - describe matrix items
> >     - remove qutations from phandle ref
> >     - use hex for sensor address
> >     - add default values
> > 
> > Cosmin Tanislav (13):
> >   iio: temperature: ltc2983: make bulk write buffer DMA-safe
> >   dt-bindings: iio: temperature: ltc2983: add default values
> >   dt-bindings: iio: temperature: ltc2983: use hex for sensor address
> >   dt-bindings: iio: temperature: ltc2983: remove qutations from phandle
> >     ref
> >   dt-bindings: iio: temperature: ltc2983: describe matrix items
> >   dt-bindings: iio: temperature: ltc2983: require custom sensor tables
> >   dt-bindings: iio: temperature: ltc2983: require 4 wire rtd for current
> >     rotate
> >   dt-bindings: iio: temperature: ltc2983: change default excitation for
> >     custom thermistors
> >   dt-bindings: iio: temperature: ltc2983: refine descriptions
> >   dt-bindings: iio: temperature: ltc2983: describe broken mux delay
> >     property
> >   dt-bindings: iio: temperature: ltc2983: use generic node name in
> >     example
> >   dt-bindings: iio: temperature: ltc2983: support more parts
> >   iio: temperature: ltc2983: support more parts
> > 
> >  .../bindings/iio/temperature/adi,ltc2983.yaml | 335 +++++++++++-------
> >  drivers/iio/temperature/ltc2983.c             | 193 +++++++++-
> >  2 files changed, 389 insertions(+), 139 deletions(-)
> >   
> 

