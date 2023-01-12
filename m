Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF26C667369
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjALNkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbjALNji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:39:38 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434615328A;
        Thu, 12 Jan 2023 05:38:18 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 13E4E320091F;
        Thu, 12 Jan 2023 08:38:15 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 12 Jan 2023 08:38:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1673530694; x=1673617094; bh=AUwDiqbFDe
        X2Nj1CtP9M6Y4zqsgZ3faiB0PqaW+QDig=; b=hVkHYJ/Whep0xqpAdw234/glts
        AD3tk2/jwkqQ5x7vFPlraFFkvot0AK5QZZqVuV39y9kusOuMgGlz1fotAnHH/LCq
        s+Aa7K2o4x8QY+O4nX8+DH0G6LFQ1zl9l57r7Ru9NnpqTf8FzpWdIHNYCNjf8Z7q
        Sk8tHO8QE6pauDLKlTdK6Ii9g1oXGJj3K25+WFj9GkQHWU5JGWyHnqVWC1TDKWHY
        wlCVpzOw9Noiq49+kQRsmbBs5fLTWwo+rj6wDVGymQ8CufdwWOJSy8A8mKfXixBI
        19nND5JlrNDnRtALg0Sk+UE7guonlsVbLsdoi+nkvvsWodn9hDYZwbOj+XHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673530694; x=1673617094; bh=AUwDiqbFDeX2Nj1CtP9M6Y4zqsgZ
        3faiB0PqaW+QDig=; b=K1Xm+DUwj8KK0hyMthZkyiAb7dda3/cnF8A2IR9A3Sa3
        RFdlsypem43Lv5i6KPzdFqi0jLccovHEiFQ8/0ErQ99yAGO+/MXG4q3M2ZYqyx/B
        mNszyu/a1TIid7Rs0Phg7JIvh67wPBawl0fUTdiCZ3wTJxcz1j5nRiomoTCImuvW
        SEWOpPrfI+9KuSaXRnLnf0Y+4+CQNOLVKWy436zzfMi8wPMC7kGGvW+ttFKVC3P8
        iRiQ/qz9yi4e6OUmNSjnJgr6QWXPsayuMLw4RJePwFSario9UEsBjqEm+SWLQK9Y
        plbMxYciM6WmbLUINlo8uapyh8nCKWdUbQbVnchR7A==
X-ME-Sender: <xms:Rg3AYwlVuUR6Kt9eCVs1HWHHD_dYF00U4vwAPLTZCFSaqYw6-eweiA>
    <xme:Rg3AY_1mkT_JSRwzfniBg8CNpPXqWNpyJuc61I7mmBPvw4dH1_qtRg77Rwlu8TU2C
    0ZveRquP_VMvute4EU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrleeigdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeegteejkefgtdekteekvdeukedvudegjeehkeeuheegueekieeuffelffdthfeg
    udenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Rg3AY-p_DAJqPt_wDqgNTbRrlTtiwVMjpUUXhSyNpk4CM3VJfCZDvw>
    <xmx:Rg3AY8ke2jZYVspAP9ODfXactKIGrGkHDCgq64uQYZK0TqXytVb8cQ>
    <xmx:Rg3AY-11Fz6hWWvNGLgPGfrRVmwQefQN0aOpNHyhFAffAR0AmPLTUg>
    <xmx:Rg3AY8yDyBGnm3cWtHJV_-T9U3UntFbxuusJmhkxLA7OlXxf3HzAfA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 34F3DB60086; Thu, 12 Jan 2023 08:38:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <48cd3e28-f1db-487d-8971-473dc8c12c09@app.fastmail.com>
In-Reply-To: <Y8AIHDizIqu9u9BR@enigma.ccjz.io>
References: <20230110042533.12894-1-clayc@hpe.com>
 <20230110042533.12894-3-clayc@hpe.com>
 <110af65f-9c18-524d-a073-ef7be60d1f5a@linaro.org>
 <Y8AIHDizIqu9u9BR@enigma.ccjz.io>
Date:   Thu, 12 Jan 2023 14:37:53 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Clay Chang" <clayc@hpe.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        "Russell King" <linux@armlinux.org.uk>,
        "Olof Johansson" <olof@lixom.net>
Subject: Re: [PATCH 2/5] dt-bindings: soc: hpe: hpe,gxp-srom.yaml
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023, at 14:16, Clay Chang wrote:
> On Tue, Jan 10, 2023 at 10:49:36AM +0100, Krzysztof Kozlowski wrote:
>> On 10/01/2023 05:25, clayc@hpe.com wrote:

>> > @@ -0,0 +1,36 @@
>> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> > +%YAML 1.2
>> > +---
>> > +$id: http://devicetree.org/schemas/soc/hpe/hpe,gxp-srom.yaml# 
>> > +$schema: http://devicetree.org/meta-schemas/core.yaml# 
>> > +
>> > +title: HPE GXP SoC SROM Control Register
>> > +
>> > +maintainers:
>> > +  - Clay Chang <clayc@hpe.com>
>> > +
>> > +description: |+
>> > +  The SROM control register can be used to configure LPC related legacy
>> > +  I/O registers.
>> 
>> And why this is a hardware? No, you now add fake devices to be able to
>> write some stuff from user-space... Otherwise this needs proper hardware
>> description.
>
> Thank you for commenting on this. You are right, this is not a real
> hardware device, but simply exposes MMIO regions to the user-space.
> Maybe we should rewrite this as a syscon driver. Is writing a syscon
> driver a right direction?

There are two completely separate questions about the DT binding
and about the user-visible interface.

The binding needs to properly identify what this device is. I don't
think anyone without the datasheet can tell you the right answer
here, it really depends what the other registers do. If there are
lots of unrelated registers in a small area, a syscon might be 
the right answer, but if they are all related to an external
memory bus, then categorizing it as a memory controller may
be more appropriate.

For the user interface side, I don't really like the idea of
having a hardware register directly exposed as driver in
drivers/soc, this generally makes it impossible to have portable
userspace that works across implementations of multiple SoC
vendors, and it makes it too easy to come up with an ad-hoc
interface to make a chip work for a particular use case when
a more general solution would be better.

Again, it's hard for me to tell why this even needs to be runtime
configurable, please try to describe what type of application
would access the sysfs interface here, and why this can't just
be set to a fixed value by bootloader or kernel without user
interaction.

       Arnd
