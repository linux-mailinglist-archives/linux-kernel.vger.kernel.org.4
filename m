Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71066A497D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjB0SUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjB0SUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:20:06 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21BD244B3;
        Mon, 27 Feb 2023 10:20:04 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 476C65C0036;
        Mon, 27 Feb 2023 13:20:00 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 27 Feb 2023 13:20:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1677522000; x=1677608400; bh=RVTlLb8n50
        XGcQuBIt7qqzi2yYXGnyOm8P26ox+Wrpc=; b=GaD5doaretM6A1f/fO2rhersoK
        SXJ83sBxCfFA8RkVSbIYnTKJXGHnKWGyn9A3ri5dFoiHOBYcMoPGA03dNRsDBidA
        8phOORR91nRFKwsNvKRa6A56tMUTPFFsv37Ciyb3Xm26AZ3/E/gH+2kU43NxGmZg
        ixxLL8eLwO1S/sDosBhrPqGxzVcYqrIS13EdjOtW6LKT23zfFrYfYT5JuXJlq7BJ
        8ZTj6gfXP/PxUEMhLbnhVMMxPN+V6MOlRXo0GpoLb8fBJW+aHZt8sAz5xqLzxzzs
        /oT9w2pb05YIV0VBsIEusiWHCfwWvOegxLG1ta+YMNXaGjv/XWnRQvjH8aaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1677522000; x=1677608400; bh=RVTlLb8n50XGcQuBIt7qqzi2yYXG
        nyOm8P26ox+Wrpc=; b=rfdkkmaJPoyqPw1pChMyE+KI/R2Q+KyLxSMO6D2qCqzi
        2/FsOmlysVLym22AAK5T6GGZ8qsF8HkWl+4zVL7Z0+yHsjvDGGN2TGSerhktz9jH
        IP0HyMlrh7bas8a9LgOP4uNyprcMSE5UMg78rxiWzgVWOE3jw5PvBfX/mKfRJhhx
        Y1X8mRfAxLOCwJDEWbvVTxdnDNOLhjQ7+NUMKEoouAiPa6SSUTD4UvEVxUFJrSO6
        39gZSjK/ud3GojuGY4ecaznmqDpG3yE1a+8M1fehe6K1uFYnKGd9yZprur+tD80Q
        ZiwCwT7jI8hnhygjVRaS91+prES4B6Bli0lk5USm8A==
X-ME-Sender: <xms:T_T8Y991Y2CYNjbOBfzfnEpnUmwoqWc9Ikpie93O9dfbahgNitSQ1Q>
    <xme:T_T8Yxumybl14yhIjSmGX11dSePAAPs42_BuH9kPH6V-rKxPwK4jg-zqObQRyYhY7
    vU_RriZA5-y1IEmw1c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeltddguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:T_T8Y7BTXMg7bXhLs4vPXXijkAoBSpNpMRiURxB-itlPWWks_XFFAw>
    <xmx:T_T8Yxcuo03NCUAntT-86Nl9Bw4faYTm6XWtd9oPv0pHfxvClLXQ8Q>
    <xmx:T_T8YyMOW1UbNP54OL071P_S35YAq-qHZi6CCw704CLBUIm3vvI43Q>
    <xmx:UPT8Yzlm-Az41o5oGDJNui__mBIaWjEF5-a9e8jmkbAluMfFXAUbBg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9C132B60086; Mon, 27 Feb 2023 13:19:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-183-gbf7d00f500-fm-20230220.001-gbf7d00f5
Mime-Version: 1.0
Message-Id: <7d29f3fd-b8c8-4687-b6a0-b8956dd39f0b@app.fastmail.com>
In-Reply-To: <20230227165049.4y7jx5nnnlibe6kg@CAB-WSD-L081021>
References: <20230222115020.55867-1-avromanov@sberdevices.ru>
 <8e5f9bfa-d612-cd43-d722-d04c40938c62@linaro.org>
 <20230227142809.kujmrraf3pcdhqyn@CAB-WSD-L081021>
 <f3e42012-609c-4085-b4f4-bd32bfc34aff@app.fastmail.com>
 <20230227155100.hhl4yvkyfqfyoa6h@CAB-WSD-L081021>
 <a5fa8b23-4ec8-475f-be5e-538b53d6f82d@app.fastmail.com>
 <33b58877-5167-c453-e686-1d10cdca66c0@linaro.org>
 <20230227165049.4y7jx5nnnlibe6kg@CAB-WSD-L081021>
Date:   Mon, 27 Feb 2023 19:19:38 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Dmitry Rokosov" <ddrokosov@sberdevices.ru>,
        "Neil Armstrong" <neil.armstrong@linaro.org>
Cc:     "Alexey Romanov" <avromanov@sberdevices.ru>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        "Kevin Hilman" <khilman@baylibre.com>, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com,
        "Linus Walleij" <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v1 0/3] Meson A1 32-bit support
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

On Mon, Feb 27, 2023, at 17:50, Dmitry Rokosov wrote:
> On Mon, Feb 27, 2023 at 05:38:49PM +0100, Neil Armstrong wrote:
>> On 27/02/2023 17:15, Arnd Bergmann wrote:
>> > On Mon, Feb 27, 2023, at 16:51, Dmitry Rokosov wrote:
>> > 
>> > Most of these don't apply in userspace, so the incentive to
>> > run smaller 32-bit userland on systems with less than 1GB of
>> > RAM usually outweighs the benefits of 64-bit userspace.
>> 
>> Thanks for the details!
>
> Looks like Thomas has already prepared a basic patch series for buildroot,
> but maintainers declined it.
>
> https://lore.kernel.org/all/20220730194331.GA2515056@scaer/

I see. I know very little about buildroot, but it sounds like
there are other ways of doing the same thing here. In general,
this is pretty much an Arm specific problem. While you clearly
want compat mode for small userland on any architecture but don't
want 32-bit kernels, arm is the only one that has a different
kernel "ARCH=" value and needs a separate gcc toolchain.

If the problem is only the toolchain, an easy way out may
be to use clang instead of gcc as your compiler, as a single
clang binary can target both 32-bit userland and 64-bit kernel
on all supported architectures.

      Arnd
