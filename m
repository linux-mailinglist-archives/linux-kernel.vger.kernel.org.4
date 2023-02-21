Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7619B69E9BB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 22:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjBUVsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 16:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjBUVsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 16:48:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E419279B9;
        Tue, 21 Feb 2023 13:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9wRyTrQMV/JTg5YpVENMGjnZWekiNX6igp9A3xduDzA=; b=Wk0SNPEDQo4F/o1PXV9LRYRXkD
        yYE1HvlqaAYQgMElqRyy38wHa3mUpZChD2YsHuwAk4W66my+56RsNZGV17/f2MStXnznyjmfYky2z
        GozltbUHR+P7mj9QmsKx2IB0Bkn8w7He77sd66RvJeAqIiYIjC5jtq+nJWTxP22FvSeJkCACvSE3/
        1tMr/o0K7pemJlzvhKx4x+BYqjE/1L7wiBwgdlu5cHhGGFwiO4Tg/nWKCqueZTG4i4DxwMHFVITdB
        +jvAlpzQTySYkjZlUsjkwZ+Fh9uopueEOEXQ2LbI21NggxnEvKClUWIin/gBKH52EJbUaq5NEz+tA
        Gf+rkPUA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUaV0-009sOz-7D; Tue, 21 Feb 2023 21:48:34 +0000
Date:   Tue, 21 Feb 2023 13:48:34 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, elena.zannoni@oracle.com
Subject: Re: [PATCH modules-next v10 00/13] kallsyms: reliable
 symbol->address lookup with /proc/kallmodsyms
Message-ID: <Y/U8MuL24OZzbIIp@bombadil.infradead.org>
References: <20221205163157.269335-1-nick.alcock@oracle.com>
 <Y8b8TOJzd/RZXR8z@bombadil.infradead.org>
 <87r0uy3hkw.fsf@esperi.org.uk>
 <87bkm22y6e.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkm22y6e.fsf@esperi.org.uk>
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

On Thu, Feb 09, 2023 at 11:53:29PM +0000, Nick Alcock wrote:
> [most people trimmed from the Cc: list for this procedural question]
> 
> On 9 Feb 2023, Nick Alcock outgrape:
> > I am going to split this whole series into:
> >
> > 1. A series of patches (123 of them at present) Cc:ed to subsystem
> > maintainers as well as you, to comment out the MODULE_LICENSE usage.
> > These patches will have Suggested-by you. This series is rebased against
> > the latest modules-next and revalidated, and is ready to be mailed out;
> > will do so shortly.
> 
> One quick question: if/when you're happy with this series, are you
> planning to take it yourself via modules-next?

It seems some maintainers are already taking patches in, so let's see
what folks take in, then if there are not takers I can just take what is
not merged on linux-next through modules-next.

So try to get them into each subsystem tree, and around rc3 send the
ones that are not merged and I'll just take them into modules-next.

  Luis
