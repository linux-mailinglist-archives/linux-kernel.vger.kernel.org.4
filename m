Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63296E9700
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 16:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjDTO0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 10:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjDTO0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:26:14 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F891FD0;
        Thu, 20 Apr 2023 07:26:13 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id AFE315C00DE;
        Thu, 20 Apr 2023 10:26:12 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 20 Apr 2023 10:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1682000772; x=1682087172; bh=mQ
        MFG0c8DAo/RaI8mHS62KbgdsQozN7xXYYhGzQ/q44=; b=VQGlz5x44r+cG4n2QK
        45eKffadkggJwKvTzrOSpOA9NyCH3W30E0uAQtfkl8qHtdGl39XLAViPgvAc3l11
        97hUtSfGt2/nOMSkOrnZF3Pi6MMeLjhSFhr31zEERtA6TtY6q7dn6MzsA/N9E0sz
        ZpLpm2Utfk2AWsfrPqXfggnH7+eUAEvR96SP4F08rcVwna2hjlymyhfvrqCMds6I
        ozEIk88dPKPVQEthZ5pzObprOOP5+Hc5MaE6G5CcvRSpb5nLWt2/0oxAhJXEL5j9
        bocxpiuZARqIlD3tin+A6m2Yzr1eGi/A5jPdUa/DS5REFOHLG054kYpdvx3cgkwO
        frFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682000772; x=1682087172; bh=mQMFG0c8DAo/R
        aI8mHS62KbgdsQozN7xXYYhGzQ/q44=; b=VnA7SH4nt1xoIB2KVpR6bayxirc2s
        h/We/A4EGbeuQ75Y93BtNY2LPnBonJ+DQSrqXq41KhQlVD004yASrgPLBYE81k0K
        KCiNxD1CXDeQWoH9hdr8RoZe9a9mkS8iNoAdj1TBXzgEIX6Kp0DdnT1GsSBG/QMY
        wC+36Zl5e3Sd7tAVJmFmCfLH7m/jY3DLJXV1ATUSb8SuVFbf/22qE553JZaBtkyX
        Dm4XTcGdBdD9B6xc3KKhQP1KFlhDEugd8qOsS3lbt8kGhhBWEFx6HRzOTNRtSmO8
        c/mjN27h3oeAng4fFfVu9LOgr233lynKjBcbbG21s2wsgrJnpx3m/aC4w==
X-ME-Sender: <xms:hEtBZILL1Uj_kPK9eJWigI80_plZifdJezksTYILdedi5IKnkXWFqg>
    <xme:hEtBZIKOrLdW3uJlUpkFiA4WAmiU0IQftdvWJdz_2mnwvpzG-5iApQ9s54aLHOGrp
    Qu88Uyi4VM_aYQgOwY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedtvddgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:hEtBZIvRuU_UCw2-porzXC5-QRnNc1xU1KO7YX1oF-f9WhinwWN17g>
    <xmx:hEtBZFaGaN8iV8I5hqQyJPojtlVYfhMU2CCbjo7JohLNdJAbRB9zkg>
    <xmx:hEtBZPY6vq8KdkWLl1qKKAUHOvyxfIMmRiIHsat7nro_kXDEV5sslw>
    <xmx:hEtBZOlwfdo3vMlRR8hKB_w2SYgu2DOHnEZtJ7b3a8qcqBbU7z2VEA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1A74DB60086; Thu, 20 Apr 2023 10:26:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-372-g43825cb665-fm-20230411.003-g43825cb6
Mime-Version: 1.0
Message-Id: <d018f78d-13d0-4d13-90c5-9b33bd121f51@app.fastmail.com>
In-Reply-To: <e6958e2e-47bc-685b-f585-a88d29173f58@plouf.fr.eu.org>
References: <5b30b2b2-c47a-da1e-8106-025c914faebd@plouf.fr.eu.org>
 <e6958e2e-47bc-685b-f585-a88d29173f58@plouf.fr.eu.org>
Date:   Thu, 20 Apr 2023 16:25:50 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Pascal Hambourg" <pascal@plouf.fr.eu.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH] scsi: advansys: disallow ISA-only build
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

On Thu, Apr 20, 2023, at 14:40, Pascal Hambourg wrote:
> Hello Arnd, Peter,
>
> Arnd Bergmann wrote:
>> The ISA support for this driver was removed a while ago,
>> but the Kconfig dependencies still need an update to require
>> EISA or PCI.
>
> A month ago I posted to linux-scsi about the module failing to to init 
> if ISA support is disabled in the kernel config (copy attached), but 
> have not received any answer so far. Any thoughts ?
> Attachments:
> * [Bug report] scsi: advansys: module init fails if ISA_BUS_API is not set.eml
[https://lore.kernel.org/all/5b30b2b2-c47a-da1e-8106-025c914faebd@plouf.fr.eu.org]

Thanks for getting back to me on that. It looks like my patch
was incorrect after all, and only the ISA_DMA_API should have
been removed, as it's now impossible to build a VLB-only version
of the driver.

I think the two ways we can address this are:

- your approach c), which makes it behave the same as the aha1542.c and
  g_NCR5380.c drivers, plus a Kconfig fix to add back ISA_BUS_API
  as a possible alternative to PCI and EISA (thus fixing my patch).

- your approach d), removing VLB support for this driver. I tried to
  find other VLB drivers and the only ones I see remaining in linux-6.3
  are drivers/ata/pata_legacy and drivers/net/ethernet/amd/pcnet32.c.
  Bartlomiej Zolnierkiewicz (added to Cc) is the only one that I can
  see having actually touched VLB drivers at all in over a decade, he
  might know more.

      Arnd
