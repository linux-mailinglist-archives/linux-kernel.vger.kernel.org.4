Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D162F7095D3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 13:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjESLDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 07:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjESLDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 07:03:38 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9FF19A2;
        Fri, 19 May 2023 04:03:12 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D343A5C00E3;
        Fri, 19 May 2023 07:02:56 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 19 May 2023 07:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1684494176; x=1684580576; bh=gV73rdtQgxipqFYPyr3Q/D+7HTlx1vCuwWY
        Zk9rvHV0=; b=cHyg654mmAsroWePFnZ4kSZFalqsGFUxLofrdI2FilESWopT1gF
        9WDo3dFq+m1KF0E8Cn9aitPx9WUpDVN81x9kAXAKqKyVz2Mbx0mBxDd1uAJlGNWN
        X1exX1FSeo3eqYNWnw/VYtsUi/hYXApTZjKMTelAdYPxoldKg97AD3OMexQO+CX/
        ovxURSu7yXoPeQmh6zvxmuE2YUcK+enznzzjudTOpe+zWEOwc2F7CsnUDTpvqeJa
        MW7+wSbFZ0IoWm6ALbf33tJQYpd/sDhs9Zwe+lCXLF3wI5BHxRQLaUhrB2v5KyL/
        2++FHFYrxtWY173DXSPXEOJoUk/kkrxLdSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684494176; x=1684580576; bh=gV73rdtQgxipqFYPyr3Q/D+7HTlx1vCuwWY
        Zk9rvHV0=; b=ar8m4LrRthd6WGP71fd/XRn6S0kUGl+1IKGZ9kFDGlbl+IJpExg
        w51qsJwcarK2nosxYsFe1r2W1BprUsvUftc8bB4PNuvpChqCUpvjI/9bUp3A2J9K
        8SRi7xXoRPhaBuxqmcVh8A9rYIq9TnYnHDconSLB8Sys/zwbGDIyT7gNA9rqTVpd
        HSwUHJNQsTgBO/kH9cWyvt2GvvVyYB6kc+zoHlC8w8gUl6ytpK95+rsZjtdsSm0c
        etUPqLda/TS7Js9NCFce8Cv+VX3TD7Vh0LHIzX+/LYCWT3A/D7IZTAqbVdbtYru+
        YndQqJECqnX5TYrLU4iEGQ6rgLGqjNOZxrA==
X-ME-Sender: <xms:XldnZGmSsdjYFrdAmDUF_egWsB5Ix4xTX2zZNbPMxYdje0KfgI2NJA>
    <xme:XldnZN3I5xtCZ5Z7W8MHJX_QkGFstAGSJazP94JUB1fSCb0BDr5fNnnMoY3aS7iAG
    _g2WEpa9CkrGdJKylc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeihedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:XldnZEpsQ-lwiW8sq8jV0ndfTGWpQTavssQ8RIj6aTQRdsOd7SBmjQ>
    <xmx:XldnZKkDGyrajy25oCrceVR0m0gL9mXTv9btSFFVMD_NA9qZ9FheWg>
    <xmx:XldnZE0p2ly206V0K_-_EfCtc5SStU6s_ty6kSyDLz0utv9DhHtODg>
    <xmx:YFdnZF65EvsJldBBS3b8yrM0B-ENKp_u5YodP-WIbzSvz6Fs921SCQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 66707B60086; Fri, 19 May 2023 07:02:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <f7edea0c-dbfe-4c16-8134-0656411a837d@app.fastmail.com>
In-Reply-To: <0ee8a26205a041cab9a787ec29201a9f@realtek.com>
References: <20230519045825.28369-1-stanley_chang@realtek.com>
 <20230519045825.28369-2-stanley_chang@realtek.com>
 <0d165c7efbb71a65803abddc364e1c5252b8b939.camel@crapouillou.net>
 <0ee8a26205a041cab9a787ec29201a9f@realtek.com>
Date:   Fri, 19 May 2023 13:01:34 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Stanley Chang" <stanley_chang@realtek.com>,
        "Paul Cercueil" <paul@crapouillou.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     "Vinod Koul" <vkoul@kernel.org>,
        "Kishon Vijay Abraham I" <kishon@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        "Ray Chi" <raychi@google.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Eugeniu Rosca" <erosca@de.adit-jv.com>,
        "Michael Grzeschik" <m.grzeschik@pengutronix.de>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        "Flavio Suligoi" <f.suligoi@asem.it>,
        "Mathias Nyman" <mathias.nyman@linux.intel.com>,
        "Bhuvanesh Surachari" <Bhuvanesh_Surachari@mentor.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] usb: phy: Add driver for the Realtek SoC USB 2.0/3.0 PHY
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023, at 12:58, Stanley Chang[=E6=98=8C=E8=82=B2=E5=BE=B7=
] wrote:
>>=20
>> I'm pretty sure that drivers/usb/phy/ is deprecated now...
>>=20
>> New drivers should be written for the generic PHY subsystem in
>> drivers/phy/.

Indeed, I missed that in my review.

> Thanks for your reminder.
> Will drivers/usb/phy be removed?
> Is it not allowed to add new drivers?
>
> In our application, driver/phy is not suitable.
> We need to notify the phy driver when the USB hub port status changes.
> However, generic PHY drivers are designed for various device's PHY.
> And it seems inappropriate to add this function. So we choose to use=20
> driver/usb/phy.=20

If you run into something that works in the old usbphy layer
but can't be done in drivers/phy, I think the better solution
would be to change the drivers/phy/ code to add this.

      Arnd
