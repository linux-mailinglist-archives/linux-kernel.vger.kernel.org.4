Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B708D6D6204
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbjDDNJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234864AbjDDNJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:09:08 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6A81BCB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 06:09:07 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B92A35C00DB;
        Tue,  4 Apr 2023 09:09:06 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 04 Apr 2023 09:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680613746; x=1680700146; bh=nl
        9pzHexPc+/Ir4DWYQvrErqSdf967oQaLPF8tI3qQM=; b=NJyq4gYRb7LCvMM71W
        7GCoOxhDiP45TcZcVXzkDWuiy0Jhqs3tf5o8Q7SvWZw1jEA+9M87DWxnSr2z+uZq
        +Wu8v17ykpaVjb9YQlGv82togjkFbOZ2OCeegEtLuMiCm8SpzdKesrgqZ0goBrPk
        38JzMotyT0XYfr25lsws6Szudbmj5CBdQSul2Qj/BXGd+j07MoT/J4mJJHsW4srW
        2icxfAGXnH6OCBBUMDlWz0AuZBz3l+VxbGjXL4GTPx+E6MsnW1HyLmWscP1iiMEU
        sP1IIs0qFLE6BKnDoRdfjChnmIu6fil1qatWQA1s/iLSmtQ3yGmXwLqt6WgzlzwS
        sVLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680613746; x=1680700146; bh=nl9pzHexPc+/I
        r4DWYQvrErqSdf967oQaLPF8tI3qQM=; b=deVOPiPTnvCWdtyQLuX916lrdqv+U
        Y4xwFKcWGGYkDUWFT5d4MDB/46zfENdw4mapptAhJXdbOepyD1Nc0TFmLHtDzt0n
        INtPHgx/9OHMn0TisBdup2ZeTnvjSoQztvNpEllFGGI3GPOzwU4DDcmvkpks0sG5
        nHgeL5hrcDrQ1Rz9rYitFdBGl6vn7kvU4So0ehr0eyuAc7EnnMJiDr5ScJzB5phl
        00VeI1bD8Ur8mA1pAdconLbBDuairEgtxHxqy7ASs6i8RetBsvbYWHa2LOdKxzNb
        HfFmMiUzcl3AIaOkIjOx7XtTzK4MeB3nYgv76UnrJ8A3058q5B3QS6ZAQ==
X-ME-Sender: <xms:cSEsZD4uMYmC0Qk2T9zuoogXpIEmYUOyVrvI6AhF_-QS5CB6u6RdWQ>
    <xme:cSEsZI6AmkbXiEG0I9EKEPR5biU2NiRWJz2YUH3ril-kZCX01hpE1OMajAPO3fZN1
    ntcJ9dNjQZPcC4yRQI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiledgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:cSEsZKeokH2HHPel3UnjXX6ojLAznw9Tg33GsSjx03V-JltSL0oY6Q>
    <xmx:cSEsZEJF9f6_i9808R14QCIX6hhPaJ3Y3KkUsMYPgrDCYFoSbPQmng>
    <xmx:cSEsZHKNwzvcjY0S2H_g_GDFmk33MGS9CISfHc0uGNqkZPJtvwOjYw>
    <xmx:ciEsZNhSP6WE9SRxZNrtT1KjnIcL6Sm7coVG3wRLHwu3n07g-7Guzw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BD0FCB60092; Tue,  4 Apr 2023 09:09:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <5a85b6db-f4c9-4cff-ab25-73fed75d6983@app.fastmail.com>
In-Reply-To: <87cc8d92-0345-bc4b-60e8-1ca016691371@kernel.org>
References: <20230404084259.13752-1-rogerq@kernel.org>
 <283f8f4c-9f8d-48b1-b161-3b712104583b@app.fastmail.com>
 <0ffa9690-9709-669c-b44d-dbb93446ec95@linaro.org>
 <076b5775-18eb-05b3-b803-c54420b3e5fe@kernel.org>
 <08b12571-5ca6-4e3d-8c56-5fc48827d17a@app.fastmail.com>
 <87cc8d92-0345-bc4b-60e8-1ca016691371@kernel.org>
Date:   Tue, 04 Apr 2023 15:08:45 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Roger Quadros" <rogerq@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Russell King" <linux@armlinux.org.uk>
Cc:     "Thinh Nguyen" <Thinh.Nguyen@synopsys.com>,
        "Nishanth Menon" <nm@ti.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Vignesh Raghavendra" <vigneshr@ti.com>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: make USB_DWC3 as a module instead of
 built-in
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023, at 14:59, Roger Quadros wrote:
> On 04/04/2023 15:14, Arnd Bergmann wrote:
>> On Tue, Apr 4, 2023, at 13:46, Roger Quadros wrote:
>> That seems really high, so I had a look at what's going on.
>
> It was based on the configuration we are using at TI.
>
> (as built-in)
>
> $ size vmlinux
>    text	   data	    bss	    dec	    hex	filename
> 14616949	5285870	 491776	20394595	1373263	vmlinux
> $ ls -l vmlinux
> -rwxrwxr-x 1 roger roger 120866544 Apr  4 15:54 vmlinux
>
> (as module)
>
> $ size vmlinux
>    text	   data	    bss	    dec	    hex	filename
> 14550571	5258106	 491776	20300453	135c2a5	vmlinux
> $ ls -l vmlinux
> -rwxrwxr-x 1 roger roger 120324528 Apr  4 15:52 vmlinux
>
>
> $ diff built-in-config module-config
> 5547c5547
> < CONFIG_USB_XHCI_PLATFORM=y
> ---
>> CONFIG_USB_XHCI_PLATFORM=m
> 5614c5614
> < CONFIG_USB_DWC3=y
> ---
>> CONFIG_USB_DWC3=m

Ok, so the size difference here is only 94KB, presumably
because have the non-TI variants as well as debugfs and/or
gadget mode disabled. For the file size, my guess is that
you have CONFIG_DEBUG_INFO enabled in your config, which
drastically increases the size of the vmlinux file, but
not the in-memory size, or the size of the stripped and
compressed zImage.

      Arnd
