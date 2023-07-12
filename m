Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEE5750BA0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjGLPAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjGLPAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:00:43 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A960D1BD1;
        Wed, 12 Jul 2023 08:00:35 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 091731BF20E;
        Wed, 12 Jul 2023 15:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689174034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dmR2M8DvxgLuUvcgHBngldyqXTz4KXC7hMLlBcuMY0I=;
        b=oljS7e6WG2GnNVXTF1IX+A97Q7KGQif7E3Rr8w8RDa66uvs9nlSQNoYm3xBw33fuQyY9NE
        wqKwL4dZX+npC9bQqEFmxdD0EConNP+0xGgGtWweUKpX7jHO5Jws6cvpvUlcK14xUGk8mm
        FpsOmdsVQgzPxQYBd9Sm10CwRJ39fTLTLpE8mr0mP41dXTCmGmdIcsTqjCt2j+x/T9d1NS
        faXmn4slCEFxNWfa8pTgJfGKQAfm1jUNT6Iw5VOPCFpNdqdYAY6N9hGjMchU8QcOHC3iIg
        xBshacGLNSek9a5qrryYaGvkeVhXit/GL8jb4GVq4uODL5OnrUIgVHF3a2iCAQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Su Hui <suhui@nfschina.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mtd: devices: docg3: Remove unnecessary (void*) conversions
Date:   Wed, 12 Jul 2023 17:00:31 +0200
Message-Id: <20230712150032.431967-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529015011.38811-1-suhui@nfschina.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'259b4d4c1308a1fa0a671be3ecd8f847c7ce2e95'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-05-29 at 01:50:11 UTC, Su Hui wrote:
> Pointer variables of (void*) type do not require type cast.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
