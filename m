Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04C66807DF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbjA3IwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235761AbjA3Iv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:51:58 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B303C22;
        Mon, 30 Jan 2023 00:51:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B890321998;
        Mon, 30 Jan 2023 08:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1675068712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2QXjhkuIwbHarU1yfK2fMrK6Ps/IzEIQQVoPuYVsFQc=;
        b=sooiBTVJhSxWNN0x7xNwBMAD/x1iMou5JF0ahJcFGI6fy98TODwzFZJu/E7H39csn+QGRq
        ZUOCR0a3eLOZOoO6sVEHIUPhvj+53ai1ZHUOYwxam266Q8pjiwKLThYbEwRNSoMl9nNjtm
        u54fUUVyXprbB9dhcsLHqP/EtQ+TkKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1675068712;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2QXjhkuIwbHarU1yfK2fMrK6Ps/IzEIQQVoPuYVsFQc=;
        b=jZ0qfspvZqO0mGnJFQwfQbHzTol9NGR7Mf4hehX/oF3cI1Fx9o9M3jpaj2IIyn1GiMWYxv
        8o2Kjp2WXe0xGSCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70FED13A06;
        Mon, 30 Jan 2023 08:51:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id p4lFGiiF12OzWQAAMHmgww
        (envelope-from <jroedel@suse.de>); Mon, 30 Jan 2023 08:51:52 +0000
Date:   Mon, 30 Jan 2023 09:51:51 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the rpmsg tree
Message-ID: <Y9eFJxQn3y3ig3qw@suse.de>
References: <20230127180226.783baf07@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230127180226.783baf07@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the report, Stephen.

Bjorn, Mathieu,

On Fri, Jan 27, 2023 at 06:02:26PM +1100, Stephen Rothwell wrote:
> After merging the rpmsg tree, today's linux-next build (arm64 defconfig)
> failed like this:
> 
> drivers/remoteproc/qcom_q6v5_adsp.c: In function 'adsp_map_carveout':
> drivers/remoteproc/qcom_q6v5_adsp.c:369:15: error: too few arguments to function 'iommu_map'
>   369 |         ret = iommu_map(rproc->domain, iova, adsp->mem_phys,
>       |               ^~~~~~~~~
> In file included from drivers/remoteproc/qcom_q6v5_adsp.c:12:
> include/linux/iommu.h:473:12: note: declared here
>   473 | extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
>       |            ^~~~~~~~~
> 
> Caused by commit
> 
>   f22eedff28af ("remoteproc: qcom: Add support for memory sandbox")
> 
> interacting with commit
> 
>   1369459b2e21 ("iommu: Add a gfp parameter to iommu_map()")
> 
> from the iommu tree.

The patch-set causing this is in a separate branch in the IOMMU tree
which you can be merged into the rpmsg tree for a fixup there:

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

