Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0266D5054
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbjDCS3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjDCS24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:28:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945782683
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:28:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3303561849
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 18:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3814BC433D2;
        Mon,  3 Apr 2023 18:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680546529;
        bh=yICN110vzqQ8myDytASlXudxGw7tRNZQDNQFPj+jn84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rkxh0Fw9pjkBlgfWD12YHOFOF2sf+jozOVwUbjptahBf3OzVzzOmPSARg2M/b/9/r
         Feh8DNH0EVkpT4vXvl7RqkEn1aHGYNScZY8XOY4CZCfLVRksLf+PC6BSPMrgel69/6
         bO1Dohjt/+C5svwlblOCq2Q90bTrG0TxeURJPU5U2j0LFtIc3K+xDLL+WZnxHE+Z2k
         zBL6tY8gEyHHQvUv+wvek+uoWsu+e43EIGkRmv8BilEmdoH2z8K+tcsXjq5SHOTGcs
         pWZxpdKhLa5jk2VQO4PgI6x6UP66080+3ioBg813MBKdsHUbwP1X01VYFOAUV2ngqq
         Ubg8yaj7bhHcw==
From:   Conor Dooley <conor@kernel.org>
To:     linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] Hey Jassi, all,
Date:   Mon,  3 Apr 2023 19:28:28 +0100
Message-Id: <20230403-punctual-placidly-4898955d636c@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307202257.1762151-1-conor@kernel.org>
References: <20230307202257.1762151-1-conor@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1412; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=Bo7lkVcAUQ2XqrBpPsqSpiTg2cX4hn+UuEXZeqaQLm8=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCnaUqf2xEioLN3AVfL95UEtTdMyj3VftrL8ljLiCbgkX a0YKnCio5SFQYyDQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABM518XwT/lBUAjfB47p5jUq 9rIT6z1ftj/+vppxsZGutreoR9qMBIb/qUGb2Z8+mtdevfnmwXvPX064brRA3JPrkstk9fc6dnq POQA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Tue, 07 Mar 2023 20:22:50 +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Here are some fixes for the system controller on PolarFire SoC that I
> ran into while implementing support for using the system controller to
> re-program the FPGA. A few are just minor bits that I fixed in passing,
> but the bulk of the patchset is changes to how the mailbox figures out
> if a "service" has completed.
> 
> [...]

Applied to riscv-soc-for-next, thanks!

[1/8] mailbox: mpfs: fix an incorrect mask width
      https://git.kernel.org/conor/c/75dfbcbfd781
[2/8] mailbox: mpfs: switch to txdone_poll
      https://git.kernel.org/conor/c/b5984a9844fc
[3/8] mailbox: mpfs: ditch a useless busy check
      https://git.kernel.org/conor/c/da82f95f7c07
[4/8] mailbox: mpfs: check the service status in .tx_done()
      https://git.kernel.org/conor/c/37e3430176ff
[5/8] soc: microchip: mpfs: fix some horrible alignment
      https://git.kernel.org/conor/c/5ca631ec757b
[6/8] soc: microchip: mpfs: use a consistent completion timeout
      https://git.kernel.org/conor/c/4f739af1934a
[7/8] soc: microchip: mpfs: simplify error handling in mpfs_blocking_transaction()
      https://git.kernel.org/conor/c/7606f4dfffa7
[8/8] soc: microchip: mpfs: handle timeouts and failed services differently
      https://git.kernel.org/conor/c/8f943dd12eef

Thanks,
Conor.
