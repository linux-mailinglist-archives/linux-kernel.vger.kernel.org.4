Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605665BE039
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiITIeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbiITIdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:33:43 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638DBC4D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:33:41 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A7CFB200008;
        Tue, 20 Sep 2022 08:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663662820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=esexip1yFJnRestUe93rAsRCI36okFNMJSeo5XdMS5s=;
        b=TOQ+glxV1YFdbvNxUx57JoLB+6WXo2fJDnvrsnjBbx+btOt6FQi5sd8UqmT3/10+fNUnsK
        JfoGmmEtj4PtkmcU7kpTcDdmCe4l2xFz+A/+0yzEYXYXxOFP/PVHm96lfi8UQ3ha6HQcPD
        pq+OWNjoKTRtr7INOi6un+FZ8FBxpV11LC2v6KwPUs+Z+i4KZPOIAphCP+KEM0jU/KONOR
        OSx/NGO2A+W9ipkt6sVUXUCOmj1UWLyMJlbrYfN/hV9IwLeAgk/rH1SUBxLHFFp758d5oA
        PPlBmFA8BXcgtxG9SJIdnRY5wB51vRQcm3RBpHw65pDDbAFeHHuoN94/bFXiqw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jiangshan Yi <13667453960@163.com>, miquel.raynal@bootlin.com,
        vigneshr@ti.com
Cc:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] mtd: rawnand: fix spelling typo in comment
Date:   Tue, 20 Sep 2022 10:33:38 +0200
Message-Id: <20220920083338.601010-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220905063232.1830197-1-13667453960@163.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'9146e732a2dee289d0988f6ad23a74f2ae8181a1'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-09-05 at 06:32:32 UTC, Jiangshan Yi wrote:
> From: Jiangshan Yi <yijiangshan@kylinos.cn>
> 
> Fix spelling typo in comment.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
