Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0DD6048DD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbiJSOMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbiJSOMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:12:17 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A19659E1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:54:43 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 9C9955C00DC;
        Wed, 19 Oct 2022 09:52:35 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 19 Oct 2022 09:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1666187555; x=
        1666273955; bh=NzYAg/YlSEKvKIBTWEWnRqnuWfSpTU9MM+bFuYxuKV4=; b=N
        z86J5hVmXo3Afd0cMjWHeEsLXu83D0C8GzkmyraQ9Ichekq8bXIrxJSUXSHn206Y
        kf2zeyqfqsAQHz47dD7rvjCuP6pWIni6GFKcSuhTHQ9ecrhwh9ImavgZ+hqA4fvb
        UglkJp/jZNZGsDIlmWa/Gt6YJwhJCnXYazw1m544uQ1msooxW/LJv/Tqj1zpRYrl
        pxNJBBoeYlYyjjWhD6OOT2PK7Yap6UQ+pCAhdnA8VK06KTShfE9t703XIHFBeBQs
        Td95Kisa0HyP4pa/crhP0AfRCHfPn6+SnPP/pND0qWiAmtzbK9dmzMDEK7uBQFko
        3aP8XAKFahuYY3BmU2anQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1666187555; x=
        1666273955; bh=NzYAg/YlSEKvKIBTWEWnRqnuWfSpTU9MM+bFuYxuKV4=; b=O
        JzccL+5FEzugRDp+RC6WsV6ob+38epOo66avPJgiPE6fQGsLOgacoILlgKsU+f4m
        peIazUdLKQOH1vtPFrsCR5YenyqlJyQw5ab6+YNr9AyPKLznkKBdOovx7bP/Lnzp
        CjSSDTgnB9pYxdZhUJf0fkDrJIAFnoWG4XxBvTD1IndPDNJIEEPXqa6x5ed1wc3R
        ANwP13SJyP/2/Sbspqinxpbk7vU1FnAcPx7d+cw7CZKcOXKWHkmeIZjSeUXqaLQ4
        u3torVAtXVuy7Y159TgDxe/MWu7NqnCm4XgYxyJa2KTZnZigz9AeGAr6ks+EhFw/
        O7f7czNe4AbCjeeaIr2QA==
X-ME-Sender: <xms:IgFQY9jTihMyeWvXHBN259hdwseytY98_P3yUMJWra0BV9AhKJHJmA>
    <xme:IgFQYyBfhu9sbuCydaO5nxh8NaMblCWTJiut2ip2YbseL3jDh7ZCnIv9aYjNktXAF
    tagEzSFbqpfJKmAbVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelgedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:IgFQY9GYjR7RBNEuXXUIaukB6FozyhgzvD0j9z8wJvyIRfk-1WD9kw>
    <xmx:IgFQYyRDJZ38NGG9Aerh3McB9ABGt1iYyjyUsAFPij3twc0k39Eqww>
    <xmx:IgFQY6yyo7xQOyZT_RjoPjtreCs9VZa-mFzMeNfLwvLCxe9E-j6GkQ>
    <xmx:IwFQYxnfNLU8-K2FFfAwsKgOl_DCNbxHkeqqA9ZV1bgSND7G7uTAXw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4D9C3B60089; Wed, 19 Oct 2022 09:52:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <7d97c52d-9917-4b3b-8ad2-7243566ae582@app.fastmail.com>
In-Reply-To: <20221019154841.1cb2a15a@kmaincent-XPS-13-7390>
References: <20221019133208.319626-1-kory.maincent@bootlin.com>
 <20221019133208.319626-4-kory.maincent@bootlin.com>
 <5e6858b7-231a-187c-acaf-f82b82a956bf@linaro.org>
 <20221019154841.1cb2a15a@kmaincent-XPS-13-7390>
Date:   Wed, 19 Oct 2022 15:52:12 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com,
        "Russell King" <linux@armlinux.org.uk>,
        "Gregory Clement" <gregory.clement@bootlin.com>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        "Alexandre Ghiti" <alexandre.ghiti@canonical.com>
Subject: Re: [PATCH 3/6] arm: configs: spear6xx: Enable PL110 display controller
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022, at 15:48, K=C3=B6ry Maincent wrote:
> Hello Krzysztof,
>
> On Wed, 19 Oct 2022 09:38:45 -0400
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>
>> On 19/10/2022 09:32, K=C3=B6ry Maincent wrote:
>> > From: Kory Maincent <kory.maincent@bootlin.com>
>> >=20
>> > Enable the PL110 DRM driver, used by the spear600.
>> >=20
>> > CONFIG_I2C is dropped from the defconfig as it is selected by CONFI=
G_DRM. =20
>>=20
>> I2C as a user-selectable option should stay. Don't remove such
>> (user-selectable) top-level options just because something else selec=
ted it.
>
> As the CONFIG_DRM selects it, the "make savedefconfig" removes it by d=
efault.
> Why keeping something that is already automatically enabled by CONFIG_=
DRM?

It's something that DRM probably should not select, so if this
ever gets fixed in DRM, you get a broken build. Just leaving
the line in there is harmless.

      Arnd
