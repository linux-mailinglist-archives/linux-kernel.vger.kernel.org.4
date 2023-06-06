Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45958724A67
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238218AbjFFRih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237905AbjFFRic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:38:32 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563D010DE;
        Tue,  6 Jun 2023 10:38:31 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B91B45C01D5;
        Tue,  6 Jun 2023 13:38:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 06 Jun 2023 13:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1686073110; x=1686159510; bh=z0
        7aqGgk2gNY0nVjmeEqLTPg7LkT0Cu/HRqUK3Vyzb0=; b=3nnUpd5RCQjMSYPS8q
        afRoOos3u5wjohmf+Vre7sDLsouET/MIDHveotO9d74UZquRHxJ+pY3dXbOnEGan
        n6HZuqauMdIFCz6UHFnvFt2pPbJ6ptC/WcRxIhCy3JTd234RImNUGsTItXUOt2iL
        Cn9Ssyk8JgCSSHbCsr/REJ26vRLk+mgaPVpo4wjuX5DC15fDj4eppfDoK22axv+E
        st5diAFvtylpJ6z1DZoPVfSm4zP2eGCOW4nxJHDPtfGuXIipbXm6+4Tt3D5Zg27c
        6iLUcvFqDVUn5F7mJ2Zq8Ttc5rxoOYxDAQ7cPll0A7CgfDiklY+rqo0Wqf4g0G9i
        qbQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686073110; x=1686159510; bh=z07aqGgk2gNY0
        nVjmeEqLTPg7LkT0Cu/HRqUK3Vyzb0=; b=BkhxQXmeWW21qBv6PD47vxFGcZHVG
        0PlYLlMcOp0FIt5dMFlsY4n2+Ck69eDSamhna2E85P8vQ5fQpDoYA5pFnn6mair3
        Msmr2IMrMxZPGEEMCMkAqBq4MJxxHKV8tx01rKfMmulLsRpLTthQWopAKnZxVazA
        ymdegCqvwEEbbzkrcf2Gevzp7dKAG1WNFxa4Pznt5WSEvNo7/h+8+JpOMEiWj2W8
        OeAkZBfUF/iMUVO5RHHbncImhWOdFgIP63iOTapoYA3cefGJjtKzv8C0Jdia0bv7
        qLGeXZlkhcOmZKsGbe0h8y4wwD7beAo+FXdrL9Mgj5RgmzXtUQZqmHbPw==
X-ME-Sender: <xms:Fm9_ZBxW4yiH3XthgS2Nn8M-4XzMgG9TlIuYWSAWx3V8cy7rpLmhJQ>
    <xme:Fm9_ZBTu7plsJUTN5nzNRYxdbHsGL27qNQoLD8ZuP8iNIADGOOhDdP7a6eU6J7szD
    lvKYKVP43YthA>
X-ME-Received: <xmr:Fm9_ZLWucf5Zlb00q5EOvFMZeYPFDcMAdsevsPAR77SV3PNZ4szc3S07g5S8-pXJCkAPg72G4qiDMgzJOtj3jFvyZ-VAc28BbCo1_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtuddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeeghe
    euhefgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:Fm9_ZDhtHcP52W02iVcqevBNti67Xiyj1aQHrJ9b0AjHmFOpwG--Dg>
    <xmx:Fm9_ZDCVi_9XVMSQtbeUFH1R2-KfYu_zbdBm29FA9BdS4zyyTi6ELA>
    <xmx:Fm9_ZMJBnt9JFwziIF_Y72ZM1PRjkGS3IjAALeP3UR2iiGnSyePCOw>
    <xmx:Fm9_ZH7TwSODW2-aojuprw-iBhW852L7NvPhVernxfQLP7jfIel29Q>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jun 2023 13:38:29 -0400 (EDT)
Date:   Tue, 6 Jun 2023 19:38:27 +0200
From:   Greg KH <greg@kroah.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, mike.kravetz@oracle.com,
        Ackerley Tng <ackerleytng@google.com>
Subject: Re: [PATCH 6.3.y] mm/hugetlb: revert use of page_cache_next_miss()
Message-ID: <2023060650-overlying-skiing-191d@gregkh>
References: <20230606172022.128441-1-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606172022.128441-1-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 10:20:22AM -0700, Sidhartha Kumar wrote:
> As reported by Ackerley[1], the use of page_cache_next_miss() in
> hugetlbfs_fallocate() introduces a bug where a second fallocate() call to
> same offset fails with -EEXIST. Revert this change and go back to the
> previous method of using get from the page cache and then dropping the
> reference on success.
> 
> hugetlbfs_pagecache_present() was also refactored to use
> page_cache_next_miss(), revert the usage there as well.
> 
> User visible impacts include hugetlb fallocate incorrectly returning
> EEXIST if pages are already present in the file. In addition, hugetlb
> pages will not be included in core dumps if they need to be brought in via
> GUP. userfaultfd UFFDIO_COPY also uses this code and will not notice pages
> already present in the cache. It may try to allocate a new page and
> potentially return ENOMEM as opposed to EEXIST.
> 
> Fixes: d0ce0e47b323 ("mm/hugetlb: convert hugetlb fault paths to use alloc_hugetlb_folio()")
> Cc: <stable@vger.kernel.org> #v6.3
> Reported-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> [1] https://lore.kernel.org/linux-mm/cover.1683069252.git.ackerleytng@google.com/
> ---
> 
> This revert is the safest way to fix 6.3. The upstream fix will either
> fix page_cache_next_miss() itself or use Ackerley's patch to introduce a
> new function to check if a page is present in the page cache. Both
> directions are currently under review so we can use this safe and simple
> fix for 6.3

Is there any specific reason why we don't just wait for the fix for
Linus's tree before applying this one, or applying the real fix instead?

thanks,

greg k-h
