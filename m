Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7FC675473
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjATM3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjATM3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:29:41 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96595AA7F7;
        Fri, 20 Jan 2023 04:29:39 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 4E16B32007F1;
        Fri, 20 Jan 2023 07:29:35 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 20 Jan 2023 07:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674217774; x=1674304174; bh=T7pXkt1im0
        XkgrRF7s8ug2WaTIjQhbFut8+JpcuyoNU=; b=rux4CAb4H6VEAOuKVya4Y9UqMg
        BOBFVAHKYqkNOzJDynMNzhUSHRE1HqJeJCz0Slqyfgq198hMGQOzGdRT3DxT6Xc7
        Nx0CumAqQFrWfyB0bXBU5Vfqj+LBmNG+8QFI9e//9Cn469sF+dubbdoe54C8NMEd
        LeO7d8VusS2P4/wTaRrYBcNJTwYrpV89skgIONCUE4kwJ3LStM3TI3Pk004vhK5J
        ht1CzQOrORrhngvnFA9P8//1xp9Ge3pQQcVBkDkguTxAYHmY1UciDtNEJvGFetnm
        m7sbCIevPrJ4eF/tQPR/5CCeQsc+sZuKLquCF1V+dAXYlzAxv3IuDZlcwhMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674217774; x=1674304174; bh=T7pXkt1im0XkgrRF7s8ug2WaTIjQ
        hbFut8+JpcuyoNU=; b=sNkbFT267yRDW9bP+T+i+ckNdAcxUHgwzJBehoZUOqGq
        8aZla/P6mORJB3xaWxhMrN9VIamPtRWGZmSFSEIlLtTRGorcK4ewLZbZ5K3eEzIV
        3fTcUOKQ5dOit4cCrlUuorDWTYWP9Cs+p4IFqHkkZmhoqzwwjIe93MkWJEdzBer2
        60d7V8EnTmdDopW4MdZlF/EHKdEPULiBGovr2f/oQ4S65RzVhPOV/pxkyjaQpjIJ
        R8K8s4xwGvpDmQ7yvrBOk8Jk/oNPQ74akUEBwTKIEFh5eXYOXGqLg/5eQJTgguwb
        dli3bXcJx3EYDgSsURWgvWnzlUsL8QxXg+L0PNZdUw==
X-ME-Sender: <xms:LYnKY2TKEF3GHUWc4BWosOGUu7U_HTsIxYOarmm9sgjZRKmal0ZCnw>
    <xme:LYnKY7wgIkpUs01AVxd__e6iFQT1Au4yiiK3M-mO41VY1z3aoQtQpK1ejsi_5HHzj
    sXowEuuoJe9TElhpvY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudduvddggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:LonKYz0woWZD93l9h2XtQvnhbEC_CViAEOxH_HIgzLqMNgZL86NN8Q>
    <xmx:LonKYyDEFyczK02lHcLJXAdFQz9yt61hp9l6Q6AjfPgBxItVgnuPtw>
    <xmx:LonKY_gFF8nPjA2Lg6LhCCi7B9qvb0koAwloZGV42dY5P-a1B1f_Zw>
    <xmx:LonKY0YGq4Gum6EUr0JDNjAG6NlVvArXj4FT3L2S8FXkeIWoO7KIug>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E0639B60089; Fri, 20 Jan 2023 07:29:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <e70c12d1-84e8-40ff-8ee5-075960497305@app.fastmail.com>
In-Reply-To: <Y8qECf4CgsNkLNho@sirena.org.uk>
References: <20230118161110.521504-1-arnd@kernel.org>
 <Y8l21Kb42l2ZcIC+@sirena.org.uk>
 <99519eb0-399d-4972-ae09-955a34830b55@app.fastmail.com>
 <Y8qECf4CgsNkLNho@sirena.org.uk>
Date:   Fri, 20 Jan 2023 13:29:13 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Mark Brown" <broonie@kernel.org>
Cc:     "Arnd Bergmann" <arnd@kernel.org>,
        "Sylwester Nawrocki" <s.nawrocki@samsung.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Alim Akhtar" <alim.akhtar@samsung.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        "Charles Keepax" <ckeepax@opensource.cirrus.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/5] ASoC: samsung: remove DMA filter function and data
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023, at 13:07, Mark Brown wrote:
> On Fri, Jan 20, 2023 at 10:05:59AM +0100, Arnd Bergmann wrote:
>
>> I see, this patch still depends on the s3c24xx removal, which
>> is in soc/for-next and I used for testing. I see a similar
>> problem with the MMP platform in patch 2/5. The series here
>> is mostly older patches I did a while ago and rebased on top
>> of the boardfile removal, but it breaks when it gets applied
>> first.
>
>> Unless there is anything in here that you really want to apply
>> for 6.3, lets drop all five for now, and I'll resend it
>> after the dust has settled on the boardfile removal.
>
> I'd left the ux500 stuff running through my testing, no
> particular urgency just it saves rereviewing anything.  Assuming
> it's fine (seems so thus far) I'll push it out.

Yes, sounds good to me, I don't see any risk of missed
dependencies for that.

       Arnd
