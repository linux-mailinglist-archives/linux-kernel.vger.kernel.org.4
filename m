Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C825465A5EA
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 18:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbiLaRVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 12:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiLaRVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 12:21:47 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA51360D3;
        Sat, 31 Dec 2022 09:21:46 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 506DA5C008F;
        Sat, 31 Dec 2022 12:21:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 31 Dec 2022 12:21:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1672507304; x=
        1672593704; bh=MwNzCwU4y8oThA8LV/hj9QJkdII91FpQFynEsjgAkEs=; b=u
        wd8/4THVCiCZ6yOyZOn3iXMMSxbkDpU9Wp7C2rtX3lqNkbWiBmU65vxHibpimtqB
        FDIGsvSPXwv9KADS4yI/eDIDD86qI6xUOOAMb0L8FaAUcZ4quFIXVHergOPZtKMJ
        kWawKPRGGdwDob4TCmYe7lKGKaxLbNwT+qJTuqRzqyL6N3sQCRn+xBgmSX5+oLX8
        s/nK3Yr6qF3/R8U102D61tMXDRWwwvElUeePjCCBVuUqxS0yLhohEb+1iTsY1apV
        EApGYAWweeOfGOFHr3oFf2VgHBtsdb57nhe7HZI4t/OSezyici3xKyc4NfwsW4mv
        jhidEBGvIrz+WbnDURkwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672507304; x=
        1672593704; bh=MwNzCwU4y8oThA8LV/hj9QJkdII91FpQFynEsjgAkEs=; b=B
        gE5QA+b/pAmKjQguidTWRC9uBV1l4TMzpXmujhet+PWepsARa7E6ruY2DMuXslBF
        3pmBD36JHLIVLJws70LfVYM6CHAk+GdfaWJVF9+b1CVKBLZIpFHw5Q1lDNx/JLVF
        lwLeOPsDPTdI0UpB4YO29sV0tVoxZCj1Nizot8DT2rkB4tuwFgwijI3DUV6gGA4J
        Z4F1uACXhKEalZJcLybrbt+07awvDb/irYwAWcXS4yG8z0vogrOLq2LNjLqtNsHk
        W6YsB4eC3bz6qHkeNDyq1q0ihrHSIzHbtuT16WTu2NdCHugjhdHbvraeSLI7SiKV
        h8Qh/tExDj8XH++gdyDSA==
X-ME-Sender: <xms:qG-wY7IbT_mbKLffc_Ju0N9wBXQfmqPZh18jde16jSPVDaEm_XDY6g>
    <xme:qG-wY_LSnmX4xZOIoY107V4Mt0bSK1zOG1mQalsWq9N-rfnI5cBxJlQuIptTyrTt-
    y0bAZrU96osaPipqw>
X-ME-Received: <xmr:qG-wYzuVnUCIzrhHPqEDyLmpcFJ6fU6h64rZsjcEXIqg7ZaVfDje_KEn3BF9jnFg2pKkANAqm9j-RByQI2JftbC_W15m5H6kHcJbU1e9Hka1TMkU27NQJqH5bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieekgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeejgfffhfdujeeftdeuudeguedttefgieetffffheejuefguedv
    heejteeftdfftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:qG-wY0b4chipnTOVdIIS5QxMreekr0uDBgf3a1PqrHtSnPeE4aOtRw>
    <xmx:qG-wYyZezoSnuelG5C4nWmQSTb6uJzdcD4TmaQ_81o6-kvBioDzhUQ>
    <xmx:qG-wY4DWYjS_6v7885Gs3pTj7OF5X-URBeWMHx9j6jrg1Lj73qVAqg>
    <xmx:qG-wY3PRYuPFLlZSgRnNVkmAq1WeV89QTlav3lQJXSmmJqJ0C5mtXg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 12:21:43 -0500 (EST)
Message-ID: <ed4a1b6d-3979-652e-0181-c34bb5a40d5d@sholland.org>
Date:   Sat, 31 Dec 2022 11:21:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
References: <20220810014024.27568-1-samuel@sholland.org>
 <20220815172653.51C41C433D7@smtp.kernel.org>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH] clk: sunxi-ng: mp: Avoid computing the rate twice
In-Reply-To: <20220815172653.51C41C433D7@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 8/15/22 12:26, Stephen Boyd wrote:
> Quoting Samuel Holland (2022-08-09 18:40:24)
>> ccu_mp_find_best() already computes a best_rate at the same time as the
>> best m and p factors. Return it so the caller does not need to duplicate
>> the division.
> 
> Did the compiler figure this out and thus this patch makes no difference
> to the final object code?

It makes a difference at least on my gcc version 11.1.0.

Before:
   text    data     bss     dec     hex filename
  18257      12       0   18269    475d drivers/clk/sunxi-ng/sunxi-ccu.o

After:
   text    data     bss     dec     hex filename
  18083      12       0   18095    46af drivers/clk/sunxi-ng/sunxi-ccu.o

I will send a v2 covering all of the CCU clock types.

Regards,
Samuel

