Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EA165FF86
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 12:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjAFL0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 06:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjAFL0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 06:26:13 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7C160D0;
        Fri,  6 Jan 2023 03:26:12 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 92AB43200AA4;
        Fri,  6 Jan 2023 06:26:08 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 06 Jan 2023 06:26:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1673004368; x=1673090768; bh=I7mBrQSCFI
        tUQt1fxLzHS6xUeZXx0GJtfnCC/5PE5f4=; b=guDcxstlcbTlVjV7lIS+fDf37l
        NG12X/yxr6xxZu9TxVS8uyp2/7pKbhRv7u5exECyNvyyTXYdzkDmtkLR0G/sMZGx
        KOGDXqC//m9WJ820qOlRD2veEDe+Oax9iMJFngR8jhQXBthsnOcI9Vh0kMhBJuX+
        ChcB237Pr0nloxj244NiNdu18yvne/+uMpJw8b0Sl6TkkftWz1uJXMpZEJ0HmyPg
        J6WM6MMmrD+8H/QYVclbZj+UCkxjkiB22H6FGorBc73X1tX+MUpUUmj0Jez1uPEa
        K6Yc+0fLCEB9Misehq3/Zj1RRnIX4jO4eFBkQ0OhDio5u/hAcNZGEBP641Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1673004368; x=1673090768; bh=I7mBrQSCFItUQt1fxLzHS6xUeZXx
        0GJtfnCC/5PE5f4=; b=Xzhd6JZKjtyjfgZVVIEWAZA+Htk60K10x2hBRdFvGNYC
        XN74CdJfEjEK/A4z2Z5ufMwo01arKR5E6XX1cAtQASJgfM86QoFAwPZu/7JjywN7
        YlweRciM0SzwUNjET+v0DBc4734rCynfmiq2ma1K66ARyOHVGV0qdmEptcwPUsz0
        Olbc+0LkU1ZFWKkbeWG3a3lbTG0oPTpBEXfzkYhRADsISXYSO6ijNBxIspDTvDyu
        7AhTQe8wSWYOIu+2L5l16ojP4MTD4vlzr+wtCciJ0kIP2IzVTLVUT9yOMYvpqV3c
        z0AmLs5pXo4bW4ESqmPgvwCEZ11DIM/1CLqTrZsMaw==
X-ME-Sender: <xms:TwW4Y0xH2YKVFGy5sl4ulYKE7x-P8FnXfbkvPGl0vlXam2oONNsfzQ>
    <xme:TwW4Y4S_l9YsliSk2AUmu4MXdVZKKYykwLRBvQQWnsRlYWtbF_gTLLfQb8hq2Rlak
    iDPLkVtS3RodSs6XQ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrkedtgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:TwW4Y2V7vbGUv6Yq8a_-7w8eqTTFdft_68WY5Xfjqv4vqBU6d7hqow>
    <xmx:TwW4Yyi0iYZHbrVv91NPYTXVY5Rx77ixhJArlxVjJE9G8gB6EdpT5A>
    <xmx:TwW4Y2BpoQE5UeiaQZvw1iraAzWhlF171STggQniNPQa8QQywNKB1A>
    <xmx:UAW4Y40Xl2XtQ8B-FWoDd-h_i5CpuqeRT1NTGqYDZBXCu-3D-VGgHg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B32FCB60089; Fri,  6 Jan 2023 06:26:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <14e3a492-5d61-4bfe-8998-b29f66b37061@app.fastmail.com>
In-Reply-To: <3bbd5135-a556-6097-9ca3-aef3399b2990@gmx.de>
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-23-arnd@kernel.org>
 <3bbd5135-a556-6097-9ca3-aef3399b2990@gmx.de>
Date:   Fri, 06 Jan 2023 12:25:47 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Helge Deller" <deller@gmx.de>, "Arnd Bergmann" <arnd@kernel.org>,
        "Robert Jarzmik" <robert.jarzmik@free.fr>
Cc:     "Daniel Mack" <daniel@zonque.org>,
        "Haojian Zhuang" <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 22/27] fbdev: remove tmiofb driver
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 6, 2023, at 10:47, Helge Deller wrote:
> On 1/5/23 14:46, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> With the TMIO MFD support removed, the framebuffer driver can be
>> removed as well.
>>
>> Cc: Helge Deller <deller@gmx.de>
>> Cc: linux-fbdev@vger.kernel.org
>> Cc: dri-devel@lists.freedesktop.org
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Helge Deller <deller@gmx.de>
>
> Arnd, I assume you will push the whole series through the ARM tree
> (which I'd prefer) ?

Yes, I think it's best to keep this together here.

     Arnd
