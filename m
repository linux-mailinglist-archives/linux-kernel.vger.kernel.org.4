Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C386F8090
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 12:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjEEKIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 06:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEEKIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 06:08:18 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E902813859;
        Fri,  5 May 2023 03:08:16 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8F2165C028C;
        Fri,  5 May 2023 06:08:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 05 May 2023 06:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683281294; x=1683367694; bh=V4D6xLrOnK5ka
        emJE3ljBJy5a0XXQgxZIK3WV5Xq8Vo=; b=ZeqM/lChYCWtP5MuNAloVu5jSa7pW
        9EaB8Ti9632juuvtWwdhVdcUkFa0+vWz8zuI2mHh7ys8X3YlYs4Ls0CQBEmgrKoJ
        DSZqQngcz8Vb8HhmR3Qq0pqGfO8MdJngDKwF7gL8yAjN+xdMk1NyoPyygIykXj+g
        jeqLX6huhwyQqjR+DLhnAwRY5fd9ux8jM94r0Diao2M1NIGmkCFqOIRMBHqVGtNW
        ZkxayzR2Rl+teGzFMLyO5s7bTlo3qwShGr6h5w9scDgk+MRXl7sYD9GqtsFME7nT
        86C8vOHXY1NeSvThG9zQojWjYdyxmMwAdYNsE4NOkzpOOR5EFACYyTK3g==
X-ME-Sender: <xms:jdVUZEorJkSV_4mNlEMk0iXx-Z3RJ4w5EOfeGpv1qRc9ZEouNDVONQ>
    <xme:jdVUZKoGU6uOamTKpd6aIdVjuqxpicADC7PI23lMazBf9bHHkmu4d1lFJOeWQV5Ml
    a1phVbf-ZWD8JMFn1Y>
X-ME-Received: <xmr:jdVUZJPqbhJ3vBaG-1646VCVacn8kSr5Fp8QgEzv3z8C3yoCda8LqOg2Auyodqz___VjL_AENpwzqNoDQwdIhOlQmaOD8S-5nQs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefvddgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeeuiefguedvuedtveduffegieehkeejjedttddvvedtvdfhueduhfeifedt
    teehhfenucffohhmrghinheprghrtghhihhvvgdrohhrghdpghgrrhhlohhffhdruggvne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgr
    ihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:jdVUZL5eYX6p2fJtrTToM6eIviIcBk-3PzFeXuqLfM3J_TurTLTMZQ>
    <xmx:jdVUZD7P_6GgdliHCw3aVVSnmajBpZfNzKztUHKJxnJwlm2NdV23Vw>
    <xmx:jdVUZLiNKyB1jkuECO69MIPoodYlGrU8tTUespAuVyJBeqjWlwCeMw>
    <xmx:jtVUZNudSS7vlAdZR5ewbq3SDVTAh-tEnnQwrZ5u9ahrWVD_zC3Dcg>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 May 2023 06:08:10 -0400 (EDT)
Date:   Fri, 5 May 2023 20:12:08 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
cc:     Linux SCSI <linux-scsi@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>,
        Oliver Neukum <oliver@neukum.org>,
        Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 3/3] Documentation: scsi: dc395x: Remove reference to
 2.4 driver
In-Reply-To: <20230505082704.16228-4-bagasdotme@gmail.com>
Message-ID: <d919a2e1-5749-13f8-7867-1f17277190f4@linux-m68k.org>
References: <20230505082704.16228-1-bagasdotme@gmail.com> <20230505082704.16228-4-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 5 May 2023, Bagas Sanjaya wrote:

> The 2.4 driver link returns 404. 

It's still potentially useful:
https://web.archive.org/web/20140129181343/http://www.garloff.de/kurt/linux/dc395/

> As no one runs 2.4 kernel anymore,

Would it make a difference if someone does run that? Were you planning to 
delete the source code for the 2.4 kernel too?

> remove the stale reference.
> 

It was always stale inasmuch as it is apparently there to give credit for 
prior contributions, plus a changelog (see archive.org).

Any published link should probably be accompanied by a "retrieved on 
yyyy-mm-dd" qualification. But no qualification is better than no link at 
all, IMO.

Of course, there is a reason for an edit here. Yet it's not the one you 
gave. "This is a 2.5 only driver" is simply incorrect. (If it was correct 
you'd get to delete the whole thing.)

This is not a nak as I'm not the maintainer. But this patch just looks 
like churn with no justification. Perhaps I'm not the only one who can't 
see it.

> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/scsi/dc395x.rst | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/Documentation/scsi/dc395x.rst b/Documentation/scsi/dc395x.rst
> index c413b629809bcd..a6320561543650 100644
> --- a/Documentation/scsi/dc395x.rst
> +++ b/Documentation/scsi/dc395x.rst
> @@ -11,10 +11,6 @@ be safe to use. Testing with hard disks has not been done to any
>  great degree and caution should be exercised if you want to attempt
>  to use this driver with hard disks.
>  
> -This is a 2.5 only driver. For a 2.4 driver please see the original
> -driver (which this driver started from) at
> -http://www.garloff.de/kurt/linux/dc395/
> -
>  Problems, questions and patches should be submitted to the `Linux SCSI
>  mailing list <linux-scsi@vger.kernel.org>`_.
>  
> 
