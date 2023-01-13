Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36252669B26
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjAMO7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjAMO6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:58:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A7B4C706
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:46:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F8E5B820CC
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 14:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0663C433D2;
        Fri, 13 Jan 2023 14:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673621169;
        bh=ug6esbEt6V0hi8pr1Nu8LN1vIj7A2m5V13oqI8rkOE4=;
        h=From:To:Cc:Subject:Date:From;
        b=cp4nFzFA27R711YxXAVF/0Iyn2pGCOXN0pLFn1pYEMZNX8oxCrFBLR9x/qc8ATlv6
         ZwPI1ieK5lYhL82RkXtseDm7nCf7DAJbRj3MnNoAN5mxwjm/FHxuQGXqJxWzH/7Nnf
         zcLyNJVQAU3GdkVioFwXniVHzV/6TyxiH7CaGyBe4EWuJVmBjJtBvhMH40nMGXqmoC
         vzIzCWUzRxaIh1OASIXqj+1wZwVb1NxtU0Esyz5Og01vKcZrqPhkgDAGBxBOkBcLHX
         vteorU/ImeUtFfNiLiCqUWskwwrXGkfvPyVyzLh2oRqvhBjBcodPhoKea4hTiAIxIz
         4hWFQ7FdnTBRg==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] riscv: Add "Code:", and decodecode support 
Date:   Fri, 13 Jan 2023 15:45:50 +0100
Message-Id: <20230113144552.138081-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

RISC-V does not have "Code:" dumps in the Oops output. This series
adds that, together with scripts/decodecode support.

Thanks,
Björn

Björn Töpel (2):
  riscv: Add "Code:" to RISC-V splats
  scripts/decodecode: Add support for RISC-V

 arch/riscv/kernel/traps.c | 31 ++++++++++++++++++++++++++++++-
 scripts/decodecode        | 12 +++++++++++-
 2 files changed, 41 insertions(+), 2 deletions(-)


base-commit: 689968db7b6145b2e4beb8b472d31162ffa5ad7d
-- 
2.37.2

