Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A369652C3D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 06:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbiLUFEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 00:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbiLUFEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 00:04:09 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B501EECC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 21:04:08 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d15so14442290pls.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 21:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cw1a4Wmo8BZ9BUfaTviwAEXLBLj33fpIC4MwtpW0seE=;
        b=LNaBAAC6+pwEiBRx2mrTBXEL876WLXEIlhSbUZ5ha6eYJzLiJHbeXHumcjEXLUQQTS
         3hcchLWWK3Dn6C5dKbCxxDS5ANK9BJO+QdlS9Yx6nGU0vbsPFJ1XOdmQWk/I4zUO6pmD
         8v4UnpZlL1Vck3ErXxIF+vyOUTeVHO9+CEMRwaouE1SupjcwHSAwTXDdX6ljWuOe/fX4
         1l+XvqsUW7p0sX4etht5LFMuPA2Tf1y2sz8cexFMWavcBm0XLxFm3s7GINhDpD0urTHe
         o2DyIeufXK9uc+pbWX44B6H4R3xutEZUhSO5QPx+bnNURKfAt0Kwc6rjHwpQ8lNcA8dm
         7zog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cw1a4Wmo8BZ9BUfaTviwAEXLBLj33fpIC4MwtpW0seE=;
        b=FQxfAzWR2ILmt5t9riT/Fdi+6vdW4QSypeBfOHwj6tIa1RSF03YYJPqkIRiblQzYVi
         3oWV/O2GqnveCPvAu3XQeppIktZgJVBc9n9gy1FZWGSteqmAhnZAVuy2yykWoAW2rNMT
         FFIuVolRUXIKSkWO1kucGSbQmoqhXwcAkdJl4ltnJl2XeLEauSFeedfPGRDQhm4e/a5s
         ztaV2Nny2dTE/ErFNEsfMZKORuOijOmWlOBGhWcOsrML/B7vZBGtE+mZj3yGpPn/LzaF
         hOewKIHmGgwYjvYA1fZjq8Z6GwY2D1ka1rFGEv0LsWMF7DfuEdYvNfkdB4h3LE9LDbvw
         XKkg==
X-Gm-Message-State: AFqh2kofGOWa5y8is8I3fdk4n0t9nN30oHeHpQ/72IYZf6N5dR/QaYG0
        hj6F8EX0gNTILKwJEh9vExYmjnYRdlg/gjqs
X-Google-Smtp-Source: AMrXdXub8MHfwEvI8OLapx+ZlwQ5mIsavqqa3gIAuZ8Th3jIUscPTTy7MNPs+xjsHQeVQxvXpfWYjw==
X-Received: by 2002:a17:902:d905:b0:18d:6244:4676 with SMTP id c5-20020a170902d90500b0018d62444676mr714625plz.18.1671599048163;
        Tue, 20 Dec 2022 21:04:08 -0800 (PST)
Received: from vernon-pc ([114.231.52.81])
        by smtp.gmail.com with ESMTPSA id v7-20020a170902b7c700b00186e2123506sm10250000plz.300.2022.12.20.21.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 21:04:07 -0800 (PST)
Date:   Wed, 21 Dec 2022 13:03:47 +0800
From:   Vernon Yang <vernon2gm@gmail.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
Subject: Re: [PATCH 0/8] Clean up and refinement for maple tree
Message-ID: <Y6KRuqh+V1Z/I+ji@vernon-pc>
References: <20221220140829.1665432-1-vernon2gm@gmail.com>
 <20221220151858.c3bj33jzwjxa3wct@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221220151858.c3bj33jzwjxa3wct@revolver>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 03:19:08PM +0000, Liam Howlett wrote:
> * Vernon Yang <vernon2gm@gmail.com> [221220 09:09]:
> > Hello,
> >
> > This patchset clean up and refinement some maple tree code, a few small
> > changes make the code easier to understand and for better readability.
>
> Thanks for looking at the maple tree.  It seems somehow this cover
> letter is detached from the series found here [1].
When sending the patch, my network disconnected a bit and then
resent it again, maybe, perhaps... becomes like this.

>
> All of these look good except 6 and 8, which I have responded to the
> actual patch.  I've indicated below which is 6/8 and 8/8.
>
>
> 1. https://lore.kernel.org/linux-mm/20221220142606.1698836-2-vernon2gm@gmail.com/
>
> Please add my reviewed-by to all patches besides 6 & 8.
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Okay，thank you reviewed this patchset.

>
> >
> > Vernon Yang (8):
> >   maple_tree: remove extra space and blank line
> >   maple_tree: remove extra return statement
> >   maple_tree: use mt_node_max() instead of direct operations mt_max[]
> >   maple_tree: use macro MA_ROOT_PARENT instead of number
> >   maple_tree: remove the redundant code
>     ^--- 6
>
> >   maple_tree: change return type of mas_commit_b_node()
> >   maple_tree: refine ma_state init from mas_start()
> >   maple_tree: refine mab_calc_split function
>     ^--- 8
> >
> >  include/linux/maple_tree.h |  6 ------
> >  lib/maple_tree.c           | 41 ++++++++++++++------------------------
> >  2 files changed, 15 insertions(+), 32 deletions(-)
> >
> > --
> > 2.34.1
> >
