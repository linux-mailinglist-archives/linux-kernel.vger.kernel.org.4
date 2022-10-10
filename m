Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0FE5FA2F9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiJJRyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJJRx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:53:58 -0400
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84ACF13E14
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:53:57 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 89B8D2B06F48;
        Mon, 10 Oct 2022 13:53:56 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 10 Oct 2022 13:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1665424436; x=
        1665428036; bh=Ed2ASF/NFpiraeYoybZuexHQtuPhqdf7I3GtBVFIK0Y=; b=V
        8GmQKa6hFqTJyhmpF9mv7V9gCo7mI3EOCfT4I5BypjGcTkYZiobVy2WfuBihVRxI
        3zadBMALcnD3TxuTgiNc77FdbmfBuECPfmZcCXW7TNpI403JghsLf+lD+z9Sq13y
        rX04MEmANgnhyfKE9vSc7YL3Ncf7gqGwd9yNGgiQgA+c4jphLm/Gggz0aC+zieeN
        4UM4bK+XgIKkolM2sZp7Y/8FFYtnY5uXgACvTrPFNtcEyGpgCTG1EpQ/2pDf0l5n
        Q+wJu2mq/vuJuW4nkEr90NP2g7o6AWK+kHqGoH/dODtwxHSyXdjzJcrb2UcvZ8d+
        KHZUFZeKC4T3mlz1kxm5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1665424436; x=
        1665428036; bh=Ed2ASF/NFpiraeYoybZuexHQtuPhqdf7I3GtBVFIK0Y=; b=e
        98jZJ1FWeqxdOgYit9DI591DJ7FQvGAUPPy6cpmRR5IshfQ62gcvDmJZD2JLFPgt
        JF0m09aROwuCf0/XvmNh8Ng566PYlTaZmvnirgaK2MO4m8IARou9sC+pBOOxb5xR
        wOnI5Zz2gsFkNRH6GGVAPOQDKV2QPUMFUfenJEH4883xhz/tCcpoX1ihVq1jXm/J
        Dre7L3bRwS7L0SOI5zrfQHkGAX4man15OHQlBHFckM9S6H2GCc0quuATLLG61qnr
        whZ6xFYP0O9HI60pNvsL28uJNX1HsqB3Zf7nLnBa8q42ggNwgfwUYl/ziV3E+0Yc
        1d5cnQ/2XXKq8XpkTzcYQ==
X-ME-Sender: <xms:M1xEYzbtiK2XMO9M6mRQ6KI8PlW1X8txVe0bgfBwGIVzYSvNgFRUwg>
    <xme:M1xEYyagKbKAhtD73TfWc2vZOKkqxqZRwouvSrpIVl1k2GBdVmQi-WdVDoW0F_5wg
    49F_wSkxGNdAoUr5_s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejgedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:M1xEY1-sA9C-oJQ7ys5cVQ_jvt_0YxzcFjgvNeoltguxM4Ms20tRjQ>
    <xmx:M1xEY5oq5Wy_L-OwfFSuia-MJMkE38nszR02s-DlOBA2K8A5PXAEoA>
    <xmx:M1xEY-pDFVBpTMomYkbcFaBCRmfFRun6DBHGziXSakWknCyUSxUPuA>
    <xmx:NFxEY3mdiyFPvTxbIpuiRq3QUw7c_D3mLCUn3AVbfTPcwdaxysy995EyAaQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C37CDB60086; Mon, 10 Oct 2022 13:53:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1015-gaf7d526680-fm-20220929.001-gaf7d5266
Mime-Version: 1.0
Message-Id: <83dd6d9e-10f4-422f-8d8d-b18ceb9dfcb5@app.fastmail.com>
In-Reply-To: <878rlnk7no.fsf@smulpajen.i-did-not-set--mail-host-address--so-tickle-me>
References: <alpine.DEB.2.21.2209220223080.29493@angie.orcam.me.uk>
 <c4ee195a-cf1f-44f6-b3b6-241d04e01fb9@www.fastmail.com>
 <alpine.DEB.2.21.2209231211350.29493@angie.orcam.me.uk>
 <878rlnk7no.fsf@smulpajen.i-did-not-set--mail-host-address--so-tickle-me>
Date:   Mon, 10 Oct 2022 19:53:34 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     =?UTF-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: Make port I/O string accessors actually work
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022, at 5:41 PM, Bj=C3=B6rn T=C3=B6pel wrote:
> "Maciej W. Rozycki" <macro@orcam.me.uk> writes:
>
>> On Fri, 23 Sep 2022, Arnd Bergmann wrote:
>>
> [...]
>>  Thanks for your review!
>>
>
> Chasing stale threads! ;-)
>
> Arnd, would you be OK adding your Reviewed-by tag to the patch?

Yes, please do.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
