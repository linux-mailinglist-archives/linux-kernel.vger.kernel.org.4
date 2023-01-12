Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9741666DA9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239894AbjALJLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239940AbjALJKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:10:22 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D4D4E43E;
        Thu, 12 Jan 2023 01:06:08 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 964DB5C00EF;
        Thu, 12 Jan 2023 04:06:07 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 12 Jan 2023 04:06:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1673514367; x=1673600767; bh=i0Vf2i9x70
        fWXxPpRrZTCxU0nL+Gr6Pa34HbDF5NKhg=; b=YTjeuD4wKJ7HrtZWtHhsXNxsKq
        cNOVgLCCr48zVApp4I+dGidjpEwO52kI/8/OrHx57KOqKryuXjC5Oo9PxBtatKSC
        akFuo+LTIiOo2IOpWyEtd4McQR8bboOjcgNME7zFfOe6HqER4caPmWWjZ0rw8Aw+
        IsoBj0NCmu06X6oiESocaT4tjYVsbJ34o3YFpPKVXYGTyQZ+70G49533ENDbjEnH
        4lm6DTLz2fzScqMe3ccvk2HNwy7VFdCyfUYT8uU0mO9ZfsQksv9nW+rKRetDFfTG
        iDXVXWFp9SO7N/Sm2GSxYbg1WtoUZbByWlgBPQ1fyb75nEoldGrG8YTCrSaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673514367; x=1673600767; bh=i0Vf2i9x70fWXxPpRrZTCxU0nL+G
        r6Pa34HbDF5NKhg=; b=pm2NzmomMkR6Z3IEHZh5NgtTVo2jgipoBuDt//2h/AG5
        S+4jqrHNsbCYqk1f+BJk4M89mnBHUpQXfx+whFXWQWyNjnhmB8cUSv1rk0Q9t0SG
        wgq29B9BL9Meb7p9htR+vi9/xI510gtGWLS1jl3rU3GJMQ7qShSqkUi9NaTEGIPv
        xDJy1fyQZP/AahEnLBaTDR9zyeSql52rSVVZMeVffw21bsYhYQpqCOIR13HQcFvk
        0kKbo7v3yW8UVnov+KowhBPbbUSbqDc35UBhEe5SNb+109CLpIySP4lOSufu01P+
        Huw1fG7dFS41lGNxuZ6e7iyLxCDSnnTqLwFFr4vJ3w==
X-ME-Sender: <xms:f82_Y8rZObVjPMvCH-CvjESEUl2uHJqzkyZKi7F2iGL3XYXt6nVvtA>
    <xme:f82_YypTe13rIXZFEJIKbWBekxKT9GgOjt3z9NfnF4uA0VUxzoRWXNE87IaVxJmV2
    p8hrRb3s5Gl0pd79LY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrleehgdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:f82_YxN9UqinprXnHU1kvfphUuDyKIhuD2U8BqWCZx7u2KnwQ2vZlQ>
    <xmx:f82_Yz6_5dOaz3XKTO-tHclB4-cvIoTkrxVMn_dgva0BU9EqyLJyHg>
    <xmx:f82_Y77lD_AIrBduzpD3zz0-yQDpV2HLm8K7RNeC9Z_V-J7nvNzlKg>
    <xmx:f82_Y1vQNmbKVazZWrQ3ChoPEmDrxRRabaxg0_f1Y_WqB8xUU-d_bg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F26A7B60086; Thu, 12 Jan 2023 04:06:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <4d2f2b81-b7ab-4ad6-84cc-f3a3c932880d@app.fastmail.com>
In-Reply-To: <20230112083746.9551-3-lukas.bulwahn@gmail.com>
References: <20230112083746.9551-1-lukas.bulwahn@gmail.com>
 <20230112083746.9551-3-lukas.bulwahn@gmail.com>
Date:   Thu, 12 Jan 2023 10:05:47 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Lukas Bulwahn" <lukas.bulwahn@gmail.com>
Cc:     "Aaro Koskinen" <aaro.koskinen@iki.fi>,
        "Janusz Krzysztofik" <jmkrzyszt@gmail.com>,
        "Tony Lindgren" <tony@atomide.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] ARM: pxa: remove further dead code after pxa93 support removal
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

On Thu, Jan 12, 2023, at 09:37, Lukas Bulwahn wrote:
> Commit 150ccb6f9a89 ("ARM: pxa: remove pxa93x support") removes configs
> CPU_PXA930 and CPU_PXA935 and uses of cpu_is_pxa93x() and cpu_is_pxa935().
>
> Remove some further dead code in ./include/linux/soc/pxa/cpu.h on top of
> that commit above.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

I had this in an earlier version and ended up leaving this bit in
when I reworked the series to not drop support for PXA310 and PXA320.

You are probably right that we should not reference the removed
Kconfig symbols, but I see that this causes a regression
unless I also bring back the change to

drivers/mmc/host/pxamci.c:                              || cpu_is_pxa935())

    Arnd
