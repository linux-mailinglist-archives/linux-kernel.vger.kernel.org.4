Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFAC73AB4E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 23:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjFVVOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 17:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjFVVOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 17:14:35 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04D0195
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 14:14:34 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687468473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bbf1F2WUUbZNrijp2VUM0ETnbJAC2wLJLqhMrcqrqLo=;
        b=FH6QLJpfSNsA+nbo7idAMH4c+wc5ky+YZ2vizqxUp34l7v9f2J3sEoPhYQ6T3Rtk0FktYv
        2o7P0dPEV+s2fJay8/8YKozlva7PGvKljDdr9LlUmWEKG4sPzWcLjuk6o0KUHpyT1+4xN6
        kKMinVtrlKz/7N3Mt3S2GOjvN0CcUzryNtYZ5oh87Ydh9eF9gZ55fDBDGmc/rkFvRQ8d98
        H3ZT+yogm+3O2mADv8Wot4ImLA/deYWum/7c+W2AxLOWfb02/L9GKLDHfbHo/RvaOEiRPB
        fSnEB4x4fv6MgZqC4l/lAyH4DCyHsJht6AJ+nTQwQJzj0vXzqHebEh0vfOcyXA==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF223FF802;
        Thu, 22 Jun 2023 21:14:30 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Deming Wang <wangdeming@inspur.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bo Liu <liubo03@inspur.com>
Subject: Re: [PATCH] mtd: sm_ftl: Fix typos in comments
Date:   Thu, 22 Jun 2023 23:14:25 +0200
Message-Id: <20230622211427.3581437-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621020331.1508-1-wangdeming@inspur.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'efd2ed9351efefe40cbcca36a527adf38ffe1b4d'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-06-21 at 02:03:31 UTC, Deming Wang wrote:
> From: Bo Liu <liubo03@inspur.com>
> 
> Fix typo in the description of the 'succesfull'.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
