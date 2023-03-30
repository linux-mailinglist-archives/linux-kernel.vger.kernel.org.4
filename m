Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789516CFBEF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 08:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjC3Gvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 02:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjC3Gvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 02:51:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA6B5FF9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 23:51:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6EF09B825F3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:51:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E47C433D2;
        Thu, 30 Mar 2023 06:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680159098;
        bh=j6ptaomqz4Mdy0IN85hUag5DDxk1uEmIEhcTkQd3Xys=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=MajGdklLDY8+LZCCBsM1CcaWT0H/yjs9hH51dXgUE+YNRf2KrS11/ZiH2b68X8EK6
         QdAcnOeR6/YqoHVl0jT+ZiFTB7+pUOHCo9mrP1+bZqlzeorvNBtpfMtz2aaBF36RWk
         UAC1pmWjgXOclfT+AgZLxQk8r3tOKS/z8uCfK0wjHdXVzUlQpyqXJxAQe/cbS0wIDG
         UcCA0Rq8inZSXizvZrKP77BjD8PYpIO7H5k2Eu3qGJtWqwc1YMq2WLWk5hp96GrSjQ
         fp44ksxqurnAfzB+whmNhaxQzy/W0IDiEe9PIwz5VHlr0T41zO7QdRkIMFUFUusB+w
         IuSvAToRWByKw==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id A277127C0054;
        Thu, 30 Mar 2023 02:51:36 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 30 Mar 2023 02:51:36 -0400
X-ME-Sender: <xms:dzElZEL8Bm0HqH6sOs-iLOYZZfRMxtzYMHzy1EN_nZnMZTehE9LV5w>
    <xme:dzElZELQasNNd2NCsWQRDwlAquzCRmmJlYKzoM3I2XcN3ISW013TydHXMbNahPYLb
    whdkJH4i23XnflVpnc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehjedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedvveeigfetudegveeiledvgfevuedvgfetgeefieeijeejffeggeeh
    udegtdevheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidquddvkeehudej
    tddvgedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdrohhrghesrghrnhgusg
    druggv
X-ME-Proxy: <xmx:dzElZEtQzlt6ahGAhDKMFiW52PlxemMgENpz_a2Wa1ssSsJbO3DdXg>
    <xmx:dzElZBb-AsdUcc5j8_m3EMWHQXXe7aVaJgFVQftolGVTml-949zZrw>
    <xmx:dzElZLa3Gfn_WtK08Nbtmmwty0EkDUnuO6brsYWT9g9aWXYfXSU_hA>
    <xmx:eDElZP7uEITwfXKzwc6maWyBCH9sPgogCJP7sHodEhqPdFUzp_wvrQ>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4E094B60086; Thu, 30 Mar 2023 02:51:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <5db9b27a-90df-4916-90da-4e8daeebf9e3@app.fastmail.com>
In-Reply-To: <ZCTOxOGDPoJoZDNW@infradead.org>
References: <20230329071405.1568021-1-geert+renesas@glider.be>
 <ZCTOxOGDPoJoZDNW@infradead.org>
Date:   Thu, 30 Mar 2023 08:51:15 +0200
From:   "Arnd Bergmann" <arnd@kernel.org>
To:     "Christoph Hellwig" <hch@infradead.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>
Cc:     "Desnes Nunes" <desnesn@redhat.com>,
        "Christoph Hellwig" <hch@lst.de>,
        "Marek Szyprowski" <m.szyprowski@samsung.com>,
        "Robin Murphy" <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, "kernel test robot" <lkp@intel.com>,
        noreply@ellerman.id.au
Subject: Re: [PATCH -next] dma-debug: Use %pa to format phys_addr_t
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023, at 01:50, Christoph Hellwig wrote:
> I've applied this as it is the first fix I got into my mailbox for it.
>
> Arnd sent one a little later, which uses %pap instead of %pa, which
> confused me a bit.  The documentation seems to allow both without
> any recommendation which one to use, which confuses me even further.

Indeed, I wasn't aware of this either, apparently aaf07621b8bb
("vsprintf: add %pad extension for dma_addr_t use") introduced the
%pap form at the same time as %pad but made it the same as the already
existing %pa. I also see that the %pa form is a lot more common than
%pap, so it's probably better to go with %pa for new users anyway.

    Arnd
