Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9F461E324
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 16:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiKFPuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 10:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiKFPt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 10:49:57 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0B4DEBE;
        Sun,  6 Nov 2022 07:49:57 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 7A9765C00A3;
        Sun,  6 Nov 2022 10:49:56 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Sun, 06 Nov 2022 10:49:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1667749796; x=1667836196; bh=2R
        ExpLgU9g1N+kqrPRFMdAkMdWjT7WLqNDmpPvDQ17Q=; b=DmjqHN7yrCbLOSSh7d
        SAzD+TBzSfihWszXmjEMLhCYtRM23iy3t8v23UduvgKsczS9UaRHpEvTq8v+3tOL
        f7HXnwv2mP/fli3F0wjI1Qd20xANu765VA67yWgsWl7LytYgL+TRmb3rsGRaF1hn
        yU8u/0CD0RD2XZG0YraxctVLF0Vuk1PwiUUbl4BvBvtW2JAokjG2dtk7KPEJ9Shq
        5Eh4yiFrIAMZmwGGdZTBzQfXj3kgadhISraqH4emcnmsVdhVywi+9P4xu3AFHaBT
        nZWf9VpS06ydtiIg5dOmPHKcGZ411UlzLAwHqg5r2UmGyDAiI8JLDheQIlDq2LfS
        1/0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667749796; x=1667836196; bh=2RExpLgU9g1N+kqrPRFMdAkMdWjT
        7WLqNDmpPvDQ17Q=; b=ZCBNc/BUa/qNzefy+yhJM+dcOSlUenf99lBMJGGmtaPS
        XdlSmmhqTdrvUZY6cQE5EAZcBPwWRxaARENTLhdeTlbItl7EfUDSkrxM9x+IuzWH
        Snp/Brj1PGVvXB9azni1q2npz6prh+naw4c+XPhei5mHxmg9WNbnd87lALgCdOTP
        Suv1a+yX94bZwXClzCBGROkFhjjr4y+ai59peTzKOtzkS4KTReG7TbJvEerCN9tE
        3x3xr2xRo5jSuMUAzNswfBZoErv/xRpRy/IKFPwiv4izeXTxUwJnZWsRloaLXBYd
        Sf/8TvFmRA7LAEUDtdFNpv16UJ+69ow6PELtHXBSMg==
X-ME-Sender: <xms:pNdnYyI3q7euMRFPQdA9gcg20ASDsAviCGJHa0W7H-4FT5kd-sNPPg>
    <xme:pNdnY6IhvZ4DJ6kK0m_c4EI-jHNM_oN5_THAzyfv89T--5baPor7XfDl3VVQcuHJS
    CW72OD5nqGjPbyHUhs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdeigdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeduiedvgeekffdvffdtkefhhedtjeduleffleegleefkefgueeijeejueek
    gfdtffenucffohhmrghinhepshhpihhnihgtshdrnhgvthenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdr
    uggvvh
X-ME-Proxy: <xmx:pNdnYys2d_fjlycfGIvKnoe_0GI9blBLCIBps-jvOSB6FKbG5rTQOg>
    <xmx:pNdnY3Ye9Pazw9PaGEgJz9l-Pmk4rvAo3kIAZ1YmkSuqQbVomK6gPw>
    <xmx:pNdnY5bAWh74a2sGmia9HKmcC-aArMCeJv87PVWPxNWkU3Kg_Ar5zQ>
    <xmx:pNdnY3P_26aZxbhFZe6LB41pZja6RekhVgEankWq7aLjy_86wsL8VA>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 38700A6007C; Sun,  6 Nov 2022 10:49:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <47fd4a93-8544-41eb-9ddd-1501b9006cf0@app.fastmail.com>
In-Reply-To: <20221102141513.49289-1-fnkl.kernel@gmail.com>
References: <20221102141513.49289-1-fnkl.kernel@gmail.com>
Date:   Sun, 06 Nov 2022 16:49:35 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Sasha Finkelstein" <fnkl.kernel@gmail.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
Cc:     "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] PWM and keyboard backlight driver for ARM Macs
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 2, 2022, at 15:15, Sasha Finkelstein wrote:
> Hi,
>
> This is the v2 of the patch series to add PWM and keyboard backlight
> drivers for ARM macs. The changes from v1 address the review
> comments on that patch set.
>
> v1: https://www.spinics.net/lists/linux-pwm/msg19500.html
>
> Best Regards.
>
> Sasha Finkelstein (4):
>   dt-bindings: pwm: Add Apple PWM controller
>   pwm: Add Apple PWM controller
>   arm64: dts: apple: t8103: Add PWM controller
>   MAINTAINERS: Add entries for Apple PWM driver
>
>  .../bindings/pwm/apple,s5l-fpwm.yaml          |  51 +++++++
>  MAINTAINERS                                   |   2 +
>  arch/arm64/boot/dts/apple/t8103-j293.dts      |  20 +++
>  arch/arm64/boot/dts/apple/t8103-j313.dts      |  20 +++
>  arch/arm64/boot/dts/apple/t8103.dtsi          |   9 ++
>  drivers/pwm/Kconfig                           |  12 ++
>  drivers/pwm/Makefile                          |   1 +
>  drivers/pwm/pwm-apple.c                       | 127 ++++++++++++++++++
>  8 files changed, 242 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
>  create mode 100644 drivers/pwm/pwm-apple.c
>
> -- 
> 2.37.3

this looks good to me, entire series:

Acked-by: Sven Peter <sven@svenpeter.dev>


Best,


Sven
