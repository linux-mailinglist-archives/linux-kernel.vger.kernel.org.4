Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFC861F97C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbiKGQWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbiKGQV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:21:27 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAE622297
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:20:19 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 249D440004;
        Mon,  7 Nov 2022 16:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667838018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s7aszBHSBcyAAcN1a1kUyOs2oLb5S8ndGC4JnlHsv6s=;
        b=LN5GHOM6hCsnQF5f0WpLlSr8Q/NAsCzFHUFIWhkz3XhV2Sb8gfMQcMl3Nuxwb182idYH1H
        ilzNcX1WmdMjYorN4g+3NLbAdXELBAWhVCiWp/uC/p2xrd5xKEdsCtXv1m10HCdTwa1w0q
        fYkIRmkYaTcRX1oE2/jDpDq03wZZktEQjJZcBiC8JhpZkrUTCg+uSZMOLfkBLEXUFlFg3I
        1I9Wxwp6oWMK873joZVvpdnmujq5BId5MctWeBXW17u4Ha+RtqOj9a3TfW5oH6AJEL35kZ
        wqgeXIIoPTugVW9pHER02B43B9kXOQxbVHCfFMP8gCh26AfbAMdwgs4qvnXgeA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: inftlcore: fix repeated words in comments
Date:   Mon,  7 Nov 2022 17:20:16 +0100
Message-Id: <20221107162016.48949-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221028134036.63000-1-yuanjilin@cdjrlc.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'077dc37db1e1da1f0e6a745328e4caa6d414e501'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-10-28 at 13:40:36 UTC, Jilin Yuan wrote:
> Delete the redundant word 'it'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
