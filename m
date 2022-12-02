Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57BD641197
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 00:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbiLBXmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 18:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234685AbiLBXmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 18:42:08 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25477ECA21;
        Fri,  2 Dec 2022 15:42:06 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 37A6232007D7;
        Fri,  2 Dec 2022 18:42:02 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 02 Dec 2022 18:42:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1670024521; x=
        1670110921; bh=yxT7HiP0z6PnQ571PxQPFu/NQAI3ieVo9QcKWIVPNaY=; b=y
        BQsZRxe+jKL9ygzmShsmMjLR1wogByCB42nEcbzwc3ogTNmLjcb14HIW6/IpCuuz
        /zarw10mAOt/Hz1WYVNViEfpD9PU19KCXZJPS7v5In486WdgCPt2hd5d+1qWLF34
        72fOmIOa1l1STZfu1XWBQd6R/AvWDHdHk01DzWEERajAxn9j7lhJN4gSXpyWhocw
        SIQI5y4QS3FSxC32Cb1hGkDnZoIUgtvfv6l/J5NW7XM/b1f3cgsfpKl8Tt/ErY4N
        ldcxTa65hQjwdTLumFaQ5I1rTInppkxCFdW1Z99WFp13r47vtPKw0H7uyNqJLn/0
        BGaNvGJ3AjFJQEeQVIUsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1670024521; x=1670110921; bh=yxT7HiP0z6PnQ571PxQPFu/NQAI3
        ieVo9QcKWIVPNaY=; b=KiA9VVRLK3HOjYjDlUzTuRq57Duc2zEq9XTkNOTfQaXJ
        K0VJJ0icSrbMM0BJ6o2+ZZIEeZrNc1NyCAD+iQKnIxyQLzcM2FhE8SpMydo6EB57
        Z71vCWaMcCmnSahY7RC1+HUq2ZAIOfHtTIgUyG0UL/+WTTlZEQql5qwm7hKd2zFc
        qH3fhds7DrVNDSd3W6aCh4RCRdw66CzDiDOs2Co3ah7bk83PWVZ/rMb8e52IEOOW
        PuuDb4FNmLOq3ykSFpGX3VbO6ePWSHEy5yXkT8PHaSatCcuysoi6oOX5mcopUHp+
        ndOXZXO3BAC++XloqgtQU12Ds9HHgkHroFT7IMPvzA==
X-ME-Sender: <xms:SY2KY4pqXDtFrjBzrV_d6DSuGqLHNx-pn1N5u7VYUpn-7pyY24rDzQ>
    <xme:SY2KY-p0P3lsb2-BR0TDveJGLPvctvLbtUaCrhW1ZuLqPFlMqSPKmgwDv3oQYSlHy
    AozvFWvBgMRx2FfmXM>
X-ME-Received: <xmr:SY2KY9NbJ05JoJNBfUEvBHhpzz0drKS0jLFvE_mZuVCiXR6gOZWTjd1dLCY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdelgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeflohhshhcu
    vfhrihhplhgvthhtuceojhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudeigeehieejuedvtedufeevtdejfeegueefgffhkefgleefteet
    ledvtdfftefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgh
X-ME-Proxy: <xmx:SY2KY_4WqYiCD1w-e1GVqNbGO5ZQSviQlTOIg1RvHwqf0AX4FRNKjg>
    <xmx:SY2KY37CEs2o58XgsOAmBmtM2MsGlhT9rfhW2ruINiuDHxBoZwUf5g>
    <xmx:SY2KY_ifyDx6lG-UslUL3zM770lY_71GjwlbADYE1sNHiEL9oZOzIA>
    <xmx:SY2KYxvfABpQOiUcLsA2UQfw8ZVSFhzHpPknfBhURXYaiagcULxSYw>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Dec 2022 18:42:00 -0500 (EST)
Date:   Fri, 2 Dec 2022 15:41:59 -0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     ojeda@kernel.org
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v2 27/28] rust: types: add `Either` type
Message-ID: <Y4qNR+Nn9utDftHq@localhost>
References: <20221202161502.385525-1-ojeda@kernel.org>
 <20221202161502.385525-28-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202161502.385525-28-ojeda@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 05:14:58PM +0100, ojeda@kernel.org wrote:
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> Introduce the new `types` module of the `kernel` crate with
> `Either` as its first type.
> 
> `Either<L, R>` is a sum type that always holds either a value
> of type `L` (`Left` variant) or `R` (`Right` variant).
> 
> For instance:
> 
>     struct Executor {
>         queue: Either<BoxedQueue, &'static Queue>,
>     }

This specific example seems like it would be better served by the
existing `Cow` type.
