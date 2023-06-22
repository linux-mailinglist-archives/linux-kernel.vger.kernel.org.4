Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698E7739E0F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 12:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjFVKK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 06:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFVKKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 06:10:55 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5306DD;
        Thu, 22 Jun 2023 03:10:53 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 4B3E05C008E;
        Thu, 22 Jun 2023 06:10:53 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 22 Jun 2023 06:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1687428653; x=1687515053; bh=rQtLPWivvoqJHEflH1RQG9ep95dMvO0UyWn
        P9cqsqPs=; b=hgNyx4A21ezJ3AFz5nxXKPLWcENK9ov93cxuU17cpSO5QTceB8g
        KmE2V/gzSbH899GspBkd/PvmIEHsNMjYTMr1FrPOUJsnUwYIYsADYucLseS5WRov
        z0RcE1dP105RKCupGkduFjcEy6w27UDxtC2neFgYesjFrzHIaCdo8perNV7FYit2
        4El7QoaWOVqkZBAlbpGmfYV1+iqDrXl3Ohtb28RhddWYPlSMzFsNHyYvC6qdkOXE
        B9m0E/bwzhvltmKXAp6y6L9OwrrVIU9py3y0/Wx+Fz5W3bmBuGjdNWiNWuaRp+ZC
        9OQPj/01xuiA1VcymD8TT/BiHEgfu7EkC9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1687428653; x=1687515053; bh=rQtLPWivvoqJHEflH1RQG9ep95dMvO0UyWn
        P9cqsqPs=; b=Lqp8Kg1AF6Jd7qR1ESsLmDMU+KhuEp3ddeHr0n7kSfY4a5ABWsX
        hfCzcu+NCfFUtPVm1SxnD2LYJPVCidiFquh67PPXWw9G3AyBdj/1fgoGsQyd0sat
        jpkYxtQITeKVlBlbcxTUQC4D6zuxtsTl19mP6K2M7zFYmiqAl/KTidQqF+270AGO
        tZsEYjo4eS+6WphReJdTrS9Wh0pdGevpgdEG3BgkjblKtHk7HBRr1Asu/myRFXj7
        wlgfJAO12LQbCm5Lve05l2Fjx+yQ/kgxhkQbm1XTckKi3DF2qHuyBoBKCH9Jhgyy
        DALSGSiucppmXislYzs1t6z2yCZjxb0lr1w==
X-ME-Sender: <xms:LB6UZCybnsLf6vIe7FXvVAz0zeVGSOzfzKDmB5AU_DMrETJAMorXsw>
    <xme:LB6UZOS1d9mkBJvpX5L--g4RS-RHmGaYGgfhS7n2ySsS1gCWZxExCFk8FYoH752Cv
    zD6cSU3roBwXlMb6dI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeguddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:LB6UZEWi84JajD8g0Nl8xAB5IB8EtzWp9SMYZxKJDF8noYAusw4yig>
    <xmx:LB6UZIiBBVj0VlmMbK5_evoPPLaXrtOP-vTTIKSdpQLsoslGgtwmNg>
    <xmx:LB6UZEAbXALC1hBnp7VHGBrcL9Y4CZ4o4ufIkQ5dMTKDbTaAnPsR8A>
    <xmx:LR6UZA2mE8ZjDdDUHX9a7RKR56N_QNeBfcvy0eBp19JklhYebBSJSQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2007BB60086; Thu, 22 Jun 2023 06:10:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <c788d873-ad57-4a94-9be0-cdc5d1326cc2@app.fastmail.com>
In-Reply-To: <19e93057-46e4-1578-9e3e-138bd09cccfc@gmail.com>
References: <20230621031605.234149-1-ychuang570808@gmail.com>
 <20230621031605.234149-2-ychuang570808@gmail.com>
 <69c742e5-3270-4b1c-be31-1552d877677e@app.fastmail.com>
 <19e93057-46e4-1578-9e3e-138bd09cccfc@gmail.com>
Date:   Thu, 22 Jun 2023 12:10:29 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jacky Huang" <ychuang570808@gmail.com>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, soc@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, schung@nuvoton.com,
        "Jacky Huang" <ychuang3@nuvoton.com>
Subject: Re: [PATCH v2 1/2] clk: nuvoton: Add clk-ma35d1.h for driver extern functions
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023, at 03:42, Jacky Huang wrote:
> On 2023/6/21 =E4=B8=8B=E5=8D=88 10:22, Arnd Bergmann wrote:
>
> I will extract the unrelated parts from this patch and create another=20
> patch for them.
>

Ok, sounds good. It would be great to still get this today or tomorrow
though, as the merge window probably opens on Monday and I want to
have the tree in a good state before I send my pull request to Linus.

     Arnd
