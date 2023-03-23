Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0204A6C721F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 22:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjCWVHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 17:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCWVHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 17:07:51 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F423122CAB;
        Thu, 23 Mar 2023 14:07:49 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 12B373200928;
        Thu, 23 Mar 2023 17:07:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 23 Mar 2023 17:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1679605665; x=1679692065; bh=LXh8RcHlRytWdP5giYX5SGps2z/loe7CAU6
        6Co3XisY=; b=XQhz4LBIVZPTu92lzWNdTkm4qB9wdOsltzzZLdkPOoLlT6yYGHc
        XN+a5SM0Ihkz/5bLUHj/Orxabp2j/sV+kZH6+YdVRSJ/TB3nsiDih/6LGXOJyIut
        scSWSFuqnoAUiPGYM4GF8f5cOI3q7DvJI+n3hz4UpqfXqnCO9Z5FEI9hGxPvjHXw
        8RLhgGA9j8VwdrsvctXuQVLQi6l6NnYDqvTuAJAASSUanS0+7NT6pdPMt/D3pTbO
        IyYPK34bdbsOl0HeQFBFDzpNXH4uWPj9PuDRhce1dAPFcr0uZAbzn0LMClpfqIHZ
        n9ysRHghK6cMsQpUHYrzK1NfkDaotsHGVuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679605665; x=1679692065; bh=LXh8RcHlRytWdP5giYX5SGps2z/loe7CAU6
        6Co3XisY=; b=cpEQNvbE5hLlP++gVezAgQEgbsiuhx6dRxwW7PKr83NBB+M7pFV
        eWwmjkCMKqOuE6V0mkV4PZXhwwNBLMfSbiMGZgSvLl7Wx4Ek1yh2KGfMfvc6lgcu
        uza5xL4ZO0rb163/9UcZyhpaTHdM8mseUgFh4TLEDrwqFQH0jjNRcfgwiRpg4Kwf
        nFOEoI0fBXH8AmU8zaJvZfvA1Qa74h449BuBqH/sBi78tg5yJzS1tSG1FHq0xzyK
        oGXMGWr7CS3ZbUYBsBoRUtl/sDmiVrAl+jn54xCxRVNsjHrirMX9ls/IM1cYGBlw
        lhYHb+J+YgWbG/kuaHG+0DGtBsa1c+0hBmw==
X-ME-Sender: <xms:oL8cZN0DgW3OLroYtCxDwFYqR7FHjzuYwiKht8HgHLPt4iSzaR4Ucw>
    <xme:oL8cZEFPGQclA8D3sCjgsO36VS_L7VmSCKBos1QIQYSiIIJKeezmqrqD0z8qLMUZ4
    MWdTgQ-R8YdU5ADIAc>
X-ME-Received: <xmr:oL8cZN58RyjaUsF1u28KDWgrDi66e2-wg8EW4H5jF0MBq7igueVmfuRoGYZiElOEAz2D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeggedgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpegtggfuhfgjffevgffkfhfvofesthhqmhdthhdtjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpedutdejffetteefkeejieehfeeuieeguedtveeijeeviefh
    ffelvdfgudeihfdvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:oL8cZK0KK0apa41-Seog06lFkBh2mBy9jsHVnabkuaNzgqKbl_8_IQ>
    <xmx:oL8cZAG-qqU2-r1ZYwACu7bNCoumI1Ha6e0XWnQ5zoKsdDYXtHa1-Q>
    <xmx:oL8cZL9oOnha_c0iuCXL5YPwF-QLzMrQSR5RnR8eXNTrXPAa5PyIXw>
    <xmx:ob8cZI_SsG43gGf1L1mme11VE_CPTfEGk5dB_B0LoRHR7VXurq9SqA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 17:07:42 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH v3 0/4] Use dma_default_coherent for devicetree default
 coherency
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20230323072944.GA18524@lst.de>
Date:   Thu, 23 Mar 2023 21:07:31 +0000
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        Rob Herring <robh+dt@kernel.org>, m.szyprowski@samsung.com,
        Robin Murphy <robin.murphy@arm.com>,
        linux-riscv@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <60D7FE31-D708-4495-949F-3F64DDC11377@flygoat.com>
References: <20230321110813.26808-1-jiaxun.yang@flygoat.com>
 <20230323072944.GA18524@lst.de>
To:     Christoph Hellwig <hch@lst.de>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B43=E6=9C=8823=E6=97=A5 07:29=EF=BC=8CChristoph Hellwig =
<hch@lst.de> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> The series looks fine to me.  How should we merge it?

Perhaps go through dma-mapping tree?

Thanks
- Jiaxun


