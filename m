Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151F45E9E7D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbiIZJ7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbiIZJ7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:59:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582CA2DC1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:59:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E987C60B68
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 09:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5C5C433D6;
        Mon, 26 Sep 2022 09:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664186381;
        bh=eCpY4n3issMeWQsobrL6g/X1gThPUqDZbWkHDnM9yGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WWi1kHDL02YJgyXGqkboRWbJozijlRJm8v/NNCTDPTM88j3XiCQ/KFA0yjVhmHuSd
         RycXEa7bXNN++Z7y4my7KUZ0v1tkcW3qRzIQ3zsedWSNkx01Kjw42BMnifyC12Byoj
         IKQ6bcC1lRWOohBI/FtCWe0VyVcsya3Zn8YQDxXTjh7lC+Kl0D2thRMwN/gjxUtl4i
         ckF2ohatoJMu24o9xiZZLFkyS9QmupjZIRHSmOHOV4jBX95pYw04kAl0tGiSxEIMyp
         XYCc2EOrLPSBRWdeHvw0vd4SQWEUrkUsergmXO8RD5CJjDt6VGrHElLxnKYQMtlp/g
         NIt4MAK7iKE5w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1ocktm-00Ccj6-WB;
        Mon, 26 Sep 2022 10:59:39 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, Gavin Shan <gshan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, eric.auger@redhat.com,
        oliver.upton@linux.dev, will@kernel.org, shan.gavin@gmail.com,
        yuzhe@nfschina.com
Subject: Re: [PATCH] KVM: arm64: vgic: Remove duplicate check in update_affinity_collection()
Date:   Mon, 26 Sep 2022 10:59:29 +0100
Message-Id: <166418635574.3586576.10515374575365980142.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220923065447.323445-1-gshan@redhat.com>
References: <20220923065447.323445-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, gshan@redhat.com, linux-kernel@vger.kernel.org, eric.auger@redhat.com, oliver.upton@linux.dev, will@kernel.org, shan.gavin@gmail.com, yuzhe@nfschina.com
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

On Fri, 23 Sep 2022 14:54:47 +0800, Gavin Shan wrote:
> The ITS collection is guranteed to be !NULL when update_affinity_collection()
> is called. So we needn't check ITE's collection with NULL because the
> check has been included to the later one.
> 
> Remove the duplicate check in update_affinity_collection().

Applied to next, thanks!

[1/1] KVM: arm64: vgic: Remove duplicate check in update_affinity_collection()
      commit: 096560dd13251e351176aef54b7aee91c99920a3

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


