Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC8C617C98
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiKCMdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbiKCMde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:33:34 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD11BF44;
        Thu,  3 Nov 2022 05:33:32 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 817295C00F5;
        Thu,  3 Nov 2022 08:33:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 03 Nov 2022 08:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1667478811; x=
        1667565211; bh=BZrwsW27orAaFsHeOq+6v+A2mK56RKbIDvtFycbgvzw=; b=p
        G+HEkObck7JV/djZFB1O5VfKbPPuIoth7vtg/ITJZRuO6wc0+9rjw9cTP9oHPnFW
        4sh3i8UtPpTtAMq0O+A+idKgT6wJtnPrYuosiRkRvjITx0lJxJ9SoRpk68Rpf9VJ
        Rhf8G+OOmGR/Fs1Fw9t5joScg++7hKIVlkK9rafBpnKf3gjddakGLj9XUoyzV5Tq
        ZIJ1hSpjYSH+74VYzaGpWm7UvgxCZAUHLRohhqerWLyu8YQ2azqT211S2BBMLg+t
        SHMe3BuxSUZhznGTspMAYs2zpZd8h39Q2JBpgO/x2f1wtY8bQ/2vKYjlT95HXtJM
        NeCxZorpa20AKt+hj8wGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1667478811; x=
        1667565211; bh=BZrwsW27orAaFsHeOq+6v+A2mK56RKbIDvtFycbgvzw=; b=R
        ID5DzaqXtAaVxDZTz6cxdQB+qSNNAeSxpRsy3FTwVVORO3+/GXOatZNPRZycyAVW
        LDcTzSU/HT9uDqF3NiWiZIP614gd9qgcEsuXSoBakdRFRoEZYrEXxWPsTFA8/eUc
        7ef096cpmAFx6Bou9beca5zHPV0AgPjtm9Z/D0GX/CJ98pDUBbja9A3ZHdluq/gB
        ddFnH49a/7UTNMFK1sv4WhQGeTpbUicDkhpVHslnDD1YEKOqlxoVUx6TiMQSa30B
        s4A69HFVbvG2WGyZUQSpq32q7aodY8vI6uikclJSFIyIPHSiCA5zuB5/NnjF5iYW
        ne1K+7icRsG+qmShn+Ghw==
X-ME-Sender: <xms:G7VjY3AbT0pQ4SX_CMmLZyQ57rJaKDIrylhb-n-MkWykIWXrvdBx6g>
    <xme:G7VjY9hqi2kM-MPsEO00D0NigxFfvRbqsIjjVEmBs1ly4vpDRnNMncZgpcodG4PS_
    pLtGyxkS3IZZaVTYvU>
X-ME-Received: <xmr:G7VjYynm2vjTdtG1dBQg8EtQ0SSsDbYNzX_y6bl-knS59Gq1IKUaishVxdxMaDYM_nFuAwR96D__oRPSqu0XPxU30cCmVMN8Qtp3eSkFu8smzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudelgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeetgfelgefggeekkefggfeludeiudffjeffgeevveekjedukedtudeuteef
    teefgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:G7VjY5xBrKBwUvWb-uHG4FAszPLyYTou82jTpIrc7Td_M6AJ9X1l0g>
    <xmx:G7VjY8TbXSyvEeZbeIIQ_-yWNUJHFQMmqAS9xSq2kV4QFgDmT0tVcQ>
    <xmx:G7VjY8ZG_0i3oLMM0MPHAmrO9mTlJup2ygxqKVMxhN6oRtsn59sG0w>
    <xmx:G7VjY_Gqo8eeFI0EoQ2Q1uJU4lLah6XbIEKEoLMr-Mz8mpDf4c0LsQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Nov 2022 08:33:30 -0400 (EDT)
Date:   Thu, 3 Nov 2022 13:33:28 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 4/4] clk: Warn if we register a mux without determine_rate
Message-ID: <20221103123328.stzhtq5e2jscjdxd@houat>
References: <20221018-clk-range-checks-fixes-v1-0-f3ef80518140@cerno.tech>
 <20221018-clk-range-checks-fixes-v1-4-f3ef80518140@cerno.tech>
 <20221026020800.38AC8C433C1@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221026020800.38AC8C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Going back to this mail.

On Tue, Oct 25, 2022 at 07:07:58PM -0700, Stephen Boyd wrote:
> Quoting Maxime Ripard (2022-10-18 06:52:59)
> > The determine_rate hook allows to select the proper parent and its rate
> > for a given clock configuration. On another hand, set_parent is there to
> > change the parent of a mux.
> >=20
> > Some clocks provide a set_parent hook but don't implement
> > determine_rate. In such a case, set_parent is pretty much useless since
> > the clock framework will always assume the current parent is to be used,
> > and we will thus never change it.
> >=20
> > This situation can be solved in two ways:
> >   - either we don't need to change the parent, and we thus shouldn't
> >     implement set_parent;
> >   - or we don't want to change the parent, in this case we should set
> >     CLK_SET_RATE_NO_REPARENT;
> >   - or we're missing a determine_rate implementation.
> >=20
> > The latter is probably just an oversight from the driver's author, and
> > we should thus raise their awareness about the fact that the current
> > state of the driver is confusing.
>=20
> There is another case which is a leaf clk that is a mux where you only
> expect clk_set_parent() to be used, and not clk_set_rate(). This use
> case is odd though, so I'm not sure how much we care.

It looks like there's a good number of clocks that do indeed only
provide get_parent / set_parent. It's hard to tell if it's an oversight
or a choice.

I think we can make that decision explicit by providing a determine_rate
helper that always returns the current parent and its rate. It shouldn't
change anything from a CCF behavior point of view, and it makes it clear
what the behavior is. And if someone wants something else, then they can
change it to whatever they want.

Maxime
