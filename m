Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259326C0250
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 15:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjCSOQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 10:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjCSOQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 10:16:20 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A3E210B
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 07:16:19 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id EDF615C00CB;
        Sun, 19 Mar 2023 10:16:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 19 Mar 2023 10:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1679235371; x=
        1679321771; bh=e4XiFtwAT6qOdumm8rj6fJDInrJFt0F6aGuIqwJiZCQ=; b=K
        zFPsKalNb7AhDZ164VkpZ1aQ1q4Y0qYgtuDmK5nUY1R7Q+9BFddQW3k1zL/7xZ/a
        dSysvcmG45KLrgF/9addNNMFs+2aAPl6WoTiYiHpmtN6c+rcv/NIJYEXo4cBorBp
        f21cGPmrjZKZnlHai8PaD0nMXDXlN2Ly854Iu5QBSIVJQabiK8fOZo6m+1x/vSAH
        kkvvtPv/0T5e85ctwMIzVDu4dd1I68rurCL4vsN5leQdtmXyKpILg+lPVxYDTCWD
        587sP8BG6tYTj5+pX3tDYvKvfmWJAQ4EDifJ6m+iyZeBZ91ki8hwVwhYYrnTZrh1
        xf/FsDzh2Y+q25dR1vzng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679235371; x=1679321771; bh=e4XiFtwAT6qOd
        umm8rj6fJDInrJFt0F6aGuIqwJiZCQ=; b=DnoJvtLdvtJjdkZSWLg90KBWQR+Mk
        +qENFW5ZKgDW+dYcNAcpcG28fQdWGofCWHHesRq8iyT/yxNWymM6DTtm3UyKByjO
        Cbm8P011yaXrlrEwEADBn98VWO1l7z1vSERXO/lTkejEt5iw1TCo9oBnVuyDI1p3
        hSvOLJryjyF/zKhoRCPV+MiMCVEYlipVdQQ+2YNFtsWvHnPdo6IKCo6Lr/91QLyg
        K1BLWxZ7tCpJhyG4IipL6gOvSEMPiqdXnjcG+2BP5nNRC0BXRFc3PzGZji/OvIEu
        bAOfwA0YZNXL6wC1s/yaN3bYmfv6Ei165LVuR/qcRWGxrT79TrMlLEZoA==
X-ME-Sender: <xms:KxkXZNlvLQlWyvfRGT26IiRtOXCf_A9j148vXh0_1cwveKQspW6Erg>
    <xme:KxkXZI2x10xwlnzmf59yAS3eZwDx4PXPkHV--JAH0PL_gA4ga0TmRGiR75y254EEj
    XxSOpa_254talNi_E8>
X-ME-Received: <xmr:KxkXZDqft2zs4LUFO9Bzdeik3t7qOWftaQgnGGdNckK8UfdnnyVCtOk0T3QT4u5r2ndwWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefiedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    dttddttddvnecuhfhrohhmpedfmfhirhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehk
    ihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecuggftrfgrthhtvghrnhephfeige
    fhtdefhedtfedthefghedutddvueehtedttdehjeeukeejgeeuiedvkedtnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehshh
    huthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:KxkXZNlTmJ0bTeM_1kZlsMmOxrctuecWMx8Fm3aRumOXVUl68hZbnA>
    <xmx:KxkXZL1tgKsjR26yzN5Cg8EdKZ9Z3LhfpyPU1maCGz4lF3v85aOr3A>
    <xmx:KxkXZMsjafmCY_AgfTBdHDERq3vgxe7TPVzsHHUfKLCQVWzZloSZjA>
    <xmx:KxkXZJCV0tvB57K8CoYfgSvX1wVGRHo3ttL5HLZxq4ql6MO6uoM0kQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Mar 2023 10:16:11 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id D114610D7B6; Sun, 19 Mar 2023 17:16:08 +0300 (+03)
Date:   Sun, 19 Mar 2023 17:16:08 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: move get_page_from_free_area() to mm/page_alloc.c
Message-ID: <20230319141608.gu2gwet75fdbxnkr@box.shutemov.name>
References: <20230319114214.2133332-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230319114214.2133332-1-rppt@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 01:42:14PM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> The get_page_from_free_area() helper is only used in mm/page_alloc.c so
> move it there to reduce noise in include/linux/mmzone.h
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
