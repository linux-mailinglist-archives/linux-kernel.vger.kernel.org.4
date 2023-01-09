Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EFA662AE1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbjAIQIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjAIQIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:08:36 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421623AAA1;
        Mon,  9 Jan 2023 08:08:34 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 2232E5C015E;
        Mon,  9 Jan 2023 11:08:31 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 09 Jan 2023 11:08:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1673280511; x=1673366911; bh=TZZ77fLWpT
        tcLAZ9nEjMfcH+q0g80s3N6e8tCHhqzS0=; b=jv3ZBT/DxpeWMWBXz6YGetGpuX
        LDxP5zQ6JM9CtbE45SZ6d4+qHYKRT0emu4ctm3J3w+oAe0FUU13eHGxGLLXSQn2R
        l2EGfdX8MFTwxZ/TIjgTJERERPeQ4s0/NL2g0vBGtG3UYRrrNeNVkbfnzm4PQd8o
        +8NyDIrZDsAHXpfTd6q18IY4FmcGNLOrZg4jGkLQNrFMBcTaiNIMjr2Ry9tA0u5i
        cJZHrKt4E1j53NeNZtd3z9PsT6RhpuWt2/dqYId/P0XrvBq5NPuz4+VmCn4L7g9b
        cUYEClc0DPyt5ZAONZmCOmYw7RJQFgxeMNisdkytCVaPLMKcPbRcAv0Umi/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673280511; x=1673366911; bh=TZZ77fLWpTtcLAZ9nEjMfcH+q0g8
        0s3N6e8tCHhqzS0=; b=sfaJgfW4GA9EQC8gmqiFyAINk99WqimzlZ1lidGvqyWl
        iUaywr8Y1Tnz0Ng3uR7y6QU4G0WrulR7Wf4jFPBpMBf3xLHo9VWpprTf/6Jn87td
        6gusOeJjVLdBjuZ5/W0YGMTqX/9H4VHuNAuHpPa2EV5g3le5AB0sldLUFDKxWr2O
        bKTJkzulx/u6uMh3+nbScQjZCDnB17jMHxop8qCvHggKMNUVrpe+FZrjmoiefLkQ
        zDPxDNBlaYSJXc0LNAZlVPxvToTmJ/yt5MeA/VD2Wqm123ReyASoUvgahuReoOtr
        wB5Gh/6JWiaPwokzDgO4ehbsuNY/yWfXiMOo0BxrGQ==
X-ME-Sender: <xms:_Tu8YzkUDxyqmIrMPF7ljEvu1Ov0EU2xyj4G3jX9U98a8A68Z-KpoQ>
    <xme:_Tu8Y23uGNl6C3iwTavdDKdg5HP4D-_mbts6K3XTXiL19T9XLGbiikHagc2JkRMT7
    LxJAWjpi_diywY5WCI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrkeeigdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:_Tu8Y5rKrx_1RTcG5YSg11b8hCTz2WDYZTsfmXMPCcd2V6E4y8X51Q>
    <xmx:_Tu8Y7kLuwShH7kdt8JF3l0jKeKysvqVTDYYeJgBDgdpV1hgoAEQMg>
    <xmx:_Tu8Yx34-4izFJuLSqT6m7Gbf2jG7V7f4vM__BnOJ1z1LvHNToxkxA>
    <xmx:_zu8Y_ALkcOAeRUDSbMd5PMZRv-4ihOfN9Lcx8Tw_XWJwfAZDwR3Yg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3D4A4B60086; Mon,  9 Jan 2023 11:08:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <56396c10-cbe2-4784-ba29-046fe6391609@app.fastmail.com>
In-Reply-To: <Y1eZY/WRA+WYeDhH@atomide.com>
References: <20221024153814.254652-1-arnd@kernel.org>
 <Y1eZY/WRA+WYeDhH@atomide.com>
Date:   Mon, 09 Jan 2023 17:08:08 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Tony Lindgren" <tony@atomide.com>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] ARM: omap2: assorted cleanups
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022, at 10:08, Tony Lindgren wrote:
> * Arnd Bergmann <arnd@kernel.org> [221024 15:29]:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> While going through the removal of board files on some other
>> platforms, I noticed a bit of outdated code on omap2+ that
>> was left behind after the platform became DT only.
>> 
>> I can put this into the same cleanup tree as the omap1 patches,
>> or you can merge these into your omap2 tree if there are likely
>> conflicts with other patches.
>
> Nice, looks good to me. A lot off stuff has moved to drivers
> over the years.
>
> As long as you have some immutable branch I can base patches on
> as needed please just go head and apply them to your branch:
>
> Acked-by: Tony Lindgren <tony@atomide.com>

I had this on top of the board removal series, which got
delayed past 6.2 but is ready now. I've just pushed this out to 

git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git omap/omap2-cleanup

and will merge this for 6.3 soon if you don't have any
final concerns.

      Arnd
