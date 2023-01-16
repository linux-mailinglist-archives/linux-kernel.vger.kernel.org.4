Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A549266C414
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjAPPhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 10:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjAPPhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:37:11 -0500
X-Greylist: delayed 180 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 Jan 2023 07:35:41 PST
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de [IPv6:2a01:238:400:200::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498551F92B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 07:35:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1673882970; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=nZsUYF7ikucQF7DLMPbDxMOc8KZ6VR6W5bqBqEbZHFkQs+T4cbHZxFsTdMA6WtYqf/
    NdYK7qAc84VFSOKEbPUiHbxMy7ASuQQWule9V1yKBPiT5zziR8CEZ/SK+rgMk022x4g3
    CU9X2i3tQ9WTczlIH0LQ/QGeltAnaSwg7066eR8SURA+rLzI4XzMeeE3nS2oYnJFAcL/
    VwwALj5URohYRKx0MMeVGh+3UYl7vb53uOFWX5Uq6QAlpYSne2uMvOyW7WEWEyMD9idB
    gczSx1eTO2Ot9CwYgz8UPuPDpAmFO7/e+ti1ilWuX7mFJ6jAkrZUHtQwNAyfNe0NG//D
    rIRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1673882970;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=AbbuHm7TvsAFiVwinj9rMZM8rW8kB0ZA+o+CqVXSWxM=;
    b=SZMZKlPURtMGL6bF2SoTarIVEatMgvPrYieXLW6siZRvHXPROToNOnSNDW/b6rUAEh
    zJu+Mbki39WDVfnpg/pwol+i7e5gaBhfaEF7jnWHVbujocQYsoe4/mDf0a8UM7L3tBHY
    wlmfPEtZ+BEGpSOkax/GAv3S0yfVrXYuWSyr4vtsaIWPW7Z3DrXx9yiKelFUfeLEgEyu
    EmyOrFdL0YlzIKkrlE5f8Vs2cn6U9C5e+9UCUgntXsejK5UIAA8aDAoHfRGhn2NzoIw+
    zMoDfoY4gStUfeuMVjCdjKGztr8zQbm0h6bVGuPzcXt8M4RTWHHznGGsqt/S8fTn19ru
    85mQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1673882970;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=AbbuHm7TvsAFiVwinj9rMZM8rW8kB0ZA+o+CqVXSWxM=;
    b=tuMfb8OK84jk6v/Vc+Obyemg4XLn1FK/6P2w9+auAZ/uQJlmuwyU+CzGfPSbeYgNZx
    44OV46vPa1ppgsNz1PzNgqteqqszDzf4T6EJUMGT3tbo1hEX1oGU1ZUOaHFtKN6e2uPg
    Ixv+bHs+2kBo6rUb3CB4SXCENnh8t5jaAm3xgAm2cdKsCxkJfmWosIhdklUcXsNp7fgx
    rLK0yaYBlCKm1yv4KRDF4NK+hcp0LTcRg40jf3vlHswkJAcnUiaIilYQrniGAXdoJ9LE
    f5G4e7lR5zcbDKTMrgclPFBe2Y+Ra0+l9C2DSLUrXwBan3BS4WCzwtNCYWSA/whECWEw
    bw1Q==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGfpGU="
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 48.6.2 DYNA|AUTH)
    with ESMTPSA id Q5ca1cz0GFTUL7n
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Mon, 16 Jan 2023 16:29:30 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH] ARM: dts: gta04: fix excess dma channel usage
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <Y8VkjQ2yZQssx/wJ@atomide.com>
Date:   Mon, 16 Jan 2023 16:29:29 +0100
Cc:     Adam Ford <aford173@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <4EFDE2C4-0BBB-4804-AA46-C40EB0D97AC4@goldelico.com>
References: <20230113211151.2314874-1-andreas@kemnade.info>
 <CAHCN7xJH+c41Yas+xnWA57KNi9arOOJDxJ=joEDEJr2k6jrRrw@mail.gmail.com>
 <Y8VkjQ2yZQssx/wJ@atomide.com>
To:     Tony Lindgren <tony@atomide.com>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Am 16.01.2023 um 15:51 schrieb Tony Lindgren <tony@atomide.com>:
> 
> Hi,
> 
> * Adam Ford <aford173@gmail.com> [230116 14:16]:
>> Would it make sense to make this default in the omap3.dtsi file and
>> enable them in the individual boards that need it?
> 
> In general disabling the unused devices by default for omaps will break
> the power management. The disabled devices are completely ignored by the
> kernel, and the devices are left to whatever the bootloader state might
> be.

Yes, indeed.

> For SoCs using firmware to manage devices it's a bit different story
> however. The firmware can still idle disabled devices based on a
> late_initcall for example, even if the kernel knows nothing about the
> disabled devices.

But how can we then handle all devices being "okay" by default and
eating up more dma channels than are available?

We can't put all under power management AND dma by default.

Or can dma channel usage be postponed until the device is really used?

BR,
Nikolaus
