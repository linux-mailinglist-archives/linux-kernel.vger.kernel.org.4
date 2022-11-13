Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD89A626D93
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 04:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiKMD0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 22:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiKMD0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 22:26:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CFA13D37;
        Sat, 12 Nov 2022 19:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KW/7mjXKC3tNdBWrluaiddbCVCwRqOO2tRgB4pyxYYg=; b=Y43ydAjXCKdi7E3Mv/BHcZa1/N
        Cq36ULd3diwnYDWlA4FPuRqzUy6/GpmEOD51g3NKIwDpJPv93821cIEG1vlaZyp8UtcNeiWlmlaqp
        hYdQFx2ZrtN2qX3qOLUyxnyTM3EvLvRAfovPStW+tk+4Pq5JekaHCOUPTokTt0iawgRxXEuf3o2Jc
        cuDraKgsNuDEiZ/LivQ4ghVyNJiv5H2wgXDTrYwQLmzTFZwwI05/aewSV3DfiqiTgCihQVM0qvBDa
        3cbiQFK0iw5lWQ/UexY+H4yafUCxpdB8dfqzpkUgURI9MGMpQInziVd/Lh/VAvzZhaDJA3pogxObV
        8in48VSg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ou3dD-009DQV-IM; Sun, 13 Nov 2022 03:26:03 +0000
Date:   Sat, 12 Nov 2022 19:26:03 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>,
        Zhen Lei <thunder.leizhen@huawei.com>
Cc:     masahiroy@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: Re: [PATCH v9 7/8] kallsyms: add /proc/kallmodsyms for text symbol
 disambiguation
Message-ID: <Y3Bjy8UlZXdpWMYn@bombadil.infradead.org>
References: <20221109134132.9052-1-nick.alcock@oracle.com>
 <20221109134132.9052-8-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109134132.9052-8-nick.alcock@oracle.com>
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

On Wed, Nov 09, 2022 at 01:41:31PM +0000, Nick Alcock wrote:
> This helps disambiguate symbols with identical names when some are in
> built-in modules are some are not, but if symbols are still ambiguous,
> {object file names} are added as needed to disambiguate them. 

*Why* would we ever want to trouble ourselves with expanding all this
data into the kernel? The commit log does a poor effort to describe
any value-add doing this could ever have.

> I am not wedded to the name or format of /proc/kallmodsyms, but felt it
> best to split it out of /proc/kallsyms to avoid breaking existing
> kallsyms parsers.

I'd like much more review from other parties other than Oracle on this then.
If this is generally useful, I'd image interested parties would be raving
about all this but so far I don't see it. Please try to engage folks
outside of Oracle.

  Luis
