Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D1A636267
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237521AbiKWOwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237776AbiKWOwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:52:24 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225C2742F1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:52:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3F838CE21B6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 14:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC79CC433D6;
        Wed, 23 Nov 2022 14:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669215138;
        bh=4+w/qhSkQClDEWpGCuK5vMgYnSvhUvQxBjmnRyx0UDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gix4xn+ujjY3jz1kv+t2KtHR93OvXBdQS3254ozepDJ30B+EwHS+aGvOuJ6jeylmK
         C/iOljO12vuJkUCcqGpZESc4t8Tc0V+AG/qwJfIRambbaMH0vITOmGbMoH53Q9DMhL
         JLUJmf2xRHRUN/M7FpIQ5rWKBfi3FfGCNGNdYyuK91gzMisTmN6nl3XxC/5PQe+izk
         uyfY9WJ7Dl7qnt9sr8d22pKbgZD7M5Rp6ocMACGKMELTdTmbHnay+78hKKrnJ5jMdb
         hxa6jxvzfG7qkeqduenlJNym4nNHGhAHQydjp3C4wkbswcOWaUy8nVL+IFjG5Fk5ve
         siAxD68yTe/Dw==
Date:   Wed, 23 Nov 2022 20:22:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>, tiwai@suse.de,
        alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
        bard.liao@intel.com, peter.ujfalusi@linux.intel.com,
        ranjani.sridharan@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ASoC/soundwire: remove is_sdca boolean property
Message-ID: <Y34znr8o9+RceRif@matsya>
References: <20221118025807.534863-1-yung-chuan.liao@linux.intel.com>
 <20221118025807.534863-2-yung-chuan.liao@linux.intel.com>
 <Y3enHzY8XY70/nWR@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3enHzY8XY70/nWR@sirena.org.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-11-22, 15:39, Mark Brown wrote:
> On Fri, Nov 18, 2022 at 10:58:06AM +0800, Bard Liao wrote:
> > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > 
> > The Device_ID registers already tell us if a device supports the SDCA
> > specification or not, in hindsight we never needed a property when the
> > information is reported by both hardware and ACPI.
> 
> Acked-by: Mark Brown <broonie@kernel.org>

Hey Mark,

sound/soc/codecs/rt1318-sdw.c does not exist for me in sdw/next. Can I
get a tag for the changes merged into ASoC for this

Thanks
-- 
~Vinod
