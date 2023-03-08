Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72E66B0BB9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjCHOqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjCHOpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:45:33 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4C5BC7AB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:44:03 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8740367373; Wed,  8 Mar 2023 15:43:43 +0100 (CET)
Date:   Wed, 8 Mar 2023 15:43:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] maple_tree: export symbol mas_preallocate()
Message-ID: <20230308144343.GA16259@lst.de>
References: <20230302011035.4928-1-dakr@redhat.com> <20230302015242.xi3y53okc4skmonn@revolver> <9abef101-3a9b-0bdd-7139-ced7d5e28ebe@suse.cz> <da65d59e-f918-d7d5-644b-33cc51c2ba6c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da65d59e-f918-d7d5-644b-33cc51c2ba6c@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 03:34:29PM +0100, Danilo Krummrich wrote:
> On 3/8/23 11:59, Vlastimil Babka wrote:
>> On 3/2/23 02:52, Liam R. Howlett wrote:
>>> Thanks for the patch.  This should indeed be exported.
>>>
>>> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>>
>> What uses it? Don't we export only things used by in-kernel modules?
>
> mas_preallocate() is part of the maple tree's 'Advanced API'. All other 
> functions of this API are exported already.
>
> More specifically, e.g. mas_store_prealloc() is exported which doesn't make 
> a lot of sense without mas_preallocate() being available too.
>
> I don't think it is used outside of mm yet, but as a generic tree 
> implementation maple tree is pretty likely to be used in code built as 
> module, e.g. drivers.

If anyone wants to use they can add the export as needed. 
