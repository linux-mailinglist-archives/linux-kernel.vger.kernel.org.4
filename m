Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185AB6DDC70
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjDKNnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjDKNnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:43:21 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A61EBB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:43:20 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 45AB9240011;
        Tue, 11 Apr 2023 13:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1681220599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1dCbFT5VKIbjHms71oFZy/8u7J+L0VfsXHy+SOmEY0k=;
        b=ftSsb8ZAyLUSONGkewKSwGPZyedH4Yum1pvEx1noBNj9eWnbdRQ1pYTaYCz5Eaca/mXGuc
        4X4DJS9aBUFobrzV3h1NXPm6OGtReRvRXmGFzPAZQkBUqel/cucEf9DlBcfVaDslgvuOWD
        FhOwemKlomnFkUFWGa4/hK2113B8ioxgzv0rs8X+nihTpr6lkMuYp5iiFbdUblEq6wlVxx
        32v6m4mdvBElehZuTevraINj67N+hyh3pIiMWnaX6DBQmAyb4pC2jYRBNefUGPg8Z378h2
        ZjG6wFOfX4mJz6bYZa9qPAgZsbJHxW8pKFZTpp4qExwYrtcSmHea31BCTdzV+A==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jean Delvare <jdelvare@suse.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH RESEND] mtd: onenand: omap2: Drop obsolete dependency on COMPILE_TEST
Date:   Tue, 11 Apr 2023 15:43:17 +0200
Message-Id: <20230411134317.445792-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407190453.66efdf9d@endymion.delvare>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'94b8f77fdb6e10118d9df29351e11949d1799415'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-04-07 at 17:04:53 UTC, Jean Delvare wrote:
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
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
