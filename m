Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9576D5B37
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 10:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbjDDIve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 04:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbjDDIvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 04:51:32 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A79188
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 01:51:31 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 05D685C0165;
        Tue,  4 Apr 2023 04:51:31 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 04 Apr 2023 04:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680598291; x=1680684691; bh=67
        isl9eQNghJhQ+dEJgQI/wOLjmDgE+mTJ0AMj2dpxc=; b=WmcyZbl836AIO8Ku41
        O+wfdOrm8c8m/CCY1xxkIgd2e0B3zyXxFeJn0nV/gaMkNWg+wiZ9rFESy5dvnx4m
        CfOe/mruIeXGelPBkmv2K2CgMe49r30SQJCfSUF0xw601XuBWi37uFwssBkhLHt5
        cK9e7zRiq0wZG5yt++2CyxGV+QofZL7H8jKjxqtpOWizt+xg6yhtpaKCtpVaINQt
        dwPedVpr6YpBwdJkirPK743/TTIbUWbGZVFQ3CTRFQbNSm+oTOdHzFE+et7e6ljN
        1vmBIAePt3SdrkP8wgHk/DiWgPlHeyFd+rPOU2jntCdQfQIUeX5dR0xr9iQBNHZH
        wDwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680598291; x=1680684691; bh=67isl9eQNghJh
        Q+dEJgQI/wOLjmDgE+mTJ0AMj2dpxc=; b=ePzBgwM0GFySE6QciebTzMmgJsP+L
        3Iy6Vm6pK1ToNVMZfrsQc1LGMG8JTIfnhFfuCLf+lj1EtW5kRxwqNXSXU+WACF2A
        hDLl/VGUrr/y+KKjEKPy4ovIVkQfmnk9/NVV3DGt4YjCwNNwwFol9IuK+KB+Rtar
        OkQFffg93nYoaRLb5ZMSz8i99+UmHmrJ7QoeFaGnNMEC22uLCclVb4lpvg4YXyrq
        F/SUVY32XrxznuVqALkJ+b1PBiacWcgLyfhEYLzFkZCmdA36M1oAqc5vp8B0EEBP
        L14k/De2y5mCGEhUi8aYL8ZwaZIKXF5XG5DgwqLyS06NqhtUDsm/ZF7rA==
X-ME-Sender: <xms:EuUrZPSJ-cjLXgKjSqJXy1odDT6SFqDnYatVgxFVqcz6TxgoGI9dqA>
    <xme:EuUrZAwRF9FJh5eW7XBukl8HeyFYOhuGr3iM6Rt8fJFgC3Rg6UMDA4GEwS1pMndLR
    6QPHpC_v-8LMmAzeNk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiledgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:EuUrZE1ik9aIxFiKYFDTMRUXj8N0NSbdeiixxGoDpmZhpKTNJyVGDQ>
    <xmx:EuUrZPB08XDGIMerWXuC84evNP-veW-ZTN9yMQLgI2Uw2ki314ko7A>
    <xmx:EuUrZIguYi-R-PDASN9wJ1VoraiK3chzW3ZBE1dxcC17-j93LyqC1g>
    <xmx:E-UrZAfQ7gKZLfBRVGyoIszRy_PZdtH84cCtud7N5RAf3gnQhzM82A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 96A69B60092; Tue,  4 Apr 2023 04:51:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <283f8f4c-9f8d-48b1-b161-3b712104583b@app.fastmail.com>
In-Reply-To: <20230404084259.13752-1-rogerq@kernel.org>
References: <20230404084259.13752-1-rogerq@kernel.org>
Date:   Tue, 04 Apr 2023 10:51:09 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Roger Quadros" <rogerq@kernel.org>,
        "Russell King" <linux@armlinux.org.uk>
Cc:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Thinh Nguyen" <Thinh.Nguyen@synopsys.com>,
        "Nishanth Menon" <nm@ti.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: multi_v7_defconfig: make USB_DWC3 as a module instead of
 built-in
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023, at 10:42, Roger Quadros wrote:
> USB_DWC3 is not required for boot on most platforms make it
> as a module instead of built-in.
>
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---

Does this save a significant amount of vmlinux size? Since this
is a fairly common USB driver, I think it does help to have it
built-in for users booting from USB_STORAGE or nfsroot over
USB_USBNET, which are both built-in and not uncommon.

     Arnd
