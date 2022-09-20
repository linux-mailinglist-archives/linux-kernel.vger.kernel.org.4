Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726765BE08C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiITImn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiITIls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:41:48 -0400
X-Greylist: delayed 451 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Sep 2022 01:40:58 PDT
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782786B8E5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:40:57 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 96B6720015;
        Tue, 20 Sep 2022 08:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663663256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NtNJCvV3XRUp7DLnv6sKp5OMSzm47xcbNcA0aDhjMJo=;
        b=e3CB2fJqNRSpS4fX3Ivz69Tre5esojl++H8gLqM34UgRvWFhZbLAlaCw+OHcXsz87zNUU/
        jQ+M8fsTgx3fg/ZBkjV5dMPgsLaJ1V3U4UjW2JPKBILMtlba743wuF4lkgVB6oQgJ7oey9
        UjedLZGidb1m7jMWLgstJzXzr9gpMuOBTeLU6c8P6Hn4xrf8F2egM/6kpW2NkSr+GjRKSG
        qONqu2Ubx6VRvg8p8EPNcqpAquvsnqJnbBEynscmJrDKQnbfh74HcgVsLmqYbF/YFXTmcf
        CBbbHe9emoiJJYVBltYqjnaf3J37sLC4z1Kp/j0C7+Eml3LNI8G8fx4VpIqulA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     wangjianli <wangjianli@cdjrlc.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/mtd: fix repeated words in comments
Date:   Tue, 20 Sep 2022 10:40:53 +0200
Message-Id: <20220920084053.602329-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220908122229.10814-1-wangjianli@cdjrlc.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'9ee67182309290aee8135b2b464d0240afe63a28'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-08 at 12:22:29 UTC, wangjianli wrote:
> Delete the redundant word 'in'.
> 
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
