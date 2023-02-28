Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6DF6A5DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 17:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjB1Q4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 11:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjB1Q4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 11:56:32 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABBA36080;
        Tue, 28 Feb 2023 08:56:07 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 72B3F5C0181;
        Tue, 28 Feb 2023 11:55:54 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 28 Feb 2023 11:55:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1677603354; x=1677689754; bh=D3O9AUaCP9
        tpAOYmxIG1pQXKHoCpHcgtdW48jYJAEyk=; b=iMjEX4ziqOBY6thDteXk6LobVr
        8GW57Xr366EZE2GkRMATNS5cOrA2iNXvBvBEv7wJBGhn3Lkul6eyB6hjOv/pSpYT
        Zhl33op7B0/BduSy7DSflQH/8qnE05JEex2Xj/1huJzhilXcyFAystiB0AZAle0M
        kF0lzMhLpMo+f2IuxpGy3IHrYrrY0w1jpWh/alcuP8N1kN/VLgPM864IpvjCjvel
        8hMWjSMhthjWdiUiWIFvlTHIKEAcn1OXDuXo/7mwKuevtNihSi4RnpMHFjPHnO21
        eF+JLDK5HXUUmjPJIAbBuWJ+1pfiMPEPUncAjlsS1QbA6LdyJXZ0gifpsq7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1677603354; x=1677689754; bh=D3O9AUaCP9tpAOYmxIG1pQXKHoCp
        HcgtdW48jYJAEyk=; b=VWI/HOjsxeOqtxSgaCYWETXClPxhI9Ty3GWlPAWxdRYe
        81wxreCo0UbHBRlod5xHM2Ckqw8Hv+JwpsCQsmlLi0ZIGA4LsF1ZcFpP8QlMDm8T
        4+3FwiePSBvUorFloZDBzJVsb6itaKOmEZsdYG4kEliaLvw27lo0Fu3SctjSlzAu
        NF12FJ4cWvaxkKrznIbHMzqvhS+305KSdc6AyNffG3zT2iqRjM3hHL+OQclO8TVd
        gL3QmQvbwWAWARJ6r5sJzIxyBvDzTKOyIZrAkkbhfx/xfo0hLXXC8GpfbWqiz7dt
        POXD2ffjUSEPeFs4+UdKUL9hDCeh79Oo+NADgKoUcw==
X-ME-Sender: <xms:GjL-Y6OG2EO9xdgF2pNrwa-wwKTKDhdfkEQLYJoenBb7CAioRzziBQ>
    <xme:GjL-Y4_hYSx0l9yly-TnpgPM7GfebLp1Lf2E5zil6HJINZ0fzb_eivzUoB1kpFT5t
    S7ZPwrr-oenUJWO_9E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelfedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:GjL-YxTch79ljI9nrxV2j485uua9b8p3wAX1jaYnWPGNBf5emULvmg>
    <xmx:GjL-Y6sY5hvPQvzbtBGi9Xf9Jz5CybvCKQ1LLKNaKbGbdsKD83aswQ>
    <xmx:GjL-YyfnCd9Qfb4FGOxCOi8prYJLXlzjw0nZwltqlrMuTQrgfWO0YQ>
    <xmx:GjL-Y_EZFRLhckUY7DHs_sYeH5NRPxruGXSR0_AlWBi6vD9VkJpxIA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 28EF1B60086; Tue, 28 Feb 2023 11:55:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-183-gbf7d00f500-fm-20230220.001-gbf7d00f5
Mime-Version: 1.0
Message-Id: <1e69e526-c270-49a0-bf00-8418d1aed121@app.fastmail.com>
In-Reply-To: <20230228164752.55682-2-manivannan.sadhasivam@linaro.org>
References: <20230228164752.55682-1-manivannan.sadhasivam@linaro.org>
 <20230228164752.55682-2-manivannan.sadhasivam@linaro.org>
Date:   Tue, 28 Feb 2023 17:55:33 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
        "Bjorn Andersson" <andersson@kernel.org>
Cc:     "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/16] arm64: dts: qcom: sdm845: Fix the PCI I/O port range
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023, at 17:47, Manivannan Sadhasivam wrote:
> For 1MiB of the I/O region, the I/O ports of the legacy PCI devices are
> located in the range of 0x0 to 0x100000. Hence, fix the bogus PCI addresses
> (0x60200000, 0x40200000) specified in the ranges property for I/O region.
> -			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
> -				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0xd00000>;
> +			ranges = <0x01000000 0x0 0x00000000 0x0 0x60200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x60300000 0x0 0x60300000 0x0 0xd00000>;
> 

This fixes the offset, but I wonder if the size of the I/O
window should be changed as well. The normal size is 64KB
(0x10000) per bus or less, while this one has 1MB.

It's probably harmless since each device would only use
a few bytes, and most devices don't need any I/O ports
at all.

     Arnd
