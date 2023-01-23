Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E9C67851A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjAWSlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjAWSl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:41:28 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7836423311
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 10:41:27 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 02C585C0099;
        Mon, 23 Jan 2023 13:41:25 -0500 (EST)
Received: from imap46 ([10.202.2.96])
  by compute3.internal (MEProxy); Mon, 23 Jan 2023 13:41:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1674499284; x=1674585684; bh=b04tMT3kRj
        Z+uBpaB37Q7ZdEKsIDu2zzLOra+ICrvTU=; b=U5OfNP7ByQvJp4PUA2OBpOiN0d
        mGUDr1B27nQKUFlpmOvkKOqnDJyB1LZ+MUCZGMV/86/JPsJ3uUKDxtXaIgOPc0SU
        yo5DbsLK1msMDG0ysogb+Nemy2ddeiyGv5EbTFUPdZ4O5p2a/15dvNViDlNtOZY1
        9/lb6q7j9xcE7dKd0UE2VI21hCcJOsraHTLC8xnx/URSGoreLcK7NCfbgcmhaWc2
        l0cPkQY/Jo6IoiL/+NfAYCdr+TloeNnoFBfU2i0toW78HMP/dILRdfgkhfeMETzy
        2eIYdCKZGGR3A9vcLoy8cnMNKwUWSm535kTUOIHvCfUnQAuq6fsFRFNKwzdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674499284; x=1674585684; bh=b04tMT3kRjZ+uBpaB37Q7ZdEKsID
        u2zzLOra+ICrvTU=; b=QZya3PJ3xZbRU2RDft6oEPjH24QFkcptx2CpV+YpNkvB
        ZX4E8+GwWHj4zQNasPOFR3NiOhh2OnfUgvBiDM8wL8a0UKtyxW+s98W2UIDJkcyp
        xfpzEgR4tEcwbzqJSwnpCijYaEbKuGf4FNN2/0DoHouspW2ft7uq11iiRXhewPqB
        vRaIEqdA0swkFCWxfFm2Z0ZeK5n2Y7TQ2ml7IHwqpX9u2n56miT7Ce7I39/6FeT+
        1sKJtqvtv7vmPVqqzY+WnvFXf+tgp8wUqHX+RkOfLmK38V2bA+FSSaB+EzGjrlMp
        2+EAdML3XabWCMQWrvB9BV07lcoW8DrOWnDVBKGAuw==
X-ME-Sender: <xms:1NTOYyDAfAsEJn8t4fETXZtnJUY8qw8m0Yg_f1fztdIupDYCa9WRXw>
    <xme:1NTOY8ipMB7VxO7dOqZyyHmLf9WA7Ga3SqgurHzPKEORgzgQteHAKDaSWSH4mG7gK
    HegtnGJPcKcqipZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddukedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdev
    ohhlihhnucghrghlthgvrhhsfdcuoeifrghlthgvrhhssehvvghrsghumhdrohhrgheqne
    cuggftrfgrthhtvghrnhephfejuddthedtgfeuueeltdekfeekvdfgveeifeduteekheff
    jefgieehheekgeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepfigrlhhtvghrshesvhgvrhgsuhhmrdhorhhg
X-ME-Proxy: <xmx:1NTOY1lSAn-j3zidhbv1RAwJc42yOBQ0nYE_rXR_DcK67T96R3C1Dw>
    <xmx:1NTOYwxy6IaCxNIqIUW9wkFlAmUhGMyHBUDd0_KZbZy8HG918knflA>
    <xmx:1NTOY3Qbww4j2GKhTJuuMqsABfcFWArpRkDPq2DAjMjGRNqyIRc-FQ>
    <xmx:1NTOYyGDPiwbynMmnw3UY8F7wTEng3kAdBp8TNJsdi83XbvCbORATQ>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7E9422A20080; Mon, 23 Jan 2023 13:41:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <db72efdd-5cb2-4578-a322-bf894fcf6066@app.fastmail.com>
In-Reply-To: <20230120102512.3195094-1-gscrivan@redhat.com>
References: <20230120102512.3195094-1-gscrivan@redhat.com>
Date:   Mon, 23 Jan 2023 13:41:04 -0500
From:   "Colin Walters" <walters@verbum.org>
To:     "Giuseppe Scrivano" <gscrivan@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     "Kees Cook" <keescook@chromium.org>, bristot@redhat.com,
        "Eric W. Biederman" <ebiederm@xmission.com>, brauner@kernel.org,
        "Aleksa Sarai" <cyphar@cyphar.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Alexander Larsson" <alexl@redhat.com>, peterz@infradead.org,
        bmasney@redhat.com
Subject: Re: [PATCH v3 1/2] exec: add PR_HIDE_SELF_EXE prctl
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



On Fri, Jan 20, 2023, at 5:25 AM, Giuseppe Scrivano wrote:
> This patch adds a new prctl called PR_HIDE_SELF_EXE which allows
> processes to hide their own /proc/*/exe file. When this prctl is
> used, every access to /proc/*/exe for the calling process will
> fail with ENOENT.

How about a mount option for procfs like `mount -t procfs procfs /proc -o rw,nosuid,nodev,magiclink-no-xdev`

Where `magiclink-no-xdev` would cause all magic links to fail to cross a pid namespace or so?
