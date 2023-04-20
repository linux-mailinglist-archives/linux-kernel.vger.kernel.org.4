Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CAD6E9903
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbjDTQCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjDTQCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:02:45 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5EF2713
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 09:02:41 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id B13993200488;
        Thu, 20 Apr 2023 12:02:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 20 Apr 2023 12:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1682006559; x=
        1682092959; bh=jajIfTVPuVBVbgFh+8afBmP6sXLejNyeNMNRhBwmtqk=; b=W
        SMmpicUwyAy8N07aHEt3KdrT1ABiMYOm/Rioc4UehTS4dkQhL/LaOf3Ifg7Z47OQ
        gsK5ei6agy8VsUPn4TlcolULpgn0gjgA0Qq+0bFY+KrWhxjtTXP1xWEtGXeCf93U
        JMd8cdR0fRUBQireNZopYiMxLFD4GAC0zhUfmZ3xswoXE5Q3AdrWDNIG4ui2LTCG
        vjfIDmCu8xzE7CK/HO+lJMHHZMtPZ+nFilEmYefdVQ4gAj5IaN98bjCz58KQGQ12
        OxCdBBByM1VGWiMmftRcNk3chIEEppJHRX2+9nI51zma2R7CIR78U9Y11noUxGCm
        ln1c1bJJDCQRAsIQ0Kn8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682006559; x=1682092959; bh=jajIfTVPuVBVb
        gFh+8afBmP6sXLejNyeNMNRhBwmtqk=; b=dEUG2WNyxVkuLtSWu41v+FeRDrOAW
        dWvFDoIyB0Ktz5NqY/JHA3QVG4Qym9wZI7Kxl81iyBhqbtQLKvRCK/RlG+TDYUOA
        4NreCNokE+q1f4wJs6kJ0jDMlfBzxeqDokPk0Pmz90PkyoBBBk0IKz6xGqX7bzMS
        kB4KgWIjDxuQS21xxDVv8w474eNoVP8RLNgqtbgXVU1ue+a39ExSB4fkw4t0ieCO
        B7lXw2gtt7kJV6kZpDsuBkbkSi/rMsgZ7Bx9CXpgrt65+/Jzkrde/D74ovHst8hv
        0eeZJBEHa3g2IAU2uFDaoMl8AQUUhBPEPh5FjjL6N4HswSn8pIocSHxNw==
X-ME-Sender: <xms:HmJBZKhol3TAlraWVNtOr8AwoDN1lgWIZSC-zAVFgPkN1vbzx91Qwg>
    <xme:HmJBZLCbVB_iBRscbPAez8OG2CWKZUN73fyu1y2c8g5dr1tkwLHSM1lCusZi_Wqgk
    VKmxtlaWbHX6gBegdk>
X-ME-Received: <xmr:HmJBZCHChnjtXh1pcm4QcW5lDGUjlXyCC5RSCuwOwBi4DD-VOtGh5FH4lU3J6oAssVgqndU9u9WLcUg_RZ322zZ1AU6s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedtvddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevieelhf
    dukeffheekffduudevvdefudelleefgeeileejheejuedvgefhteevvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:HmJBZDS6GT03yAC40V9EEONRJuJa49-KHDMrgoRde5Ci-eMrpjpmtA>
    <xmx:HmJBZHzEch2gkjs5dRfRC7WTU08JQithmMP2tZNVLiLklczhcB2b8w>
    <xmx:HmJBZB6tm9HYEbGtNH6d-hajNviRdfYaZOEEJ5ZbOksfkzDVNOXziw>
    <xmx:H2JBZJtnwBbC_xakI9pWhUCYxcvZIT5HvAbdsYJlmr3egtkSruR93g>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Apr 2023 12:02:36 -0400 (EDT)
Date:   Fri, 21 Apr 2023 01:02:33 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux-kernel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, stefanr@s5r6.in-berlin.de
Cc:     tiwai@suse.de, broonie@kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] MAINTAINERS: replace maintainer of FireWire subsystem
Message-ID: <20230420160233.GB33275@workstation>
Mail-Followup-To: linux-kernel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, stefanr@s5r6.in-berlin.de,
        tiwai@suse.de, broonie@kernel.org, rdunlap@infradead.org
References: <20230306035814.78455-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306035814.78455-1-o-takashi@sakamocchi.jp>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 12:58:14PM +0900, Takashi Sakamoto wrote:
> In the last few years, I have reviewed patches for FireWire subsystem and
> requested sound subsystem maintainer to sent them to mainline, since
> FireWire subsystem maintainer has been long absent. This situation is not
> preferable since we have some user of sound hardware in IEEE 1394 bus.
> 
> I will stand for the maintainer, and work for FireWire core functions and
> 1394 OHCI driver, as well as sound drivers. This commit replaces the
> corresponding entry.
> 
> As you know, IEEE 1394 is enough legacy. I would like to schedule the end
> of my work in the subsystem. My effort will last next 6 years. In 2026, I
> will start strong announcement for users to migrate their work load from
> IEEE 1394 bus (e.g. by purchasing alternative devices in USB and hardening
> system for them), then in 2029 let me resign the maintainer and close
> Linux 1394 project.
> 
> My current work focuses on real time data (sampling data) transmission
> protocol in packet-oriented communication, thus I would provide less help
> to implementations for the other type of protocol; i.e. IPv4/IPv6 over
> IEEE 1394 bus (firewire-net), SCSI transport protocol over IEEE 1394 bus
> (firewire-sbp2) and iSCSI target (sbp-target).
> 
> If receiving few objections from developers, I will start my work to send
> fixes for v6.3 prepatch, and PR for future v6.4 or later. I'm pleased if
> getting any help until the end.
> 
> Reference: commit b32744751e75 ("firewire: add to MAINTAINERS")
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  MAINTAINERS | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

The patch is applied to for-next branch for v6.4 kernel:

* https://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git/


Thanks

Takashi Sakamoto
