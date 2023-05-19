Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721D4708F06
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 06:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjESExw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 00:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjESExu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 00:53:50 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CF710DC;
        Thu, 18 May 2023 21:53:47 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 704385C0148;
        Fri, 19 May 2023 00:53:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 19 May 2023 00:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684472027; x=1684558427; bh=DvA6KR+zTo8Tl
        45tDoGl60OGn7Mp+gVqUU5IsuJpDS4=; b=S6oEgnqWG0ih2m1BwJ0eqeB0LUzVD
        xHTXh//gxAs/c/scnaj9KHEK+FAQpzDKNycaqraX5r/dc5dzpiptvzdyB3tiQH7x
        /5mN7RRCcaGAGWnJKSb9tnZO5REuaN52m8/jQQgDhsUbKjZYMsKlT5N/lZ6ruYLn
        WJ6GA4vaw/Qv0uU8HzpwMbErIgvLoxMoABzUfe4ccXA7C0Q5xgYlYXnsXN3y6XvQ
        Tb9z3Zw02oFQAV+G3YQHr4X/UIgfVkooQzyQ3LY/eXjbjHeaVJpWBWyJ3dNMCZ/H
        rah9uaGW/0nQTXzd4OBRt1yjRVgN0cKnYkeOLyURoXueBI31srv0BoMKQ==
X-ME-Sender: <xms:2gBnZEHJNpxdgBoqPuj_hFS3JjjvYLjM3rBuT19dvoFupgW1uZT03Q>
    <xme:2gBnZNUyBuqOe9WPDEP1rHLK_xSHVjx_2LEB0eLzMV3dkpVvu9yg3HB8Yr-2PepzU
    aNVsAs3zVpaN4pr1gY>
X-ME-Received: <xmr:2gBnZOJaC8CCp_c4uivU0V1KI11wcNUzI4lMJdIenHtsVLcNbqDSg6fZztBPLbrmo-rbZWXWsD2UdnKEGm3eCGi12F0YI7b_yiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeigedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvtedtgeduhefhkeeuueegteetheeuleeuieevkeeluddvvdffffdtvdet
    ieeuudenucffohhmrghinhepthhlughprdhorhhgpdgrrhgthhhivhgvrdhorhhgpdhtoh
    hrqhhuvgdrnhgvthenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:2gBnZGEquAG8b4FWurj3i1wbsqUjOftOxpIjQt6VI2kLKr0zjMGSIg>
    <xmx:2gBnZKX1LJ3cfOaKUsEq4NFkaqNbcf2ZDPpxna0pHbhuUrqIHt_mcg>
    <xmx:2gBnZJNx2VvDy8WH9VKQJJ8Ccx7Kg5VXpsazI_GUC6wxJXDafevZjQ>
    <xmx:2wBnZIx0diWrG9R0VfsLLF835b2gG923T4XAW1HYPeATzgLlzAoRVg>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 May 2023 00:53:43 -0400 (EDT)
Date:   Fri, 19 May 2023 14:53:40 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 02/11] Docs/scsi: introduction: multiple cleanups
In-Reply-To: <20230518212749.18266-3-rdunlap@infradead.org>
Message-ID: <525c424f-a748-80f5-5a16-ca979bc77864@linux-m68k.org>
References: <20230518212749.18266-1-rdunlap@infradead.org> <20230518212749.18266-3-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 18 May 2023, Randy Dunlap wrote:

> Modify URLs to use https instead of http.
> Remove ancient URLs that don't work.
> Change "scsi" in text to "SCSI".
> Change "cdrom" in text to "CD-ROM".
> Drop the reference to "autoclean" for modules since I can't
>   find it in any current documentation.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/scsi/scsi.rst |   23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff -- a/Documentation/scsi/scsi.rst b/Documentation/scsi/scsi.rst
> --- a/Documentation/scsi/scsi.rst
> +++ b/Documentation/scsi/scsi.rst
> @@ -6,30 +6,28 @@ SCSI subsystem documentation
>  
>  The Linux Documentation Project (LDP) maintains a document describing
>  the SCSI subsystem in the Linux kernel (lk) 2.4 series. See:
> -http://www.tldp.org/HOWTO/SCSI-2.4-HOWTO . The LDP has single
> +https://www.tldp.org/HOWTO/SCSI-2.4-HOWTO . The LDP has single
>  and multiple page HTML renderings as well as postscript and pdf.
> -It can also be found at:
> -http://web.archive.org/web/%2E/http://www.torque.net/scsi/SCSI-2.4-HOWTO
>  

That link got corrupted by commit b7223d9bdec. It used to be
http://web.archive.org/web/*/http://www.torque.net/scsi/SCSI-2.4-HOWTO
which does actually work.

FWIW, I'm not in favour of replacing any links with archive.org links 
unless no better source can be found. I am in favour of citations in the 
form of a link with retrieval date. In this context the date can often be 
inferred from commit or release dates.

Therefore, a second commit, 0ea6e611221, could also be reverted with 
regards to this link (if you're planning to edit it). Just my $0.02.
