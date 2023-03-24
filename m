Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2A66C8497
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 19:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjCXSPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 14:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjCXSPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:15:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FBF1CAF2;
        Fri, 24 Mar 2023 11:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q91sWKJ5qM0W+8Z2LcDEZ6Jbw6upCOB7ZMAE+jGPJwg=; b=RWNXTpRzFjxpwU3DSt34RoSEbL
        wUW/vnyRFYpzVs/qOQG0jHZgLSNLcK7YnRj5XRQ1aOdstvpcW3FPiwOwskz307W80fTRJNhiMiyQr
        euUyyTt9fSFEA2Z5+zwoVJv/vfY3Dvtiup92aqr/W4ppGQXBvMx+mSXiPLJbE2ScAdphRuNExEG5P
        sP5JgWInutm2BxiqVmox+LRFZiZA4boxD5qVQFsVOIAX+fIpSN3QBhXCvUKK7eB1VcgbKAdxuQ0Bz
        5wFW0/Zj78sZIER4CxLDmBj9bHwNdEYwkSDQv14aOZJJxptIypEOKqKKsi2Uj2ejYDoInHgymcgUH
        FfviE01A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pflwD-005GZI-3C;
        Fri, 24 Mar 2023 18:14:53 +0000
Date:   Fri, 24 Mar 2023 11:14:53 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Kees Cook <keescook@chromium.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Liam Beguin <liambeguin@gmail.com>,
        Wu XiangCheng <bobwxc@email.cn>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] Documentation: core-api: update kernel-doc reference to
 kmod.c
Message-ID: <ZB3onTspQs2eV6pZ@bombadil.infradead.org>
References: <20230324085310.20571-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324085310.20571-1-bagasdotme@gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 03:53:10PM +0700, Bagas Sanjaya wrote:
> Commit d6f819908f8aac ("module: fold usermode helper kmod into modules
> directory") moves kmod helper implementation (kmod.c) to kernel/module/
> directory but forgets to update its reference on kernel api doc, hence:
> 
> WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno -sphinx-version 2.4.4 -export ./kernel/kmod.c' failed with return code 2
> 
> Update the reference.
> 
> Fixes: d6f819908f8aac ("module: fold usermode helper kmod into modules directory")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Link: https://lore.kernel.org/linux-next/20230324154413.19cc78be@canb.auug.org.au/
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---

Thanks, queued onto modules-next.

  Luis
