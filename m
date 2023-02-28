Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCA36A50E7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 03:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjB1CIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 21:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjB1CIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 21:08:22 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33ABD1258F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 18:08:20 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 93D3532004E7;
        Mon, 27 Feb 2023 21:08:18 -0500 (EST)
Received: from imap42 ([10.202.2.92])
  by compute2.internal (MEProxy); Mon, 27 Feb 2023 21:08:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1677550098; x=
        1677636498; bh=4HJeaQSQzuM2zFEk+6eAykEbXgS0NrBs8PIgUxarOY4=; b=t
        Pd+aGzwi/xoUSfioPYPj9VguIK3T4tMkYt+09gJ0a3qapj1gfzXcparwyEYYD6vD
        zmWnAavTK2LhoDPZ7Rd5qFAW/t/+vt10jWWDRTTqeFUP8Yq27r9xclpceOkKTjsB
        iFiUlloKEm+bFagFa19WIAPMAwKoJmMabgPkXGqaGqobkB/voTSlytmSi254m6Pl
        h3fC/mSBMKrY5vthGWKC7LYgPgVWSyFVGHSTih+3qWPyBRFLqLFpFtFTB/hxRwLJ
        TUiz9zUMGIaGEtW2DnPwl6bcjAd+z8RdnSdVHvCwQtQ7M/tN8QjxBqryWqeKQ5iC
        Bi0KmLeV+0TbI8MNj6iDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1677550098; x=
        1677636498; bh=4HJeaQSQzuM2zFEk+6eAykEbXgS0NrBs8PIgUxarOY4=; b=Y
        7PsCD3R4NQ1YVKx26kpXNcWkBiEkkHErZmH/47+T39u9ucPWqg5YayEHRKqQJNee
        5xb/CD7+2ziZFoVahciKvqE3a6gNB1Zd9nwYXq5+mUJnfgSCznM1RFmQVQFFzIKi
        3ZtJ0w40VT7Mxbi1sb7tF2C0jXrY11R2hv38Z1rAu+IPSmge/GlbCXjlbGQo+yZi
        tAwkNSgWb4ZDTehwTe+Mo/Li3tGcyiBR8l436fnmr5uzKvvm1yJo7fC174SRNFz4
        iSMcA7ERhlWneaEgI15eUITcariW8nqEoFEbYD2bcmDo1jagA178r/d4AiZqw4Ex
        FbEdGJggUWn70PDquztzg==
X-ME-Sender: <xms:EWL9YzNCCX8RKKcJdtN_qqVtugqcm2f57LZ5cFA6uFecI2LQ6pHacw>
    <xme:EWL9Y98dZfFS9jr53PVI_nTMDrGpsiXl9WF2lNmEFzh76r2_M2aaSocqk_icpKzkh
    ncd4wv1DbptKSqub4I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeluddggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdgg
    ihhntggvnhhtucffrghgohhnnhgvrghufdcuoehvsehvuggrrdhioheqnecuggftrfgrth
    htvghrnhephfduudevtdekfffhteffhefhgedttdeufffhlefhkefgjedtkedtkeelfeeh
    tdegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehvsehvuggrrdhioh
X-ME-Proxy: <xmx:EWL9YyRq2INyDC3wiAsuwEb7IA1FduODH-hxIN62nuWMO6o0aGXlaQ>
    <xmx:EWL9Y3v1lOgLKMMa26rH7D4rzQdKWo_TuqVSse_hpPYPkg_DqAHcPQ>
    <xmx:EWL9Y7fLoA-h4_lcIOYhlRp3Ygpq1dhRm4FRnOoigHDJ2hSLSOsXPw>
    <xmx:EmL9Y7knU0Rafq1wYDghrSANJCK1wvC4IjEYhMgReFEvm9UUqiUVdQ>
Feedback-ID: ic7094478:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8277EBC0078; Mon, 27 Feb 2023 21:08:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-183-gbf7d00f500-fm-20230220.001-gbf7d00f5
Mime-Version: 1.0
Message-Id: <55fa16a3-068f-4b53-b1b3-831b7f013830@app.fastmail.com>
In-Reply-To: <Y/bV5D8gmG0B7DpN@1wt.eu>
References: <20230223010025.11092-1-v@vda.io>
 <b9df4ad5-0a4a-4061-a645-bda9fc42a874@t-8ch.de> <Y/bV5D8gmG0B7DpN@1wt.eu>
Date:   Mon, 27 Feb 2023 21:07:57 -0500
From:   "Vincent Dagonneau" <v@vda.io>
To:     "Willy Tarreau" <w@1wt.eu>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/4] tools/nolibc: Adding stdint.h, more integer types and tests
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023, at 21:56, Willy Tarreau wrote:
> On Thu, Feb 23, 2023 at 01:53:06AM +0000, Thomas Wei=C3=9Fschuh wrote:
>> On Wed, Feb 22, 2023 at 08:00:21PM -0500, Vincent Dagonneau wrote:
>> > Hi,
>> >=20
>> > This is version 6 of the patch to add stdint.h to nolibc. Previous
>> > versions of this patch are available here:
>> >=20
>> > * v5: https://lore.kernel.org/all/20230220202010.37475-1-v@vda.io/
>> > * v4: https://lore.kernel.org/all/20230209024044.13127-1-v@vda.io/
>> > * v3: https://lore.kernel.org/all/20230206013248.471664-1-v@vda.io/
>> > * v2: https://lore.kernel.org/all/20230202201101.43160-1-v@vda.io/
>> > * v1: https://lore.kernel.org/all/20230202160236.25342-1-v@vda.io/
>> >=20
>> > This version integrates the feedback from Thomas, removing the limi=
ts
>> > for ssize_t (not required by the standard) as well as multiple cosm=
etic
>> >   issues.
>>=20
>> Thanks, for the whole series:
>>=20
>> Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>
> Thanks to you both! I'll take care of all this this week-end.
>
>> Note:
>>=20
>> When sending new revisions it makes sense to add reviewers and
>> commenters of the previous versions on Cc.
>>=20
>> It makes it easier for them and gives you a faster review or
>> Reviewed-by.
>
> Agreed. Overall I find that for his first patchset Vincent has
> done a great job ;-)
>

Thank you for your guidance on this patchset!

> Cheers,
> Willy
