Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521DA61F99B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiKGQ1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbiKGQ1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:27:01 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAF527927
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:23:15 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F406B4000B;
        Mon,  7 Nov 2022 16:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667838194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t/n4ceiMfhKCHKucjsMxy8StCawz2KaDruUXWtlmsEs=;
        b=DhWE/W3+O7xoKnTMIOh5uGlRzjkxkJonhNVM5GdRBFSFs0FDZYR8y5kTMWEc3t9gtYPouV
        n5KecszsZtkFMOzMSss+Tsea2f2wqmgYZAu5P7yUKu1WxtGlwTW+62DLwk8svdwkExAHhp
        xsRKyVnwBe59QBgaeCL83+70bbDZ+mm/su+SNPtROACVxns8z8sCV6cceaZsZMJUXgrlR7
        IDKGROzM+7832fmjhCMN/XCEj9W3MijB/AtuneYCnOZFAjWsZes00EaCldmLu5LuoiukDY
        9WzHKwnZLKG0YfF+dEb9O3+am9K8e3ZSCNBqbZUmzSFvSHuN8A93AxdQgeNWgg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH] mtd: nand: drop EXPORT_SYMBOL_GPL for nanddev_erase()
Date:   Mon,  7 Nov 2022 17:23:13 +0100
Message-Id: <20221107162313.54222-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018170205.1733958-1-dario.binacchi@amarulasolutions.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'a50ae8c98e5766a4fcb78e76f13cc658b784eac1'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-10-18 at 17:02:05 UTC, Dario Binacchi wrote:
> This function is only used within this module, so it is no longer
> necessary to use EXPORT_SYMBOL_GPL().
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
