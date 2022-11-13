Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2312626D8C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 04:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbiKMDCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 22:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiKMDCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 22:02:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEC0CE2B;
        Sat, 12 Nov 2022 19:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=61efaf8RTlvNOhUGQwmoI/xscEHmtLMGzUUcKWgEHXA=; b=NAFD+KbQYX2/O79dvSeh89kXif
        xCC1HKPnrBKOVyJx90G+ancal0LjEGbHvqOLKLo6qEQPjx+fYf5p8GtCt65LtLtm2/7667jaTG+eL
        6/ZDvTmG33mWKugsGd2qNQA1GtrZjI6VMX6kVtPgbrK4W/91x6iAkPCZYHl/OJdJpwcK2C1njHuKU
        kO+g2PdSOcRb7rwT5byFWWbHgX6TKqkrQk8Xdg8ZNtbJ0sddjoB1QximTJ4EE0zR5cOrX1nz9egjj
        m+kTeYLkd5882xCuoJSEzFXjlWkw3PWf2CY4xBbamr2MIwguk2aoPTgxKunJ6NBZpvaG2+MBUQcup
        HNkR8HrA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ou3GX-009CX1-N1; Sun, 13 Nov 2022 03:02:37 +0000
Date:   Sat, 12 Nov 2022 19:02:37 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     masahiroy@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com, thunder.leizhen@huawei.com
Subject: Re: [PATCH v9 3/8] kbuild: generate an address ranges map at vmlinux
 link time
Message-ID: <Y3BeTbHxj9OmmmIY@bombadil.infradead.org>
References: <20221109134132.9052-1-nick.alcock@oracle.com>
 <20221109134132.9052-4-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109134132.9052-4-nick.alcock@oracle.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 01:41:27PM +0000, Nick Alcock wrote:
> This emits a new file, .tmp_vmlinux.ranges, which maps address
> range/size pairs in vmlinux to the object files which make them up,
> e.g., in part:
> 
> 0x0000000000000000 0x30 arch/x86/kernel/cpu/common.o
> 0x0000000000001000 0x1000 arch/x86/events/intel/ds.o
> 0x0000000000002000 0x4000 arch/x86/kernel/irq_64.o
> 0x0000000000006000 0x5000 arch/x86/kernel/process.o
> 0x000000000000b000 0x1000 arch/x86/kernel/cpu/common.o
> 0x000000000000c000 0x5000 arch/x86/mm/cpu_entry_area.o
> 0x0000000000011000 0x10 arch/x86/kernel/espfix_64.o
> 0x0000000000011010 0x2 arch/x86/kernel/cpu/common.o
> [...]

This does't say why we'd want this. So either you merge it with its
first user or you explain here why anyone might find this useful.

  Luis
