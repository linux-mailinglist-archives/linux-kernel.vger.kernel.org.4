Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7265B8AC4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiINOh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiINOhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:37:11 -0400
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C822A952;
        Wed, 14 Sep 2022 07:37:10 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 129872B05FE9;
        Wed, 14 Sep 2022 10:37:07 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 14 Sep 2022 10:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663166227; x=1663169827; bh=xJl2LAcb7s
        EtYyZZirpB40eXZ6TcEV285ewHbMiGHJI=; b=piWbBs9PPgYGh2Yd6lS9tc7WwI
        XNL1rCYm241QYhVaH2WfS739Ogdhc859b7MBJzm2MzFQjJauJDpFUvI6gZ/af88R
        3TYMurTzQbH0NqT2+tW41r/+Q1hZBy0TPr25tz8ma9zJK/vYMNz2+s0ea40gBTYg
        kpa3O4Zv0fA1nHKBPECgREefHvoQG5/4/sMhCnxa+cNP87+uWISUU30e99D4K6B5
        8BWE1416bw0mXAMMy1uVblm+oQPiy2cNHVuOebpZz3o0D4/RMYSKHywDX3Hh9yRV
        Y0tGZ4iwIHGomC/BdoYLBn+R3SzendrxzbM6fKNea92uqrC2fn3pksvieCOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663166227; x=1663169827; bh=xJl2LAcb7sEtYyZZirpB40eXZ6Tc
        EV285ewHbMiGHJI=; b=gMG/aBa+oGgQjd+/ok4dy4gyBSqRAbQywHM1kORil8sQ
        eDACTZ1OCszT3/FUxg8llfRZypl7mT5kw8sIBhOdao0bJS1iXmaLdpWDsXQEutIJ
        F+3HN43kBbBOjiU5hXvnVN3XI/kMZNiNeKoXAyaD4B4PXlWGscbXzJBDZX2ZJm86
        YW1tPlSiVhbGVgky4GsmqSmdHIKeJU4v277tE9GzPENbS4kFqIhLDDzyKr8zTHw1
        l7o1qqw4M//ocJYxIJCm6E1kGfm1df/X4gvYG8ra6Tp7Z5WfxpA4dSRb1YP5iVfR
        1mIvZLnC0PSeqbFLut9hP0ULJGKbR3lvt2sXfOmZdA==
X-ME-Sender: <xms:EuchY9MaMcssPsEd1xci-FuxgQVod6czzH3xtY2cN0eyfN6g0Cwobg>
    <xme:EuchY_8ZfJ53snt4OaYZp__pFEniwGN0_gaSDqo2ctUu4swari2FU-GUsplNzV5ev
    IVBHQfarlJSudlIkJY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeduiedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:EuchY8SDpgqo2AZCZ91WrWHvYzrCapaW6Vfved99dfMLEevEsJ0OnA>
    <xmx:EuchY5ue29jLwFVKDIFDnM2X3Y_oDQut4qg0M7EFaTO0e8wdiMVhsA>
    <xmx:EuchY1eOKYPyfcSgSopOIA3YweuvyRS5XfzlOHvnOYhDKWw-Au6HYA>
    <xmx:E-chYwstl8IEIdpA5qVBh1eDzjjyYVa4A3SxXRaSToptA2qF1lrbkW2TxoY>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CC81DB60086; Wed, 14 Sep 2022 10:37:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-934-g6274855a4c-fm-20220913.002-g6274855a
Mime-Version: 1.0
Message-Id: <78651e07-6b3e-4243-8e1f-fcd1dfb3ffe1@www.fastmail.com>
In-Reply-To: <20220914142944.576482-2-manjunatha.venkatesh@nxp.com>
References: <20220914142944.576482-1-manjunatha.venkatesh@nxp.com>
 <20220914142944.576482-2-manjunatha.venkatesh@nxp.com>
Date:   Wed, 14 Sep 2022 16:36:46 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Manjunatha Venkatesh" <manjunatha.venkatesh@nxp.com>,
        linux-kernel@vger.kernel.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Will Deacon" <will@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
        robh+dt@kernel.org
Cc:     mb@lightnvm.io, ckeepax@opensource.cirrus.com, arnd@arndb.d,
        mst@redhat.com, javier@javigon.com, mikelley@microsoft.com,
        jasowang@redhat.com, sunilmut@microsoft.com,
        bjorn.andersson@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, ashish.deshpande@nxp.com,
        rvmanjumce@gmail.com
Subject: Re: [PATCH v5 1/2] dt-bindings: uwb: Device tree information for Nxp SR1XX
 SOCs
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022, at 4:29 PM, Manjunatha Venkatesh wrote:
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,sr1xx
> +

You should not have wildcard names in the compatible string.
Make this a specific model number without 'xx', and
have the devices list their own name along with the oldest
one they are compatible with.

     Arnd
