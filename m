Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCC364DC9F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 14:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiLON7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 08:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiLON7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 08:59:08 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6AD2FBFA
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 05:59:07 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 6BBDA5C0196;
        Thu, 15 Dec 2022 08:59:04 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 15 Dec 2022 08:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1671112744; x=1671199144; bh=nGHq/iEmlX
        N8UnzuJBSP8sIb1Dfy+Sh0PJFA06vQEjY=; b=Dxn/RLRyunn5H8hcJiaCoNkZ3T
        hXEummKDmm+LYN5VP4DD1i88GElbO2/2BDXZfPXKw3u7C6h2eDaTjYXJ4lbXDRmq
        yhX8FcgXDD+PDIEFRgWG6GNjDy+F16RBETBQ2EHxPea1L/Z6bS89BCj6TEe4Esu8
        7kEpeU6WQTSnBEZuL2m7SByzu1bd7jYrTSXCucrbwn++jh66RsB+Hgbh7JrJLgdq
        +S6UQr9UNwVhachha7FtSPjAF6nGXFdu+Qa4URFfHG+ObiZGKa4k6dKkgwlmPhv4
        37I1JjXE/GrjSOCNK4haK5Xxj+p4KEi8qXVM5HGCLMeS8Uq1+/oHAtK1oEnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1671112744; x=1671199144; bh=nGHq/iEmlXN8UnzuJBSP8sIb1Dfy
        +Sh0PJFA06vQEjY=; b=tINBhqq7hz/oysQX2KcNZ3CRGtO2F6kFA41DYHKkJcgg
        ZAiejBx76d2GR+BAIKW1cf85KUZVHCZBsBwvfmjp4ThdrMgRTdhsP36mUBMVYTFl
        x8QAspThAWMDPnbs8kUxLexaVIxIuNYoz3MOLfWFicRritafEBqwj22ojlZ9BNIg
        E9Wb/+yz3JH8n/GvlBLUXEmVLpvMmg4gKWPpmcDHDCTQj//IKPkc4ssls8QaVztm
        3okLOMiPx6Mltu481uhdQSLX4HXA1NLeMnZvxg8DUu/Xzm/4h+s8LHfFgDzejcoh
        4DtEqCaSLhiiSFzl18moxV/UY+B4kIMjppPk7xinfA==
X-ME-Sender: <xms:KCibY9rEO9TZvgH4w3jlUhmXyet4x18mZKIUg-wIxP7SPceTRqdRKg>
    <xme:KCibY_rIPN1TX0_9LJiVYyduoA-45qOmPnm7c-LduWIpjDbUiOAQBl-Q0KPJQ6GcN
    jLVGoO0r4UyyKAj7Ro>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:KCibY6OGStmgJUGHcgQQIFRBNO7VyOtfSjnc0D204JIClJ234Dgl0g>
    <xmx:KCibY44x2TbtFt-E8lwEjov848S3Wsmj4oJMYh2GmvBgJ6vETuYOkQ>
    <xmx:KCibY85xK4w9iAF4thEVsa91nNZ3Y-4QaMsk-44JLOQ7Ixv7-8ezDw>
    <xmx:KCibY8Gq2S6xeQxL2SCQjB4Qz36tmIqy8HGq45PTnUOYJ0JqUhrJAg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1C437B60086; Thu, 15 Dec 2022 08:59:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <e81df256-cd0f-403a-9405-a126aac7447d@app.fastmail.com>
In-Reply-To: <20221214175327.57703-1-sebastian.reichel@collabora.com>
References: <20221214175327.57703-1-sebastian.reichel@collabora.com>
Date:   Thu, 15 Dec 2022 14:58:43 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Sebastian Reichel" <sebastian.reichel@collabora.com>,
        "Russell King" <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv2 1/1] ARM: improve Cortex A8/A9 errata help text
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

On Wed, Dec 14, 2022, at 18:53, Sebastian Reichel wrote:
> Docuemnt that !ARCH_MULTIPLATFORM is necessary because accessing
> the the errata workaround registers may not work in non-secure
> mode and mention that these erratas should be applied by the
> bootloader instead.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Can you add this to Russell's patch tracker?

   Arnd
