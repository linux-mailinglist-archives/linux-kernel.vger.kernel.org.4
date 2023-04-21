Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0296EAAFE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjDUMyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 08:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjDUMyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:54:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA07974A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 05:54:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3204560AF2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947CEC433EF;
        Fri, 21 Apr 2023 12:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682081643;
        bh=I/hkmHkr0t6rftgWIYUYNyWtDDq+GSlmzg3C74Wvth4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QXWmEmiz6rJ7go3v//Izk3NvQn3tnGWOuCNJt5LtIBVICslVRtRZG0kIOdIpEyWun
         qBwh1oNetEDE3Uwjxo5Bm8POiQMniwpRX5eSOTsCMHcUtCiUp3jDoKNQp3IYXvhXFY
         Vkn2xz2/ltq6f7pLorI8dqm1erzYTFf6JDS6cB33mzvxeRSt+RKyU67XalmOn6Szep
         bSZ5A99jPAZqKmfrawjfy3yTFJD2+D4t3fNvAkc2A2JLyUiwY7fdeLAecNSJrt9RcI
         cJ4rCNBYaQaxzsig5zpvyjTkh1yEx11tWNOdD+ZhJYDf6/n+52jhMR/7Q6z9AaOIOw
         IssHZa9esH07g==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1ppqH3-00AArk-JC;
        Fri, 21 Apr 2023 13:54:01 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     catalin.marinas@arm.com, Jingyu Wang <jingyuwang_vip@163.com>,
        will@kernel.org, yuzenghui@huawei.com, suzuki.poulose@arm.com,
        james.morse@arm.com, oliver.upton@linux.dev
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: fix repeated words in comments
Date:   Fri, 21 Apr 2023 13:53:59 +0100
Message-Id: <168208160323.3020266.14762754614507604067.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309075919.169518-1-jingyuwang_vip@163.com>
References: <20230309075919.169518-1-jingyuwang_vip@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: catalin.marinas@arm.com, jingyuwang_vip@163.com, will@kernel.org, yuzenghui@huawei.com, suzuki.poulose@arm.com, james.morse@arm.com, oliver.upton@linux.dev, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Mar 2023 15:59:19 +0800, Jingyu Wang wrote:
> Delete the redundant word 'to'.

Applied to next, thanks!

[1/1] KVM: arm64: fix repeated words in comments
      commit: 3d1793562858f2bc42cc722fe00ec9b2ff0618e1

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


