Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83658617CCD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiKCMjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiKCMjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:39:37 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84EB11162;
        Thu,  3 Nov 2022 05:39:35 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 9DFA35C0172;
        Thu,  3 Nov 2022 08:39:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 03 Nov 2022 08:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1667479172; x=
        1667565572; bh=tBDrAJ8sBb+woFd54hehHJ+Mvs/qgHmsd/IMMfzwL5E=; b=s
        ZPnXjtXJ24nQmg6bvr8jGO3usTIGpanu8VdhKsagUAuwNRRagw3YKsjawKLwfo8g
        Akl5YYx1BLete5+JwJOUhgu9NnUCNteJC+LmkO9YO0kCulpOBUY3uOenh3W3z6Xx
        Gmp1OG94ww4KQi7NLJ623RSt1fAI0iZrCsWGFIIK4rQ3ip4kVIRQo9ldC3LpwG61
        zilrVznG71EFroStD1WvjmuK+n8Z6b+C4Le0IzbVCQZ04odCzIVO/pYLH0TfgSyO
        Bvz2Z2ZIHC9bYSG0LaiJF89jWgd7/FWMPkzIYzNxVvhUY+WDUucY2ZIDIzxK5a7C
        hALSGEybH7n+hsRw2VYdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1667479172; x=
        1667565572; bh=tBDrAJ8sBb+woFd54hehHJ+Mvs/qgHmsd/IMMfzwL5E=; b=h
        S9/f7ziUg8qd3mt9TTb6dfevR4k97x2pk76OZKcdNh9syW3wNDD7EaexNFY/0wnc
        JRzgBu+712wbVELM+/z9m6k+/w7Xng5/zS45CBXPl58h1eimZskCi2KXuwnvm+iS
        rNI9yWldH8XKQIAhcH0BWeRV+E2sP7zvgj/NyykFG3K3BFvbg7+XTQuVTdIhi/ex
        SKuarjBurtVPdG6wcrdwbwvqQFmlH1XwmZA7nWpjFror4b4WbNq1QxE76HCDIXvW
        LelKO+G6nVlsdTiGhNbURZ1L8HR0m6YBWCSaCxqfq/QvllrgNlmPlNYBqcub8m2q
        QZJjZoWINmxL3GD62Vzwg==
X-ME-Sender: <xms:hLZjY0VDIOhIdTUq0fNsfA-n068vZenIU0urL9crnnU4O41twMTSpg>
    <xme:hLZjY4m-vvOUqhDh75GyNmWsgzAIaymTVQ_nrvZ0JvQCj_dlzLuqsSdQJbE7xL71O
    S8yenFzc2bzI5vIdqQ>
X-ME-Received: <xmr:hLZjY4aOEpPC_MeFiLzoCZxJX0AMNkH-LC8LmF4Fp3IlaySwP-L4EdrDBMJuUqwGI936GpYH_czCOkR8to2RBNTcgZpbkl_QyjvWo2s2g31kFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudelgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeetgfelgefggeekkefggfeludeiudffjeffgeevveekjedukedtudeuteef
    teefgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:hLZjYzV_XidNmFwVsb6YOrvo7G-zHlIxbYbH3pWHZPLOaFDJrqWCyg>
    <xmx:hLZjY-mLpSBw_4fuK3uYAyvuqZN9KpnF1KxEztnIFe2pKs9fuRdPhQ>
    <xmx:hLZjY4eE4ivv1eUIlDPPFqW0BgDnZkAjQT2NNO67-ofRF7Gz7L8Cfw>
    <xmx:hLZjY44kOom2vzLep52d5746YDNDiQsnwFcRCwGNHU9KgB8-9GdxkQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Nov 2022 08:39:31 -0400 (EDT)
Date:   Thu, 3 Nov 2022 13:39:30 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 4/4] clk: Warn if we register a mux without determine_rate
Message-ID: <20221103123930.koc22wtbch56ql4y@houat>
References: <20221018-clk-range-checks-fixes-v1-0-f3ef80518140@cerno.tech>
 <20221018-clk-range-checks-fixes-v1-4-f3ef80518140@cerno.tech>
 <20221026020800.38AC8C433C1@smtp.kernel.org>
 <20221026135215.nqndtcb2unxqwwux@houat>
 <20221027214509.8EC66C433C1@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221027214509.8EC66C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 02:45:07PM -0700, Stephen Boyd wrote:
> Quoting maxime@cerno.tech (2022-10-26 06:52:15)
> > On Tue, Oct 25, 2022 at 07:07:58PM -0700, Stephen Boyd wrote:
> > > but I'm fairly certain a coccinelle script can detect most of these
> > > because clk_ops are usually statically defined (although not always).
> > >=20
> > > Either way I already see that 'owl_comp_div_ops' will trigger this
> > > warning. And 'at91sam9x5_smd_ops' looks even more likely. Given that =
I'm
> > > not super keen on applying this patch.
> >=20
> > It's the reason why I didn't return an error at first, I wanted to
> > report that it's invalid and let to drivers the chance to be fixed
> > still.
> >=20
> > Should I take your above comment as you'd rather have the affected
> > drivers fixed in this patch and we then return an error, or is it that
> > you don't want that patch at all?
>=20
> You can try fixing all the drivers that are failing to meet this
> requirement (found with grep) and if they are fixed we can start
> printing the warning. That seems to be the practical approach to
> getting this patch accepted. The TODO irks me to be honest. I'd rather
> we fix everything and make it an error and be done with it.

ACK. I had a look this morning and there's indeed a good number of
clocks in that case. I'll work on it.

Maxime
