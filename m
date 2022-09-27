Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BE55EBBFD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiI0Hva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiI0Hv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:51:27 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424E82713
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:51:26 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id AC59758055B;
        Tue, 27 Sep 2022 03:51:25 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 27 Sep 2022 03:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1664265085; x=1664268685; bh=hhJBZFDAuM
        e9MRrygXN+gN6m3AyhwBPuDzBCskbFGDo=; b=gYEDmTELzHrP5CPkBsK38Zi6Hl
        A60S9uIgc4ezMYC31OkJr5/3pioXY761DKLEsYCTR81WPFm/JDUxtlySs08ltxJO
        I66N0tiGbk65ABUelzf9rt0klttNHv4QFbS8K+qVGolLA4/J+LxD6mugr61FY7+E
        en2yY7Gu9HMbF1rRaBHxD8uMP6HGkotSSNmWe+iFx0x1dSGmrEOJagRh0onDxigp
        xiYscY9tx6gmMFWXC+CNOIdSyR2wU+TDq4kxgiqvEpuzX6mUaRSnrt7c+Qcg0ItD
        GM8+lyCabaeyNdu1RoHzcTwyu9mcl3HIDDwjsd3aiMHu8UmTpTsNBDqxLrUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664265085; x=1664268685; bh=hhJBZFDAuMe9MRrygXN+gN6m3Ayh
        wBPuDzBCskbFGDo=; b=DST+9PV+3Kllyz+iJXk3P56OSqIUffN4Tga7IelqAtli
        dUTjmP88+Qew4tRMLrEdIZyd5XUXBBLZeTHFwNGNuyaGUZyRCCEtC2rMLt48HxqH
        pTnGbe/weDW3sK1KvVBp+x9FMiFqSVUiK96judw6cPk4LG622AmFfNreb2VyeKNk
        ELWSMAxxAZsXNYJn5n6rx4F+lgViskYxg3cG1YbAcSG3VjnIb0Y/oevLWJ1VoqOw
        D/VYZFRLmFWAxo/OsLfc4YX5F+NNdBOF6QalsfylTPPtmRmStUWZHJx/Pc48Yjv9
        +kvQbus6xAIWLmogQAhGylTP22PoLO2ScO+exOTakg==
X-ME-Sender: <xms:fasyY7WxXnWSOttQQs949b63fFFd5TndhfqPHUSvqYynFG735BSKLQ>
    <xme:fasyYzlkzB0cgzRgPYWks_tWlUNKE8Dy_STOaJL2gltu2mG9YhkThazW7JIEJasJv
    BEj91GAp17xx2DGuC4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegfedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:fasyY3Y6_htBAKKlNd06KXJvbHSbKUjGSUQE2ErcVcQ68rXpdozE_A>
    <xmx:fasyY2VUcNEvzgw_fQdFJUB7Dltx7OVsADmJyxl9ogZqQcJMcwXpLg>
    <xmx:fasyY1lxBrgTENNyuh43EIXpe0DO1ohl5kdrPQjLDuWGGgM5BxZe1g>
    <xmx:fasyY4uoweJQkYMMP4TvNAzoAWJMUZbmkdhcMClVFEpxKCNFI7mqrw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6003AB60086; Tue, 27 Sep 2022 03:51:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-968-g04df58079d-fm-20220921.001-g04df5807
Mime-Version: 1.0
Message-Id: <e0efb8a9-b4b0-47bf-ab84-ea71c3630f9d@www.fastmail.com>
In-Reply-To: <20220927045514.2762299-1-chenhuacai@loongson.cn>
References: <20220927045514.2762299-1-chenhuacai@loongson.cn>
Date:   Tue, 27 Sep 2022 09:51:04 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Huacai Chen" <chenhuacai@loongson.cn>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Marc Zyngier" <maz@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Xuefeng Li" <lixuefeng@loongson.cn>,
        "Huacai Chen" <chenhuacai@gmail.com>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH] irqchip: Make irqchip_init() usable on pure ACPI systems
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

On Tue, Sep 27, 2022, at 6:55 AM, Huacai Chen wrote:

> @@ -28,7 +28,9 @@ extern struct of_device_id __irqchip_of_table[];
> 
>  void __init irqchip_init(void)
>  {
> +#ifdef CONFIG_OF_IRQ
>  	of_irq_init(__irqchip_of_table);
> +#endif
>  	acpi_probe_device_table(irqchip);
>  }

I think that #ifdef should be in the include/linux/of_irq.h
header, with an empty inline function in the #else path.

   Arnd
