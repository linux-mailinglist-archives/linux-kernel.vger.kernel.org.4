Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184FD6576E0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 14:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiL1NTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 08:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiL1NTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 08:19:35 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A531F1173;
        Wed, 28 Dec 2022 05:19:34 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E26E85C0178;
        Wed, 28 Dec 2022 08:19:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 28 Dec 2022 08:19:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1672233573; x=1672319973; bh=hr
        lNtNYlQa9wbjhSeAQelcswFDbd9QN60Imd0IatPMM=; b=SvZtkcO9mh8st6EnHZ
        I5FPADnH8quRAPVT0A+swJYJau3ILdjVv3X/zCGVkMl/oaI07sCdkXDehBY9BpIN
        vLMeVNwCiE8AXF4JyslOKQolyIQiFRdkvwryPYZQCNqHq/cWjbiAV3fcM3NZx9MY
        YB2QUl5bz5Xn4a2fQZfYMAPPVtzoeb9QuwiYEKas/nXaIcPc4qBPqaoLGy/DEZOI
        Lk08PE1OF2ql7zBQvq+k/YEx2/7/i3UkghsgkSs/AbZ5M/VbJg7nBl+HEoa1p3PM
        A9htLNTBcYevJR9S4n8gvr/KKO3yUuNOqaFi9BgH5acWleQUCpZrt+poICiYmkjh
        +ZfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672233573; x=1672319973; bh=hrlNtNYlQa9wbjhSeAQelcswFDbd
        9QN60Imd0IatPMM=; b=tj/rWfyjUkLK9U/aQ1AhrSgNzHgG0nKdJK0yukqe5FKL
        0hFef2uWMyyG+C9JjkNcSERz9ydRxWsLSM4Tz+gUKtPy+wZyQ+rdHRhJBh3yuJfx
        596Wz1/nhu7oQj7F0SPfiSQyF168ARz+W4oo0MkKpyaKlV3GZtflX+cinCWdT2qn
        P5s3BOEphZKLzYGN9YY2IaLLfIlavNgEqzEJqVE3RLHVldpe9utomhkhtgnrRKT/
        jwHuq7yHYmkTW884en6mpJJNTjoVJ4GibkzkT0UUVz3j57sERWpF92FEo3mxDTXJ
        MIJZF56QP7+KcbfoqMVxk7wD3POH9/CwjIybmaMplw==
X-ME-Sender: <xms:ZEKsY21oHIrxSKi_elKkITFbiuhL5nhFbUiL6hUBcfEuqrXg4_VuPQ>
    <xme:ZEKsY5GAXGb8ya37X_9PHCEd9DosPN0uMHztqA3sO23xinQsU9omROyypuA3UWmEH
    9lX5VHTR5fZtY17eyc>
X-ME-Received: <xmr:ZEKsY-5b8euuirYICOp_iHMtX7mB2FMp00cT2J8iUe2R_K3EYWRs1BKpEwPgewAWHi-09rusJG5mCsNQjrOM_o306oZgEPsMfo9n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedriedvgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjfgesthdtredttderjeenucfhrhhomhepuegvnhcu
    uehovggtkhgvlhcuoehmvgessggvnhgsohgvtghkvghlrdhnvghtqeenucggtffrrghtth
    gvrhhnpeffleegffevleekffekheeigfdtleeuvddtgffhtddvfefgjeehffduueevkedv
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvg
    essggvnhgsohgvtghkvghlrdhnvght
X-ME-Proxy: <xmx:ZEKsY31kp7aclg1o7KewjwBmEiM18hBQaymKgUYwD2631-QwnSHSlA>
    <xmx:ZEKsY5HbDW_takI1CH1RRLX3mwM5uZvVix2gZ3q6fUZkz6_XqI46kw>
    <xmx:ZEKsYw9fvWQZ0rdd8WT2rWdnl8GiDZuEFULpHdcp9J4SeBxDmIbQtw>
    <xmx:ZUKsYx90VrzrLXMfTQyC50Q3S7azp6piZMAilbQg4yR7lhzovOc7UA>
Feedback-ID: iffc1478b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Dec 2022 08:19:32 -0500 (EST)
Date:   Wed, 28 Dec 2022 08:19:30 -0500
From:   Ben Boeckel <me@benboeckel.net>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Vitaly Chikunov <vt@altlinux.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: certs: fix FIPS selftest depenency
Message-ID: <Y6xCYmZkggGzzzBM@farprobe>
References: <20221215170259.2553400-1-arnd@kernel.org>
 <Y6tF52G6/bnG+VfJ@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y6tF52G6/bnG+VfJ@kernel.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 19:22:38 +0000, Jarkko Sakkinen wrote:
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Might want to fix this when picked:

> Subject: Re: [PATCH] crypto: certs: fix FIPS selftest depenency
                                             dependency ^^^^^^^^^

--Ben
