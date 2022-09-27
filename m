Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2025EBE00
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 11:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiI0JHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 05:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiI0JG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 05:06:59 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5B5ACA27;
        Tue, 27 Sep 2022 02:06:57 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D13D45C0097;
        Tue, 27 Sep 2022 05:06:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 27 Sep 2022 05:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1664269614; x=
        1664356014; bh=WaQcSByyoaDah9UEl+zHh42iO4P7y7tfs8vteGT9EFw=; b=L
        0anKO+0elJrDuOYsl8/GsTjx0xq8gR41AySrhZehBknQDlqxJfFxzeH6CL6fMjTK
        oJNJIyEfX71a1dJTpUzBBni6YgHk7hPIwFmyFYs2RKdS26TL8uHjP8DENUWs+KOM
        kTYt8n9xi0QkGyujxn32OflEOG2X1ebE9FJT1tAhDIoLFgQwOirz4003WgyjcwWz
        AW5SA5kZ+KCy/xWpyfkYnhHymOIMzxbjPl3jzsp2OnouYDMc8KU2wG/78g/4Nh12
        tA3jxToPt5Lhs+gEiQ748+gzj3Hm6BoSUIvosZ+d2GsakKO9Vpin9fzBNVvTTzKK
        usDwMlZ2YrfhCc2EhhWyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1664269614; x=
        1664356014; bh=WaQcSByyoaDah9UEl+zHh42iO4P7y7tfs8vteGT9EFw=; b=R
        NrPCj+Ra6VhFUZQbDjbn+YHrzJxk6wf+xwhiM5NHcQtALcy/yUYSgx2SYZyD8SQW
        yRwMlyUX/2NSCTagdodhgX98BT4VsrWoRlTz7c8o33khvMul4Fc4QuYm46eb2JeF
        soeumpyWFPeNr+5KJVwiFO9/QOXz5pBXmvlz8jZ2SETOkSqrz3u6PkTCjxZCnQeC
        A6bTV4M7WgTyZ9svDWd3Zg8y4EKJBhIEIl6auAQSqKzFTMHvdCZRnc80gV4s1vX3
        7k2IcamukFNbRRPMKTv5alZOAazIpTEL4LvXPCN3jjOeVtWs9UsB1wfl9AdWbuMW
        M0SbpYH6qSoUA6hzNA/Ag==
X-ME-Sender: <xms:Lr0yY2HL9c1bCLechf7x5xKw6bxgsDrKxpyQDLFwqCavdAlh-RB35g>
    <xme:Lr0yY3Xawmm3OtAD__hf-PmeDx-A8Flwe7aifiGKZGT3YVpYlcTc0Q8Jry9bBS6Zt
    hxlNnecekN-1JcjI7k>
X-ME-Received: <xmr:Lr0yYwJ6eOlE4gVBPVP7ozNITcCgXCaDmptkQ0o6JPs3NOogAYx6Di8OWqEaLWToLlA7YA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeggedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvveffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpefnuhhk
    vgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrh
    hnpeekfeffueejveeujeeugeelleehtdegvdeludektddtfffhieefledvudehfeejieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvg
    eslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:Lr0yYwErpSBjjCUqqHRVwY-DaSyyVtNjeOh3O1KmYK7L-JpBqy-aAg>
    <xmx:Lr0yY8X5JQqmypQWQR4AhGkjZGBykIm_fg9fk-TbVwm1PQpBpktaPw>
    <xmx:Lr0yYzPzFAkT_Nj5h90xpY--mjwLZUAEj8NU2JEBu8LVuQlpJ3i1Sw>
    <xmx:Lr0yY7M46gmt4ZNpiB2v1toyFtng-67atFxILvPifVt8l3utF5Iw5w>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Sep 2022 05:06:47 -0400 (EDT)
Message-ID: <26bbda5d03f0eadc54dfa0036e24e16ae9134f5e.camel@ljones.dev>
Subject: Re: [PATCH v4 7/7] acpi/x86: s2idle: Add a quirk for ASUSTeK
 COMPUTER INC. ROG Flow X13
From:   Luke Jones <luke@ljones.dev>
To:     Mario Limonciello <mario.limonciello@amd.com>, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     travisghansen@yahoo.com, catalin@antebit.com,
        Shyam-sundar.S-k@amd.com, ruinairas1992@gmail.com,
        philipp.zabel@gmail.com, iam@decentr.al, hdegoede@redhat.com,
        davidedp91@gmail.com, marko.cekrlic.26@gmail.com,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Date:   Tue, 27 Sep 2022 22:06:39 +1300
In-Reply-To: <20220921204055.22889-8-mario.limonciello@amd.com>
References: <20220921204055.22889-1-mario.limonciello@amd.com>
         <20220921204055.22889-8-mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.0 (by Flathub.org)) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mario,

I have confirmed that another suspect ASUS laptop requires the quirk,
patch is as follows:


---
 drivers/acpi/x86/s2idle.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 2cd381f6c002..c811eeed42cd 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -428,6 +428,16 @@ static const struct dmi_system_id
s2idle_dmi_table[] __initconst =3D {
 			DMI_MATCH(DMI_PRODUCT_NAME, "ROG Zephyrus G14
GA402"),
 		},
 	},
+	{
+		/*
+		 * ASUS ROG Flow X16 - GV601
+		 */
+		.callback =3D lps0_prefer_microsoft,
+		.matches =3D {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER
INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "GV601"),
+		},
+	},
 	{}
 };
=20
--=20
2.34.1


