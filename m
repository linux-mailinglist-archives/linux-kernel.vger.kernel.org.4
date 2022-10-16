Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F275FFF8D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 15:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJPNXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 09:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiJPNXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 09:23:12 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619C832DBB;
        Sun, 16 Oct 2022 06:23:11 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 2EDBE5C0065;
        Sun, 16 Oct 2022 09:23:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 16 Oct 2022 09:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1665926588; x=
        1666012988; bh=luOh1+tXqD7JMWO63diGmzw1lVMjKMj3+nXqqj2Jd70=; b=V
        JKFc1tWmuQAc4v127ngF04vXL5JVjXdfS0zg5lUuQYjC87yz/n+NHZJ3PA3P+swu
        /sTXP3WN9oxQZXh7mGYkbsK43JMklb7UNDDBh/mmasVfTKKd++Vrp5XCu3w20LYY
        lJhXiHgwLRBRhbPE2hp+4gtBQluEZ3DSZZcDaAGGx060Mwsg5iUQrmT7U03H2ASc
        EPpteLYSFDjLuqDXiVos4sWgMOMg+xecoHR+PvSOO+ZcBVbN5ozApw17wxse2nt2
        +xn7vG0OKHhQradz7iny4eVeNvlqA5voxMDzf31Qq3S3d+EWEjywf4oG46IkBiDa
        i+Gme8oJ/zPEqXAlBOGpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665926588; x=1666012988; bh=luOh1+tXqD7JMWO63diGmzw1lVMj
        KMj3+nXqqj2Jd70=; b=pWHazTuKjzH67V5VKZSaxNo5eNnpEq19tt0JhIszsFg7
        W+OLBVTRoT7/E0dNwKPdTlI60ZM+l9JjkfhLqC45UtiliY+WwOJCqoUm8r+9Ou3x
        RMAyDMNb0ksTbzl4iwKtomOtkq3NH39NJI7uAdUY626QqEVDqrIu0XYU//ts0mVt
        09LzGnAKAqXpjTD1I5s7mEMiv6w+QdgfenJiSBM2GHS+pn53bWXzNcRPaYcXQUiL
        hh+H23qvIG3eDjvF9XGocMw5nZRhJA4SobGf0vKpXvfX99ykmqDVkV+pnEFhF0r2
        teEebRoMa8kKHFkp+/EcvCGTihVclI2VQguqCTrNmQ==
X-ME-Sender: <xms:uwVMYx5TEhV8OBMN34G-Tu6mFP0LThe1cgep69vCunD7bvdXX-14hw>
    <xme:uwVMY-5zGFvesB4mJippybwvToIG0TuPTXS-tMdfMSBD0yVS48KqwIIvpEK7qLDlU
    xvZ0mfPwfNzCDPE3NU>
X-ME-Received: <xmr:uwVMY4eIWfy-hGyF_9sLbta4RjidQ5cjP9frgd4G1wV5KslxysteAzR2dH90>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekjedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheplfhoshhh
    ucfvrhhiphhlvghtthcuoehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeduieegheeijeeuvdetudefvedtjeefgeeufefghfekgfelfeet
    teelvddtffetgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhg
X-ME-Proxy: <xmx:uwVMY6LXHxY8cOTSSJmJXWXP4jo72XYovaS_tr2nDXekK7f3OlHJ-w>
    <xmx:uwVMY1Ig5og4cX74dxy3dpKrKnWKyY-YFUj9wRzkqK-j2WV2HCYekg>
    <xmx:uwVMYzwLhHNm-Gu0ZpmaOTHIgL3QDmEOqEXhrGg1aMe18bmOD3mr4w>
    <xmx:vAVMY8-gp3q3EUNtj94KoCGKsyeL2jm2m97mZYH-VHhxQAGUENnGwA>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Oct 2022 09:23:06 -0400 (EDT)
Date:   Sun, 16 Oct 2022 14:23:02 +0100
From:   Josh Triplett <josh@joshtriplett.org>
To:     Olliver Schinagl <oliver+list@schinagl.nl>
Cc:     Gary Guo <gary@garyguo.net>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/13] [RFC] Rust support
Message-ID: <Y0wFtj615KqqvGob@localhost>
References: <20210414184604.23473-1-ojeda@kernel.org>
 <fae4873e-2ff9-df35-0ab9-34bf4417b717@schinagl.nl>
 <CANiq72mRxM-7griYF+0FWqYoSoNL8ad=L-i6a2-GsaCeb0C6qQ@mail.gmail.com>
 <ba8cb315-9d73-2f45-8bf9-d9473d369dca@schinagl.nl>
 <CANiq72kz+Txauo+103_-fN_J8PhhCdJUH5XepShUQmJzW6a4tA@mail.gmail.com>
 <5c0bb1db-5589-32ca-ac22-4aafb3c15751@schinagl.nl>
 <20220728112114.0000003a@garyguo.net>
 <a4803f2e-2e46-1c7d-0e89-96f5cbb0ad11@schinagl.nl>
 <00604162-9157-3862-b463-de90cb17c69a@schinagl.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00604162-9157-3862-b463-de90cb17c69a@schinagl.nl>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 15, 2022 at 04:16:14PM +0200, Olliver Schinagl wrote:
> +indent_style = "Visual"

Without commenting on the rest of this: visual indent style produces a
*lot* of diff noise, and I'd strongly recommend against it. Because it
lines things up, a change to one line can change many adjacent lines,
and make it hard to see what actually changed.
