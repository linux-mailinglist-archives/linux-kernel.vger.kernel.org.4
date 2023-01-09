Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA099662ADC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237258AbjAIQI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbjAIQIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:08:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C367D3AB26
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 08:08:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6054F6118C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 16:08:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D67CC433D2;
        Mon,  9 Jan 2023 16:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673280492;
        bh=L7OgefsegSZIPl94QzC1zkIELk9VjaBHZvVdo32x78U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YnM9uBOcWaS4MGAiYdTFD/nz5I4gZnUJuGgN1czIxdnkd4Fa+bAtrZ2eadwpCIxzC
         9C4jRlI4ScOjs0+YkXROwyQ5T4xR9Z3rvKcO6XQYpHcuM93Mc8SlG5CbVT/8K7j/FF
         LB5MDJd3OSooTFct4RI6eDWGTxtpjWR6N0GbO9RB+mgaeAxBmBmSrlnc+88s6OfWlO
         LoRFmzpkvzNj9BWxyh9hAKhrsg5f0jF7VTXxQEDAd46VgDojWdLWuIAZHUnggTZxAx
         2H+0BiGPVbs5D5O1BFSfFPiEueudQGm5YhtDyekw2Kx1r8toipRMd5F6AwBY+lFd3k
         BxP0RYB2VAdQQ==
Date:   Mon, 9 Jan 2023 21:38:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     broonie@kernel.org, tiwai@suse.de, alsa-devel@alsa-project.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        peter.ujfalusi@linux.intel.com, ranjani.sridharan@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] ASoC/soundwire: revisit support for clock
 registers
Message-ID: <Y7w76Vv12JBJAOP9@matsya>
References: <20221118025807.534863-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118025807.534863-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-11-22, 10:58, Bard Liao wrote:
> SoundWire clock base and scale registers are only supported for SDCA
> devices. That's fine, but that leaves SoundWire 1.2 with optional
> registers not supported. This is a corner case that needs to be supported.
> 
> The change is mainly on soundwire. But rt1318-sdw.c was applied to
> ASoC tree recently and not in SoundWire tree yet. @Vinod, Are you good
> if we go throutgh ASoC tree? Or @Mark can provide a tag and we can go
> through SoundWire tree?

Applied, thanks

-- 
~Vinod
