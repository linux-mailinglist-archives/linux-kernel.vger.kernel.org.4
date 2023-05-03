Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1B86F5673
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 12:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjECKn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 06:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjECKnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 06:43:24 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F82835A6;
        Wed,  3 May 2023 03:43:23 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id 15E712B0695A;
        Wed,  3 May 2023 06:43:21 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 03 May 2023 06:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683110600; x=1683117800; bh=m2
        b7jemaeDgVDN/yXM9EiMNoy1q6cv1GnASV/ZhZJOc=; b=WrlcuJSZCuIXk9sb1Q
        SpXXj5FyZRmxZuz1k8wKZV5++aVZGods0u4IsZKnp78HfY7/sgSBcYJrf1SjZ95o
        AbWmVDysL5tbVj0mv23iDyWu48jMlAQ3P7oKNvBhmLdYV+aA/ClRwyyhJnw9Osor
        Wp6KBCIET6wOTCgyzOtu43OWs9VyuSZntIJvxPB+uljtrIkduB7ZdrnRDkImSOl9
        NuiJwExj+KJBYmqeKjfnzZvTIgLXCw8dfuvZtKsGy5gwRIgu2g+Hh5cbBJD/fWqW
        2W1e67BSI2+jlGCI6RPTNOsGxwOIPVKQWcX3Dfu7VxUvgU2lBip0Xyd+nLyvKqJd
        I3Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683110600; x=1683117800; bh=m2b7jemaeDgVD
        N/yXM9EiMNoy1q6cv1GnASV/ZhZJOc=; b=FcKLcB5AhURyWSU9AeAkrNMWNPmzP
        RN7TT7leW/rr6wgT486DThSzmv16TT0ttqKjcwZW8P+nv8iOzx1CAgQ7qdduWzxQ
        /Gz/Tcw4EOx0qgSJzyfHZLyX0ySoPQeV4zdRo6+Z7HAc9vt4vJcmOsLPsWzJb3kx
        O5niH9wc2uX7N1BZ1hMWuN0sCvoccvWcuLRJ4WbAxdtfzL4iETLx0JZ/2DPV9EWa
        lREUL3KRPMFdQMUufxe+DGAVXX6ZA3hPEwaiCQ6pe4SSUvj3jssC8Snl0FUda3Dz
        8L+4gh+rEf9s51OzAITtqaE5LWEdTZhmO7S7JsLOaRXCvXsgolbFT92Kg==
X-ME-Sender: <xms:yDpSZPCqsf08zSuGB9S_Yyasjyfw8C7NFU4cOM__vE3LKtp5PZuGng>
    <xme:yDpSZFiEb6HH6H_58GlixH3G-nv3jp37AdKwTgdBGBFYH0DY8nzkEJ5mgat6Fv9LK
    KKIIOZPpYqGCV37HyY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvkedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:yDpSZKnB4jWJCZbdAILCLoQ7Tb1JDWaGOQ4QRvtfyLGkz3ZL_6SLDg>
    <xmx:yDpSZBy3OQb_c4T8ysdY1Cp9Lj863KLs0081WZpxCobqdPOlwPyYug>
    <xmx:yDpSZETjKdOdSUw3JxfayiFtx-J69d0-e3sxVxrEKYSU1TR-jv4gqw>
    <xmx:yDpSZAxATWHiqR3-vrO-mZXAs2G96Hf5p2LRUHruhuMW2qX03HsehI4wpP4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4B4C0B60086; Wed,  3 May 2023 06:43:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-386-g2404815117-fm-20230425.001-g24048151
Mime-Version: 1.0
Message-Id: <89dfb3e4-4009-4ed1-8cb0-d6ee16928caa@app.fastmail.com>
In-Reply-To: <20230503011920.GB31464@dragon>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain>
 <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
 <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com>
 <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
 <2783a3ba-8fcb-7e5f-3147-91d02e573ba4@kernel.org>
 <20230503011920.GB31464@dragon>
Date:   Wed, 03 May 2023 12:43:00 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Shawn Guo" <shawnguo@kernel.org>,
        "Krzysztof Kozlowski" <krzk@kernel.org>
Cc:     "Rob Herring" <robh+dt@kernel.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Olof Johansson" <olof@lixom.net>,
        "Christian Marangi" <ansuelsmth@gmail.com>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-sunxi@lists.linux.dev,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-aspeed@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        kernel@dh-electronics.com, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org,
        "linux-oxnas@groups.io" <linux-oxnas@groups.io>,
        linux-arm-msm@vger.kernel.org, linux-unisoc@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-realtek-soc@lists.infradead.org
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023, at 03:19, Shawn Guo wrote:
> On Tue, May 02, 2023 at 10:02:03PM +0200, Krzysztof Kozlowski wrote:
>> On 02/05/2023 21:40, Rob Herring wrote:
>> 
>> If I remember correctly, Vybrid are a bit closer to iMX than to LS
>> (Layerscape), but it should be Shawn's call (+Cc).
>
> I would suggest to have all Freescale/NXP platforms in a single
> directory, which includes all mxs, imx, fsl ones.

I'd go with 'nxp' for all of those then, and also include the lpc* ones.

It's fine to stay with historic names if changing it causes problems,
but if we are going to change anyway, then let's call it the current
owner's name. It will get messy again soon enough with the next round
of mergers and acquisitions.

      Arnd
