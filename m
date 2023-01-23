Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A20B67772C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjAWJNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjAWJNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:13:40 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E97C6E83;
        Mon, 23 Jan 2023 01:13:40 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 671075C0041;
        Mon, 23 Jan 2023 04:13:39 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 23 Jan 2023 04:13:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674465219; x=1674551619; bh=3Ien72spyC
        35PS+lnFsIwwr9WLEpjvmko7n3yAyQohI=; b=Jwcc4ODtjdfCJNwx9yDbiOvi13
        zaTrGjFbrUVI90yc1TnN6xE1X4KrhW7WCl7B43owm5q2uhjK3ZtFndx7gdXrQAjV
        p0gvnbZcyWbGokw/yc5E7RcbC3TmZLQQeO4LOuE7pd8doz3k52ObFIpW1A1SvGMy
        cyQg6t7yA2CbxDoaPS9VrvUXUKrbD5695zMpGf0lUhwujhw51dKd/VN2UwWX+lOC
        yXXav2Mnh8L/2XFCNhhwnXFxBHz/kKQfU9pwqniXXwQfmRmgLxhGvddlFj4dQQLY
        v8rzSFg9HGSHeXBnmoYhuoBgPQ0kWmpz+7VPnDJEDLqMff+JUrNDOp4eo1cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674465219; x=1674551619; bh=3Ien72spyC35PS+lnFsIwwr9WLEp
        jvmko7n3yAyQohI=; b=QE6fgP3vQvZE2hhxC6gy5Dig1Jfl2EkmyfNpuPC10ri0
        ow2hW/zVSlVQopMXQseQlA8HwqmjtMBIz8hYTnACm5BsCJcxjF482X3EeNORg2iK
        islUXsxmA2/tsP5yiAxwuZ0Mlf6yAv2kGUiQIklKLjh65FxmfH13XcCmFu5TKmAG
        T8lLVA2+4f3K0Pw2JMQxKnuvHiFWoxjAo9bmWwJ0Ym8NuM2RlmLZDCCpa6sOOQPY
        XxDSZks4n+ChFl95ioXIeGNyQ9IYK6SxxMG+bLa2sZVUF1xgP2mZbUBAK6DYbfdl
        lqFPBDPxUPfRHubxRBMb+UdmlvJj0RgDD+n/eDgOlg==
X-ME-Sender: <xms:wk_OY57aMwHdR4WNse4Zc9NDoC9ioUTrhLu7YSAjlqBzCi3EQ9QV7Q>
    <xme:wk_OY24lHO8B8xx0j2JM5E6uqlW4DLbaPv2i3WNGTKbLRFG5SYJ2Ht7tQxcTWbGSk
    PjFbRRUKAxhQ6Y1vfc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddujedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:wk_OYwccZfVzkWUsjHDoepQOBIWpquBFsCkh_HFrDiTNreAgwjV_GQ>
    <xmx:wk_OYyKlkoBaeojkSde9fe9ISnXrrdlMPdy7Ej6291B9swDCpMMz8w>
    <xmx:wk_OY9KfaHLBsGdeHySbKi98k4yxys0TWm7Jr55HjMGWw8dDYo2KYQ>
    <xmx:w0_OY6F8qqDKUiCTznkS0tqfuRN5M-p81j1sFuYknUVDzxcfRSD8Vw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0C4DEB60086; Mon, 23 Jan 2023 04:13:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <ed0880bd-5c0a-4831-a440-2b1600890d35@app.fastmail.com>
In-Reply-To: <20230123100923.7899a60f@canb.auug.org.au>
References: <20230123100923.7899a60f@canb.auug.org.au>
Date:   Mon, 23 Jan 2023 10:13:18 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Stephen Rothwell" <sfr@canb.auug.org.au>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Olof Johansson" <olof@lixom.net>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the v4l-dvb-next tree with the arm-soc tree
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023, at 00:09, Stephen Rothwell wrote:
> Hi all,
>
> Today's linux-next merge of the v4l-dvb-next tree got conflicts in:
>
>   drivers/staging/media/Kconfig
>   drivers/staging/media/Makefile
>
> between commit:
>
>   582603a95734 ("staging: media: remove davinci vpfe_capture driver")
>
> from the arm-soc tree and commit:
>
>   d2a8e92f0b41 ("media: vpfe_capture: remove deprecated davinci drivers")
>
> from the v4l-dvb-next tree.
>
> These 2 commits removed the same driver but caused a conflict due to
> other changes to these files.
>
> I fixed it up (I just used the latter version of these files) and can
> carry the fix as necessary. This is now fixed as far as linux-next is
> concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

I can drop my copy of the patch, but from the diffstat I see that
there are a few other differences: Hans' version removes
include/media/davinci/ccdc_types.h, which I forgot, while my
version drops include/media/davinci/vpfe_capture.h (which
is still included in the v4l-dvb-next tree, but not in mine)
as well as the obsolete driver specific entries in MAINTAINERS
and Documentation/userspace-api/ioctl/ioctl-number.rst.

Hans, any idea what we should do? I'd tend to leave both
patches where they are and let Linus figure out the merge.
If I drop mine we need a follow-up patch to remove
the include/media/davinci/vpfe_capture.h header, while
dropping yours would likely produce the same conflicts
against your tm6000/zr364xx removal patches.

     Arnd
