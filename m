Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A506693BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 02:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjBMB0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 20:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMB0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 20:26:21 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AF9EB4D;
        Sun, 12 Feb 2023 17:26:20 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 75A18320029B;
        Sun, 12 Feb 2023 20:26:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 12 Feb 2023 20:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1676251576; x=
        1676337976; bh=guqNRHcMVWDS1JdER/xG2jRdN0GsHvvgSiGFe5DcgXY=; b=e
        I6TMHYyIs5bJi5kLyccPbbwLCfxp8I0GEVNspDZrb/Fnj5YHoEG9QD9FW/Sjoe65
        ZGFWRtyjJRj8HoKWhCTiBkz4rf/e1XR3HdCxUpY9BLt2BbIs0zBkMhauAB8+mkJp
        B4iqZfFkgIjvq3vZE8u7HZvqSlbYmdjfk5mkpDZG8BPBifuYT5Oasrv9WAinDbd+
        k+zdWpnoPfi8rMwdSiigWKyxQNewURO5Ls0w5sia05lLH1DHiC7feejldYN0xRrD
        0G6Kt3cnePfaydatBd9vBu/ngmFR+tHq0cWhYaNstZZ1UAKCLbfTKPpz88oK1+UQ
        YI4gFupmE9n/QT93nnlCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1676251576; x=
        1676337976; bh=guqNRHcMVWDS1JdER/xG2jRdN0GsHvvgSiGFe5DcgXY=; b=M
        vQvn4d646Z43jqisClI5d4KOLtMfslF18wt84EClUidLO5zXHsgBf8QjsGjv6Qbi
        s6dc5G+HWNRZJqkvPGsOM5tt2H3EMn/pUWmZCvpwAMziOmWlZ1+D3PO+kvHkbrnJ
        NSGWZ/mduGvJh2a9IvMAa9fLkbMc8wA1yRZU1EpcjsZdJXx7jzTsnthw9fi32fI/
        UCh8P6VRrv9zgeqRjbdz0KBDEk12i3jF9VnDKJuD8jihIS8qM2NG51gDJ90ibyGM
        xGPKPcXjObiiNin/t3oPp28Gw7YboU+GAj44/aQ7WFWKA9xtT/gPE1aSHKw+voUu
        T1FjMH7pufD1O77c/U1dQ==
X-ME-Sender: <xms:rZHpYyyFB7LrtW30_ioQcaGMLN1VCxYcn5WpYzgANqB_SIKxvbCEXA>
    <xme:rZHpY-RXX8M3p_wivH7AWzvIljNMPsaAyLbs8mqaqP-mvbq3LeSPsrESSP0Kltkvh
    76yYKM4Kt0E>
X-ME-Received: <xmr:rZHpY0WcH45pJsAUiNZjaHj_ToZciSgN5eV5P7noh9tcTIX-bjm-dtnmz_BEhdWsIDNvXpLODqwcdwLB8eAtFE19jx2TWC-bPYmybycGDMGiZjuwMiWl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeitddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epuefhueeiieejueevkefgiedtteehgfdutdelfffhleeflefhudeuvdefhfeghfehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:rZHpY4jzWhRSbZ2PLvNacufOieZ6sqhyhBxcKUtDEeDli_kMhnLwqQ>
    <xmx:rZHpY0ClKQ9cDPW4vDkOaXtVoXMwYYw_45sKkc94t7H9Ld48uEdtGA>
    <xmx:rZHpY5J4GTfwq2ULAosFOB4e5WrpWdqJOphTCUUuptqw2fdlR-cl3g>
    <xmx:uJHpYz6OnsokHDCRjMs0gkYy1U1u42yRYdCxirnk_ylXFKpnedWKzA>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Feb 2023 20:26:02 -0500 (EST)
Message-ID: <0011cfb4-5dee-a1f9-ae6d-2c9e71842a52@themaw.net>
Date:   Mon, 13 Feb 2023 09:25:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 0/1] autofs: fix memory leak of waitqueues in
 autofs_catatonic_mode
To:     Fedor Pchelkin <pchelkin@ispras.ru>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrei Vagin <avagin@gmail.com>,
        Takeshi Misawa <jeliantsurux@gmail.com>,
        autofs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
References: <20230211195950.452364-1-pchelkin@ispras.ru>
Content-Language: en-US
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <20230211195950.452364-1-pchelkin@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/23 03:59, Fedor Pchelkin wrote:
> Syzkaller reports the leak [1]. It is reproducible.
>
> The following patch fixes the leak. It was proposed by Takeshi Misawa and
> tested by Syzbot.
>
> In other places of the code the waitqueue is freed when its wait_ctr
> becomes zero (see autofs_wait_release). So I think it is not actually
> supposed that inside autofs_catatonic_mode wait_ctr cannot be decreased to
> zero. Please correct me if I'm wrong.

Clearly there's a problem here but I'll need to think about what's going

a bit more myself.


>
> Also, looking at the discussion [2] of the '[PATCH] autofs4: use wake_up()
> instead of wake_up_interruptible', shouldn't wake_up_interruptible()
> inside autofs_catatonic_mode() be replaced with wake_up()?

Yes, I think so but that also deserves a bit of thought.


Ian
