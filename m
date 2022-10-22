Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C42608B9C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 12:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiJVK1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 06:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiJVK1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 06:27:18 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E04B95E7B;
        Sat, 22 Oct 2022 02:42:33 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1E5045C00AC;
        Sat, 22 Oct 2022 04:37:21 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Sat, 22 Oct 2022 04:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666427841; x=1666514241; bh=mgwwibNaT3
        9+srj0kSxQYqzYjr590nm91NQ/yE3P2VI=; b=BlDGDTNlJnJCBDoKT3UDmEXcje
        3oWmZxA3QtASURMgetnwzRk/HVzhXXJT81PcEvD/rs0R5FFooMwg/8ino08gYwFo
        yYfhb3Lv0w10TZdx6au/rM92a4h+4GSxKlBD38ewIg7zcKpUcQA0c8X1AgHTMY3v
        H0pgILNR5liO9VKvdLh148Qlz9CihXrA6n347AegJs6kVhpen/0d41pX2pEimQLA
        i7b6WzgCEyNKX+T6OAPxCVSHls1gbWsfodXCcDYjcfl57aJW0/Fjg/VY+C6cD8tB
        4ZOmKJlVzPA9wcp0gLi21XuHFAPW3Ky9VpazzPQ7V2m+92D4NVFbXX3JmJjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666427841; x=1666514241; bh=mgwwibNaT39+srj0kSxQYqzYjr59
        0nm91NQ/yE3P2VI=; b=SE05WV5Py97h+F83QVMY0MmqmuueN5k9AcJXrepAbhzm
        QwKLBuX/46fOXAqJuX21J9A9ahIywGxBM2BIsD7otYqbUMiSiut/94hZcwEY/8RI
        Jdg61nF8R89MKblMeOaEnFNn7hWAHl9yXbLRK7GpdkdMIk+v04qszV/NVdOF+alu
        uLuftvGjhYlfEq3JoAp4v9xURPqUox1ibGt9YXKZlninBGv2fknbm62r8MdEEXDu
        1HVMBMangmjXjJJQpb99Rm6B0PeE5SSxfwhfSPEXvT7cC08BI3mimNo/0HkD/ukY
        uWBvvlPODRMLh6H7Vpj8QeAGTbD5w/6JAwRGhAj7qQ==
X-ME-Sender: <xms:wKtTY75D2DcAbdgrUGELNl-oQpJT05H2e3yrixPOWMyorJBOggNGfA>
    <xme:wKtTYw6oD5OCKCoPZV4Skw39kP1pP0yHNbfOQfNyF9CHAa-dPpIcBk_ZBYB55XOHZ
    xcEJHK1T0dCvTRembk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedttddgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:wKtTYyd677ZS6V5nDCIWyEXkC6e2RPl_S52bm1oYRQ7dJPYpd3QGIA>
    <xmx:wKtTY8J4jb5TKSXNdLNH_0WO3C-LIhoy6yfmdoAgh_wjzrkABu0nww>
    <xmx:wKtTY_J61geLH48-lwzxVXZpK-4i7tbIPDIpMQJ0PrHmQt8eaPX3cQ>
    <xmx:watTY38U9nsfu-102bCxNQax6DBR2hTlITAZW2LXPxOdRdNZSLvJ-w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 83A8EB60086; Sat, 22 Oct 2022 04:37:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <a357e9f1-57ec-425a-9a55-9c6114be6487@app.fastmail.com>
In-Reply-To: <3644e7cb-4a1e-b78b-5ac6-594590190a20@roeck-us.net>
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-8-arnd@kernel.org>
 <3644e7cb-4a1e-b78b-5ac6-594590190a20@roeck-us.net>
Date:   Sat, 22 Oct 2022 10:36:59 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Guenter Roeck" <linux@roeck-us.net>,
        "Arnd Bergmann" <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Jean Delvare" <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, "Ben Dooks" <ben-linux@fluff.org>,
        "Simtec Linux Team" <linux@simtec.co.uk>,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 08/21] hwmon: remove s3c driver
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

On Sat, Oct 22, 2022, at 06:02, Guenter Roeck wrote:
> On 10/21/22 13:27, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The s3c adc driver was removed along with the s3c24xx platform, so the
>> hwmon driver is orphaned and can be removed.
>> 
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
>
> I assume you plan to push the series together. If not, please let me know.

Yes. I plan to pick up all the patches from the series through the
soc tree that have not been NaK'd or applied to subsystem maintainer
trees.

     Arnd
