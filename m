Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7384A65E010
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 23:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240600AbjADWfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 17:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbjADWfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 17:35:16 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205AE42E0B;
        Wed,  4 Jan 2023 14:35:16 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 873B95C0134;
        Wed,  4 Jan 2023 17:35:15 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 04 Jan 2023 17:35:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1672871715; x=
        1672958115; bh=9nSj1q7zrjVrHxpXLsqOcxeqElrzwEPSBvGhfldNRfM=; b=U
        ESssoN41ZgPoFtZQUPojTuKCXpL2LDZjkED16G9s7nCnA1tmfRBbKWwLeV24ruBt
        Pl66tQD8eOuVsOWDV0R9qoG8944S0nn1xh2n6PZ5CdvTMBLAluNNqCge1oGUMiuo
        Y7KWxq6loXsyP4NPnfjO/d0JC6+Dsk1d5Hvctz8ZNOCIFIp4JxRNWKfuM6qhgGSp
        BJn6PgjB8IQEJ/E0WCADHDI0oauTruA3DCY+FYk1SM4rLE/6bpOm9wkJHt2OCsJe
        f0Xl8t6FIVdI8yTj60mPgFLuuiO4DB2Qt+Oh1uhUS/9/vlWF0zuzRdDKVPsv2A/w
        vfovqM1+tXItTbzszBO1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672871715; x=
        1672958115; bh=9nSj1q7zrjVrHxpXLsqOcxeqElrzwEPSBvGhfldNRfM=; b=x
        XfeFMMSkIjqDp/ACOh7XxE3Dx+Fv61YQAGYNzAvb0u8GFNexp4S/9LxfkflJSgBf
        25mG36h9xzl992ZkLKhzATAADHw07YYufGZZ1fpF06hegAOdXrmXaUvOmjy1wuky
        5EhNinBnzlARntFOfhrjuaJvpyIlzcWZTrl13fFCd0aYF8szenBUbIO5e9XFLry+
        wDdHW5rMc+a5zwUUm0IFP7wQGo5rVzF+A4p12lrGlmZiBZ2rP5CXu8lamuMCHtHt
        +O3iDLfiiqcNzcYXPtipaRcRavY/8n/DiP1hEb1DEVhglKtwK/84UnjiusZJMecC
        CiYxAkQyZY/ui3TmeTNdQ==
X-ME-Sender: <xms:Iv-1Y1IWnYU2LJGoYaBdWWaW9R6EzoupAydBJZKg6iQmP71xyvSziw>
    <xme:Iv-1YxJJfv1JaISL-r0QkEpoakedfLWauRJ50UqhRfU0wm8O_0RiS975ftZH0jxQv
    BGgp9mLErwfxSU518s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeejucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedtgfejveen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggv
X-ME-Proxy: <xmx:Iv-1Y9ugY1So_65wAHgDHHEau78vxDvUPnpVkgGqBE_okLqtL3iwTQ>
    <xmx:Iv-1Y2art-m0VjeJGkMtl1HXIEaD8OYdlqL2sQointxIq_7Hmldx0A>
    <xmx:Iv-1Y8ZifTk2vC9y7Xla4m0jHUMnKw7rKALtRf06a4O4SW8zslqH2Q>
    <xmx:I_-1Y7wfUr8KFUIfe0wuQQF0zlIdBqjezD-x-S0vy_XLSPOxr8nqtA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E348FB60086; Wed,  4 Jan 2023 17:35:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <acaa26a6-f918-4dfc-8326-888e8d35fb09@app.fastmail.com>
In-Reply-To: <Y7W+E2/bywt16BqJ@google.com>
References: <20221211025700.1180843-1-jk@codeconstruct.com.au>
 <20221211025700.1180843-3-jk@codeconstruct.com.au>
 <Y7WvXTPxyIGw5y9R@google.com>
 <33f6f9e66c8143515d36d17bf33d95362830f83f.camel@codeconstruct.com.au>
 <Y7W+E2/bywt16BqJ@google.com>
Date:   Wed, 04 Jan 2023 23:34:54 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Lee Jones" <lee@kernel.org>,
        "Jeremy Kerr" <jk@codeconstruct.com.au>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Mark Brown" <broonie@kernel.org>
Subject: Re: [RFC PATCH v3 2/2] mfd: syscon: allow reset control for syscon devices
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 4, 2023, at 18:57, Lee Jones wrote:
> On Thu, 05 Jan 2023, Jeremy Kerr wrote:
>
>> Hi Lee,
>>=20
>> > > @@ -124,7 +127,17 @@ static struct syscon *of_syscon_register(str=
uct device_node *np, bool check_clk)
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0ret =3D regmap_mmio_attach_clk(regmap, clk);
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0if (ret)
>> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goto err_attach;
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goto err_attach_clk;
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0}
>> > > +
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0reset =3D of_reset_control_get_optional_exclusiv=
e(np, NULL);
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(reset)) {
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
ret =3D PTR_ERR(reset);
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
goto err_attach_clk;
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0} else {
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
ret =3D reset_control_deassert(reset);
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
if (ret)
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goto err_reset;
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> >=20
>> > The else is superfluous, right?
>>=20
>> Yep, we could move that reset_control_deassert() out of the else bloc=
k.
>> If there are no other changes, I'll send a v4 with that.
>
> I'd wait a little while to give Arnd a chance to respond.
>
> Might save you a little work.

Looks all good to me,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
