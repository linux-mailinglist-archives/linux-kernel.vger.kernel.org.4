Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5282F6A50E8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 03:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjB1CIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 21:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjB1CIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 21:08:48 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F132021971
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 18:08:47 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 50BA532009B4;
        Mon, 27 Feb 2023 21:08:47 -0500 (EST)
Received: from imap42 ([10.202.2.92])
  by compute2.internal (MEProxy); Mon, 27 Feb 2023 21:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vda.io; h=cc:cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1677550126; x=
        1677636526; bh=Ag4Olo5xWRwIkyWqTdMgUeIZOPpWWMfRZyRO7cNplio=; b=e
        apwwxvKyRRn4pEoleyCIyOaO6pZDV7uHV9iVGSJIZS/VfDwFEW6JGPhx+DhB5JW9
        UIL9Bnk/P0j5Ds5hQWQ/atp1KxQhahn8SU3lEIrvtFjuQd0qJBSdURpAaO2pj1HD
        9epzn6n50+vPeYuE3X4UvTF2aT1TkJiUClmR33Suq/KzZkMGUBR9eKFkvTIVmYvW
        zFUi1LrnL5/a4ZopkDYjpc50aD4ioINXvhqukKjPXjEKqq1Fli54z5SQuuC7NWZD
        NTVEDN5WYMRgFKSUgQcgJd1WJcWcubCUwhucRWA4m6MRqoSq5608AVRuiwMYwtem
        B/TMoiV2fvVf2kIgF0P5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1677550126; x=
        1677636526; bh=Ag4Olo5xWRwIkyWqTdMgUeIZOPpWWMfRZyRO7cNplio=; b=O
        tUde5LD6Z0E+UWLXno5HgXLbawsCcWtNV81Ds9L6JD4CgODIk4GFtU9MxSzyYTY5
        BYDplSx49TZCMdnWwuc9ZSMtgN6rAhj8oUnbzpJEipzv4dBGTUse9OTrtdq2AHtK
        xe6HN3Vs9CenSdmx6rYTIS2Y0QdbMjsHTtOFESyBSbZp4AJ4ZwicmgNb2bouwgYc
        E2EXKBglqt+S7Z7rRaMOdaOtEma/lmt2KURQ0ZlXzzKN9H5+HIDcQ1jW/ZLykaf7
        Dt8JU+fKNc0KYw/EIMKec5+zS9IcXaIAJoZa3asam+n+Wh9/O8e2ymv+uOUYf0SG
        x06QxZ1gT+iyKfcerecgw==
X-ME-Sender: <xms:LmL9Y8iNC2FTD4wQQApaPvcVEnUgxFZGVOgdkx85vh3AP2kwh9oIow>
    <xme:LmL9Y1Aqox9OVbFQOuV36DUd4xySqj0bqMuATtkFYs7qls2fvixtavDQWlMZUkWoG
    fnt9Ab8AjUgCx7dQkI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeluddggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdgg
    ihhntggvnhhtucffrghgohhnnhgvrghufdcuoehvsehvuggrrdhioheqnecuggftrfgrth
    htvghrnhephfduudevtdekfffhteffhefhgedttdeufffhlefhkefgjedtkedtkeelfeeh
    tdegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dunecurfgrrhgrmhepmhgrihhlfhhrohhmpehvsehvuggrrdhioh
X-ME-Proxy: <xmx:LmL9Y0E8nWkAR473yV6jrUVZiBXEvuRqUD6DF_pOQ0V1FnW5jbroBw>
    <xmx:LmL9Y9R55GqBwpFov_0rUDdoEbXr4ui2ve_o457h3XIIpOi0Z84ayQ>
    <xmx:LmL9Y5wbcCxoWg-Cf1pe5ZEssTqdgirjxrhsLMpJRo6Q1TR2Nw4MFQ>
    <xmx:LmL9Y3ZAY4Jixq1VH7VTLpOp4iCDc62OV0oiAwbflmrBohcld4G2Eg>
Feedback-ID: ic7094478:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BB6A7BC0078; Mon, 27 Feb 2023 21:08:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-183-gbf7d00f500-fm-20230220.001-gbf7d00f5
Mime-Version: 1.0
Message-Id: <842ba2bf-ee1b-4d84-b78d-2fc251a1c8be@app.fastmail.com>
In-Reply-To: <b9df4ad5-0a4a-4061-a645-bda9fc42a874@t-8ch.de>
References: <20230223010025.11092-1-v@vda.io>
 <b9df4ad5-0a4a-4061-a645-bda9fc42a874@t-8ch.de>
Date:   Mon, 27 Feb 2023 21:08:25 -0500
From:   "Vincent Dagonneau" <v@vda.io>
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     linux-kernel@vger.kernel.org, "Willy Tarreau" <w@1wt.eu>
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



On Wed, Feb 22, 2023, at 20:53, Thomas Wei=C3=9Fschuh wrote:
> On Wed, Feb 22, 2023 at 08:00:21PM -0500, Vincent Dagonneau wrote:
>> Hi,
>>=20
>> This is version 6 of the patch to add stdint.h to nolibc. Previous
>> versions of this patch are available here:
>>=20
>> * v5: https://lore.kernel.org/all/20230220202010.37475-1-v@vda.io/
>> * v4: https://lore.kernel.org/all/20230209024044.13127-1-v@vda.io/
>> * v3: https://lore.kernel.org/all/20230206013248.471664-1-v@vda.io/
>> * v2: https://lore.kernel.org/all/20230202201101.43160-1-v@vda.io/
>> * v1: https://lore.kernel.org/all/20230202160236.25342-1-v@vda.io/
>>=20
>> This version integrates the feedback from Thomas, removing the limits
>> for ssize_t (not required by the standard) as well as multiple cosmet=
ic
>>   issues.
>
> Thanks, for the whole series:
>
> Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>
> Note:
>
> When sending new revisions it makes sense to add reviewers and
> commenters of the previous versions on Cc.
>
> It makes it easier for them and gives you a faster review or
> Reviewed-by.
>

Noted. Thank you for the reviews!

>> Vincent.
>>=20
>> Vincent Dagonneau (4):
>>   tools/nolibc: Adding stdint.h
>>   tools/nolibc: Adding integer types and integer limit macros
>>   tools/nolibc: Enlarging column width of tests
>>   tools/nolibc: Adds tests for the integer limits in stdint.h
>>=20
>>  tools/include/nolibc/Makefile                |   4 +-
>>  tools/include/nolibc/std.h                   |  15 +-
>>  tools/include/nolibc/stdint.h                |  84 +++++++++++
>>  tools/testing/selftests/nolibc/nolibc-test.c | 139 ++++++++++++-----=
--
>>  4 files changed, 177 insertions(+), 65 deletions(-)
>>  create mode 100644 tools/include/nolibc/stdint.h
>>=20
>> --=20
>> 2.39.1
>>
