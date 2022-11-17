Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E36C62E6D9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240836AbiKQVTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240908AbiKQVSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:18:18 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A8184333
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:16:36 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 31AD420005;
        Thu, 17 Nov 2022 21:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668719795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2cwSDhmKhGB4TboptHUOlK62HhhK9Bmkg6FgEj+P/bQ=;
        b=X+L5le7AfovUztN631/qe+Z558YwUXV2uhwouiBlfiIL97YH98tSz3IMtYThDrPqsbE96Y
        nxzUJQWrhtEdCiI+VHB1S0VpJraZrWfpf9S6JWuB61octw0pyOS9pah6CQOVuOc+PoUgHI
        soTfquU6bRrdgu5RSwdzHu0OFWk3Tj+4O+/Au1OYVeScYT0xrpn4Tqwn8zjZ0DxcZArK8i
        HOtZMHURO8wTojzOWkNcOkiSuE8mBblIQ++Bs0h7YnY9rZiyQaijkgxC+YfnfOL4StCJcc
        ni5zcjtMKlJWiBaiMvGputNLaH8mSJIIhDq6GwFg/0bI3vwEo20uPCvRTaIzhg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Hui Tang <tanghui20@huawei.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, u.kleine-koenig@pengutronix.de
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        weiyongjun1@huawei.com, yusongping@huawei.com
Subject: Re: [PATCH v2] mtd: lpddr2_nvm: Fix possible null-ptr-deref
Date:   Thu, 17 Nov 2022 22:16:33 +0100
Message-Id: <20221117211633.1273693-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114090240.244172-1-tanghui20@huawei.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'6bdd45d795adf9e73b38ced5e7f750cd199499ff'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-11-14 at 09:02:40 UTC, Hui Tang wrote:
> It will cause null-ptr-deref when resource_size(add_range) invoked,
> if platform_get_resource() returns NULL.
> 
> Fixes: 96ba9dd65788 ("mtd: lpddr: add driver for LPDDR2-NVM PCM memories")
> Signed-off-by: Hui Tang <tanghui20@huawei.com>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
