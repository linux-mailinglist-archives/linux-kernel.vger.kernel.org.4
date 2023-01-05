Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69FF65E82A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 10:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjAEJqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 04:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjAEJqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 04:46:46 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A14568A7;
        Thu,  5 Jan 2023 01:46:31 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 1680332009EC;
        Thu,  5 Jan 2023 04:46:30 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Thu, 05 Jan 2023 04:46:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1672911989; x=1672998389; bh=Re
        eVYXXoQmzg71a3dadwFOkrgyrpB9RqBRBioW6WdJs=; b=I2317b/qhr65GwM/6z
        vChVLjQhL10Ejzw8xfejgdexJTug92mRZ+vsQwnQv3r3NDYRM41y3Dwg/WCa3vPv
        b1hofr6VFaQQBuQbXkc4WMuEGrcwSOoC8iItbsisxPzjMSXvzsJoAbpayTzjU/Su
        JBnnOXkjiFvjbnDYtarqMLzWG6dmZWprYg325fR8v8WDfdbqmaOrGLOdJb+YU2Kb
        cH5GpG8dLJh9YaG8VaLrCXA2pMQmo04n10q4mDd3xRojSpvSVmuUjPFhWUq9gr0D
        MEcI6i+FLTNlPwI97rzZWLjzZMs4SwPtWweBBILP3a/eutnD02fkbdz17DHEPFzZ
        djCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672911989; x=1672998389; bh=ReeVYXXoQmzg71a3dadwFOkrgyrp
        B9RqBRBioW6WdJs=; b=XEck3zsX/E54i904WdfhmloqKiUKZ33P8zLL0aMEDui4
        Yf6RRO1E/c6etJ+W6CwPrLvEoeHJ1zCgdKMTqluhi6r2L/Iv8pnaJDY03zH6WcnG
        tmvSnZHlGkI5BIzVh3L54Pm099Veo1b4qG5OLX3wCevlC9LpWkXy/E9edgfalZTu
        oTSdCEq9wQdX+OLytu4TwiMUNU2kdwQH90w6pfFXmA3168m3teyr4lQN9JZzdMOk
        PHwWHglh4KL2kn2ctt1L7kJr8L+YHygdKxYJP5YZGGTZEApnggqUA6wqijGi+mFU
        r6XuP+KsQr7DE5QSDIBw2gRqjf9103HIly7HB1Fhvg==
X-ME-Sender: <xms:dZy2Y2yU4yQ52ytV8RCTZRNnk5tLzFz17ix6yp6wVI_vjsKjxmOJQA>
    <xme:dZy2YyRWxe8OkPOBmQ0iskudIE1deB0CeqCpVTUncRCL2Ki69sH4C0P7JZAqhGF8j
    H8xiwuBWdXCvQM6JAY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeekgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeelvefggeffheevtdeivefhkeehfeettdejteduveeiheevveeilefghfei
    veeiueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:dZy2Y4Vd-voPtt_MrRPdEWGzvuVY9Ii7FK8Xk5mdFfygC5MVG-1p6w>
    <xmx:dZy2Y8i7Hp7ZWPK4IX40Le0Y3byTtcb2BKbF8R2mwozKfz0j9__wFA>
    <xmx:dZy2Y4Bob7iVlpOfi5sOUZ8eHeB958WeStsmfFZwrqeennA2BgcHaw>
    <xmx:dZy2Y84agZ0du63ri5bZfV7GunpI3wZ-IdTYzFQkajevOqUb5f3T5A>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6F1C3A6007C; Thu,  5 Jan 2023 04:46:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <2267ef84-a167-4cd6-86fd-725e064eae62@app.fastmail.com>
In-Reply-To: <57a52e19-e121-6082-a4d8-f58ade353782@marcan.st>
References: <20230104110013.24738-1-marcan@marcan.st>
 <20230104110013.24738-7-marcan@marcan.st>
 <228a80d4-752b-42ae-84b4-47197ec82c24@app.fastmail.com>
 <57a52e19-e121-6082-a4d8-f58ade353782@marcan.st>
Date:   Thu, 05 Jan 2023 10:46:09 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Hector Martin" <marcan@marcan.st>,
        "Joerg Roedel" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>
Cc:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Janne Grunau" <j@jannau.net>, "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, iommu@lists.linux.dev,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] iommu: dart: Support different variants with different
 registers
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

On Thu, Jan 5, 2023, at 06:16, Hector Martin wrote:
> On 2023/01/04 22:43, Sven Peter wrote:
>> On Wed, Jan 4, 2023, at 12:00, Hector Martin wrote:
>>> +	u64 enable_streams;
>>> +	u64 disable_streams;
>> I don't think disable_streams is used anywhere. I assume you just left it in
>> here to document it?
>
> Yeah, we don't use this field ever, so we might as well drop it. I'll
> leave the #define for T8110 in though, as documentation.
>
>>> +	u64 ttbr;
>>> +	u64 ttbr_valid;
>>> +	u64 ttbr_addr_off;
>> 
>> This name confused me a bit since off sounds like offset to me while
>> this is actually another shift. Can't really think of a better name
>> right now though. I'd at least a comment here to describe it.
>
> How about `ttbr_addr_field_shift`?

Sounds good to me!


Sven
