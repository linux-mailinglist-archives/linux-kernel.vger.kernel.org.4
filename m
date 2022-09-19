Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C02C5BD1F9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiISQQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiISQQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:16:10 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D5B31348
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 09:16:07 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1C5651BF209;
        Mon, 19 Sep 2022 16:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663604166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6s1GEq/NI5LtLtoKNvI8GY+IRQMhDfNQ2NfkC4suIrE=;
        b=p2LLNDPsZ2c8y/bc3+rdRKTyzUDu0PaZzdiZWvYDZW4rBfzS1Aee4IqRVGDxLnU2t7j190
        TfKzVyb+2bBNxxiEgjQ3zGBh2z0jSq8Xm7RhEP3hLbK4BjLUDcjbC/62BBKVI/CuV1C5PZ
        6BDJRZRNFbkQwvbG/TBAo+gVPyGMrUHqeZgz7xloU+CDPvx841cFmxKIntMHB4CO2TWJWz
        PKsNj86q74xG2Kpb9Y4iz2jf2tq2wcHWekSF4xZXPVd4YSKoRkp2SctrqLjzqSbQEqN19a
        PG5XF0JJtGP1J72J0n2QecrVcryzOIQCa16WMzP7nDvf1ItdKivHcGe7Q/0xZA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Zeng Jingxiang <zengjx95@gmail.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zeng Jingxiang <linuszeng@tencent.com>
Subject: Re: [PATCH] mtd: physmap-core: Fix NULL pointer dereferencing in of_select_probe_type()
Date:   Mon, 19 Sep 2022 18:16:04 +0200
Message-Id: <20220919161604.226569-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220727060302.1560325-1-zengjx95@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'8b740c08eb8202817562c358e8d867db0f7d6565'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-07-27 at 06:03:02 UTC, Zeng Jingxiang wrote:
> From: Zeng Jingxiang <linuszeng@tencent.com>
> 
> Coverity complains of a possible NULL dereference:
> 
> in of_select_probe_type():
> 1. returned_null: of_match_device() returns NULL.
> 2. var_assigned: match = NULL return value from of_match_device()
> 309	match = of_match_device(of_flash_match, &dev->dev);
> 
> 3.dereference: Dereferencing the NULL pointer match.
> 310	probe_type = match->data;
> 
> Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
