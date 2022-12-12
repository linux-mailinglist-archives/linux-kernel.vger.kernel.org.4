Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AAF649AAF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 10:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiLLJIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 04:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiLLJIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 04:08:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66BF1D7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 01:08:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 921FBB80AD7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 09:08:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E674C433D2;
        Mon, 12 Dec 2022 09:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670836097;
        bh=z5HqcNfQJi1MaenD9RiDHiFMXvNXPXoJXEhKMYHhZY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=InVOrkT1F1aLJT+4NIgtTnatQBkkM198K5TAlHCJ8DXZyGYDgCMCcXDT0eXeJz3c2
         OhCJHYPme4sbb5dZ565a7cKK1qaCiXEYnJXWXdWME12pIlCCH/ACPMXWctIjtXW60f
         IuquRiVR6GDD+fIAHNt6VCVJTZdv9i9JOkl/eqcqPqxoBMDPgSI2SrFb2+v/4ERFVd
         FwO3vmlhycWZHL/qgN6p9nBfu58Pq619zffjzAZeRkpY32bmPFV9B/0vIzup6X1FPT
         8XEuC6uh+1O9G054kGOYlyrFGYScTrFqJ6xZb4ApBVv5sbXNDxSuv7Ammblp9CCKKA
         nqMt4EAnyZwyw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1p4enG-00C3aO-WF;
        Mon, 12 Dec 2022 09:08:15 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.linux.dev, James Clark <james.clark@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH 0/1] KVM: arm64: PMU: Fix PMCR_EL0 reset value
Date:   Mon, 12 Dec 2022 09:08:11 +0000
Message-Id: <167083608669.635334.13408416430959494147.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209164446.1972014-1-james.clark@arm.com>
References: <20221209164446.1972014-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.linux.dev, james.clark@arm.com, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, will@kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Dec 2022 16:44:45 +0000, James Clark wrote:
> We noticed qemu failing to run because of an assert on our CI. I don't see the issue anymore with
> this fix.
> 
> Applies to kvmarm/next (753d734f3f34)
> 
> Thanks
> 
> [...]

Applied to fixes, thanks!

[1/1] KVM: arm64: PMU: Fix PMCR_EL0 reset value
      commit: aff234839f8b80ac101e6c2f14d0e44b236efa48

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


