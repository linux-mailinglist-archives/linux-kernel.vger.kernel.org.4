Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B474C6DFC47
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjDLRHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjDLRHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:07:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC1B2D55
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lzta4Lh8LurIXk3BdU+dNUXNGo9kwEA2Xm/xfZv+R28=; b=m0i5lhke/0QwY8hzvX70osTiMo
        3A9QkBlX2Rb0E+pi29wiFpLSDrINtdUw8/hqY3yH0az5SXAf7HKBQuPgqC+sFSbJ7u8NUkOz+LvcC
        vNbLaqz2OFm9hbXVMs9okkdSwNKkF73RF7KAVsPcspnvzn1wyaKxinYP3iuXshNSQIA6AaH6TLmZV
        JtKtF3F0VHg7JwFXN7KULth+KLBjnjLf0qGhYwNLbWOuOutDZoy0PCCMOzUl3r+CZi+GNJNg7yHJ/
        zyDNwet58LYwX/sJOut2M6PdVMf47gNakt+TtyNT+Xdy/L3BCpKjHT9o8DPiirFHdmfAONtMOucjw
        7qgYoYpA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pmdvv-003ukj-1T;
        Wed, 12 Apr 2023 17:06:59 +0000
Date:   Wed, 12 Apr 2023 10:06:59 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     jan.kiszka@siemens.com, kbingham@kernel.org, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, song@kernel.org
Subject: Re: [PATCH] scripts/gdb: use mem instead of core_layout to get the
 module address
Message-ID: <ZDblM40+MVm9XTgT@bombadil.infradead.org>
References: <CGME20230412112345eucas1p10c0ab064156268c9021abe9fc6bf1fd3@eucas1p1.samsung.com>
 <20230412111508.892296-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412111508.892296-1-p.raghav@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 01:15:08PM +0200, Pankaj Raghav wrote:
> commit ac3b43283923 ("module: replace module_layout with module_memory")
> changed the struct module data structure from module_layout to
> module_memory. The core_layout member which is used while loading
> modules are not available anymore leading to the following error while
> running gdb:
> 
> (gdb) lx-symbols
> loading vmlinux
> Python Exception <class 'gdb.error'>: There is no member named core_layout.
> Error occurred in Python: There is no member named core_layout.
> 
> Replace core_layout with its new counterpart mem[MOD_TEXT].
> 
> Fixes: ac3b43283923 ("module: replace module_layout with module_memory")
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---

Jan, Kieran,

That commit is in my modules-next tree, so I can take that fix in
through my tree. Let me know if that is OK, and if you ACK the patch.

Pankaj, thanks!

  Luis
