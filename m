Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669386C29F6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjCUFlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjCUFlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:41:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E7717CED;
        Mon, 20 Mar 2023 22:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=V+8E3N2hWBMY6JuQmKvAuziEhrAWOBaYxYWA1/lHFMo=; b=PZrBUD6jn6h0x9MriVZBLTBQP0
        C4ALnRjap0IJJR7wQjpZDkxe0U9MfJPJhWsZ119kwFBbS1dtNyXCs3LU0wwV9t3oM9gZelGBLSwkD
        PwIOb3YDFAqKstEJrwe8Cbby0u7ClWLuq3C7L8KQffHETP+vIKV4p+VIBrk7rgFu1H3W31RDlOuZ1
        n9XHLZtnkio5y9RsiASEehuG2QSKkJ3ejIE8S3xZOiDaoeJVNUQypYA8i5iVKWZw1tMwzyuT+4pwo
        ZTSTkZsl9FLkXyldkhUZzDeGX6VdZgJTTdcE3QPVo9KPYK8EC5VPyvazJl+M6GUOdn5oGRPoeGhuF
        BUHcTxTw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1peUjw-00BHkn-2s;
        Tue, 21 Mar 2023 05:40:56 +0000
Date:   Mon, 20 Mar 2023 22:40:56 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the sysctl tree with Linus' tree
Message-ID: <ZBlDaMh023N20uuo@bombadil.infradead.org>
References: <20230321132052.7d12fd7d@canb.auug.org.au>
 <20230321132227.5f63cd43@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230321132227.5f63cd43@canb.auug.org.au>
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

On Tue, Mar 21, 2023 at 01:22:27PM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> On Tue, 21 Mar 2023 13:20:52 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > Today's linux-next merge of the sysctl tree got a conflict in:
> >=20
> >   mm/memory-failure.c
> >=20
> > between commit:
> >=20
> >   44b8f8bf2438 ("mm: memory-failure: add memory failure stats to sysfs")
> >=20
> > from Linus' tree and commit:
> >=20
> >   cfe7e6ea5ee2 ("mm: memory-failure: Move memory failure sysctls to its=
 own file")
> >=20
> > from the sysctl tree.
> >=20
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
>=20
> Sorry, I forgot the resolution - see below.

Oh sorry, its on Linus' tree, so I can just rebase too. Did that and
addressed the conflict as you did, thanks!

  Luis
