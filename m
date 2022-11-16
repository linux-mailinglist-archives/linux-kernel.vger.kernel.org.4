Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB6062B6EA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbiKPJvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbiKPJvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:51:48 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F291D300
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:51:46 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 2E62A5C013A;
        Wed, 16 Nov 2022 04:51:46 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 16 Nov 2022 04:51:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1668592306; x=1668678706; bh=WvmpilUMu5
        G+PHhyVsWdPFbF4UbiS27YKqOm8VA/Jbs=; b=YAz6EO+n/FiIY8VNDDUlaNYHRT
        xdbSg6x+ACSZR6vNeY+9IcpwljXM5Z3FefrkAd9Dd5oUnCJrq8IRjVqWAQ0arVWN
        AKycbOHt5x90Q4RKGMl/vbZd97t35VCtZw2j+WlRhTv/+vTiQNu6dnUhrebRH+CI
        6eWCPrefuHnoT/vanM5GOQH6cftFyFF/lD05bAutwFmmspA8oHprzeYdWNIWc3pA
        Sph1OBmffI7OrxDgP/dm0zYoikPD5FoEpstb/jjfO7Bf0cTDmIn4gEM6st2500Kh
        OziMJLvdXg8yjtmPyuX5WWsYux6tJjGQSS3ArlHw6HRCNzrYJn6dUVjKEksw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668592306; x=1668678706; bh=WvmpilUMu5G+PHhyVsWdPFbF4Ubi
        S27YKqOm8VA/Jbs=; b=gDqRN2OYbEtbed1U187nWwT79K+yItqIDZKuBBiWsG9F
        eFv+7PF9cvr1xfkR3GABcqZnz4RcN1/T0jl62Cy3tOQFVyU0riAWcDNMzwQ0V8jM
        HjQ0Lae/lp9Zb1wkY5Ysd20X1ZmR0T330skmSHPJ3tI++e0ackjeaKHlL8O0fp5I
        PZKO8kdRkcrryxEoQC2C4vGNDsZzaFQXG85Pz11HwzxYVvGfYZrUH1ZAfnjx1hBc
        im3BFfgud+CdR0rh/aGaqnrDFKXnuEXLFmlbUQ6sRQIDkeku5r+HenMEa4YbNCzX
        aROtOGpyCiFoQZ8bq71W0IReOQS8Nr62mNtoNXhdyA==
X-ME-Sender: <xms:sLJ0Y54SHfGzTA23ZRFiTzR2rclYudH_tDpIB-spLA-tFtzRT7_Ufg>
    <xme:sLJ0Y279uD0X212MipKWOfMvU0Uh6KYBEb32YBT3jBok8-Xy3KlqouYfeZkqPuAjG
    jhInwt352WS3O_ZIKs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeeigddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:sLJ0YwcUPXgaYJ5cAKu0PDxTBlRuJF4Brc9KBakVIpRPyH7pBlkuyw>
    <xmx:sLJ0YyI9V9_Zpde2Fl8mZEkcXnY33WHnbK0jzNA-q93jj54493ZL2g>
    <xmx:sLJ0Y9JXrYz1n-cl4wO4d_5hrs1gVKc2tcInlrnlfQeLR1GNwCJSMQ>
    <xmx:srJ0Y0bBKWub3Mf2Zy5RqRfvT5Q7f5TaxaXM74jlHW0FybQs7r6OZQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 03586B60086; Wed, 16 Nov 2022 04:51:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <2bc2a74d-29f6-4cc9-8a60-3c91e8f3ce30@app.fastmail.com>
In-Reply-To: <20221116094712.14312-1-matt.hsiao@hpe.com>
References: <20221116094712.14312-1-matt.hsiao@hpe.com>
Date:   Wed, 16 Nov 2022 10:51:23 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     matt.hsiao@hpe.com, linux-kernel@vger.kernel.org
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

On Wed, Nov 16, 2022, at 10:47, matt.hsiao@hpe.com wrote:
> From: Matt Hsiao <matt.hsiao@hpe.com>
>
> Currently, the hpilo driver is licensed as GPL. To run OpenBSD on HPE
> servers with BMC (HPE iLO) functionality, a dual MIT/GPL license is needed
> for porting the hpilo driver to OpenBSD.
>
> Signed-off-by: Matt Hsiao <matt.hsiao@hpe.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
