Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB7D5F5228
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 12:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJEKDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 06:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJEKDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 06:03:06 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE1E57263
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 03:03:05 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id E1D3D5803A4;
        Wed,  5 Oct 2022 06:03:04 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 05 Oct 2022 06:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1664964184; x=1664967784; bh=xQyo6nLBko
        Zet2YLUeDAAXuWflSHesnOexFMEZa12C8=; b=RQwsE8etVHm88Q8bo41BZ8+rk+
        xdqN6LgVE8AxOc6g/EVWGbRKT7ANjnz+FBEDs10xiloutD4WRPZT6/Gv+VKFb7su
        7eNO/xp+pw1mnOtLUE7d+Y1C6cuYCaklOfNjJckNiM1BRd+Recb/7kjNqmWdfA+9
        Fl/tiZT9sA2GNAcFXI73t/A3u8Ci+3DXFkaOXBG20desALdpAzKXljgk0YcOLXRc
        ZLBe2SE3z2n0ou9QN5SVH3s52Bw8St4gWtlBtOA+yskXxvLmadotBDzH2JcEYq9y
        QqZPzmbrTsdDk4H92vqrt3o+qQ/ncml+GSBu95JS2ZpOMxOuJAt2foLflUqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664964184; x=1664967784; bh=xQyo6nLBkoZet2YLUeDAAXuWflSH
        esnOexFMEZa12C8=; b=f8uGsh/0Qr3CexhkicxUQWXNOUOcKhj2PsoS85NeRWK8
        J+At+WjRt9vUpaU0hsPXPrQqhU6NYIEeQfoCTkFU/3l787UVlFwdfhVDrvUMPdtS
        8C6Zsgzh1O3XP7BFo0EOtQbcDLHFL0wlLWLT5UZN13Uhl+t6j9APyC8QR5BXDtj0
        SX5XHuOXkUYkUjzomzVZWqBEf/qWQ27a8KYE/MxGrg/jxXoCqohyVvubEaxTxFrv
        tmxEkbtVSLeGyp0evOwMwoilygrRlDL1GSEY81vb5PmloYzuRt6uZpvVN1Ih+aYt
        sck6XVh9NL0Lx/cpYtBFcg2o9hgEXhPuPvn2V/gGug==
X-ME-Sender: <xms:WFY9YwoZckACcG0_tOFdsuGlwiUdYVH484NDGpsF4Be4C6MiS8RTdQ>
    <xme:WFY9Y2rBQfw1VtoiFBHoQb4iG8kSv4ylD3OqV46cUa82d5Gz9mf7_nW1n-ASuNqby
    Zx8whEa1bKzUbmx8HU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeifedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueelleeifeevffejvdegtdekveffgffhfeejhefhkefhkedtvddvieel
    jedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmpdhgih
    hthhhusghushgvrhgtohhnthgvnhhtrdgtohhmnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:WFY9Y1Pu3Kw6dKqOh22bFpolOsEFNXPgi_nan_1vNDeXiuyIlg-Bkw>
    <xmx:WFY9Y353lwudfPbOA4X-dSfDjYnEaS5L6sWpBSPb33u1TlAOFBzozQ>
    <xmx:WFY9Y_7YRK0p4YJLRlT7rIBYGW9Td5Y8lCjpYWHgdY8L1CK5DFXYLg>
    <xmx:WFY9Y_HHJvTHXb7FTsKb2zZTOPiQ68e2TBQZSJT3eHEa2eM7_YSf5g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 47E31B60086; Wed,  5 Oct 2022 06:03:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1015-gaf7d526680-fm-20220929.001-gaf7d5266
Mime-Version: 1.0
Message-Id: <81b789b7-eca3-4d93-bb29-24ebedd9b60b@app.fastmail.com>
In-Reply-To: <202210051742.p1o10Y5y-lkp@intel.com>
References: <202210051742.p1o10Y5y-lkp@intel.com>
Date:   Wed, 05 Oct 2022 12:02:42 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "kernel test robot" <lkp@intel.com>,
        "Eric Biggers" <ebiggers@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [ebiggers:wip-fsverity 6/8] fs/buffer.c:2280:5: warning: stack frame size
 (2128) exceeds limit (1024) in '__block_read_full_folio'
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 5, 2022, at 11:11 AM, kernel test robot wrote:
> tree:   
> https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git 
> wip-fsverity
> head:   06702850f2f281bdd6165c4783a0a15685efbcfd
> commit: dbcfaa162251f84f78105036633f71e91dc3bb8b [6/8] fs/buffer.c: 
> introduce __block_read_full_folio() for ext4
> config: hexagon-randconfig-r041-20221003
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 
> 791a7ae1ba3efd6bca96338e10ffde557ba83920)
> reproduce (this is a W=1 build):
>         wget 
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # 
> https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/commit/?id=dbcfaa162251f84f78105036633f71e91dc3bb8b
>         git remote add ebiggers 
> https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git
>         git fetch --no-tags ebiggers wip-fsverity
>         git checkout dbcfaa162251f84f78105036633f71e91dc3bb8b
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 
> O=build_dir ARCH=hexagon SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>>> fs/buffer.c:2280:5: warning: stack frame size (2128) exceeds limit (1024) in '__block_read_full_folio' [-Wframe-larger-than]
>    int __block_read_full_folio(struct folio *folio, loff_t limit,
>        ^

IIRC the conclusion we came to when this last showed up was
that on Hexagon and PowerPC4xx, we want PAGE_SIZE_256KB to
depend on CONFIG_BLOCK being disabled, in order to completely
sidestep this issue. Pages this large should be really rare
anyway, and those platforms tend to run from RAM or MTD flash
rather than using block based file systems.

    Arnd
