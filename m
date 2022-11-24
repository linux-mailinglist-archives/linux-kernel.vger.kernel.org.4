Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEE36377C4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiKXLgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiKXLgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:36:20 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB61F9A5E7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:36:18 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7A5302000A;
        Thu, 24 Nov 2022 11:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669289777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NPQ9iL0V2zuDFEHLP6m5JHoIoi4igoS967cGM7EHc74=;
        b=hDAm9zhaOagyXz0rTbcFmXhklwRIv2vi9K9pn6oCk2StAxC4Z5sfjEyoIXmzMxr0BQth9P
        aRH/Lpdqwnps00D+PVTdC2hhyUPopwRLG3nYm4sp9lzhvEqe3ICqNH0aSWOpFlKrKWn55O
        UAuUr8T76nRg7k4HDqSg5SHlLM3cmbM/uQTnVET90I+zrP/dcgccrgWb16/w7TQE1s8an7
        7M0UpJrLE4lzJDDecGzF/CtSGyTWrFSUAIdRPOjNxikdGrObTH8x9xJktUujX42eMPYm0c
        zqYVuiFz9uOdRJAfRCo+9pEUIzNTs01+VyZbdvT2j+RfC/f/gj1i8JiZnCsF2A==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jean Delvare <jdelvare@suse.de>, linux-mtd@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>
Subject: Re: [PATCH] mtd: rawnand: Drop obsolete dependencies on COMPILE_TEST
Date:   Thu, 24 Nov 2022 12:36:16 +0100
Message-Id: <20221124113616.266315-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221124115946.5edb771c@endymion.delvare>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'9c31d6b40c8e14c0bdd5c2f5728e174da8cf15db'
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

On Thu, 2022-11-24 at 10:59:46 UTC, Jean Delvare wrote:
> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> is possible to test-build any driver which depends on OF on any
> architecture by explicitly selecting OF. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.
> 
> It is actually better to always build such drivers with OF enabled,
> so that the test builds are closer to how each driver will actually be
> built on its intended target. Building them without OF may not test
> much as the compiler will optimize out potentially large parts of the
> code. In the worst case, this could even pop false positive warnings.
> Dropping COMPILE_TEST here improves the quality of our testing and
> avoids wasting time on non-existent issues.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Naga Sureshkumar Relli <nagasure@xilinx.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
