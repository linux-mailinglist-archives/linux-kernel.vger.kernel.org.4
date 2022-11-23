Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA98A636227
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbiKWOpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbiKWOpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:45:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D2163CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:45:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 603CF61D51
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 14:45:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DACC4314A;
        Wed, 23 Nov 2022 14:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669214719;
        bh=JjSRB1gRJ3pgoS9q4CAE6iiJArcPdfzpnU5eRwNhnY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vFfHdSRcWdQzPkB2cwZ3QHOx5vyC+jyRcAlJhCs1xBSFFdYViT426ZCJEFG2lb0rh
         puV00JR7xpH20dik1qJAwNT0ox5qVr13YiXOLHX7E5zVH0xNCfsOmksSaY+jy+2nvv
         CQaYDuLY6dnlAKdqu6AWNN7IVO31siNVSuejQ+/+rUmTEQHqAlS3d8IY1tgpF0Af3i
         +pAW69V3i8YWA/PEu25VNL/GiMXYcnyVG1qCzuMKAg8eWxl2Kj+aZ5N8c/U3QLTT7J
         pYTB7JO0XZoJA+rSUmou3cAFUZbJAGBjAkfZK58ZpVWLm6iM6DdqJW1WX6d/ttGqJy
         MVrz3OrpfZlGA==
Date:   Wed, 23 Nov 2022 20:15:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 1/8] soundwire: intel_init: remove useless interrupt
 enablement in interrupt thread
Message-ID: <Y34x+0VqQsjaIjoA@matsya>
References: <20221111042653.45520-1-yung-chuan.liao@linux.intel.com>
 <20221111042653.45520-2-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111042653.45520-2-yung-chuan.liao@linux.intel.com>
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
> When the code reaches the SoundWire interrupt thread handling, the
> interrupt was enabled already, and there is no code that disables it
> -> this is a no-op sequence.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
