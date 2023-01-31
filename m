Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBED1682108
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 01:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjAaAuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 19:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjAaAuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 19:50:19 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8653722A09;
        Mon, 30 Jan 2023 16:50:14 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 8E24A5C00EB;
        Mon, 30 Jan 2023 19:50:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 30 Jan 2023 19:50:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1675126211; x=1675212611; bh=7t
        Evx1Wq5hBcE5AoXBcFiR1em1/omSb3W+2cm4SsFBg=; b=EzLEb0NJHKdget6FRw
        lrwscUWU1bgg5OjQD4O5h/3QbwMNtpbwHJzMuaUJRAlDNQv/tqF4iapFRHC3JF/o
        LRW/hCT4R0mPEIcK+Lqdr/OhYQmsetUfLsFreuP0cmU5sEAcg1bRq64lU8K3Bila
        w1Q472SoRxvv1jEp6NlhpKjXb25Q1gSvtwF9Jsg7TvRnPb1K5cP/ay8AokZAntDy
        idLhfk32NTG+rR7CIQP+I+P42NvEdbyqEZl012tcwkIGNdIjJiT10MGnDftkUgP+
        Sin9SQFnhqDakSTdf1NmPp3kzcRZtWK6wUHCg7lsLyEE15qnThb7hHbAdkklVG26
        dp4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675126211; x=1675212611; bh=7tEvx1Wq5hBcE5AoXBcFiR1em1/o
        mSb3W+2cm4SsFBg=; b=YDwuHc4pMBREvLwGoFKifbXZD7iv6vJFUOLbjH9TlQjS
        uoQQriMUTc3lw9d7X14fsiUfGVkeo0h3RVz3IGxXSpzk6/XwgyM7VpOyBHv2+HwC
        iJxkXrVVvH3LFGj+f3RLsUpjDfZJAEascYrni8oQqlCHANGjmbyqIolMYgmPqxS8
        8M6hUa995ABVmeZbGWblIXA4SVlyXRjAk5Zq6HVcBdXQZc0T8XZ786dG0sBd1eEV
        1mGyM6b8RcRBbSA/8vC98RzsNGUSXnJOdHBTvANDmeeHnA+paN7Tez8WmMAy9wcg
        Ft8GjT+XsvPBEnt6fGKVHqWRoDcaQ8McEsjrSSv3CA==
X-ME-Sender: <xms:wmXYY2QTL5Psv_yD0BxdxKd_mAfiRAh_IjTlAlZl57Jzqzz2QdW9xQ>
    <xme:wmXYY7w1ndaUgu5C-_A5lZhslK6QpGBhzl3n4TsnqdqjSNRPoIQIoDhI5XuNnuSXs
    5KFQzYHOwNUhKe143Y>
X-ME-Received: <xmr:wmXYYz0h5yej8Fg_23aFFt4WA87BwK0rt3w070FcwYYd4H6CZLUw3AJKfzhkKO9YvcJ-GmDL5Lub8zAzAzVwt5RvaQSB_v6vu2rl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeffedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhepveeilefhudekffehkeffudduvedvfeduleelfeeg
    ieeljeehjeeuvdeghfetvedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:wmXYYyBhZXSWty01-mo8vHp6stQwexso1oBGUpiLUzR0f4ySMxl-PQ>
    <xmx:wmXYY_jeMCoxfETvZKJlOKQUzoxz3duHtNe8EaaAUy8QO5IjBSFCvg>
    <xmx:wmXYY-pbqPwrTAz7aF4A0KVY210cTD7Pdk16tWEMM-H1AHo4ky2_tQ>
    <xmx:w2XYY1YI6d7RbCG4xg3AuAGejCltIiuIgYtO5oq469Iq3XH4BLE0ig>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Jan 2023 19:50:09 -0500 (EST)
Date:   Tue, 31 Jan 2023 09:50:05 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RESEND] ALSA: doc: Fix PCM interface section typos
Message-ID: <Y9hlvUFyic51GPGj@workstation>
Mail-Followup-To: Miquel Raynal <miquel.raynal@bootlin.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20230130162924.119389-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130162924.119389-1-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 30, 2023 at 05:29:24PM +0100, Miquel Raynal wrote:
> Fix two mistakes in the PCM interface section:
> 1/ Members of the snd_pcm_hardware structure are channels_{min,max}
>    and not channel_{min,max} (mind the 's').
> 2/ Another sentence is incomplete as the reference to one structure
>    member (period_bytes_max) is missing.
> 
> There is no relevant 'Fixes:' tag to apply as both typos predate the
> Git era.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> 
> Hello, I wrote and sent this patch in 2019 but I likely only Cc'd Jon
> and the doc ML, which might have not been enough, so just in case, here
> is a resend.
> Link: https://lore.kernel.org/linux-doc/20190829145512.3752-1-miquel.raynal@bootlin.com/
> 
>  .../sound/kernel-api/writing-an-alsa-driver.rst        | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
 
Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Thanks for your long patience.


Regards

Takashi Sakamoto
