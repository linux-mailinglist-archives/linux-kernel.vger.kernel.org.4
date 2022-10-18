Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82C16027E0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiJRJEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiJRJEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:04:38 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B76632F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:04:21 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 73587240003;
        Tue, 18 Oct 2022 09:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666083859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jafh7VSLsIGbCiC7CvilxArhMrKLKSbn+m8zb4GGQH4=;
        b=AWakTaFMm0MkhFio6Z5Q06ZWYcicBqQjBplyIUyodPZSx5kLT3PCUoQBnDzzv3wUEqnVzA
        RLoK4Pz4rMzn7khN6sFi6aPFJEZf/B38XLHdBnWFECcJ+yuEO86x5cTdnyqZZIJLQdqYy3
        D+MoyAwCsej95xtF96dulooHCwDSOLH21k+SqnCYU34YiZNNk/7uIZX1UgQIhRC3C+6AUM
        IWLuVtkruevxJm7eSrJX3m4/wgmo4tFhkgJZSXyUJCJ3lWGNFSYln6ZFzci6wn46/q3W2t
        KWKeteNF92Sf70qosyaWITSKqXl828KCtYwqBb1EpVnwHeklAU1RQ7KG0Oysrw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Vladimir Zapolskiy <vz@mleia.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mtd: rawnand: lpc32xx_slc: switch to using gpiod API
Date:   Tue, 18 Oct 2022 11:04:17 +0200
Message-Id: <20221018090417.466323-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220928230019.2140896-2-dmitry.torokhov@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'6b923db2867cb5e18ac4a1d5d5b4eecf0b619538'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-09-28 at 23:00:19 UTC, Dmitry Torokhov wrote:
> This switches the driver from legacy gpio API to a newer gpiod API.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
