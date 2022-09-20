Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A095BE044
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiITIet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiITId5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:33:57 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D472CE1E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:33:56 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 81B704001B;
        Tue, 20 Sep 2022 08:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663662834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bTNKFIz45ZPZj71J12Gcu1Bo9Rngcq86HefzYguO+wY=;
        b=HTVawlf/jkZs3RU6DVLQGRhmAlS+dk7QQFr/Xk24zml/INT/C5h2UNfWVkE56g1wWXKReR
        Xni6XcfOM2TlhNcC+BD/V0gknYvL4uaSZtxIHzAo00qq++PgRDTDCML/TwLX+2DAA9D6rb
        50iPOct+g6I91VHAoOMSZBh3ah36paTeAEMvIyf4M0+ZcgTfK81Qbj1P3VEQ+cO90MTnpE
        yzPXob3Nn+5nLyJTl6gE2YehxNPQebA6rn2lNVwoH6kKa9gxLwHnUGhHNS8smBsZ3jCLuM
        gmONxjSEoQbdy5YE+6v3KazQs46/Sf9NogIf2fqDLQ0dVDgwnzjOFgc/4NJ7og==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     cgel.zte@gmail.com, miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, yangyingliang@huawei.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] mtd: rawnand: Remove the unneeded result variable
Date:   Tue, 20 Sep 2022 10:33:50 +0200
Message-Id: <20220920083350.601092-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220901074555.313266-1-ye.xingchen@zte.com.cn>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'15a3269417459c09215c64c1d18441cb0727ef28'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-01 at 07:45:54 UTC, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value cadence_nand_set_access_width16() directly instead of
> storing it in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
