Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD0B6AF5D7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjCGTiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbjCGThg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:37:36 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEC1B79E2;
        Tue,  7 Mar 2023 11:24:55 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 947F4C0007;
        Tue,  7 Mar 2023 19:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678217094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eMi0mbcjRztU100Tey2B8cyzSfC0ZC93pEwyJgBeTio=;
        b=SPDlwe0p76ZXh73NXOVpUjy8tCXJAlYzijf2yHzzbNTieX6RcEUcB9/vXsWO8UVlOYZxR/
        ruFeEr/lQNBk9GpfXJURWukB9fFbdz16m1DNCcx+wm8XaP8qf0w/lZSvEC43D4hEQfC5x2
        VZuecOv8od3vXKjKc5zzY0Nv3kBJbDuUSsU+VrSB+JbjFPG8LHuX/smsA86xkkeXC371gQ
        I4ujLsR5JkKBRimt6xezk5H4GCFKylRXafdXEGAiHuE5V4K0Lz4/a7XUXwxhf3ltuuPC2v
        oACf0fVYuWu230caP9wrIIb9wibyfys2TvgaCf/AuRVTxBpwjBd1dKOJdPPd/g==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mani@kernel.org
Cc:     quic_sjaganat@quicinc.com, quic_srichara@quicinc.com,
        quic_varada@quicinc.com
Subject: Re: [PATCH 1/5] mtd: nand: raw: qcom_nandc: Use devm_platform_get_and_ioremap_resource()
Date:   Tue,  7 Mar 2023 20:24:51 +0100
Message-Id: <20230307192451.432989-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230306144141.15360-1-quic_mdalam@quicinc.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'bcf09d7e2ff435a5d587760170728c11773a4362'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-03-06 at 14:41:41 UTC, Md Sadre Alam wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
