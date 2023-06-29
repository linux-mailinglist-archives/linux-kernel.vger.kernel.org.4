Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234BB742103
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 09:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjF2Hbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 03:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjF2HbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:31:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32EA2D52;
        Thu, 29 Jun 2023 00:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WO2Pk4RvEwUKcqC3zK5xDq5WvCKQJzHvaYR/UXIIXfs=; b=r3VdmzsNXfUzy46QSIw7zIiY5w
        1hgbjQLrGgLDrm0juIusovpWpQrdruw/srVsDzU5IuNkGyZXUzw4bxdphVbYH4Xg4WAJVSd6IwMLy
        x9WUZlwf6PkiSP7TZwdgrvPxbh0mqnVe/4pxcKve2ihU0sRxdCISWU7R3cvQ18j+Tjhdcq7u2ZhXb
        M4D4VFchOv8J9BMFaRKEemeSvCW2Av34GBPE6e98KOhdtnzPFyMS5042Tt5ef+4XWdt+DukGQwiOg
        axw2wpiebY5cTb6sPLreNHM1ZopTK08q0MupEIyU6tXktJ2NQR2+FuNFsh99FsqZEcYf2W826+Ud4
        0XTMg+3A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qEm7V-000Ct9-30;
        Thu, 29 Jun 2023 07:31:13 +0000
Date:   Thu, 29 Jun 2023 00:31:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH v4 3/4] ublk: enable zoned storage support
Message-ID: <ZJ0zQSX9YOWqJbqE@infradead.org>
References: <20230628190649.11233-1-nmi@metaspace.dk>
 <20230628190649.11233-4-nmi@metaspace.dk>
 <ZJ0ZAmpNpid8Ff08@infradead.org>
 <871qhuzpxr.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qhuzpxr.fsf@metaspace.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 09:25:32AM +0200, Andreas Hindborg (Samsung) wrote:
> If you prefer the latter, I can change it back, no problem. But I must
> say I think it comes off cleaner when we move as much as possible of the
> zoned code to a separate translation unit.

I have to say I much prefer the ifdef.  In the end Ming is the
maintainer though, so I'll defer to him.
