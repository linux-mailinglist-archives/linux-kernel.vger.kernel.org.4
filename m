Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A244E62715A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 18:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbiKMRwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 12:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMRwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 12:52:47 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F069710070;
        Sun, 13 Nov 2022 09:52:45 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id CE34C32000D7;
        Sun, 13 Nov 2022 12:52:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 13 Nov 2022 12:52:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1668361961; x=
        1668448361; bh=to/nS/YHMoZGbUTDuWf2VM+aexKdoy83Yy01COB+YwM=; b=a
        t2EimwiO/ysCMb22zBUjRkyV0jxhCFdV+AVDxGEcP7/Hk1nZ5W708+NRAzNxxqdz
        p688weQVZDjjVt2Xk+z/E8mv+/XGIp/wesIKyDqhP4pOTe67pf/lDcoUUtZe8/h/
        DKuubPgbtJUrTDhU0vWTzM77oJWJxg541UPcUJvxkL+jwC+jwq/MIqmSywGxH1V7
        vl4oigCbtcVgNhVQ2A7LExVdOlYYPUs7WzJ2WAZn+JZgwgP8LekOSWcCWLRRum3q
        zwfotOoIwEdYdiJg5ks1KSGPLReeBFayHo6tCMg2QoADsGTSN4SwSIZtCyTrBXdR
        P2wHkzjuOvPCo+CveBpbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1668361961; x=
        1668448361; bh=to/nS/YHMoZGbUTDuWf2VM+aexKdoy83Yy01COB+YwM=; b=d
        lhvUDCOq4JE6ZuE1umxApYq0nFICgA7M0vtK36b5pzVP3IvLjhBsKBkG37Ip8Sb7
        ZhQC+APr7SIel6RXVDXp9Haw0vVYS1M9AbdKLy4tqrmMHbbGEUJK1FXwRhWFqjsn
        KmGMl0hTuUej0R+DNnDy13R+/nDCSoBd9cW0CJJUR3DVFzyzzKOg+iLw7PX9/EJF
        4cu6yvgH6mexNDnInxiehM2Xjn5lA48q3tdzTXnl3Mb7WViF6a2hFTDfAFvkFiiI
        9XyzPg4ONuNnKd64z/jX+xny7KpIPfvU2gpijcOb24yk0ofp+n7kMdIHDB9+7AVu
        3QQka0F+paRMfVqrIBK8A==
X-ME-Sender: <xms:6S5xY_HqUtD0dfLAbIP08fB9tnBvXBj_LpKCcFbMPy6JrWYobP4n1g>
    <xme:6S5xY8WqhA57rpdlmcxyYFki5pXu4dSP5LdLzAVaAg2Y0izAQg-1V11ZEGN__nOg7
    z3yIS_If20hKianuA>
X-ME-Received: <xmr:6S5xYxIM5pq1IFTW1w911ar0_T1xcuJr_d6x6bBnCtR2WXsMwlOmN2-b_64FEIYMl-b5sUSYAjo-vw708UH-5R_Syb6dJ9EChDZ8o2199nZiZdhFeEwBv0XqEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedtgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeekjeelleefiedthfdtgfekgeehudefudeugeffvdfhudekleel
    fedtteejhedutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:6S5xY9G7RqRmRJ6LTMe0CZ0VI3vhN0Hs28A20Nz0jsfhQihDbByceQ>
    <xmx:6S5xY1WCyx2wETriDeKho8DBGI3kOp4fmQKl4iYFDo93v6Egb3l73w>
    <xmx:6S5xY4N4AeQBnDn6JHcQux1907-Ial8snGe50GP2jDEzVhKUMaMhPg>
    <xmx:6S5xY-NTm6YwlLmY1ubB8jn_Axs4zeDaXM7mGaTENvnZmfpKQ9C9hQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Nov 2022 12:52:39 -0500 (EST)
Message-ID: <658c5d48-e84c-9c92-84e7-b31dc8861fec@sholland.org>
Date:   Sun, 13 Nov 2022 11:52:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] staging: media: sunxi: cedrus: make vb2_ops struct
 definition const
Content-Language: en-US
To:     Ian Cowan <ian@linux.cowan.aero>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
References: <20221113014703.138717-1-ian@linux.cowan.aero>
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <20221113014703.138717-1-ian@linux.cowan.aero>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/22 19:47, Ian Cowan wrote:
> This cleans up a checkstyle warning where the vb2_ops struct definitions
> should be const.
> 
> Signed-off-by: Ian Cowan <ian@linux.cowan.aero>
> ---
>  drivers/staging/media/sunxi/cedrus/cedrus_video.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Samuel Holland <samuel@sholland.org>

