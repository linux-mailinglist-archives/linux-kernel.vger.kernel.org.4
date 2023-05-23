Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFE970D94B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjEWJk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjEWJkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:40:53 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E053119
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:40:52 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1AA1C1C000E;
        Tue, 23 May 2023 09:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684834851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ATylLbCJ67fDBCfvkABy03LGMsbdHiaiqACbv5gXDoc=;
        b=cfZWC4eGtEu6pwdMyXVKWcSahlMm+WZsJoiyjzlP3K+c+OulqNnNr7ZKjcl4QkTs7kGi5o
        4UZCQ3VKJ9DKHUayCq/FZUr9zohuUxFA99kdBvrGNrtSOFpdHuiBky3i+I7cqWpzoulPA9
        pINk3c5v+KpTqD89BiMPktg2lNu3U0Itj/TQUpk5gQOuxYfoo3xIBnA0nRrFmU0hG+GCK9
        nNznUgBoOGDJr02EWPx5oya/K9s0aj0XuGwYs4rsckZbiTxgGD7WMoEwHubh3a1BREXYHV
        Wc7irv0x3rsqZweD1C+PCWNSMpo3GfaB2/r+ZlEyZP6tXeDW8b5C/Uk1fcCJXA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Michal Simek <michal.simek@amd.com>, miquel.raynal@bootlin.com,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH] MAINTAINERS: Add myself as reviewer instead of Naga
Date:   Tue, 23 May 2023 11:40:48 +0200
Message-Id: <20230523094048.304664-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To:  <06df49c300c53a27423260e99acc217b06d4e588.1684827820.git.michal.simek@amd.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'faa5e6cbb559252da28976e7513c889545334696'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-05-23 at 07:43:42 UTC, Michal Simek wrote:
> Naga no longer works for AMD/Xilinx and there is no activity from him to
> continue to maintain Xilinx related drivers. Add myself instead to be kept
> in loop if there is any need for testing.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
