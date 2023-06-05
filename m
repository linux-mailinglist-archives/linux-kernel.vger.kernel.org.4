Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F40723364
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 00:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjFEW4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 18:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjFEW4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 18:56:00 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3229CD9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 15:55:59 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id DD3505C06CF;
        Mon,  5 Jun 2023 18:55:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 05 Jun 2023 18:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1686005756; x=
        1686092156; bh=Eog24KCYFUe8sVMLxRnUuAe7b2ZA8l4HhKqKfnpqwXA=; b=C
        JcJv82/nBkX0uo1d3G3dntMBzNaBBHiPjfQ1qYTRWCWP8ok3MofFVT/E5XyZLQU8
        9yofmxe0TZETUfrqZteFyjKUZ083WPuHrXsFU3IT5TLe3kiasVIO2geDXiYsXmY3
        sQlcUGgyQ/cVghqUkQ1RVnql+2lckrKEqJgt6dmV32fuuLq2aTgbsPIVTcrGXYQo
        BRZ361HIkmrNlolOWrO63QVSf3PmCJdWz3y5p1xlHBoCs3okY9rG5GKCfDtbB5/1
        gDzzGPzKVQpVj+rA0PNICUoAolWfmIxdTsDfpZRiTwvFuyUIzvIHr6E1jRtW4Jfg
        K+UWyK27SRYU8j5GDGEaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686005756; x=1686092156; bh=Eog24KCYFUe8s
        VMLxRnUuAe7b2ZA8l4HhKqKfnpqwXA=; b=GFuaraqOvshZWzg2JfQJVXpibUZZd
        ktdZ0dglazBKPe5IpR/FN4iocmZ6oTolMa79T6GhKlTCdDsRI7BIibl6YQg46zN0
        kYi4O54OgQmPaaStSRQeM/kzdUnFvQfHuW3OEh2fT2oMOZ98BKmTq7jySkENFTM2
        GA7iQ2mQQ0vP8leu6LjDLDuJ6w/5WienYU8PRTcfdH9qAHO/sLuit9jiJbxwYELu
        oKO046KWUD89kxLUgTJJ5rGdj9XBunVjsOdji/ftZB0nZEWyKsbBjDqGIj4kXcbH
        4uoCOouA5y1XMfueEICL4FOpmpdijZZZmMY+ho9z12uDZpJAIrrlti1FQ==
X-ME-Sender: <xms:_Gd-ZNEXuI5Aiy2QQkmdmqdHKS5OXTS0AqssEpjI3SfA4MOuhAzoyw>
    <xme:_Gd-ZCUGaqSn3u7IHc_mv4U4VoG7rR-WVcLYKBTxLw9QfEa217so-BbzMj8d1rwWS
    fucUaTbRpRbYMzv3PE>
X-ME-Received: <xmr:_Gd-ZPIzJvrry9OvNqPMWwUKtRw6z4p4xAvJJzwxgn_cAlZBKA8tSHtU_O_CpbrAFxY5CMKMWI7W6qTF4YN50OzdlUpSUY1l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedttddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevieelhf
    dukeffheekffduudevvdefudelleefgeeileejheejuedvgefhteevvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:_Gd-ZDH26th2SgxybJaaGtsEXqHWRXz8XVP75Ed5mToL_JKie9Ulxg>
    <xmx:_Gd-ZDWdqiS8DgFpvyvJ-Slmeu_WrujGUSTkXWPMSAPfRB9ssqUY0Q>
    <xmx:_Gd-ZOMppUnB4QxMRZ-LdBEv20C43Wjkvh7I0ULNX1CwKC0yzyzuig>
    <xmx:_Gd-ZKc2ngQ10B9c9Bet4VRiHm8-_TNsP0FSHXstPrvVsv3IwkAXaA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jun 2023 18:55:55 -0400 (EDT)
Date:   Tue, 6 Jun 2023 07:55:52 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] firewire: fix warnings to generate UAPI documentation
Message-ID: <20230605225552.GA178739@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20230601144937.121179-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601144937.121179-1-o-takashi@sakamocchi.jp>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 11:49:37PM +0900, Takashi Sakamoto wrote:
> Any target to generate UAPI documentation reports warnings to missing
> annotation for padding member in structures added recently.
> 
> This commit suppresses the warnings.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/lkml/20230531135306.43613a59@canb.auug.org.au/
> Fixes: 7c22d4a92bb2 ("firewire: cdev: add new event to notify request subaction with time stamp")
> Fixes: fc2b52cf2e0e ("firewire: cdev: add new event to notify response subaction with time stamp")
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  include/uapi/linux/firewire-cdev.h | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

Applied to for-next branch.


Regards

Takashi Sakamoto
