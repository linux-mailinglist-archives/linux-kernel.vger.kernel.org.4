Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A666026C4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiJRI1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiJRI1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:27:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E5A98C89;
        Tue, 18 Oct 2022 01:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V5dGkxM1ZkAhl55SodKMgmP9uHBAgzf/1ehqjAwBQSg=; b=n3TT8wBI46W/+1MsaRPGODqZ3F
        w/ijffxzIj6hRWARwmKYiHMKKGGfBkPNeRkppqypRpHTfC9xPqTPA0noYPrklowhf6696LAjUknZ3
        S3F7Tj2RvmW/4/1VEGuUurGVorUw+GMawxeUdJsZC3OukkDo6hgKgcp3na02Knmk+d8h4i12p+09e
        9S9lH4m8NMCpLAGlKWSPkUsTPFzx4rQ2a6oXUmHkW7e1XfP42u1YQDLMUIGJRlE59VDxMaUKtK6eo
        +XXFl19y2BxlFK4526VI9mwj8AFxCpoogHkpgwSn8sqP6H0CZ4brHEJpbUo7DAOc3b3TZ9qlYeD1C
        cllFc0jA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okhwM-004O5I-Bc; Tue, 18 Oct 2022 08:27:10 +0000
Date:   Tue, 18 Oct 2022 01:27:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Khazhy Kumykov <khazhy@chromium.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: allow specifying default iosched in config
Message-ID: <Y05jXggD6W4uMOMJ@infradead.org>
References: <20220926220134.2633692-1-khazhy@google.com>
 <fff022da-72f2-0fdb-e792-8d75069441cc@opensource.wdc.com>
 <CACGdZYKh4TXSaAAzJa13xsMH=tFzb4dYrPzOS3HHLLU8K-362g@mail.gmail.com>
 <7e3a521e-acf7-c3a8-a29b-c51874862344@opensource.wdc.com>
 <CACGdZYKvTLd0g2yBuFX+++XeSa6aapuAwOM7e63zhKgdKFEGEw@mail.gmail.com>
 <Y0PHsxmsWHFYiLPK@infradead.org>
 <CACGdZYKcpHG_bWew_K78CgwDYMQAGfXX+QU4-9PNoV1j2E1a0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGdZYKcpHG_bWew_K78CgwDYMQAGfXX+QU4-9PNoV1j2E1a0g@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 10:22:59AM -0700, Khazhy Kumykov wrote:
> > > The kernel already picks and hardcodes a default scheduler, my
> > > thinking is: why not let folks choose? This was allowed in the old
> > > block layer since 2005.
> >
> > You can choose it using CONFIG_CMDLINE.  We can't add a config option
> > for every bloody default as that simply does not scale.
> 
> Are you referring to elevator=? It looks like that needs to be
> re-wired for blk-mq, but seems like a reasonable solution. I'll send a
> new patch out.

Yes, thanks!
