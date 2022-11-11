Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDCB625F91
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbiKKQeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 11:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbiKKQeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:34:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CE26274
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 08:34:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73CEA62057
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 16:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D789FC433C1;
        Fri, 11 Nov 2022 16:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668184448;
        bh=JJ4ciy0pSg3JBG3X1MXWARYaxTs9O6hs+d+zbsG/fC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rtlEkTK7VIdY9UeRt3GP3qF6XyJkE6qmblOlij8vBdz9juxWFEd910ei8vH8dPcdJ
         jKTU2QyHKQiY0Ev74OQIJOw9dfP10OIcAeFcs3G7k4ip7E5Eikg1blLtpYi9tIUJ/M
         gldIBiKaMOubxTux0/hEsJ3i2lYehpGNbk9mSZcb17cGvCHwPyMPeLMHc07KqUeLJr
         kcdXI8R+qw3B+kPxBgOrVJutjJ3xJb7Ugqmy/UOaxSX5r0TI2nNtYp1jnxV9cthVfY
         JqVmhwLr8LnRUtWRaa0uGDEhPU0Z+vdnPtG9seGhLefTQoe5UWAt6zkTRglCG7fRT9
         vRGwlDJLmDTGw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1otWyk-005TBo-Gw;
        Fri, 11 Nov 2022 16:34:06 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     will@kernel.org, Zhiyuan Dai <daizhiyuan@phytium.com.cn>,
        catalin.marinas@arm.com
Cc:     kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Fix typo in comment
Date:   Fri, 11 Nov 2022 16:34:03 +0000
Message-Id: <166818443803.3370275.13137182146469716162.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1667737840-702-1-git-send-email-daizhiyuan@phytium.com.cn>
References: <1667737840-702-1-git-send-email-daizhiyuan@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: will@kernel.org, daizhiyuan@phytium.com.cn, catalin.marinas@arm.com, kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
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

On Sun, 6 Nov 2022 20:30:40 +0800, Zhiyuan Dai wrote:
> Fix typo in comment (nVHE/VHE).

Applied to next, thanks!

[1/1] KVM: arm64: Fix typo in comment
      commit: e1b3253340029b06f5f648d8390807cba4e4ec23

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


