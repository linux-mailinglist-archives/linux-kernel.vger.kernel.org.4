Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139ED6EDB7E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 08:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbjDYGIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 02:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjDYGIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 02:08:39 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16CE5271;
        Mon, 24 Apr 2023 23:08:33 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id A8F365C00AC;
        Tue, 25 Apr 2023 02:08:30 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 25 Apr 2023 02:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1682402910; x=1682489310; bh=aJgi4spPsFQMfOdmy5CVQvlkrVppKGiGa4z
        XRLkCvhw=; b=PUyyiP7uvMsLeJ4aMHmXRJqlthrOClNFs1rTtuqwn7hczrza5Xj
        ArZQuKjNOBZ5dzgph04QngM3idcNQRiaq9V1qPxADUeA2IEtInPHMpBHQK+mbwpR
        nVykboFKchlNSHM73ZCcWLLcmnyhb+dcKWY0nzjQWPzUvcy8jrQv8SJUslImF5MM
        /MdKAjE7tSg9TBD0I0pHkWuESYtYzZ58SSutWirNoQqC/C2IsACI6welHx14Xj77
        JfZghkFow0AGDtBqLjkhScJNQyidA6Dih380GZkvG/az5BnPRfdfkJh3QqIJPr+h
        b5sEgMt/5m0I47oIoj44QImDPDeKm0ifYdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1682402910; x=1682489310; bh=aJgi4spPsFQMfOdmy5CVQvlkrVppKGiGa4z
        XRLkCvhw=; b=ZZmgqeQiihJAmXaoMLh9ch8IMYKc4EuYPCVG8KbGrwiSBsurPeg
        CJBncCrM8jD9ws9n4smPrWoK0QWjXNJAmVphUXxGlTV9lbVA6cLcyp6xtnahBspZ
        7VNm2hYg1EUkoMy+7UkIgPVwYNN+aLHcDvsO8YoE6oI6QT8VdR/6gJ/7DVGD1mJK
        K1p0vlfVSNH8VB+3DRu61+8kLLxTS99CClaCtX8E7NJR0WBraZPrP5NxY+a599tx
        fV1Ad7oiM5CGy1TdZjR5aQJ+0yUh8lS/qmWHPBe/TtcoDsziuqt1bSyN9VHylHiH
        FShSUH2rod449TNkDJ3vcXKk/Kfascz/vTA==
X-ME-Sender: <xms:Xm5HZOk5GbNgi8EqvtVOrx02eB9RHBsm5bwBsbLMSxejQJTg-8S6rw>
    <xme:Xm5HZF0ah6RYyU2fPcXs1A232j43IrvSzWRTJwsmGFikdszDccakxJNzaC_Q-yQAG
    n54crXtaSg6fLi6jQ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduuddguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Xm5HZMofUlrleyL3tbizc0XPyn0QLtOkkur-zWnt1eh8Exg-Ht1wAw>
    <xmx:Xm5HZClxovzsbCpkLVNOujEpGlyFcW7xsx0BBJqBZgHw63-ULHipWQ>
    <xmx:Xm5HZM3I5J7MbPmwaSVio56fLvwqYiDaHbfVwr4jZwiUmgpUYNqyPg>
    <xmx:Xm5HZP2D-_sVHNyFLu6tVhd2bY1S_6Q4wNiXE3G-ixS7qo0zUiWwZw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0BFE0B60086; Tue, 25 Apr 2023 02:08:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-374-g72c94f7a42-fm-20230417.001-g72c94f7a
Mime-Version: 1.0
Message-Id: <16ba11f1-5aa2-48c9-81cf-e3d98f547657@app.fastmail.com>
In-Reply-To: <90d4aba4-d0a5-9868-583b-b3a4dd7ca6d6@huawei.com>
References: <20230424073020.4039-1-lihuisong@huawei.com>
 <e0c4f4b5-8b34-4542-b676-f98ddb8ef586@app.fastmail.com>
 <90d4aba4-d0a5-9868-583b-b3a4dd7ca6d6@huawei.com>
