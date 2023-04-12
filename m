Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2971E6E00F2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjDLVeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDLVeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:34:23 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740A17A84
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:34:22 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 013763200991;
        Wed, 12 Apr 2023 17:34:18 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 12 Apr 2023 17:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1681335258; x=1681421658; bh=J86eK8P/5LXOc1wbChINVEAn8dtQJQ28ybu
        RVVusRCU=; b=Q6e82Rgf1xRSjfxccHh+Nog/2EhLW656s8ZyFh6qc16KRR42Qjh
        qJbkMEiYFDHS4knGIXPhGEprfuqjYo2SWPKCzfXUDJJvgFO4r9LR9NMmJwno25fF
        YlVvHsZysIEhfcisO1p1jUjk3VSpucGITBXneCAhL7m8DNd3K1v7IFgoap3CQcxm
        iavSfmO9XRJUtZOP4c2yqgbo/wXByDCBdDDy8BXmosIYtaHIp0pc8FyrRrz+EKc9
        NVfmE5a3vNK5Ee+fYW2rOXFWouqetQt2pX8ZjhJJwMYYt7mPlcezcNji45+gaHLr
        7Na2Jj2QDVdAfOPF/dT+veArnmYHO2Nx2NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1681335258; x=1681421658; bh=J86eK8P/5LXOc1wbChINVEAn8dtQJQ28ybu
        RVVusRCU=; b=k6D4bWk6I7odZ+VJN9R1AvBhxSW7E8pvvCB94nlT9QaJOscrT/3
        pdPWr0ARdCyV5C+0iczyqpCzo4u5zirLk3R4ttvijaLhvb3IC/qVSYtZarEt/Hg3
        myWbGnyevLac5TGEFEPF56Bu5T17wOkhvoWBjMtruP9vwm1+aOIvtPIiNPBKn0ZI
        rd8Wz/8iAv1++WepuKykXoYWVvX4rLApLXApfrZbvw3yrL3lGHAHT6JZHTTkyH+/
        PFzsm274viKiqcGaL93Ju9+NhcpcFSK9AsNXJv6aVSuPUR1MEqeKiPL0U3fvKkf/
        w0vJA9Yzqs2Z/hqv1gMJwxULav1e+SUtl4A==
X-ME-Sender: <xms:2SM3ZDzZjKMdJB9MsKBBZmxHHW0SVirwWFXWFOreucx9z3TC5z1D1g>
    <xme:2SM3ZLSCasFcND5AdE2Qe8aOyj04b3AD6rsIuzRUzqu6seVLzTZypP8f-HoG6v6la
    BJjONfX9kMMwisbwmY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekjecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfgjeev
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:2SM3ZNW2F5kNFdlFdv3XLyyVOoeAeYOzYvxhyvzCPfdt59OEvdWAqg>
    <xmx:2SM3ZNiimwTdFPxKukgigT8PofKsNoid8nXn63TciGgbfE_3GsgpZg>
    <xmx:2SM3ZFAq9nX5ve9KrWtO_wAL-gb46-UYCK26kTMuUFOUsZY6wzpTvQ>
    <xmx:2iM3ZNY_4AmfNdDQW9T66PnXQIcbwW2UNqz5mRrqW5gocGCWUzdCKw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F264AB603F4; Wed, 12 Apr 2023 17:34:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <9ae523ae-aad4-40b1-8b6b-d5e18bf8b92a@app.fastmail.com>
In-Reply-To: <20230412212126.3966502-1-j.neuschaefer@gmx.net>
References: <20230412212126.3966502-1-j.neuschaefer@gmx.net>
Date:   Wed, 12 Apr 2023 23:33:15 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-arm-kernel@lists.infradead.org
Cc:     "Russell King" <linux@armlinux.org.uk>,
        "Nick Terrell" <terrelln@fb.com>,
        "Tony Lindgren" <tony@atomide.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Sebastian Reichel" <sebastian.reichel@collabora.com>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Xin Li" <xin3.li@intel.com>,
        "Seung-Woo Kim" <sw0312.kim@samsung.com>,
        "Paul Bolle" <pebolle@tiscali.nl>,
        "Bart Van Assche" <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ARM ZSTD boot compression
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023, at 23:21, Jonathan Neusch=C3=A4fer wrote:
> This patchset enables ZSTD kernel (de)compression on 32-bit ARM.
> Unfortunately, it is much slower than I hoped (tested on ARM926EJ-S):
>
>  - LZO:  7.2 MiB,  6 seconds
>  - ZSTD: 5.6 MiB, 60 seconds

That seems unexpected, as the usual numbers say it's about 25%
slower than LZO. Do  you have an idea why it is so much slower
here? How long does it take to decompress the
generated arch/arm/boot/Image file in user space on the same
hardware using lzop and zstd?

       Arnd
