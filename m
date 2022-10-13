Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A4D5FD590
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 09:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJMHdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 03:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiJMHdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 03:33:53 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE1D11B2D9;
        Thu, 13 Oct 2022 00:33:52 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 703CD5C0053;
        Thu, 13 Oct 2022 03:33:50 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 13 Oct 2022 03:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1665646430; x=1665732830; bh=U1GPnkRrOj
        kf2h2kttART7uQoH4bT9tLh5te/qCpI+o=; b=cHtQwd9I5W94IzjzEzR++OrLUa
        /K0YDDLS7ehqqkoybsUc0UsumaUTccHhFbzbaZqpNJFmzj1fB5e6N1FpQsi8ZFpy
        xPp4pMA0KSeiq6GBl1fo/ZRalNTGvkLzCK8spU2iUzZXhswITDQxZJ8khTWFd7oY
        6pqNrJaC1jkDA1ow55aktOckeyFbY7geHVJ7nnY3JYBEzyaPhJAiGK5tHLhq1zki
        LEmpXcxJIe3XvJpDi15lRLIFkd9FWqV5iSCISIAP9JbR+jOqe4lv/AnOtyasTOwg
        /mj6U/7LiK8KyoTe5IrtCljzuE5FcX3LHKLc3AJffYpj5BjbeIHa5jeYdfGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665646430; x=1665732830; bh=U1GPnkRrOjkf2h2kttART7uQoH4b
        T9tLh5te/qCpI+o=; b=KcJSeLHQ+n4uGifWV4UjtNCf4iDZr3aAZ+PyH7eBCuMO
        rvY+12wZHpDlAfHyYbGkRFD4EQhOvnFIquG4gnrp6xo0RIypjRH1/ntHC5e+WJwL
        7sM/Y129UyXPD9TwheCV3XUDJs9QXj81rYUziOjEMAplC+rhO1bdGbfppI9q3QaM
        OAdvyDPMdLlZ9b/Q2Qy9IuFHhZ/hllP++Fm5JxuAGO/uw2RtyCth1rcWsOuBnYam
        CdpTyICsF04maZeq7Ve0vT0xZijsn3TTBvWZdcXxuijvtDzH0udxWAtXhrAfjBRf
        JoZlH8ynixW2lCBKqRra+WXsXIq03ythDF19zJ906Q==
X-ME-Sender: <xms:Xb9HYwb4mLkR2CMod27VCnBV2LR1R4KnJlT5RCqMg4T2a9yXLbS_Mw>
    <xme:Xb9HY7YadZaJuPnSpw4leAMrDtnsCz9N3EPY_tigTBGq6ncvIjToz9_7zrWrbUcBe
    CxtszzZd_UvyRjYltk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejledguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Xb9HY687BLEQYUv1p0HkI46dLgAiSaTynTSrdFeR8WUTkTZSu7Wtuw>
    <xmx:Xb9HY6oPpDjlfmQ4grw2tp0i0UDJfg9St0X_zFoYJb4oG_CCr5h-uw>
    <xmx:Xb9HY7or6Zz4BImMuC8xDvxnaCTZeYNet00DDVgaPgwDQfDn7HuFPw>
    <xmx:Xr9HY6WIUpC8-Cgyuu41Hd4H8ziUDxjKlaagoBF04gTPoECVqf6-tw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C2FA3B60086; Thu, 13 Oct 2022 03:33:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <4429d1ec-579e-4b0d-a8d8-06b9a5877a9c@app.fastmail.com>
In-Reply-To: <4517c95f-1dad-5a8c-5202-073d0a7eff29@opensource.wdc.com>
References: <202210121422.MJsXaw1M-lkp@intel.com>
 <4517c95f-1dad-5a8c-5202-073d0a7eff29@opensource.wdc.com>
Date:   Thu, 13 Oct 2022 09:33:29 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Damien Le Moal" <damien.lemoal@opensource.wdc.com>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/ata/ahci_st.c:229:34: warning: unused variable 'st_ahci_match'
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

On Thu, Oct 13, 2022, at 8:13 AM, Damien Le Moal wrote:
> On 10/12/22 15:37, kernel test robot wrote:

> I am at a loss with this one... There are plenty of patterns similar to
> drivers/ata/ahci_st.c doing something like:
>
> static const struct of_device_id st_ahci_match[] = {
>
>         { .compatible = "st,ahci", },
>
>         { /* sentinel */ }
>
> };
>
> MODULE_DEVICE_TABLE(of, st_ahci_match);
>
> For instance, in drivers/pwm/pwm-sti.c, we have:
>
>
> And countless others like this for STI and other arch too.
>
> So if CONFIG_MODULE is not enabled, how come we are not submerged with
> warnings about unused variables ? Is mips arch special in this regard ?
> Or am I missing something ?

It has nothing to do with MIPS, the problem is

                .of_match_table = of_match_ptr(st_ahci_match),

The 'of_match_ptr()' sets the pointer to NULL when CONFIG_OF is
disabled, which avoids a build failure when st_ahci_match[]
itself is in an #ifdef.

In this driver, there is no #ifdef around st_ahci_match[], so we
simply want

                .of_match_table = st_ahci_match,

The thing with the MODULE_DEVICE_TABLE() is that it would
create another reference if CONFIG_MODULE is enabled, but not
for a built-in driver, so you only get this type of warning
for randconfig builds that have the driver built-in and OF
disabled.

It's a common mistake, and we should probably remove most
of the of_match_ptr() references as you rarely have drivers
that optionally use OF support but benefit from compiling
that support out on kernels without OF.

     Arnd
