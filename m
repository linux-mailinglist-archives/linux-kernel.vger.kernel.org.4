Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615CA6F7BFD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 06:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjEEEgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 00:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjEEEgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 00:36:35 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A214C124A4;
        Thu,  4 May 2023 21:36:34 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1AE525C00C7;
        Fri,  5 May 2023 00:36:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 05 May 2023 00:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1683261394; x=1683347794; bh=O+naYreEKHDmJ2BcMOYxYi+2+hV4OxeETyY
        wMMZX6YY=; b=OKVI4FkQCG7KikgKvVfzNSm9UDwwaq30XQUI8fKLwPQjD65bugH
        O5fVb5JMS2Bxt4wgA5NoBwNanft6gmKetjJ5ndJBngIT4tyKx4k8d+Zq0yQ1x02b
        Ko9ExWqaYZ+3TAvduAEPqzuW941jOTPDx4Dc2FnRd6Xr+MSVM/B4+UzC7QgNco5T
        oL+qIcz5+zS7E/T9VKjHGWB833kfs7Pr4n/tMqgEnA+pgaKXh6RaRhz6xWSSWgCP
        dGNOUZXVsy0paYacG8jq3WiCMwVIUI5yvk378bu/tOTLaV1Og/vcFM2Ws/mZlRWJ
        9rlE8GiNmrA/XgIJknWt/TQAUcl5jsGjuoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1683261394; x=1683347794; bh=O+naYreEKHDmJ2BcMOYxYi+2+hV4OxeETyY
        wMMZX6YY=; b=gQUO6WGkAGfXzms7YMtXo5adBGw3sJ+Uc5N27B6AVIoe1abdRNP
        Bf7q270LY8Fe27Y/5R6xlbv6AYJun3hZjoiR/73zskhAdROgdCwTjyQacHJkAKen
        0/eHNWKEIDg4xlkjaXSkfTBSJzwLUgPJwonDsflScvtxQrWxJNhovIvjQRR4itfk
        TQ0vMYiLzHkoB9rEiniiy5PLBqbBVDgxjuAqxO2f/yybghxMGZABvUAu5Outxy+G
        MRxN0gRMS43B7g4RZLs0Zd/qAWqfoc9x0GgYzuwn9cNQN0ZUUihjdFGxPheurYFb
        /vjvNL3dMbJSxZs9ElxnKfyCvszyI3/ZRlA==
X-ME-Sender: <xms:0YdUZGUHML8u92pxAK09U4Buts-JqHehhtiLxJZOOf3reVpV-kTdIQ>
    <xme:0YdUZCkAKj1EviqUp4gKIgFeFy4nh3blVUC3b0foUQjnkFLm3RSYML4aHe_xR2it0
    A08ipBTDiYVDOv0YQ0>
X-ME-Received: <xmr:0YdUZKY_M3KPruoJUab06OFq8hxmsxhZpecvn2G06xDjAZQQOuiQqk8U036sisOQH5KRiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefuddgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffuvfevkfgjfhfogggtgfesth
    hqredtredtshenucfhrhhomhepnfhukhgvucflohhnvghsuceolhhukhgvsehljhhonhgv
    shdruggvvheqnecuggftrfgrthhtvghrnhepudetiefgieehtdeghfeutedvvdefiedutd
    dvfeekvdehveettddvueduudetvdehnecuffhomhgrihhnpegrshhushdrtghomhdplhhk
    mhhlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:0YdUZNWp7JD5Jjkn0aWJ_Pf24PNM_BgABvfE3XkdpiOt39uZbk696A>
    <xmx:0YdUZAly-dcJAOFpz6t2IWnY9A1lQvsCqgiun_ys249_vTsrStyhyQ>
    <xmx:0YdUZCdA3IBTQFBkn2FJ3cJCHeTQGuEuf4vx-VG8YPn96YgtB_7ozA>
    <xmx:0odUZOYPctAOag8Z6tDep4X_JRXgIdtRMhIyf8Zw7UngCSLBdNwlvA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 May 2023 00:36:26 -0400 (EDT)
Date:   Fri, 05 May 2023 16:36:10 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH] platform/x86: asus-wmi: add support for ASUS screenpad
To:     =?iso-8859-2?q?Barnab=E1s_P=F5cze?= <pobrn@protonmail.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, hdegoede@redhat.com,
        corentin.chary@gmail.com, markgross@kernel.org, jdelvare@suse.com,
        linux@roeck-us.net
Message-Id: <AS46UR.T68QO79EHLHI3@ljones.dev>
In-Reply-To: <R0Q3UR.1AXX7YQ75CIN1@ljones.dev>
References: <20230503040207.257406-1-luke@ljones.dev>
        <_BfjSVwlhmByGevAd1Yo_jhipUa3r6y5HHSi34xdeaYqelyPe1PRnOEru21Yw76x0spJwAAs3jr0MJ0f_jUc8QY75Q1J1ovT5QPvm0p2WhY=@protonmail.com>
        <R0Q3UR.1AXX7YQ75CIN1@ljones.dev>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, May 4 2023 at 09:22:03 +1200, Luke Jones <luke@ljones.dev>=20
wrote:
>=20
>=20
> On Wed, May 3 2023 at 17:46:53 +0000, Barnab=E1s P=F5cze=20
> <pobrn@protonmail.com> wrote:
>> Hi
>>=20
>>=20
>> 2023. m=E1jus 3., szerda 6:02 keltez=E9ssel, Luke D. Jones=20
>> =7F<luke@ljones.dev> =EDrta:
>>=20
>>>  Add support for the WMI methods used to turn off and adjust the
>>>  brightness of the secondary "screenpad" device found on some=20
>>> =7F=7Fhigh-end
>>>  ASUS laptops like the GX650P series and others.
>>=20
>> Is it this one: https://www.asus.com/content/rog-screenpad-plus/ ?
>> Or is the "plus" version something different?
>>=20
>> If it's a "proper" screen, wouldn't it be better to add support for=20
>> it
>> in the respective subsystems? E.g. why not register a backlight=20
>> =7Fdevice?
>=20
> I think it is similar yes, likely the same thing.
>=20
> Adding as a proper backlight is what I wanted to do but at first=20
> blush I wasn't sure.
>=20
> Looking at include/linux/backlight.h + some examples it looks clear=20
> now. I'll try to
> work up a revised patch and get it tested by the folks with the=20
> actual laptop.
>=20
> My only possible issue would be how to handle the on/off part?
>=20
> Cheers,
> Luke.

This has now been addressed with "[PATCH v2 0/1] platform/x86:=20
asus-wmi: add support for ASUS screenpad" at=20
https://lkml.org/lkml/2023/5/5/9


