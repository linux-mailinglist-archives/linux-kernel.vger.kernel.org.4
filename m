Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2780266881E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 01:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239924AbjAMAKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 19:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbjAMAKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 19:10:43 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9568940861
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 16:10:42 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 70A385C00B3;
        Thu, 12 Jan 2023 19:10:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 12 Jan 2023 19:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1673568641; x=1673655041; bh=fn
        0w1gSR5DhOV6wrzetzvqJJjGA7awX0sZ7gHK1BH/Q=; b=BOQJnOfNbZsiA95+o3
        xdZp6MCLdZMTzaocrB/0UyDRkcLXi2xkFD+lY3uxivC2pJHdwZnpZbMHopjBUctM
        va9SelUa/2dVs5ZaC9r0/7WOB/xEO8q7UWYWM9Sts5uZf2METrizVXRk1UmX0OKq
        KMfqBKfcwtu07lSxbWZmkTFLRcR6//ie5VHE0j3AajqFbBoGAGS1av0y0zY6pi4X
        HqdD5kfK49pqlQZNPhP3EEgu902A/YHmfIGnyrK7SiZsa/w2o3Sa/Skz6IMiohXq
        dC6ynx8kGIxbu9JFKniXYEagxl4Z4jgquvJAxWkCXKoutKk3Lou9v1nrSFoiT8D/
        n5dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673568641; x=1673655041; bh=fn0w1gSR5DhOV6wrzetzvqJJjGA7
        awX0sZ7gHK1BH/Q=; b=NxQbSwT50YVM8JGTH5Qf66/uZGD2RRXtclEucb+pKHpl
        fm56sVIj2nBPUx+COUD9Z9dmUB+0eEqJE7rtgeoJn28o9KB3IuBG78bUeny7qR1s
        WWQoAKuLA34GRXrg2mB9taMeyF5OwuaG516xD8QmzzbL1z+btfskDyvrU43vjJdU
        FxsRIASkAuQ7VuWUQsbncf2B2G10UexkJ28wbIhJbrt6VLJVgbaAhxUeKBOUALAd
        NalTKsxHEoEr39NcKu27rzeAfjWNUt3vVPCMrPtz8IYb4VlICIcHe9zrss6E/6Jv
        n6xG6pXg9G70yoxZj5JbIJ+ZYcKNr3LUIPJwcQzsUg==
X-ME-Sender: <xms:gKHAYyZ-zX-h6X5XiFI3jXSCS_9HP79vJQR6j4DB5eslc6z16BL0CA>
    <xme:gKHAY1b20pA4Kd4YzMGXmz4F5i2f5NjsErwRLMiB8usiyVeReW0Jo4hd8Yld4BMmC
    o-jPpNNMNdl3Bf3Iok>
X-ME-Received: <xmr:gKHAY89-zNUbJa6HibVU2ILVKD6S-ak3Dh8ZY5B8grE5dYOd-BYbBYOxWTReEcd-CFRh4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrleejgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueehtedt
    tdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:gaHAY0pkt2-PHmrI2qKrVa2P85QtgN3D9ylKGD2jrZKX1wj8WzpMsA>
    <xmx:gaHAY9rzqzELJr24R0l7xBhESXCuB8anedS97PNlXVV4m50nZCT-Mg>
    <xmx:gaHAYyRMK_1vPCVqRFOH0UjHQ4lT5zXTaQrweFGVAGOL10Rl9Vbg7w>
    <xmx:gaHAY-e4ziIhCFAc33M2FGgVH-sYGI7cW9d7j-OeZbtpw1wz3ZCk5A>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Jan 2023 19:10:40 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id A6A84109AF0; Fri, 13 Jan 2023 03:10:37 +0300 (+03)
Date:   Fri, 13 Jan 2023 03:10:37 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm/khugepaged: Fix ->anon_vma race
Message-ID: <20230113001037.adqha6lxj7lh75at@box.shutemov.name>
References: <20230111133351.807024-1-jannh@google.com>
 <20230112085649.gvriasb2t5xwmxkm@box.shutemov.name>
 <CAHbLzkpAVTys9dBSodHBB3ovKhwP8imUsyXy=aPqY5SyXCT7ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkpAVTys9dBSodHBB3ovKhwP8imUsyXy=aPqY5SyXCT7ww@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 10:12:53AM -0800, Yang Shi wrote:
> > This is totally wrong direction. Or I don't understand the race.
> >
> > At this point we already paid nearly all price of of pagetable retraction.
> > I don't see any correctness reason to stop here, except for the assert.
> 
> Isn't it possible that collapse_and_free_pmd() clear the pmd which may
> point to a PTE which maps the COW'ed anon page if this race happens?

No. At this point we have huge page in the place in the page cache and it
is locked. COW fault would serialize on the page lock.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
