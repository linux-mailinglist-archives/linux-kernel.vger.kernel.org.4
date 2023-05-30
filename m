Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33AF7162C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjE3N5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbjE3N5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:57:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8F5C5;
        Tue, 30 May 2023 06:57:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CD7CD1FD68;
        Tue, 30 May 2023 13:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685455028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9+bxRqmQABeptP61XaPA8azXzWiuC1sGZjwii7P9rlA=;
        b=obd0PnWR5Vm4DLCVnKC88fpDBgtNxJcjO6gOo0wWDrG4bjmidgOE/vLj10ZiEFQ4FQHGYG
        uxizfhQxe355d9hu6pFFqhwdyoPGrNMEDI7Feo88Uh9pOblAxcJ4bFLCyRDR0j9ujoxIuW
        aGQDOV1LokoDn/RB+9uOn4Ied3t/vDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685455028;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9+bxRqmQABeptP61XaPA8azXzWiuC1sGZjwii7P9rlA=;
        b=3ljufY1kWk83GIvwak8lNiyjaFn6EFsdkQcR34F3E04WVQwiJuMFoeOZFFHt7CgIneR3bB
        PUxhrixkQ99+HMAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFAF313597;
        Tue, 30 May 2023 13:57:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IgTCLrQAdmTzUgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 30 May 2023 13:57:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 21103A0754; Tue, 30 May 2023 15:57:08 +0200 (CEST)
Date:   Tue, 30 May 2023 15:57:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux SPDX Licenses <linux-spdx@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Actions <linux-actions@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Jan Kara <jack@suse.com>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Diederik de Haas <didi.debian@cknow.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/2] SPDX conversion from UDF
Message-ID: <20230530135708.lajsjvkrrlxddumw@quack3>
References: <20230522005434.22133-1-bagasdotme@gmail.com>
 <20230522095308.ypwi5txynkbvnfw7@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522095308.ypwi5txynkbvnfw7@quack3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22-05-23 11:53:08, Jan Kara wrote:
> On Mon 22-05-23 07:54:33, Bagas Sanjaya wrote:
> > This small SPDX conversion series targets UDF file system, which is
> > splitted from v2 of my SPDX conversion series that is triggered by
> > Didi's GPL full name fixes [1]. It is done to ease review.
> > 
> > All boilerplates in fs/udf/ is converted, except fs/udf/ecma_167.h.
> > The latter file apparently looks like 2-clause BSD Source-Code
> > license, yet the second clause is from third clause of 3-Clause BSD.
> > This custom license can't be expressed satisfiably in SPDX license
> > identifier, hence the file doesn't get converted.
> > 
> > This series is based on mm-nonmm-unstable branch.
> > 
> > Changes since v1 [2]:
> >   * Correct SPDX tag for LGPL (correct spdxcheck warning)
> > 
> > [1]: https://lore.kernel.org/linux-spdx/20230512100620.36807-1-bagasdotme@gmail.com/
> > [2]: https://lore.kernel.org/linux-mm/20230517083344.1090863-1-bagasdotme@gmail.com/
> > 
> > Bagas Sanjaya (2):
> >   fs: udf: Replace GPL 2.0 boilerplate license notice with SPDX
> >     identifier
> >   fs: udf: udftime: Replace LGPL boilerplate with SPDX identifier
> 
> The patches look good to me. So unless someone objects in a few days, I'll
> queue them into my tree. Thanks!

Patches queued now.

								Honza
