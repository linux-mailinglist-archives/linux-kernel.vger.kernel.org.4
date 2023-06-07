Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131E2726083
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239886AbjFGNHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239651AbjFGNHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:07:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C191BE5
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 06:07:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B59A763F23
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 13:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54950C433D2;
        Wed,  7 Jun 2023 13:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686143234;
        bh=aGjLwz4N42P4QiuIiT4FYjf9xa0TcOslcVe57Qh1kn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M1kPRqrkTEJpSyPik+Y2JLNBevPSyr5aM/zRhzNWzjlZqbOrceS01A8hNFOZqHes1
         IuBn39Lr1eEBLntJbNKRtA+VD2YIIpSVdZXdUPMlDPjOJD56VlzpgSj2c0qs9Ff+Hy
         dS7ZoupSNZkE54q/IHCHtzH8HLaT7pncDNcoVci5WAIm5fqEzokUXLbbwpsVOw2cvS
         CosDAJthe6LMcHWuK5UCb8KGOvZPVvjIEf8ZHbQ8ymG62BuifKnM0wpOdpz7caH34D
         HmJuAbhdo1AvUCe4nDjCeJeYY3JdWkr0CxRrxuK+eWaQN0FeMo1pLuP2I28mIN9/fC
         xS6sxMvtyanSA==
Date:   Wed, 7 Jun 2023 18:37:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        tiwai@suse.de, linux-kernel@vger.kernel.org, bard.liao@intel.com
Subject: Re: [PATCH v2 00/26] ASoC/soundwire: add support for ACE2.x
Message-ID: <ZICA/YIYQ/DGhhdk@matsya>
References: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
 <ZHHdSjXwyHvBezkG@matsya>
 <8f4a024d-a218-c4ed-925c-b74663b7e280@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f4a024d-a218-c4ed-925c-b74663b7e280@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Pierre,

On 02-06-23, 15:46, Pierre-Louis Bossart wrote:
> On 5/27/23 05:36, Vinod Koul wrote:
> > On 15-05-23, 15:10, Bard Liao wrote:
> >> This series uses the abstraction added in past kernel cycles to provide
> >> support for the ACE2.x integration. The existing SHIM and Cadence
> >> registers are now split in 3 (SHIM, IP, SHIM vendor-specific), with some
> >> parts also moved to the HDaudio Extended Multi link structures. Nothing
> >> fundamentally different except for the register map.
> >>
> >> This series only provides the basic mechanisms to expose SoundWire-based
> >> DAIs. The PCI parts and DSP management will be contributed later, and the
> >> DAI ops are now empty as well.
> >>
> >> The change is mainly on SoundWire. It would be better to go through
> >> SoundWire tree.
> > 
> > Applied, thanks
> 
> Hi Vinod, is there a way you could provide an immutable tag for Mark
> Brown, the patch1 in this set is required for my next set of ASoC
> LunarLake patches?

Unfortunately, I have picked the whole series into next. If I was aware
I would have pushed them to a topic.

Mark can pull sdw/next but that would bring other things as well which
may not be preferred. I guess next best would be wait few weeks (rc1)

> 
> "ASoC: SOF: Intel: shim: add enum for ACE 2.0 IP used in LunarLake" adds
> the SOF_INTEL_ACE_2_0 definition to select different ops for LunarLake.
> 
> Thank you
> -Pierre

-- 
~Vinod
