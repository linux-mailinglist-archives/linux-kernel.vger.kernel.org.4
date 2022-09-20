Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D285BDBF2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 07:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiITFBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 01:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiITFBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 01:01:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CDD1759E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 22:01:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91CE9622B4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 05:01:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1C3C433C1;
        Tue, 20 Sep 2022 05:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663650060;
        bh=JcZOwfCNW3dBfAsXNvo/jTqcE40QGR1s+zdpQNoCiQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hrc9u/NuNYtKURUjWKz2ISE9VZtxrhEVc/aAnu90Z3I/Jybpf7Dr831tnglAZegQz
         M4BRK41iaIh3aCOmhtvFh1DEt3QiBhU5hwny2E3kuqjS9MyMYCOjOgAei2m6SRqsh+
         cD3P9Oft5ecsL+gVKbqnEZcdPZRTBkBwMDJ+8FTboc4hdDbR6OuDvFybtxsnSOly/4
         aeBzxa4+ZRhGt5au9o7lxluzw2kusipuk/2R/2Z2ga4nTchyTdaGqc37MlH0Nh8A3a
         cCZ3iCsJXkhtK37OhFvK/OY9IA8Oq0VBDAeB/AjBwHbSiV1UZ3ts0cSB/J+zKrIWl2
         VLClmp7H5RkiA==
Date:   Tue, 20 Sep 2022 10:30:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH] soundwire: cadence: Don't overwrite msg->buf during
 write commands
Message-ID: <YylJB+GfMxQL3ogS@matsya>
References: <20220916103505.1562210-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916103505.1562210-1-rf@opensource.cirrus.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-09-22, 11:35, Richard Fitzgerald wrote:
> The buf passed in struct sdw_msg must only be written for a READ,
> in that case the RDATA part of the response is the data value of the
> register.
> 
> For a write command there is no RDATA, and buf should be assumed to
> be const and unmodifable. The original caller should not expect its data
> buffer to be corrupted by an sdw_nwrite().

Applied, thanks

-- 
~Vinod
