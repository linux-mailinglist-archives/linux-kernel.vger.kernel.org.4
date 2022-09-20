Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51495BE050
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiITIfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiITIes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:34:48 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E8965653;
        Tue, 20 Sep 2022 01:34:21 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 87C3740015;
        Tue, 20 Sep 2022 08:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663662860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hIDCJPbOLzcRAxwQmEioDQfvkrfBcsu30Bu++9B+/1s=;
        b=nUb8JSyQgzCTbXM7v+cpWwMcXHbpm62onfDQG+C4Q0TGOaWjeFVdp5jyCpBXdixxB11H+0
        6/bp84XXzheJdJ7My81RQm0Uf82U8xk6ObbQqOMnGtTGk+aQ5viAAG/8hatzgqM7zR79Hh
        u5EN0IRkdyToQxx8BWozJHZlzI0PgD65nAY/cYakqxOIWuu3j4TQUe2eaNwMC2eSK7Bee7
        3ipfxiaGJo5anGElPv0M3b6yCbgoBAlETcCOp4c6RyvaXRxPzrjDCoYyE/rvb3+ZL40fJa
        KydiiA8VtTzma/xiqg2QLiqSV2p7ix8i45XiEvHiPy4Ep2vvpq4NNJKJk59I0w==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: cafe: Use correct function name in comment block
Date:   Tue, 20 Sep 2022 10:34:19 +0200
Message-Id: <20220920083419.601287-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220805180117.2375503-1-colin.i.king@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'81141fe9bc176b6a176abfe1cbc7f6ba71d37e89'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-08-05 at 18:01:17 UTC, Colin Ian King wrote:
> The incorrect function name is being used in the comment for function
> cafe_nand_read_page. Correct it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
