Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19EB6366C2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238884AbiKWRQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238900AbiKWRQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:16:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0D95ADDB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 09:16:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56F77B821F6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 17:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BEBC433C1;
        Wed, 23 Nov 2022 17:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669223782;
        bh=9xE2IqP0KBsfRtdmc8ZVF2DkL+MOQ8a+r0kEVIXmtoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p9LcoYSoVrAIwZ1W7CImXNGOJg5h+R3VlUGErNgHl737BzFEgFTPDUycwRBLnTgXq
         6yqe3gNO4CoZeo21HbBm6SG6doXGN6jpAURLM/Kf+D8P1UK74ldFt+j6nBdHcyCqZ5
         X66s9vdFldMa6MEdsA54B32HFbtxgLmrn0e8b0lPP+fSFBOx2e142b9oDX+Z4PirN9
         /eO4/oiUEC5dCHFqA7FTu7JFNbe/pMCKFOQTc4XK/xIdKTaBF6JpO+VxoI77fmTPAp
         OBu0MSKnQvvvQh/rUjN5TDNlkHWQaMov3GPIe2dkE7B/4ugjFqI4zoG6oztThUI44d
         IODa5p40rvCJg==
Date:   Wed, 23 Nov 2022 22:46:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>, tiwai@suse.de,
        alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
        bard.liao@intel.com, peter.ujfalusi@linux.intel.com,
        ranjani.sridharan@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ASoC/soundwire: remove is_sdca boolean property
Message-ID: <Y35VYW/s8Cnv1jEV@matsya>
References: <20221118025807.534863-1-yung-chuan.liao@linux.intel.com>
 <20221118025807.534863-2-yung-chuan.liao@linux.intel.com>
 <Y3enHzY8XY70/nWR@sirena.org.uk>
 <Y34znr8o9+RceRif@matsya>
 <Y347f24Tx5yZtjLw@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y347f24Tx5yZtjLw@sirena.org.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-11-22, 15:25, Mark Brown wrote:
> On Wed, Nov 23, 2022 at 08:22:14PM +0530, Vinod Koul wrote:
> > On 18-11-22, 15:39, Mark Brown wrote:
> > > On Fri, Nov 18, 2022 at 10:58:06AM +0800, Bard Liao wrote:
> > > > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> > > > The Device_ID registers already tell us if a device supports the SDCA
> > > > specification or not, in hindsight we never needed a property when the
> > > > information is reported by both hardware and ACPI.
> 
> > > Acked-by: Mark Brown <broonie@kernel.org>
> 
> > sound/soc/codecs/rt1318-sdw.c does not exist for me in sdw/next. Can I
> > get a tag for the changes merged into ASoC for this
> 
> Not reasonably, that's basically the entire tree since Linus doesn't
> like branches.

Okay.

Anyway we are close to merge window, lets postpone this after that

Thanks
-- 
~Vinod