Date:   Tue, 25 Apr 2023 08:08:08 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Huisong Li" <lihuisong@huawei.com>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>,
        "Shawn Guo" <shawnguo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, soc@kernel.org,
        wanghuiqiang@huawei.com, tanxiaofei@huawei.com,
        liuyonglong@huawei.com, huangdaode@huawei.com,
        linux-acpi@vger.kernel.org, "Len Brown" <lenb@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, "Rob Herring" <robh+dt@kernel.org>,
        "Frank Rowand" <frowand.list@gmail.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] soc: hisilicon: Support HCCS driver on Kunpeng SoC
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023, at 05:04, lihuisong (C) wrote:
> =E5=9C=A8 2023/4/24 16:09, Arnd Bergmann =E5=86=99=E9=81=93:
>> On Mon, Apr 24, 2023, at 09:30, Huisong Li wrote:

>>         depends on ACPI
>>         depends on (ARM64 && ARCH_HISI) || COMPILE_TEST
> What do you think of adjusting it as below?
> menu "Hisilicon SoC drivers"
>  =C2=A0=C2=A0 =C2=A0depends on ARCH_HISI || COMPILE_TEST
>
> config KUNPENG_HCCS
>  =C2=A0=C2=A0 =C2=A0depends on ACPI
>  =C2=A0=C2=A0 =C2=A0depends on ARM64 || COMPILE_TEST

Yes, that's perfect.

>>
>>> +
>>> +#include "kunpeng_hccs.h"
>>> +
>>> +/* PCC defines */
>>> +#define HCCS_PCC_SIGNATURE_MASK		0x50434300
>>> +#define HCCS_PCC_STATUS_CMD_COMPLETE	BIT(0)
>> Should these perhaps be in include/acpi/pcc.h? The 0x50434300
>> number is just "PCC\0", so it appears to not be HCCS specific.
> This is a PCC signature. As stated in the APCI,
> "The signature of a subspace is computed by a bitwiseor of the value=20
> 0x50434300
> with the subspace ID. For example, subspace 3 has the signature 0x5043=
4303."
>
> I am not sure if all driver need to use this fixed signature mask.
> As far as I know, cppc_acpi.c didn't use this signature and=20
> xgene-hwmon.c used another mask defined in its driver.
> So I place it here.

I would still put it into the generic header, but it doesn't
really matter much, so do it whichever way you prefer. No need
for a separate patch if you decide to use the global header,
it can just be part of your normal patch.

>>> +
>>> +static int hccs_get_device_property(struct hccs_dev *hdev)
>>> +{
>>> +	struct device *dev =3D hdev->dev;
>>> +
>>> +	if (device_property_read_u32(dev, "device-flags", &hdev->flags)) {
>>> +		dev_err(hdev->dev, "no device-flags property.\n");
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	if (device_property_read_u8(dev, "pcc-type", &hdev->type)) {
>>> +		dev_err(hdev->dev, "no pcc-type property.\n");
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	if (device_property_read_u32(dev, "pcc-chan-id", &hdev->chan_id)) {
>>> +		dev_err(hdev->dev, "no pcc-channel property.\n");
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	hdev->intr_mode =3D hccs_get_bit(hdev->flags, HCCS_DEV_FLAGS_INTR_=
B);
>>> +	if (!hccs_dev_property_supported(hdev))
>>> +		return -EOPNOTSUPP;
>>> +
>> Where are the device properties documented? I'm never quite sure how
>> to handle these for ACPI-only drivers, since we don't normally have t=
he
>> bindings in Documentation/devicetree/bindings/, but it feels like the=
re
>> should be some properly reviewed document somewhere else.
> These are ACPI-only, instead of DT.
> I will add a comment here as Krzysztof suggested.

I understand that they are ACPI-only, what I'm more interested here is
the general question of how we should document them, to ensure these
are handled consistently across drivers.

>>> --- /dev/null
>>> +++ b/drivers/soc/hisilicon/kunpeng_hccs.h
>>> @@ -0,0 +1,204 @@
>>> +/* SPDX-License-Identifier: GPL-2.0+ */
>>> +/* Copyright (c) 2023 Hisilicon Limited. */
>>> +
>>> +#ifndef __KUNPENG_HCCS_H__
>>> +#define __KUNPENG_HCCS_H__
>> Are you planning to add more drivers that share this file? If not,
>> just fold the contents into the driver itself.
> Yes, we will add more drivers in this file.

Ok.


       Arnd
