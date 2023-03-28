Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992C16CC011
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjC1NDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjC1NC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:02:58 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55ABD1BDC;
        Tue, 28 Mar 2023 06:02:30 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2497E5C0068;
        Tue, 28 Mar 2023 09:02:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 28 Mar 2023 09:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1680008547; x=1680094947; bh=RgfOcRz7Y9eemhhj/K9vB90mPZhFUINw5BF
        WLJTEWvg=; b=XT1bkKRGOh2E/x5JAYAuMLyNiDnIUuvpodvt5driju1aWi80oeN
        mPc0FqqTR2bqYsXBLvTzWR/01JPImuxllDpvWUHmHHbK6ccdBe4cs1pCTptd/4C6
        Cai74nhcYmf7d1MGKvueVSauZ1D5LyaEREBsyJy5pKdN0Mv5h1LHjHc3JZKMyOs/
        1OpH4tfi2KLvjPWyOjiTrRyGnabyS1zzk1qo/3H8c9l6Yc8QNYdFbHLxP/JIH0Xg
        fjAB+m3OG1Cy4jAsWMBQ3j/3LpGA2tH7LYxwDPG1Pw1E9S54FBLwr+VN/qhb1QzY
        43YM4j4NrQTCpmO+XA4Ho2pHKstjkg9QQgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680008547; x=1680094947; bh=RgfOcRz7Y9eemhhj/K9vB90mPZhFUINw5BF
        WLJTEWvg=; b=Ng4ehF7ju2al1N83yAu1TPFPrqY8x8L44K+/SjGec6oyQfK57hp
        BAOLQ0pPp1sE0oealjiVsj/Gou+YqDkaT9UZJ0SJGpnQgfQ52iI5RmKL4CRneZL1
        KTyarNnWIpXVVAJAGXpQNJSmXJUCcQcc9JCfKpzU5YrBxqFR2fA0lMCzDxUuDSyb
        yMjn2VwXBQDc9MZGRqLd+eFg/8cWcSRjr5aTECiN1I58+CT4zNKyFfwecDrrcu5k
        L+WZ4ejxgDmPFJyqtcbqQ45pQxwzAlUUwZw9gbdGcpX952vig83kp8ddce4W0/Z0
        c9EnQ7uUQOH2mRigkfDEIr1RrR9M0Ghg4Pg==
X-ME-Sender: <xms:YeUiZDu9OG480fT8HAXyiUJiwyAATFHVvxjH3VB-CAFjpZ5PMUZpHA>
    <xme:YeUiZEewhcybDReytqiXw6s8ezwnOSY7ApkZ9Edsx7gI-RH7AsBnrVtohaavhR7oP
    E_iA20oDhTblJazl-k>
X-ME-Received: <xmr:YeUiZGwwIDzGdySRBP3SKo_ItGOA5wjfWoYSHxwydHxCBqvOupm3j-ybPCDBmS-YbuLO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehgedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepuddtjeffteetfeekjeeiheefueeigeeutdevieejveeihfff
    ledvgfduiefhvddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:YeUiZCMSqRV3eaooG1vh72OUOb3OZZBs1PGMZo9g9r4L0XtLzOst5w>
    <xmx:YeUiZD_vz22qEpX_9pGKYk4PlQSqSh6Tt5h8OlIYeOoF7aFlfvvDvg>
    <xmx:YeUiZCUUdkNhGjeBz3hWAHzJA5R__gsxJcWyeg1v1L7QnBsYIekjdw>
    <xmx:Y-UiZGXDEOYvSE_eKUnGgZOtc9OvLtb-xcYXbTgnhv2pd44pm-_4lw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Mar 2023 09:02:23 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH v3 0/4] Use dma_default_coherent for devicetree default
 coherency
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20230328074511.GA6188@alpha.franken.de>
Date:   Tue, 28 Mar 2023 14:02:12 +0100
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        Rob Herring <robh+dt@kernel.org>, m.szyprowski@samsung.com,
        Robin Murphy <robin.murphy@arm.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        frowand.list@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <9CCE7638-91FE-4B1F-9EAC-17362C041CE9@flygoat.com>
References: <20230321110813.26808-1-jiaxun.yang@flygoat.com>
 <20230323072944.GA18524@lst.de>
 <60D7FE31-D708-4495-949F-3F64DDC11377@flygoat.com>
 <20230323213930.GA7730@lst.de>
 <CB41D3AF-20F6-42F3-9168-C0D6E716431A@flygoat.com>
 <20230328011812.GA21977@lst.de> <20230328074511.GA6188@alpha.franken.de>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B43=E6=9C=8828=E6=97=A5 08:45=EF=BC=8CThomas Bogendoerfer =
<tsbogend@alpha.franken.de> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Tue, Mar 28, 2023 at 03:18:12AM +0200, Christoph Hellwig wrote:
>> On Fri, Mar 24, 2023 at 09:17:38AM +0000, Jiaxun Yang wrote:
>>>>=20
>>>> Is patch a 6.3 candidate or should all of it go into 6.4?
>>>=20
>>> Please leave it for 6.4, as corresponding MIPS arch part will be a =
part of 6.4.
>>=20
>> Ok.  I'll really need review from the MIPS and drivers/of/ =
maintainers,
>> through.

+cc devicetree foks.

>=20
> I don't see any MIPS changes in the series besides the ifdef =
CONFIG_MIPS
> part in patch 1, which gets removed again in patch 4 (chance to drop
> that completely ?).

It was suggested by DMA folks to have that patch.

> I've merged the corresponding MIPS patches into mips-next last week.

Thanks
- Jiaxun

>=20
> Thomas.
>=20
> --=20
> Crap can work. Given enough thrust pigs will fly, but it's not =
necessarily a
> good idea.                                                [ RFC1925, =
2.3 ]

