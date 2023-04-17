Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EC76E4B89
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjDQOeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjDQOeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:34:11 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC88E8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:34:09 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 5D9125C010F;
        Mon, 17 Apr 2023 10:34:08 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 17 Apr 2023 10:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1681742048; x=1681828448; bh=5w
        HADxpamxOhsMSAMwbSDLMLWu3tas218Jbf2vjpkPY=; b=AbKPbXXB95thEch+GV
        aMyLlDB7ZUbxtxvCEH2VT0T3UXqx/bd1n8tjrP1i/GAhkxs61iGDdsrfqlm+HIUr
        c+pO5SM5EYlquV0lcpOVxxD8b47YE4TH6f53rCnooxEhpsIYuPFHqJcv4RgSp2f7
        UMAahDSIWRDcVccfH2LZOwMUbj6573hBeHDKt2CIRTpAjMZczmQ3+SrJIGE1dIWi
        S7VNPGP926Dh9puUMgFLP6QCdVYiuxEjPeVzOKs+/HHlJFxoTciPn09b356KcT/Y
        dOFe+89RrrQliM170m53a4+K1tvC8TRMVwh0UK9Hr5W9yctN66rmfm7bJbgPQaUp
        vdWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681742048; x=1681828448; bh=5wHADxpamxOhs
        MSAMwbSDLMLWu3tas218Jbf2vjpkPY=; b=hM1k5CTBO5I4HXjfYz0RcO65/71K1
        IqumLVAP3Ib/Ojw35fHweSKVgS9EZHasmNiIZMJ+SjnCJ+DxJ9/vc2Tj1hQmz3/Y
        wO4jHfepA/ld3tw1TgdG05weQlogot/3lT0Y8Lqca8SLYvQplZhq5D9Qn47uQ7pr
        v0Bmb5dOfrdgeJODjx3aXNjUFFymBKSw/e2Ei2MubMizEFTRmJ/hTwVFHoclKoT+
        XLFNV/F3usHGhSN+ErnSE7Gc63SFIzIoBdwlnWK5v/63V1vHYL2hE8i2xr0h8rJu
        0rR3psJf95bxeK84wxeh+GxeUL5sOoGuVC6ejMbJ2d2UwclKzKIvZKafA==
X-ME-Sender: <xms:31g9ZAFwC-pHSYAWuPzXVo8EkSpw65VSfRXAMEHliNlBm--rSyNsLg>
    <xme:31g9ZJWyYVQ3XuOG83h33HpDz6F_ojQosehXayzHiX98tyubPRC10FLukQQzDzxqf
    N33QJJ0ZY4QPMUIL1E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeliedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:31g9ZKI_x4LkYNK3mYhBX58C35DyabVRYv7d2AmGL9mMIo0rakERQA>
    <xmx:31g9ZCEQPRxVtfzUKqtV0YsFdDgMwg8KYs4yoN-nDfOuEXIMHllFKw>
    <xmx:31g9ZGVILZvCVYbEs_5CFOiStCLO_uN7_W7Uwr10Nd9ZwSZN3UDUbw>
    <xmx:4Fg9ZPU-CpWDGq86K767nDzYH9hOzgDAjG6Mgq2iAxd0aWbs-6j8ug>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8E228B60089; Mon, 17 Apr 2023 10:34:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-372-g43825cb665-fm-20230411.003-g43825cb6
Mime-Version: 1.0
Message-Id: <39d905b6-060d-4ab6-a5f1-2613af2345f6@app.fastmail.com>
In-Reply-To: <20230417132717.1990023-1-kamlesh@ti.com>
References: <20230417132717.1990023-1-kamlesh@ti.com>
Date:   Mon, 17 Apr 2023 16:33:45 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     kamlesh@ti.com, "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Bjorn Andersson" <quic_bjorande@quicinc.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Thierry Reding" <treding@nvidia.com>,
        =?UTF-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@collabora.com>, "Mark Brown" <broonie@kernel.org>,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        "Andrew Davis" <afd@ti.com>, j-choudhary@ti.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Praneeth Bajjuri" <praneeth@ti.com>
Subject: Re: [PATCH] arm64: defconfig: Enable crypto test module
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023, at 15:27, kamlesh@ti.com wrote:
> From: Kamlesh Gurudasani <kamlesh@ti.com>
>
> Enable crypto test module, used for testing crypto engine performance.
>
> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
> ---

Applied to soc/defconfig, thanks

     Arnd
