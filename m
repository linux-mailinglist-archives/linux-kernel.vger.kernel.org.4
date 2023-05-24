Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CC770F1CA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240271AbjEXJIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240192AbjEXJIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:08:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE79F90;
        Wed, 24 May 2023 02:08:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87BC662EE8;
        Wed, 24 May 2023 09:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D42FC433EF;
        Wed, 24 May 2023 09:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684919314;
        bh=IplHIKisPGc4ZSs40w7kePLg0DC0C+JPosEuWZ9HR3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cmEPAoM/4LFak2GJMfyD0VgZJCyx/WOTukUx+9GwFimK5NARsFOVL1llwwHaooM6p
         neIqskRmafiwRzT6Y0wFFkdR21VkqqAdarc66gec/o2niM+2OGzU6OJ1cPdGKJjtUg
         ym96gqJUL/jEXtPVCj5WPE6sBn6+N8xai3IE9pkJyOXXVr3NT8dh99ThMDsZCJ2pJn
         C8Q1P5nm5vwtP9BGeHcjZ62rWJ+pkjXIlVAqiAsvz0w2jMyvpiStJc42NFMS+QSdU9
         nOh33Lr7miKMJZxThGbKcGOef9TxlRieMRCNDI6jwdazGXNBQOKA6LhfZF8IU2seq9
         2L3qc0Xg3aSbA==
Date:   Wed, 24 May 2023 11:08:29 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the nfsd
 tree
Message-ID: <20230524-unumkehrbar-abbezahlen-f7b2865fe532@brauner>
References: <20230524095545.0f70a1e7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230524095545.0f70a1e7@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 09:56:14AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the vfs-brauner tree got a conflict in:
> 
>   fs/nfsd/nfsfh.c
> 
> between commit:
> 
>   fed41678532c ("nfsd: don't provide pre/post-op attrs if fh_getattr fails")
> 
> from the nfsd tree and commit:
> 
>   1a6f4cbffdf5 ("nfsd: ensure we use ctime_peek to grab the inode->i_ctime")
> 
> from the vfs-brauner tree.
> 
> I fixed it up (I just used the version from the nsfd tree - which
> removed the code modified by the latter) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

I'll drop Jeff's series from vfs.all since he's about to send a new
version anyway. Thanks!
