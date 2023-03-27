Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394506CB21F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 01:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjC0XJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 19:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjC0XJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 19:09:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712D3213B;
        Mon, 27 Mar 2023 16:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oMDBWqWOlIU0sHD7bRFINkPbOz4tKP/jx+uoy8N2eAk=; b=jq9AhNHYbXWbeJb64OED8KLPrC
        CH3w8f30Va2EwWmHyytVUhjFeQwtwxGhO2OTQCWhnKTB5oYVu9fnp3+shk0u/Xxc5kyYcYIdgq/fI
        OcwtxGs7LV71vbhmZVqEaNOhnFlUVRZqCCJUG82hKMmVjrsExdV4z3IWMOnpcqDCtPOdTAmdYSg3H
        NdH6CaS6dIpKihvKhO2n8uZecFGV93QVFqXRcpWjSkQ6ci/Qhnml2b9ZXmhxKOMTXVxugedYVJy+a
        tfo4pi7gWtvbpkhJDEiP3htz1hltRoGMj220K07jyxRftTU+B6i+CvnEsD0Rnqc28qaYaGPVpCBXe
        Kc+iJ3cg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgvxM-00CdF7-2N;
        Mon, 27 Mar 2023 23:08:52 +0000
Date:   Mon, 27 Mar 2023 16:08:52 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, sth@linux.ibm.com, hoeppner@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: annotate bdev_disk_changed() deprecation with a
 symbol namespace
Message-ID: <ZCIiBHyrzDoTJPXT@bombadil.infradead.org>
References: <20230327184410.2881786-1-mcgrof@kernel.org>
 <ZCIVx2UNN8VAWYAH@infradead.org>
 <ZCIgavqUnw0Z3A3t@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCIgavqUnw0Z3A3t@bombadil.infradead.org>
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

On Mon, Mar 27, 2023 at 04:02:02PM -0700, Luis Chamberlain wrote:
> On Mon, Mar 27, 2023 at 03:16:39PM -0700, Christoph Hellwig wrote:
> > What I'd really want is something like an
> > 
> > EXPORT_SYMBOL_FOR(bdev_disk_changed, loop, CONFIG_BLK_DEV_LOOP);
> > EXPORT_SYMBOL_FOR(bdev_disk_changed, dasd_kmod, CONFIG_DASD);
> > 
> > Which ensures that the symbol lookup only succeeds for loop.ko and
> > dasd_kmod.ko, and that the export only happens if the relevant
> > symbols are set.
> 
> I think that could be done, sure.

BTW is anyone aware of similar exports which are stuck in this way?

  Luis
