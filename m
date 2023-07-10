Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C7674DE71
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjGJTp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjGJTp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:45:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27A1187
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wlZXOKJa51A2yn9rFVOOCYfWPuKQ4LE1eseiahlKuQE=; b=O12EtDyVlkYWB77dt/sbDpNf/1
        hvFN1ez0Gu+NJFMypF92VghNCI2Kr0YW0dKnaV6wQeC5iH9AtPJFtKo49/E0SLw8vfnm+zJT7BDOD
        NMAJc6cOCZVKwSh14t0wAxkicbAzX0/jlIPsvCJ1/IOp5pFl8shiLsOm3EsxuoPP/Zb9Ar94xsAi5
        FlZnbj6S67X2LaRJH78Lhe5OpJ8xIKQpm2YEGcg8Y41tkyuqBrKI2lb/8djGj0nonEA8aNgWdoLxy
        NpX02x8Yf0uTqYgSxSoqa9N0GzD0mnVi4GWRK59BDVwDVCeXV8AFrYzbBCWN/mzr7o2vVZn0TTaG9
        qAiunhHw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qIwpW-00CaUu-1g;
        Mon, 10 Jul 2023 19:45:54 +0000
Date:   Mon, 10 Jul 2023 12:45:54 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     rdunlap@infradead.org, thomas@t-8ch.de,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] module: Ignore RISC-V mapping symbols too
Message-ID: <ZKxf8jK8m+073rBE@bombadil.infradead.org>
References: <20230707160051.2305-2-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707160051.2305-2-palmer@rivosinc.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 09:00:51AM -0700, Palmer Dabbelt wrote:
> RISC-V has an extended form of mapping symbols that we use to encode
> the ISA when it changes in the middle of an ELF.  This trips up modpost
> as a build failure, I haven't yet verified it yet but I believe the
> kallsyms difference should result in stacks looking sane again.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/all/9d9e2902-5489-4bf0-d9cb-556c8e5d71c2@infradead.org/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Thanks, applied and pushed!

  Luis
