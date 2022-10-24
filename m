Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDEB609BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiJXHni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiJXHnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:43:02 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79A56170A;
        Mon, 24 Oct 2022 00:42:44 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id ECF635C0088;
        Mon, 24 Oct 2022 03:42:43 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 24 Oct 2022 03:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666597363; x=1666683763; bh=IIF/PO05CA
        3+vGqzY/ZJRFYdM97BLEDtjsTXN4o8/DI=; b=RRSw3+C7LupY0tB8ZE65MvNC1n
        5j8qWf4BqdbpuhpmmxvI97ivUfZ7DnVR7FJbHeuO5WoFCypRFZlQPXaBkAN5XulA
        CTV7YH4gZlhGZE2+qFH3/JitLewVAbVmqpYeVuzjIFi96B736mNT/5M6KmD7Feju
        Pu875r2uZv4NPEzSbIFjaPmo+1xpuiVu4Tl/xFcwUNJ6kYKPh67UuOaz06kJn1mN
        zWs2A6+ezQb06l1fI26CeRFdu2d+HRyWzhWA4xLq9RGFppGQRBXAzOiXP2kP+xDH
        FH04r5hHyK0csoiZV04Im/JdZWk0TtITVAMre21X6SLdN4EQtlhd9mTRMHuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666597363; x=1666683763; bh=IIF/PO05CA3+vGqzY/ZJRFYdM97B
        LEDtjsTXN4o8/DI=; b=uKBmjQH+cCId3wtYcUaU+//pjIANOSsP1yXknE+lrAAO
        8U1d02P/C2FJTShVBSs3X33BNtxyNqaHDDtjn1bwhKC53VMalH4tp4LYLW8JF9qQ
        mAEWGthnvTjcd3m202ZT/2w/xL1Pl/MxxypKFDRv3l68hC+42oWhLvjRzKwedCoE
        hdJSRzLjLmOBuSxGTFe6kTU/Eg3EhVmVrICdzFO1gdQRlyx6pEeDLCapNm6gAzUn
        qKdFU+juPYGTo1pJ7xhGubXq7/kT12BnE9YJ40eJNWpuLSf6IdbA/5kUBqhx/01i
        QiavC7ulG2x6sGQyns3xOPVHeFLodaYKf5cIu1BG4A==
X-ME-Sender: <xms:80FWY8hwlX-dHxvqJz_bnIDp_X_yzVVA-0DIInEC5UiJA_5Z2gzm4Q>
    <xme:80FWY1DRSkZh4RiMnWgEveNmG-VMksNx8do0UM9O1WRuV5sRFz_KU9NZ0MpQ6SGnX
    Lz2D08ak6uPDb3oVd4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedtfedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:80FWY0FXCXMBSY-u_MjL9DWToe92Q7ArI3qbsEQzW73G5t9hMer57Q>
    <xmx:80FWY9T4LXLyHJbJW3XURNc-aTPHhe69b6NdkE9RcNiXpvNb07Ynhg>
    <xmx:80FWY5wu1WLAGX_nhJl2nlmT9rkgw_Cgv_JhLOYdT6-s8QpJXUjlmw>
    <xmx:80FWY-IXoU6zD5g_4E5ndPxoUP4hdsjwbgN528SQwNVrKVdWyXQaRA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3E63EB60086; Mon, 24 Oct 2022 03:42:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <697f1503-1289-45bf-acb0-57429c903665@app.fastmail.com>
In-Reply-To: <Y1Y+o2aDz2Cd+ZG8@google.com>
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-7-arnd@kernel.org> <Y1Y+o2aDz2Cd+ZG8@google.com>
Date:   Mon, 24 Oct 2022 09:42:21 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Lee Jones" <lee@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Sebastian Reichel" <sre@kernel.org>, linux-kernel@vger.kernel.org,
        "Ben Dooks" <ben-linux@fluff.org>,
        "Simtec Linux Team" <linux@simtec.co.uk>,
        "Rob Herring" <robh@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Lukas Bulwahn" <lukas.bulwahn@gmail.com>,
        "Joe Perches" <joe@perches.com>,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Luca Ceresoli" <luca.ceresoli@bootlin.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 07/21] power: remove s3c adc battery driver
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

On Mon, Oct 24, 2022, at 09:28, Lee Jones wrote:
> On Fri, 21 Oct 2022, Arnd Bergmann wrote:
>
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The s3c-adc driver is removed along with the s3c24xx platform,
>> so the battery driver is no longer needed either.
>> 
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  MAINTAINERS                            |   7 -
>>  drivers/power/supply/Kconfig           |   6 -
>>  drivers/power/supply/Makefile          |   1 -
>>  drivers/power/supply/s3c_adc_battery.c | 453 -------------------------
>>  include/linux/s3c_adc_battery.h        |  39 ---
>>  5 files changed, 506 deletions(-)
>>  delete mode 100644 drivers/power/supply/s3c_adc_battery.c
>>  delete mode 100644 include/linux/s3c_adc_battery.h
>
> Any idea why I was Cc'ed on this (and only this) patch?

Not sure. I use "get_maintainer.pl -i" to generate the list
and try to prune it manually to avoid adding too many
people to Cc. It appears that for this patch I accidentally
included everyone who showed up in the git history for the
maintainers file, rather than the people who touched the
actual driver.

      Arnd
