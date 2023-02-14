Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3A2697020
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjBNVxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjBNVxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:53:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7228B10A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 13:53:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12695B81D63
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 21:53:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E417C433D2;
        Tue, 14 Feb 2023 21:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676411623;
        bh=+Xm/IjO7zOYY3xtxffSO9GMqU3xo7Wj16H3ovl72Lag=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=n78rwaVg52TvFfFt9l664ssZAovGLmEThBZ5TGXDHUZvjAPT2/MPpOJnlURjTAx3V
         nPMSI0GarT4MfdrxEdcsa6eSbDfEx9rYwWSU86bXek2w8DD1oH0c/em5gwB+ztZn/3
         n77YhLHidHhqQfuQ1yZ77HlgJjdyjlSlzaPNzGWItdUdBEoRK7Gyk8TWGYuBdTq7tU
         ueq8J/YM5j3sFPE2t9cRM2D+d4+B4Qom+OUMLo88UMSWx4BmInKNPDMyGBhxhQXPRK
         N9Y4ceC0Q5JEJfH957W1ZFsfkogRZaFzi+GpIcLCgzTtiIp+1CycpzywHiDoYtIe7t
         RcHfNVvAoZyzg==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 59ED527C0054;
        Tue, 14 Feb 2023 16:53:42 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 14 Feb 2023 16:53:42 -0500
X-ME-Sender: <xms:5QLsYykLywU9a7QODpMhMK8rwDpxGAJjTlX2M37AvFOkv0D8yYC4ag>
    <xme:5QLsY52yPANFM6sOHhhntpXOq-Og6G9wysQmbNNlgilqXuVe4Cmi2-xXjGbByzjbt
    3kUu0a3j3qiKdkMw-8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeifedgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpefgffejleeluddugfejueeiteefvddtgfeutefhvdfgudfhveekgeeh
    gfevledvudenucffohhmrghinhepphgrshhtvggsihhnrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguodhmvghsmhhtphgr
    uhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedtvdegqddvkeejtddtvdeigedqrg
    hrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:5QLsYwpzba8Eln08MFe5Wu_FAeR8DIjIyLkAYgaKz4m2E_QkUyhrKw>
    <xmx:5QLsY2ljEAW9qw1jcAe5ZMZsLUPAgiWJNQBTr_G9BV88JM5XzPCsrg>
    <xmx:5QLsYw1uWtA_NKPTj_XoHwaV3BHigDL91Pj8iZcYNN60hZCUYpQy1w>
    <xmx:5gLsY1tlKk1fX_LUbWv7R2B8S4Q9mjHS33JTDQSbHt9xC5SZ91BSmg>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BAD14B60086; Tue, 14 Feb 2023 16:53:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <85de69eb-5d71-4b29-ba83-c0258d58b807@app.fastmail.com>
In-Reply-To: <63ec01f0.170a0220.94c76.011e@mx.google.com>
References: <20230214132831.2118392-1-arnd@kernel.org>
 <63ec01f0.170a0220.94c76.011e@mx.google.com>
Date:   Tue, 14 Feb 2023 22:53:14 +0100
From:   "Arnd Bergmann" <arnd@kernel.org>
To:     "Kees Cook" <keescook@chromium.org>
Cc:     "Brian King" <brking@us.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "James Bottomley" <James.Bottomley@steeleye.com>,
        "Damien Le Moal" <damien.lemoal@opensource.wdc.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Niklas Cassel" <niklas.cassel@wdc.com>,
        "John Garry" <john.g.garry@oracle.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] [v2] scsi: ipr: work around fortify-string warning
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023, at 22:49, Kees Cook wrote:
> On Tue, Feb 14, 2023 at 02:28:08PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The ipr_log_vpd_compact() function triggers a fortified memcpy() warning
>> about a potential string overflow with all versions of clang:
>
> Perhaps this is arch or config specific? I haven't been able to reproduce
> this for some reason.

I saw it on three arm32 randconfig builds out
of a few thousand, with clang-15, clang-16 and
clang-17. See [1] for one config that triggered
it with recent linux-next based tree.

     Arnd

[1] https://pastebin.com/c9FEjzKe
