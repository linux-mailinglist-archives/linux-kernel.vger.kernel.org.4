Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944847392A9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 00:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjFUWni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 18:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjFUWne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 18:43:34 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62142173F;
        Wed, 21 Jun 2023 15:43:33 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id F40D85C0083;
        Wed, 21 Jun 2023 18:43:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 21 Jun 2023 18:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687387409; x=1687473809; bh=1CfwJNcZ9ExTk
        aHBALnXwf9D4LiJBitSPaLMtzcAid4=; b=AcHXmWMbZZx9QwNb4c44Lg1chaJ8B
        Fizjaek5kMP54fIQze62PtHho1dPLnj8xoOJWm7Uwzh9sXPTfS7vzt9RREZbF7/6
        KcZedAO9pzD550q26Py3O5ACyMU/2M7GDUYCZflnss3T9rgfjfG8dl2sHA0/rPvv
        xUcX40tfMgniPTz/dppYLe/M2dgCf5IN/P4nP3p1EnBTB4vrhhlLrrBRXMTadQ0M
        xsbCPNyczDp2GsCnXdpImEFiCC0WOfyxW/A1zPgEuUUlh880RgdfeFh3/aK8KwGl
        nMF3WZObT43GcRYgF0HzFKIHSkOMDKFuCade7HcRboUiIzcnTLQ9MjCgw==
X-ME-Sender: <xms:EX2TZORG2ByZnoRyJL7GQFd5zaQshcdXJwoAQutMTeSCY_a8_kd3uA>
    <xme:EX2TZDwj7fHDq532tYiXasIzlc_04phpcw0YYWVGNU8Xf9Jg9-0HxfEOuSuHX3KI6
    XuMz9GqzS6_pk38hg8>
X-ME-Received: <xmr:EX2TZL1AUIoSZjV04FMID_zcjBk2MnTXHUXotYg75EeGh0v3wNI8-AI1wmsKbbkbB2KavViFZT-vvnwngK4lEMJ3TPDkeXHVbj0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeegtddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeu
    heeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:EX2TZKDKdNf9EjDHbdLPr_iui-7_z4A2QhoC7Or5bKO0aqEdggmf_Q>
    <xmx:EX2TZHjKiXLnE8up1qBwIXhVfb6B34Ne1oWJFcSh2N2w34RBCziqVA>
    <xmx:EX2TZGqhGciDyaNCdRM6tqy2SSn68Ofw1SKaPYzJXgqjDzzA6jTJ4g>
    <xmx:EX2TZNY5lG5j_z4h7eA2-qXvkyWzgTYn67xTNVhQCYZG9JEr5mrC0w>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jun 2023 18:43:27 -0400 (EDT)
Date:   Thu, 22 Jun 2023 08:44:18 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Theodore Ts'o <tytso@mit.edu>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        tech-board-discuss@lists.linux-foundation.org,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Linux Contribution Maturity Model and
 the wider community
In-Reply-To: <5490402b-8b9f-f52d-3896-41090e639e51@linux-m68k.org>
Message-ID: <d69b0814-4a74-ebd0-7e08-3765f0acab1a@linux-m68k.org>
References: <20230620212502.GI286961@mit.edu> <5490402b-8b9f-f52d-3896-41090e639e51@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023, Finn Thain wrote:

> The technical projects under the purview of FINOS require a contributor 
> license agreement. This has historically been a difficult pill for some 
> contributors to swallow, so it's hard to imagine widespread adoption of 
> the entire FINOS methodolgy

I'm afraid I may have mixed up CLA and copyright assignment. I can't seem 
to find the relevant CLA text. Sorry if I've mislead anyone.
