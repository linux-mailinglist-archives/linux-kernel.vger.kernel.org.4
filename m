Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FE165D54E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjADOPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235012AbjADOPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:15:39 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1198112ADB;
        Wed,  4 Jan 2023 06:15:37 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id BA7705C01B4;
        Wed,  4 Jan 2023 09:15:34 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 04 Jan 2023 09:15:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1672841734; x=1672928134; bh=Fn1aQEXTry
        mHnWymQOrd0h3tQi3NafhSd3arLPnzkI0=; b=Ks0nnbzchE3a9MdHfWdff6SGhT
        NNuBTQkbbQRk856PiUGuPtTPXOO4EWiG2eLnky1Fe83iKhf5isWyYaj6dL95goYM
        +cMT8kgsxV2X9wzhwbMjbpXYYnADB0Ol7YrgEl3+n/OK9EdNeoEDZuej8IMQYMHe
        jaQGPPpDyFLtK4t5NieoJ5z90fkE+rUvIZRvI+uLNHX5DIZGgDrdtdrBloqulWvN
        zXAVIAu1UmHxqJKJDtF3oUYSo5q6IXcgpxWdmWaEr3FUJfyviBNZAVsmCUyiF0Zd
        CK5frI7p3SK9N9d0R9Td3ss6wAzSYMbPCbmDU4cETX+HKVPGR95SmJKPSuCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672841734; x=1672928134; bh=Fn1aQEXTrymHnWymQOrd0h3tQi3N
        afhSd3arLPnzkI0=; b=PfJJY7BdjE9XKomOO3FAguSwAJbsoxpOtteKA2AH9GCe
        di2SCn+pfmmZUfFL1RmJI0QtizGbuFnUVPmYzAc5KzNv/V+inA0isBcm420qg8eq
        z/SkxKiiNUe4LvBFGswlgp+tnPUxgzGw3x8+jU31+R18HOAGXgR5Ko/W9XLGX+eI
        /+VELJWfmf1fq/oQgk7yV2h6pY0f+xPJa14KNzKpVSGm/Dhrw3QhF9k3ghX+zJsf
        dGMIsAP9x8tIdYkChPUSDdufb2TjTSNzoRYzsW/vzqneWxok8gjC/lV9Zdn/RDID
        ngy7cN9Vmb0CTKHnGPe66J0dSyIESH+0NAmRnCEI8A==
X-ME-Sender: <xms:BYq1Y2YD9LaCyi7RpUrZlAjmlLUDlXKWz-coGihwz7dT58cbTP29-g>
    <xme:BYq1Y5Yy8f7exDo1k5sgaomeRmh2af6NHR3eOOmryQJcO1uZNS3WYMi8PNhkcUUx2
    Xfyfa9cn2Q7g09dXzE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeeigdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:BYq1Yw-mze03m1sJLe9G-8FhVbq1AUQK0F1vB5yNhoSvwQi0PQKrCA>
    <xmx:BYq1Y4qaeGBFCh7Qv7qiiZX0cTDdkDURjAaqDkUl7n2X2tL964mu9A>
    <xmx:BYq1YxqNrc3pbSXTNVpRj35tKeq1zjwvLxV_ED0Cg-KGuEHIPuUF1w>
    <xmx:Boq1Y3gt-izzaAnIaOt1oEBmJI_9SdY7uLaxxa_i3aDqxBWbFmyLMw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4ED8BB60086; Wed,  4 Jan 2023 09:15:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <62fa1fff-b055-410d-bbf9-e4017dc23e88@app.fastmail.com>
In-Reply-To: <Y7V9Debcc9lqWBmT@spud>
References: <Y62nOqzyuUKqYDpq@spud>
 <20230103210400.3500626-10-conor@kernel.org>
 <b5712732-40a2-4e29-b29f-e0ab5516d518@app.fastmail.com>
 <Y7TBh+CJdZPJ6Xzl@spud>
 <ed198390-1bde-44ec-9f3f-b0e016b4b24c@app.fastmail.com>
 <CFB874A3-3E6F-4C5B-B47D-381EB1E07C02@kernel.org>
 <43aee000-5b89-4d94-98d2-b37b1a18a83e@app.fastmail.com>
 <Y7VpeK48nslxklkF@spud>
 <1b7d4caa-2c9c-4aef-81ac-47288d3a652c@app.fastmail.com>
 <Y7V9Debcc9lqWBmT@spud>
Date:   Wed, 04 Jan 2023 15:15:12 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Conor Dooley" <conor@kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        "Andrew Jones" <ajones@ventanamicro.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Anup Patel" <apatel@ventanamicro.com>,
        "Atish Patra" <atishp@rivosinc.com>,
        "Biju Das" <biju.das.jz@bp.renesas.com>,
        devicetree@vger.kernel.org,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        guoren <guoren@kernel.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "Jisheng Zhang" <jszhang@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        "Magnus Damm" <magnus.damm@gmail.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Philipp Tomsich" <philipp.tomsich@vrull.eu>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Samuel Holland" <samuel@sholland.org>, soc@kernel.org,
        "Daire McNamara" <daire.mcnamara@microchip.com>
Subject: Re: [RFC v5.1 9/9] [DON'T APPLY] cache: sifive-ccache: add cache flushing
 capability
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

On Wed, Jan 4, 2023, at 14:20, Conor Dooley wrote:
> On Wed, Jan 04, 2023 at 01:18:45PM +0100, Arnd Bergmann wrote:
>> On Wed, Jan 4, 2023, at 12:56, Conor Dooley wrote:
>> > On Wed, Jan 04, 2023 at 11:19:44AM +0100, Arnd Bergmann wrote:
> Perhaps more of a question for Palmer than you, but how about leaving
> ALT_CMO_OP as-is in riscv/for-next at the moment, wrapping it in
> zicbom_cache_foo() & leaving that extraction for a follow-on work?
> There's another conversation going on about expanding the THEAD stuff,
> so that could be done on top of Prabhakar's v6.

Right, makes sense to me.

      Arnd
