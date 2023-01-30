Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669696807D9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbjA3IuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjA3IuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:50:03 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CF5170D;
        Mon, 30 Jan 2023 00:49:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 80E8521995;
        Mon, 30 Jan 2023 08:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1675068558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7lyb3LLwsSXBjOcOHJDKpcEkhSavcXSrtyfTb3BTmlo=;
        b=mz25kx0fdRRNlP48Fy7lsIOjfShvcq0+JD9jdIymmkOGUvppd6JgoPFzW3Zbk1tnzKZnci
        cg8wnXuJrcBArJVi9ChiW3aMoS7Z75VHUn9x7K5bntH5/Xa+Ymqep3ofsIDlfVUgcMSN4G
        pbTAND1fOt7bfD/kLvvaZpqFk9jO/ww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1675068558;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7lyb3LLwsSXBjOcOHJDKpcEkhSavcXSrtyfTb3BTmlo=;
        b=5u7xjjKx3573fH5ak4HXZwPiVAkSIQ+PJoBoIJ4gCuNPcvjacDunxZJt0zbh+9PbhB2sSo
        z9Hzd4bU5S7NpJBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43F2513A06;
        Mon, 30 Jan 2023 08:49:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zYQzD46E12NxWAAAMHmgww
        (envelope-from <jroedel@suse.de>); Mon, 30 Jan 2023 08:49:18 +0000
Date:   Mon, 30 Jan 2023 09:49:16 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: linux-next: manual merge of the iommu tree with Linus' tree
Message-ID: <Y9eEjCsWUWeFccGd@suse.de>
References: <20230127141330.28b2c653@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230127141330.28b2c653@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the report, Stephen.

Alex,

On Fri, Jan 27, 2023 at 02:13:30PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the iommu tree got a conflict in:
> 
>   drivers/vfio/vfio_iommu_type1.c
> 
> between commit:
> 
>   895c0747f726 ("vfio/type1: Respect IOMMU reserved regions in vfio_test_domain_fgsp()")
> 
> from Linus' tree and commit:
> 
>   1369459b2e21 ("iommu: Add a gfp parameter to iommu_map()")
> 
> from the iommu tree.

In case you want to fix this up in your tree, the patch-set causing this
is in a separate branch in the IOMMU tree which you can merge into your
tree:

	git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git iommu-memory-accounting

Regards,

-- 
Jörg Rödel
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Frankenstraße 146
90461 Nürnberg
Germany

(HRB 36809, AG Nürnberg)
Geschäftsführer: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman

