Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D246FCF41
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 22:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjEIUPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 16:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjEIUP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 16:15:28 -0400
Received: from out-58.mta0.migadu.com (out-58.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5709106
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 13:15:27 -0700 (PDT)
Date:   Tue, 9 May 2023 16:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683663324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LkTznK2Z03Vodu7CHSj8IilAg1DvNfs35ZJK4M95LHM=;
        b=hVlZyijC8g1SgMMcQzMD2aPZOFsIXJukaHMQb7xAEZD0ie3kpmD214xSLxW6Qwe29rRInp
        iGi16+pUQ1aKH0le1y5M7fozdDuuDjk5weFK4WsJ2563X4AR/tPsnXme6t3R11oOvUVdxp
        0emtidDzOsxOH1uEW0xSB7wFOIfH52M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <ZFqp1UEjM8ibrCWT@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <ZFqOukfefifbfHMb@murray>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFqOukfefifbfHMb@murray>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 11:19:38AM -0700, Lorenzo Stoakes wrote:
> On Tue, May 09, 2023 at 12:56:32PM -0400, Kent Overstreet wrote:
> > From: Kent Overstreet <kent.overstreet@gmail.com>
> >
> > This is needed for bcachefs, which dynamically generates per-btree node
> > unpack functions.
> 
> Small nits -
> 
> Would be good to refer to the original patch that removed it,
> i.e. 7a0e27b2a0ce ("mm: remove vmalloc_exec") something like 'patch
> ... folded vmalloc_exec() into its one user, however bcachefs requires this
> as well so revert'.
> 
> Would also be good to mention that you are now exporting the function which
> the original didn't appear to do.
> 
> >
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Uladzislau Rezki <urezki@gmail.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: linux-mm@kvack.org
> 
> Another nit: I'm a vmalloc reviewer so would be good to get cc'd too :)
> (forgivable mistake as very recent change!)

Thanks - folded your suggestions into the commit message, and added you
for the next posting :)
