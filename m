Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034FE5EF2E3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbiI2J7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbiI2J7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:59:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A860512CC85
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:59:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8C29B82209
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E110C433D6;
        Thu, 29 Sep 2022 09:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664445541;
        bh=BXkonWJgpsbuy/26LAupm79T+HxrsMlPk/4p4uUXRTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aDBlj/G1IOsJkXqyjv5qcv8M0tQMVA1T5LA3b982kglWFJKx32bLwWZor7TM5g2jj
         LCxrU+pWJhOnzu+D9qYb5CiMvudNJCq0RgHEH+LG18h5Krbpb5CIdOiYzPE0rjURu8
         T5SVhOUprLS1B9vXJKLGL4tKK7ywC08WCAMQ2bqwXwk3eLozc8L7J0lMBNz3KptdTg
         PxA1UhIlxz4m9ON8UCWuwHfl7z3ePkDcXcXBdUqbvkxvdIpQ35bviMj8R284OUgj32
         M8vVSHnIa63L8EF6HbWqqsBRWBAkKp3SWqLzkfnK8K4FNGZnIsurU/KyTdLdM0eXPT
         B1ncciPJQ2D5g==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1odqJn-00DVVu-IG;
        Thu, 29 Sep 2022 10:58:59 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
Cc:     suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        kvmarm@lists.cs.columbia.edu, james.morse@arm.com,
        oliver.upton@linux.dev, linux-kernel@vger.kernel.org,
        alexandru.elisei@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] KVM: arm64: Fix comment typo in nvhe/switch.c
Date:   Thu, 29 Sep 2022 10:58:57 +0100
Message-Id: <166444538478.3798115.11069322305925080874.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220929042839.24277-1-r09922117@csie.ntu.edu.tw>
References: <20220929042839.24277-1-r09922117@csie.ntu.edu.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: r09922117@csie.ntu.edu.tw, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, kvmarm@lists.cs.columbia.edu, james.morse@arm.com, oliver.upton@linux.dev, linux-kernel@vger.kernel.org, alexandru.elisei@arm.com, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2022 12:28:39 +0800, Wei-Lin Chang wrote:
> Fix the comment of __hyp_vgic_restore_state() from saying VEH to VHE,
> also change the underscore to a dash to match the comment
> above __hyp_vgic_save_state().

Applied to next, thanks!

[1/1] KVM: arm64: Fix comment typo in nvhe/switch.c
      commit: 43b233b1582de501e441deb7c4ed1f944e60b1f9

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


