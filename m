Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721A162B6FB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiKPJzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiKPJzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:55:03 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00E21BF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:55:01 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6BD745C0218;
        Wed, 16 Nov 2022 04:55:01 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 16 Nov 2022 04:55:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1668592501; x=1668678901; bh=ZoQ20vdIWW
        bfqgYzqpZ1g616vOvb54Vmy8Tikqx6AYg=; b=hwtSlOOxj/O9Gt1J0AIqLXsvTD
        WYGK/WoNVpMHcXi391EuNlmmPh55nXvyKOXM2u7qnAjZ6TJtLXihLsyT98NkeJQy
        NazSEf0dQ0O07oMarpCaYxZrZ1RQiLmJYNzogce6N326K8km8jzsTtjMKYhLorew
        be3VGxEBA6fK3YArCMkWgpGx1rk22Fa2vBN74rFd5We/WOwnLI5g6YPZLI3EnSzc
        TD7IuLXCv26b01SDnBo4OBNW8yPltGom2cytC7wrfQQ/dOkFdoGhjSwe4UkyhOWS
        FWNVFY8h1f6Nku0XPsp51ooj43+2OL4ak6xWLZyIgms3HuzBTrcEZ98JCEXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668592501; x=1668678901; bh=ZoQ20vdIWWbfqgYzqpZ1g616vOvb
        54Vmy8Tikqx6AYg=; b=nj0vqLFnMYhix2CDbo1c5vYPak6f4GQZgJTCfbuA9uI9
        Bg1AdxHp5/hbfDbAxCzQz3OZgttAkJcaVHCjj9FPxKn4qkrVledSh7dod7h+WE2f
        e+FBXBl+IvyGsHj20FeDZIMYQNBqkqLHU93Abu5ENtEbck4N38JCVMYJWTuqmWxO
        V3MdkvQ17lLA4umoiQlmhX9n8WY5jWoLqCMYq5Uwg4cVOGX9YKe8NzMZzWOKBz7g
        5ilx+YP0xD1j6gtNFPC5l8cTdk28S8TOH95CNNnPiDOZopzpO3ZaZzam//ssSKmj
        aRY5TPdzaYh2qQJRJFHNQQblVe/XHBSCudJruTW4Qw==
X-ME-Sender: <xms:dbN0Y1-9b9iNmARZZOjFfpUJ6wAc5FaosHeeNvCQNNt5HE3IQ4Fxgw>
    <xme:dbN0Y5sXQcn117h40ihAixFWHeQP9kt5MS55av_V-AqUKONk1KDT_nIYhMoNXONAT
    XIvRGmdUQTriUjGdcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeeigddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:dbN0YzCnMFDcjCuucIr8__vf4_6XH4NM0G9yKK7juwJZBkonqjR0Nw>
    <xmx:dbN0Y5e7D-D1k2MLjW6mp9icFQ965LXY5e35nG-LSDZpaYYxMYmf1Q>
    <xmx:dbN0Y6NNtKY8gGBv2TibLSJcoo_rf22WqzwU6636k68BFO8i3mFatA>
    <xmx:dbN0Y0tNzawZC98mpYnj6XhYA2unZZr2fU0582T_qFQyNEH1gbrGHg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3CA8FB6008D; Wed, 16 Nov 2022 04:55:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <98f186a3-6ba0-4690-8ed6-dd6f82403fb2@app.fastmail.com>
In-Reply-To: <2bc2a74d-29f6-4cc9-8a60-3c91e8f3ce30@app.fastmail.com>
References: <20221116094712.14312-1-matt.hsiao@hpe.com>
 <2bc2a74d-29f6-4cc9-8a60-3c91e8f3ce30@app.fastmail.com>
Date:   Wed, 16 Nov 2022 10:54:40 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "matt.hsiao" <matt.hsiao@hpe.com>, linux-kernel@vger.kernel.org
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        christophe.jaillet@wanadoo.fr,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        nishadkamdar@gmail.com,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        dhaval.experiance@gmail.com,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        arvind.yadav.cs@gmail.com, standby24x7@gmail.com,
        wfp5p@virginia.edu, jslaby@suse.cz, prarit@redhat.com,
        "Tejun Heo" <tj@kernel.org>, adobriyan@gmail.com
Subject: Re: [PATCH] misc: hpilo: relicense HPE iLO driver as Dual MIT/GPL
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

On Wed, Nov 16, 2022, at 10:51, Arnd Bergmann wrote:
> On Wed, Nov 16, 2022, at 10:47, matt.hsiao@hpe.com wrote:
>> From: Matt Hsiao <matt.hsiao@hpe.com>
>>
>> Currently, the hpilo driver is licensed as GPL. To run OpenBSD on HPE
>> servers with BMC (HPE iLO) functionality, a dual MIT/GPL license is needed
>> for porting the hpilo driver to OpenBSD.
>>
>> Signed-off-by: Matt Hsiao <matt.hsiao@hpe.com>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

To clarify: this is for the changes I did to this driver, they are
fairly minimal. I have not checked who else contributed here that
has to agree before the change can get applied.

      Arnd
