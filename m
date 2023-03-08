Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7826B0CAB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjCHP31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjCHP3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:29:25 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AC57BA26
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 07:29:18 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 89A1467373; Wed,  8 Mar 2023 16:29:13 +0100 (CET)
Date:   Wed, 8 Mar 2023 16:29:13 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Vlastimil Babka <vbabka@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH] maple_tree: export symbol mas_preallocate()
Message-ID: <20230308152913.GA19628@lst.de>
References: <20230302011035.4928-1-dakr@redhat.com> <20230302015242.xi3y53okc4skmonn@revolver> <9abef101-3a9b-0bdd-7139-ced7d5e28ebe@suse.cz> <da65d59e-f918-d7d5-644b-33cc51c2ba6c@redhat.com> <20230308144343.GA16259@lst.de> <59b703ac-9660-a0e5-09f7-c5b69d4f39cb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59b703ac-9660-a0e5-09f7-c5b69d4f39cb@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 04:18:55PM +0100, Danilo Krummrich wrote:
> Consistency wise I think we should either also export mas_preallocate() or 
> don't export the other ones either.

Please send a patch to drop all unused exports.
