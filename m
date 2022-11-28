Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B3D63ABD7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiK1PBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiK1PBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:01:00 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3F2222A2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 07:00:59 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 3146D3200035;
        Mon, 28 Nov 2022 10:00:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 28 Nov 2022 10:00:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1669647657; x=1669734057; bh=Heo27byu/e
        zrA9coHgXtmsVth+oZRdefAxp8/MnKvu4=; b=OLQT56/8EplxY4L2+FzHfVbi4O
        RqW4YkiiNUd/s9ARdS0T3mMupX8Urj1NzSCLP1g+0wONVcJFNWHkd3E8tc2BY4d/
        6hu5BlghKgDh+ON4yQu94/3fqcKpEntNJwe9DRDEkBtr0r6VKD9uWsjGDrmsSUzC
        0+eecQAC1rWn5gE0IhZmD5eXrW4gyH+QZKy9MxPQmTIg9ToHHn7zPpGYz74fzJyJ
        lm78HLa2Yp8tlYIzpDBk8loOLKbOuvkGLXjlZJ/QmSimgp0mh74aTUpcz2M7kiXx
        9Ssmi8Bm7ptDDfVlodCFZQBrcEJvhQ62iiDpjgcxW1/MQFAGaqPFhZjyoKDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669647657; x=1669734057; bh=Heo27byu/ezrA9coHgXtmsVth+oZ
        RdefAxp8/MnKvu4=; b=KNxvlxsiTJ142v0Du3bc6lDq3xSqmB44AhWaGS3jQZhf
        8Q1rN4gwoA3P1AjsK3Tcr6g6jfKh/AUBW04nzHMBUvojBtckYWfmmOrCUgiWmbI7
        6bXMmFNW8F7WiiCPgfIJZQCNmVOzfu9PhYUyVHdIIZfQdnZTXvL7p9SVAgAS6RaD
        Y+A2dr+L6q4pfWxsq5bKj1SgKqsfNJOHsxZTaMtzJUA2gw8NcL7+wwV+45BqbSz5
        HswLE30fizecZZTuPPIvrgeJ4f0JnnWuCuWrKj+Y0aati9ApD8EVRMWF+N0DtrOJ
        /u/VK6FXy0E73rN64xtz7FWua4adNjrnMEBBiKIbkw==
X-ME-Sender: <xms:Kc2EY_ox2l4rpncuQnS3ZtEIUCNCP0Rpkk06UvybCFVtlWxVJPw3Ag>
    <xme:Kc2EY5r_O5LNnls2UhqNCEM2Dum6EJeov1O8-0rwzhDgD1n6daxpiF3gMD0imQhaz
    9-L1IcdZ2R6mhXcrVg>
X-ME-Received: <xmr:Kc2EY8OIiFBpFqVLPMihkGbLU8Zai5PCOdZjRKGPWYVLJ6eVBcJjkmDEU_QasQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrjedvgdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeeutedttefgjeefffehffffkeejueevieefudelgeejuddtfeffteeklefh
    leelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:Kc2EYy7ZqGdQHfVRSOV-5spZiNBKYBzUhCF7l4jO444AfQGDrCJU3Q>
    <xmx:Kc2EY-6QryxNapLMt4CbACiAljNZ_qs7R_gmd93Aj1mc2vxU6BkWCQ>
    <xmx:Kc2EY6glRUOFnW4yNmwYVZ4eWeBXJy8NXHVI9GlyxBFQK8IeEjDHbQ>
    <xmx:Kc2EY0mYPU3mifl2oTA8pf_xdMEoaWZveJSFXiAtN1UoAn7XdXl0AQ>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Nov 2022 10:00:55 -0500 (EST)
Date:   Mon, 28 Nov 2022 08:00:51 -0700
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v3] fuse: In fuse_flush only wait if someone wants the
 return code
Message-ID: <Y4TNI8+QVHFuzeZC@tycho.pizza>
References: <CAJfpegvrd2nsydG26stcmeEkdO1JLyeu69KrZs4dvVxXtoz42Q@mail.gmail.com>
 <20221114160209.1229849-1-tycho@tycho.pizza>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114160209.1229849-1-tycho@tycho.pizza>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Milkos,

On Mon, Nov 14, 2022 at 09:02:09AM -0700, Tycho Andersen wrote:
> v3: use schedule_work() to avoid other sleeps in inode_write_now() and
>     fuse_sync_writes(). Fix a UAF of the stack-based inarg.

Thoughts on this version?

Thanks,

Tycho
