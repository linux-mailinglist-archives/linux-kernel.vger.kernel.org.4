Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D11269C5DD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 08:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjBTHNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 02:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjBTHNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 02:13:34 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8896EA4;
        Sun, 19 Feb 2023 23:13:29 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 7593D32003CE;
        Mon, 20 Feb 2023 02:13:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 20 Feb 2023 02:13:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1676877205; x=1676963605; bh=67c1IIuZHX
        18iDaWAaPszosm6lxR2+rVic8oeofJ/oQ=; b=FPMfv2De1XwIJmtJ0WY5XuSlVy
        7zU5izDopRuCcuf2UMBBz4DN/zXlaT44yvgPxga45C9YykZMPnYJiehR21ZluCsl
        W3z68Jf8UwP92rVwBTcdHz3ZgzyQh4WNMM/GGB6htJLR3aaFfWWmO2mN0OrqFNDW
        Rm84xTMa/Yeac/6Oyy0YvfviWmuDnlC0q+7e2Ya2lNWauu4kOKOa5gCn+JrxrM7T
        nBJ0ZqqrV3uQvQ6jVGj180Z+ogiUyIWPlSwSXsOLLEao/3NlpR+y1jXbMwFIsDin
        mHB4ZIkEMwotTtHOBr+i/2YK3fnvzMCMj7j1r0t07RSw4Cn5O9ZPHlIC38kQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676877205; x=1676963605; bh=67c1IIuZHX18iDaWAaPszosm6lxR
        2+rVic8oeofJ/oQ=; b=bYeoEHNvMrmmqWAvwu2+jOC5VyVgMZA1anTrLNx77RhU
        oC2dFukWkiI/OGicPN6PK28oZ4mIRmEPk3ML3+ZEKM96E67GJQv/aCFsy4POXhkz
        6ESq9II3F05rQ/ron8Oj0aNErpgDPQg3UPyOues+Ex0zGC8W6Bv1AXGCVV+M0Rcn
        925wz1FLd9O8RnlnTYMqxXwFHenwUUPVR1KJz9jaEXeRZFs84d62TIWBWIsJ0YTT
        gK6iR6U8KW+kYtL1cfxFlqo/MU9qimrI0BIGIjnPvvEPfUeHIm9dPY+5JtTPd15J
        JOfJF5QkhU9hUrAmnHpxXtun6cJ3g3pu19JmzHEzHA==
X-ME-Sender: <xms:kx3zY77mVL-ia_UTTPMfNQ0zR_01e25BM_yo2NQm3wjhkLRda2aGuQ>
    <xme:kx3zYw4Pk4GtN0917dJPFlxa53u45_Wx8KRgR7gdlPE49pKaGTOIZKWa5SzF0Ha6E
    arYIb22K7m9Qg>
X-ME-Received: <xmr:kx3zYydVbEcCI_49wrLPXN3SV52TbY_JgSXalDr_uir7jHMl4tiR_rUtCk7q9u4WBTDNvSY09tbY1_XvtQL4Oi-wk9mZ0Umkr9chpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejgedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:kx3zY8K3eFSlm7qlMjyVSEjk0OX8IDMSRYvGyqfXwoXbCmxvdADkow>
    <xmx:kx3zY_JNmktPg1-VwnPPbcPWk2lO_9YXVJqzjOsL8XYb19Gaji-Hlw>
    <xmx:kx3zY1w4uQqL1VQ9JNdH112z7KWWVgHIPaBA5Pz3F-oe-rUIBNr7QA>
    <xmx:lR3zY8BA2AhvZfHcuorORd7m4SfF9yvoyo-7Ijdfr-31lnW956HITQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Feb 2023 02:13:22 -0500 (EST)
Date:   Mon, 20 Feb 2023 08:13:19 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the driver-core tree
Message-ID: <Y/Mdj8q6jHugVSBn@kroah.com>
References: <20230220133847.11dacf2b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220133847.11dacf2b@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 01:38:47PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the pm and opp trees as a different commit
> (but the same patch):
> 
>   9f467f6375af ("OPP: fix error checking in opp_migrate_dentry()")
> 
> This is commit
> 
>   eca4c0eea534 ("OPP: fix error checking in opp_migrate_dentry()")
> 
> in the pm and opp trees.

Thanks for the note, this should be fine, I didn't realize it ended up
in the opp tree as well, sorry about that.

greg k-h
