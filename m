Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785BC63622B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbiKWOpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbiKWOpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:45:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAB54046B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:45:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC33D61D50
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 14:45:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98ECC433C1;
        Wed, 23 Nov 2022 14:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669214743;
        bh=GP/bMroxjBd4Bf28LbNnOgH2qW191d23DuhYrLswhdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JBa1XbMM+lIIIXQVi6VicwOnHWiXamVdPpwzQecxCdb98E8HcgzLXQx7f1rYhkU7b
         73txLU8V/QrYeGnVvOAcjbh4gectc9QJNYpLZoyr5W1CeO8Gj3KzLBUR83LfKBAawG
         w6dPZYJnyWkS41yN3IGsReJjRhzxeacm+LsEWE3So/L9NkaqzIpPxCrp4airt/XbEy
         yG0agQEaT2KRBUi8MwOyk8uQ3Ml6EsvpTA/ozdiYCXTqr8CL/WU1bI8bQAfx1aaUWh
         OPTu6TOSDwJqIcbS2gdXxnn+lCmuycz9lvNnn1AjpCpERK71iXxqyTjwmdhTuoi7wv
         i/AegByoaSD/Q==
Date:   Wed, 23 Nov 2022 20:15:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 7/8] soundwire: intel_init: remove check on number of
 links
Message-ID: <Y34yE23O0WFq2uDK@matsya>
References: <20221111042653.45520-1-yung-chuan.liao@linux.intel.com>
 <20221111042653.45520-8-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111042653.45520-8-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-11-22, 12:26, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The number of links is checked with a chip-dependent helper in the
> caller, remove the check in drivers/soundwire/intel_init.c
> 
> This change makes intel_init.c hardware-agnostic - which is quite
> fitting for a layer that only creates auxiliary devices.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
