Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BEF6AF5D5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjCGThv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjCGThd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:37:33 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F34B5FDA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 11:24:50 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E72561BF204;
        Tue,  7 Mar 2023 19:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678217089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YVqEnyPhmv/4u/K9tmRhmQoFGUUi52Q71HNMmgDhKXQ=;
        b=ZJzcfvq3bgVH5hzx0BgDASVWBn+j6cspAUYiPFvLXXutt+H5JNrjh+KBNVcdPKywIpL3Dj
        ikfszn8n9AaOdegzlgvrUHNKYSTkO9lEFv7KdQPLyBSYTeD7VWsqPCb8BpiKZD5eWMKxz2
        gevKKnCZzB+XyQUCNsww+JanU/ZJ31F52nPMz7fKJqpbxORf6ipgllzjotdeZy4SaxscnU
        BTLwYuXbAdFlr9J1A5iAhCnJ+nAyWWl88xy8+/3xPTP7CaCyz2x8gOzjV/uNK6NACLnnKn
        7cQ8t1pySr0JRXtqxHz1RHk2AoiiJuJkClqYPeT8jaqdRbjAqw+gMwNADceIng==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     quic_sjaganat@quicinc.com, quic_srichara@quicinc.com,
        quic_varada@quicinc.com
Subject: Re: [PATCH 5/5] mtd: rawnand: Fix spelling mistake waifunc() -> waitfunc()
Date:   Tue,  7 Mar 2023 20:24:47 +0100
Message-Id: <20230307192447.432961-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230306144810.22078-1-quic_mdalam@quicinc.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'42bf4597b7da8d9e3bc6039260e5437902af925a'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-03-06 at 14:48:10 UTC, Md Sadre Alam wrote:
> There is a spelling mistake in a chip->legacy.waifunc(). Fix it.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
