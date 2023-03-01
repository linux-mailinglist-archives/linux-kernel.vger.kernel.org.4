Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6ABF6A6BFE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjCAL6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCAL6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:58:09 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AB515891;
        Wed,  1 Mar 2023 03:58:08 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B40215C004A;
        Wed,  1 Mar 2023 06:58:04 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 01 Mar 2023 06:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1677671884; x=1677758284; bh=DW3WbC75cz
        X0LV0l9cu2j+K1Qv1UGQIUsfyeJalR0c4=; b=hLq3+W3boNQL75WBk1+3ShBkTz
        9Gh0/EoeQQYqXomMVJ2NuF+8u8PZb5Yk0MyShtm+eBI25C6o21OiZbRYuvYFUe+F
        6FkWSlDyP83+aDWERuh+uK/b4vp6kJQ0/rJjTHj4dGv8X+yXL5nD4+bU0+BcAary
        hL/ZaSoDuYfUoD7p/RaCWT6pNQ6DiBICr4cMHBWhMt2+kMR0z/tUNGMCskCSL3qr
        lhwhyxsPfeqWGyvGo5XGT1WghlMzUEO+/nvJlCuRFInJET99GG3mMIEVuY6vVCPJ
        Sh/wpFENA4zLWZr/vS+cl4NzPJ2ltzZBr2Gcf5y6qc7Zn4juWPyYcc6eCnJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1677671884; x=1677758284; bh=DW3WbC75czX0LV0l9cu2j+K1Qv1U
        GQIUsfyeJalR0c4=; b=FMRjJwkS5K+X0aFn3FqMwzUeQvzq24yiOf+kGLzFq802
        GwWWIeTctc4rEWpiJOHb5MAlCY2y+yoX3OCo+bomfyTKKBTanmGg7CgPgE9lCuaT
        hvaK/A32KlqwNGHJx8kejNtNWanZnLzLXPZRlz1xQtvpmhr9uMiR4BbiZi5eOFlr
        YNE52w2HH7Ruj0hWR0wLDYGeytrbBCMuyfN+LV8e0bjHwixKQcGXkYJgQYZVWdv6
        7SNMdGWoi442mXiwOHywwbO1zWqkpXVT55a6jcKDqHWamCOy6w1iB4wm8OQoVoSI
        9OqSr5xTC4EgVpVkdT2MB3gRR9olb6Eg5b/Qz43+UA==
X-ME-Sender: <xms:zD3_YwXkzxdEZqNJQiYdHWpLYWWAizy_YX87cx7F8FJi46zWkUoIAg>
    <xme:zD3_Y0mw8rwNKTnXL08Ts6EHKbcWfUp0rkt7y6gsDrfBo_H96PwleH3Y_RohzZBt_
    xYQKZ0s8R0Fp5VX2RY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelhedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:zD3_Y0b9YkYTaGxkS5tu06FYE_gtq5VGduPopIRcDwUdSBjji3TAxQ>
    <xmx:zD3_Y_UmHl0K0n8H82M33u8R27OhwF1TQiCxVLvXmZjL3V3MyZfvgw>
    <xmx:zD3_Y6l49lj89V8sSB879wFyYG5jsWP9TqhwkTrRQQRV9vsLVcgwOQ>
    <xmx:zD3_Yxv2m2lLI9T2cS9dwHSC0IgZab28m-P3A3NiswR_TSD0V27H1w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 685B9B60086; Wed,  1 Mar 2023 06:58:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-183-gbf7d00f500-fm-20230220.001-gbf7d00f5
Mime-Version: 1.0
Message-Id: <b19a25bd-7fa1-4220-b8d6-919399a9e7d7@app.fastmail.com>
In-Reply-To: <20230301112935.GD5409@thinkpad>
References: <20230228164752.55682-1-manivannan.sadhasivam@linaro.org>
 <c5e36887-f84d-40ef-bef9-8a3947bbb73f@app.fastmail.com>
 <20230301112935.GD5409@thinkpad>
Date:   Wed, 01 Mar 2023 12:57:43 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>
Cc:     "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/16] Qcom: Fix PCI I/O range defined in devicetree
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

On Wed, Mar 1, 2023, at 12:29, Manivannan Sadhasivam wrote:
> On Tue, Feb 28, 2023 at 05:58:37PM +0100, Arnd Bergmann wrote:
>> On Tue, Feb 28, 2023, at 17:47, Manivannan Sadhasivam wrote:
>> > Hi,
>> >
>> > This series fixes the issue with PCI I/O ranges defined in devicetree of
>> > Qualcomm SoCs as reported by Arnd [1]. Most of the Qualcomm SoCs define
>> > identical mapping for the PCI I/O range. But the PCI device I/O ports
>> > are usually located between 0x0 to 64KiB/1MiB. So the defined PCI addresses are
>> > mostly bogus. The lack of bug report on this issue indicates that no one really
>> > tested legacy PCI devices with these SoCs.
>> >
>> > This series also contains a couple of cleanup patches that aligns the entries of
>> > ranges property.
>> 
>> Looks good to me. I already commented that we may also want to use
>> 64KB everywhere instead of 1MB for the per-host window size.
>
> I also spotted this discrepancy while working on this series, but the size
> seems to be not universal across SoCs from many vendors. So I settled with
> whatever range that was used before.

Makes sense. We could add another patch if necessary of course, and
it probably doesn't matter much. OTOH I don't think there is anything
SoC specific in this and we used to just truncate this to 64KB per
domain. It's only really a problem if the total size of the I/O ports
for all domains in a system exceeds the 16MB of virtual memory area.

     Arnd
