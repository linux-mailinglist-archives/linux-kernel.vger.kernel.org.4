Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23EE7143A5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 07:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjE2FQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 01:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjE2FQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 01:16:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0139B
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 22:16:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED9DE604AD
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 05:16:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC863C433D2;
        Mon, 29 May 2023 05:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685337360;
        bh=ndRWXQzxO1TqHUmrmU3vFMlwQAoNr+yislTsYdJ1l8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CAGUJf01nAVHhzzT2a9QncHZwdEbwKD0lb6fQMLBsSGbPlggal8TF50Dt4OHTCkb5
         Q4Mm105vamL3cX418ZnmoR301+t/4/oCk97npaX+mfjo4+IWTBPTp0ohwH+2caYNAw
         h529n65tFgXHOtAL7cFZ4EL5YOF36o4go6uUm+qc9Ki0ADXkqKiWa2sShK+gDP7LhC
         web6d8LmEX+wjcGiW/6PBwxsg5pVMLe8Iab/ze5OuxslZemcybeiu2W6G1cIznR4nL
         XUAMZoIOzVpheUZXCNWeL0TqBR6hGFnJGvLaRervT66YpPgpiSbue12RzdOv8ibglY
         bDt7V8KLVlHIQ==
Date:   Mon, 29 May 2023 10:45:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: intel_bus_common: update error log
Message-ID: <ZHQ1DHv8HxSWMpiJ@matsya>
References: <20230518024215.164281-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518024215.164281-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-05-23, 10:42, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> We use __func__ in all calls of sdw_cdns_check_self_clearing_bits(),
> except in one case. Likely an editing miss when the code was
> refactored.

Applied, thanks

-- 
~Vinod
