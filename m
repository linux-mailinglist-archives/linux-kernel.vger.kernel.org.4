Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50BD62E6CB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240658AbiKQVSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240934AbiKQVR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:17:58 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5FD8C0BE;
        Thu, 17 Nov 2022 13:16:05 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 184A4100004;
        Thu, 17 Nov 2022 21:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668719764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b0LnV7zw4PVMZ/yFK8keNGGMheSfJL76xYuNexBsgUA=;
        b=Ca6vsTUOr0Uiru6/3wNLu4QBUlIsd3WogLBxNaFPFwZ04zQ81h2JqtSPqqOGMtfUrtUTmQ
        dzcx5ZH4NR70ba8XBzNF0dtC+MypYXgCAWG88yavL+hGeLnNTNFkYp/Dj+M+QTUl0+4jNK
        fl1HYJ4xoTMhVE13MYPoj/it1c/QHuV+RaiszkRm/c5vZl8PQSsRAiAZdp3l7iQqzDM9+u
        z6Tt1CEqUX+wem0EIDJ4y5Dcg8PFqm8E2Ca7fLTwRfUgBBFAUTgqEEZn6FcCpA1+BtmSuX
        WurKr9/idNKwznqk8zB3t+T7pA1i+v2IDQVIKWlbKvmwWcTKXrvMWXhmcyURCw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 06/17] dt-bindings: mtd: ingenic: Mark partitions in the controller node as deprecated
Date:   Thu, 17 Nov 2022 22:16:00 +0100
Message-Id: <20221117211600.1273520-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114090315.848208-7-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'73fc6320651ab13da88ee3f4a4bb7499f0b21e20'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-11-14 at 09:03:04 UTC, Miquel Raynal wrote:
> Defining partitions as subnodes of the controller has been deprecated
> long time ago, but unlike having partitions within the controller node,
> having an enveloppe named "partitions" (which is not itself within a
> chip subnode) is not that common, so keep this deprecated definition in
> this file.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Acked-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next.

Miquel
