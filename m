Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E53E712C06
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243048AbjEZRp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242349AbjEZRpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:45:24 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B80099
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:45:22 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685123121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vW8GWMbz5sTr9yyBQ0lOsQ1IhyxKg59MofgGMizdKZQ=;
        b=Hc0jQu080me9NGxGSjMcNU9MtqoAT0m8wq8c2XZ9oUPTgTTn8fBPCVWe9PW9cMjQppK5dn
        MqHy+EF4taIPrgVNJVPP9stX7oCbGUOALsvdhxzKbFZvdinYc6dOh/cdFhJ4pjyZk04vaI
        6w7KK9Vk1upj9krH/HgRJVu1qLi8CGwzmbOEC8qskE/Yv7xOZ5a17dy77FiCveiEmFhqPq
        QMUrMkwydV5+Uwih8Kxs7+RFmdyb4WOVhAGhLmmsCdPkNtvo9QsuUUXBZayB36HdAw0An5
        sUMlUiMSmKLCg3D0H/KzBtWevtVb7LNcdqSnTSNINbI2rW/ldZSiiFq4fjU+BQ==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5600060003;
        Fri, 26 May 2023 17:45:20 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com
Subject: Re: [PATCH] mtd: spinand: gigadevice: add support for GD5F2GQ5xExxH
Date:   Fri, 26 May 2023 19:45:19 +0200
Message-Id: <20230526174519.922160-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525110526.21998-1-quic_mdalam@quicinc.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'ef1560b670bd28ca3230c7f5ad29c6a211fb1adb'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-05-25 at 11:05:26 UTC, Md Sadre Alam wrote:
> This is 2Gb SLC NAND flash with 4b/512b on-die ECC capability.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
