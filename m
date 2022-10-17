Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5ABC60115A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiJQOnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiJQOm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:42:58 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF35566A5D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666017758; bh=Wba2l4Kwed3G/6vyWzT3y3nHVxraG2sEVvdQ86jT6rY=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=mbMel+jkBx+IkCbcpro63iOXUrg9YjL3NqhFFlOkpjN6zSdb6wqjGCuhQd2oGfI6u
         tRRzPy0tWGbC7t4h7zdo2L3/1gg4VZjpjzSxAdE1+Zjc9+LOzKRhaAhT43aauOfjku
         tsy0uCa60ilisCoMMIjjCYAQ+3dQ410FROEjIGF0=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via [213.182.55.206]
        Mon, 17 Oct 2022 16:42:38 +0200 (CEST)
X-EA-Auth: 59HAc1ReCgkEZhVAZP/yoTSANglxHpuna6Dpwz5K78DAYgEI0BFoRJ58jtSe2S9zMcJZzx2xum0Nl3Tbxy0SofnHetXzLqpT
Date:   Mon, 17 Oct 2022 19:43:05 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumarpraveen@linux.microsoft.com,
        saurabh.truth@gmail.com
Subject: Re: [PATCH 3/4] staging: r8188eu: remove {} for single statement
 blocks
Message-ID: <Y01i8U3g+7udq+Mg@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1666011479.git.drv@mailo.com>
 <478d652b9f467d47685c1af72a876f34dd92710f.1666011479.git.drv@mailo.com>
 <alpine.DEB.2.22.394.2210171556290.16433@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2210171556290.16433@hadrien>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 03:57:16PM +0200, Julia Lawall wrote:
>
>
> On Mon, 17 Oct 2022, Deepak R Varma wrote:
>
> > As per the Linux kernel coding-style guidelines, there is no need to
> > use {} for single statement blocks. Address following checkpatch script
> > complaint:
> > 	WARNING: braces {} are not necessary for single statement blocks
>
> It's nice to say something like "Problem identified using checkpatch".
> But putting the verbatim checkpatch message that says what you just said
> doesn't seem necessary.

Understood. That sounds better. Thank you Julia. Will include your feedback in
the next revision.

./drv

>
> julia
>
> >
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > ---
> >  drivers/staging/r8188eu/core/rtw_br_ext.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> > index 427da7e8ba4c..290affe50d0b 100644
> > --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> > +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> > @@ -655,9 +655,8 @@ void *scdb_findEntry(struct adapter *priv, unsigned char *ip_addr)
> >  	hash = __nat25_network_hash(network_addr);
> >  	db = priv->nethash[hash];
> >  	while (db) {
> > -		if (!memcmp(db->networkAddr, network_addr, MAX_NETWORK_ADDR_LEN)) {
> > +		if (!memcmp(db->networkAddr, network_addr, MAX_NETWORK_ADDR_LEN))
> >  			return (void *)db;
> > -		}
> >
> >  		db = db->next_hash;
> >  	}
> > --
> > 2.30.2
> >
> >
> >
> >
> >


