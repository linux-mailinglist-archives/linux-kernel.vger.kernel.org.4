Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16D65B4ED2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 14:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiIKMlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 08:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiIKMld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 08:41:33 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376A632ABE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 05:41:32 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 51EB85800EE;
        Sun, 11 Sep 2022 08:41:29 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Sun, 11 Sep 2022 08:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662900089; x=1662903689; bh=1GZ2u26PHV
        wOoJDnASgBsAUd+m1Af4353JlGnsnz/f4=; b=ScXp8ztibFMeakt2Z9ENRjE97W
        rWlIRQ6bkbR7joS+Vbf2NKoyBPIhNBgf3FgAA6XasGfcRZsc4Qpmtl0wYGzskLOv
        t2QKQ9WIkGHhAoGCPXpKdiJuSoHQzfQOq2CQPyykRF5bn21NZKnSZhfx1dcCtuPw
        TZY0p5XFL1yd3F0QVTwsBHv1Pdk2ViXUkaeCef7ZOZQ0VC3ptnlpaQYaE+pAXh1P
        W3WWNV5Sn0ZkOqsepVn/ZUKtYe7Tfa5K+BVNx3clwRc81WJOSRKlnFa7Nc2HHdTg
        RTgReauhdFlDi/QAIW34cXW9og0zFMC9woBeqx/NWgdMkFc1OqXIM3S6tMLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662900089; x=1662903689; bh=1GZ2u26PHVwOoJDnASgBsAUd+m1A
        f4353JlGnsnz/f4=; b=eghne2qRWd1wsuKZGpIqjrPPhv5TyGTEAyn3BSZ+x6G4
        M4XzcnyADbsOcQmdOwxeQWZthGv/YDncqXBytBp+4bDaBkNMitnyiNCS3SL55lBc
        BsfDIw7GKftLimJQTelRp/BdmbfZvXpws6sORj9qKlJfecOwxZl3Kr00+KGT2sNg
        8DrPvFBLC4ZAu7BSMfKeRFe2EedkUKPvNaob0TBkznAFV3Urh70/cqjHrBgDiKE7
        IwYOjR8fax9ahMRByFctXuWYktbg0Rn0oJZnQPcNz2w1ek6YrmeNFXHy2Oyk+qKS
        2/ORLQVtuY8FeEGqVvIu1JUTraUmGpsVGXSti4zCGg==
X-ME-Sender: <xms:eNcdYxpHahCVkpQvxfZE6fKxhA0gV0Mlm4hYexMSn_sV9MjOt_RUoQ>
    <xme:eNcdYzq-D9n0nuM8lgGDZARsUsFdXS7IFVRo_ljUKU6s6FzNjgO5uNs3Pi5K9FfHp
    v2JAsEsq5CgcCfVWa0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedutddgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:eNcdY-NydDEuwzokdY6-AEcFbuzVCA0GsbdMwtnVIkaTNknIQaXXIg>
    <xmx:eNcdY85I9LUqQWafaOQxVgruPrxhWgux4pE7A5uTnpkOW7aFacNgvQ>
    <xmx:eNcdYw7Yl_Bg8_6_8LTXEUZkOn9nR3oPOkdDWCx1RBByDjwSN_4j1A>
    <xmx:edcdY9umv6K3ccyA9GaOn9ILqN-Eu1MM42_ih-1xLzudeaKPIYoAxQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CB2C2B60089; Sun, 11 Sep 2022 08:41:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <c4f3d527-7e70-4077-b40b-129144d79374@www.fastmail.com>
In-Reply-To: <0ad5f339-de31-2849-34a1-928ae65cc696@opensource.wdc.com>
References: <20220909090343.21886-1-lukas.bulwahn@gmail.com>
 <21359abe-c3c9-4aa8-8ebf-75ff64cb1935@www.fastmail.com>
 <2379456e-4f18-d619-10bf-022327de0463@csgroup.eu>
 <4b33bffc-2b6d-46b4-9f1d-d18e55975a5a@www.fastmail.com>
 <0ad5f339-de31-2849-34a1-928ae65cc696@opensource.wdc.com>
Date:   Sun, 11 Sep 2022 14:41:08 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Damien Le Moal" <damien.lemoal@opensource.wdc.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Lukas Bulwahn" <lukas.bulwahn@gmail.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] powerpc: select HAVE_PATA_PLATFORM in PPC instead of creating a
 PPC dependency
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2022, at 1:54 PM, Damien Le Moal wrote:
> On 2022/09/09 20:31, Arnd Bergmann wrote:
>>  
>>  config PATA_PLATFORM
>> -	tristate "Generic platform device PATA support"
>> -	depends on EXPERT || PPC || HAVE_PATA_PLATFORM
>> +	tristate "Generic platform device PATA support" if EXPERT || HAVE_PATA_PLATFORM
>
> Shouldn't this be:
>
> 	tristate "Generic platform device PATA support" if EXPERT || PPC
>
> ?
>
> And while at it, it would be nice to add "|| COMPILE_TEST" too.

The idea was that this can be selected by CONFIG_PATA_OF_PLATFORM
in any configuration that has CONFIG_OF enabled. Since PPC
has CONFIG_OF enabled unconditionally, there is no need to
make this option visible separately.

Same for compile-testing: since CONFIG_OF can be enabled on
any architecture, PATA_OF_PLATFORM is already covered by
allmodconfig builds anywhere. The separate HAVE_PATA_PLATFORM
is only needed for machines that want the non-OF pata-platform
module (sh, m68k-mac, mips-sibyte arm-s3c-simtec).

       Arnd
