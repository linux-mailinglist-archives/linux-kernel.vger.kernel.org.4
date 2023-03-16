Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C216E6BD29B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjCPOo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCPOo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:44:26 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C942D15566;
        Thu, 16 Mar 2023 07:44:24 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 3F3195C00DD;
        Thu, 16 Mar 2023 10:44:24 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 16 Mar 2023 10:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678977864; x=1679064264; bh=lN
        HiUop2duty04Hs1IhDp2V9CWKLAvzuo8xtH3K/m4E=; b=Jo4HzIW3VinYSAtEQN
        b0LVtuA5dAWWEz9b4IRmCu6FUdmgCc6fmX4HgLPtD9dwpDQqX9yMXYCZVaS+YVWr
        v3DMeo7DMFNjPpiDgukp+QpxLCaHqevZBcDVXGYlisF6qIjda180UkQx2pH8z4Mk
        7bREmchtVfabi5Fn55qmIELyItv+VY5PH4R/KbJnHbfQ9LrJ+onwcZP+3qq+RzpO
        N7+MZYLy4ed9IJDLkssWBnhigPXmrIJOCIDb/LJPS+aajkp2aeUj7YLdjn7O3WbI
        bFcdrpchyuFQnoapGu+e/BxnvK6ZQRRhpH/jQSk4n1L933paRclqTN2tHO2SUvuL
        fcag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678977864; x=1679064264; bh=lNHiUop2duty0
        4Hs1IhDp2V9CWKLAvzuo8xtH3K/m4E=; b=M7tzRWi7bGJClvV94YgQn7KXb1cm7
        GnzDvPNdNDDDhGb4Eino3/o65cLWuRB4J+94f8QDlCLELBtV08exeXuMrqL8lpk7
        mhPG92fv7wNT3YVlBDjSDYGtwczFgABTtBN7ZY320b0xq+7CzO9q9iUU7RmEESTB
        fTLuAJZPNrnmK+ewFDMlOvtL3eJ7ICB/qpRiy3Wih7cpJNl2YJe54wXYshRnnJUo
        4AN7PrsyXUjtvpvHYYhA6RcX8ZzkkE95DtPGE62af628tYAWw2QXeXeSBD8LDjNF
        j2gY1ikZy4Fp0CMxSnCYelEm8Ogs9xGhF8N98Z1PQyADlL/OPOQXHNdbw==
X-ME-Sender: <xms:RysTZFeWPbpS_ilMGdpFmfOk7aR4j9mBWM8h_hmBBBVhf1NeqbdlBQ>
    <xme:RysTZDNJdfPJCKOuF_zMzIG_4PVKcQxCmhLg894n8SAC4d2bt0K-lYsaItY6SihyS
    nUzX7icE1tYfQK1Fig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeftddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:RysTZOhUGLVJs7XQeyesBf5V08Q_XHpcORQzrGsDiGYOox6aqJrruA>
    <xmx:RysTZO8CaLJsl1VMBf7VDSLvQRJIqyYLS6a_AmC8NUcsgqhDJMfoVg>
    <xmx:RysTZBu-g5v-rzx_mPObIsjyO_qqPCWoIHKy8PLkAyfGrcJu0l_L5A>
    <xmx:SCsTZKG6kcYe4SFbDdU8Uow8qw_MfsssFueHjjUQjerrgkrzJJdX2A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B692EB60086; Thu, 16 Mar 2023 10:44:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <fa966844-2750-4951-9a40-ecc2653aab77@app.fastmail.com>
In-Reply-To: <20230315072902.9298-4-ychuang570808@gmail.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-4-ychuang570808@gmail.com>
Date:   Thu, 16 Mar 2023 15:44:04 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jacky Huang" <ychuang570808@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, "Lee Jones" <lee@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, "Jacky Huang" <ychuang3@nuvoton.com>
Subject: Re: [PATCH 03/15] mfd: Add the header file of Nuvoton ma35d1 system manager
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023, at 08:28, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
>
> The system manager is a set of registers used for power control,
> multi-function pin control, USB phy control, IP reset, and other
> miscellaneous controls. It also contains some registers that
> provide SoC information and status.
>
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  include/linux/mfd/ma35d1-sys.h | 95 ++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 include/linux/mfd/ma35d1-sys.h
>
> diff --git a/include/linux/mfd/ma35d1-sys.h b/include/linux/mfd/ma35d1-sys.h
> new file mode 100644
> index 000000000000..dcd85231125d
> --- /dev/null
> +++ b/include/linux/mfd/ma35d1-sys.h

> +
> +#define REG_SYS_PDID		(0x000) /* Product and Device Identifier */
> +#define REG_SYS_PWRONOTP	(0x004) /* Power-on Setting OTP Source */
> +#define REG_SYS_PWRONPIN	(0x008) /* Power-on Setting Pin Source */
> +#define REG_SYS_RSTSTS		(0x010) /* Reset Source Active Status */
...

It is a bit odd to have a header file in include/linux/mfd/
but only have the register numbers in there, and not an
actual drivers/mfd/ driver to go along with them.

I think what we often do is to just list the individual register
numbers in the drivers that need them and not have the central
header at all. On the other hand, I can see it's useful to
have this documented in one place, and we clearly don't want
to add a driver if none is needed.

Maybe Lee has a suggestion for how he'd like to handle this.

> +void ma35d1_reg_lock(void);
> +void ma35d1_reg_unlock(void);

These look like they were left over from an earlier version
of the code. Since you use the regmap framework, I think this
will take care of the locking for you.

       Arnd
