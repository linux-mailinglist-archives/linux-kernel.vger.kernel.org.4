Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52B9665B1C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238426AbjAKMMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjAKMLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:11:45 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A2A218B;
        Wed, 11 Jan 2023 04:11:44 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id B3B3F320027A;
        Wed, 11 Jan 2023 07:11:43 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 11 Jan 2023 07:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1673439103; x=1673525503; bh=h5f0Ezzl8m
        OTD0EoVtHbW3DPUvA2QGRRBpJtSNWOlbc=; b=icjnSazJLjDb7KYrxn4byeqSWj
        nv3T1IgscrVWB67EedH0M8Lt0Mo6d1ql8zXubjUeTJG6d3tqdnmf+n2I2vlAJbKB
        T3ZKydtr4L4nZxDk34Y2LsOwjOcL4jNuJ7LoLPBsu8xzL8idLaDYkJc4C4lebVkC
        PiIr9mTJgrB4Nca0FiVGaOrcW7v20CE4OI1yc5PUk++BKwNbbELzpfiLjbbM64L9
        TiHTHJUesDce+b2HrGSJ8r/ZnfjP4op4mEmvIQ0V3ykyjiBZ4CNqCKI622mlAjvY
        caEPbGuHTF3VuGxOQIh2r8KUku+rGWG2zuaSz9dqPOkFSBR2EiBfEB6FJBhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673439103; x=1673525503; bh=h5f0Ezzl8mOTD0EoVtHbW3DPUvA2
        QGRRBpJtSNWOlbc=; b=heLq0GF8qpL7G4MTMX7QctTxhJD6guE0k9Q16bS37NQW
        nKekaw40vZ+unub0IlCI364qGmbJVa5RA2bwnt0o7hu7euT1hle8yPqfMlhq5/8x
        jtNkj+Vjk6OAk9hMoJfSVH7YYwFD3RAQMc6A4Ts8oQcAr6kmu92vIZVinIEkJA0Z
        6LUrbGecVyjgED0JlzstNvsG5jDSufXBcrHJJIBFZH2tR2yjLIG56uRDtDuJ/f74
        zKvt7PG/ax4bDxxSm53KAUABXzt0CiacYhvzljIIgOpqH7D0uEzwYypOgOjLVLkB
        nCqZ4EetgV/HJkziWucSimfmZw3HO9NAXdnSE8jEtQ==
X-ME-Sender: <xms:f6e-Y0GDCtaWMPWH2zahtNOMOpSLBCHjduUdxi-LbBjvc2_fF7WaYg>
    <xme:f6e-Y9VkSDoMK09CpaSr1oKQD6z6A6pQvIBMbVb5BSl_F8smVDLAZUWNcZckzsgaX
    PxSkG--69ZOovf8i3Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrleeggdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:f6e-Y-KkJn0e3e2y9zU3SyEWnK1tolJ7J9xSWbalKPNnXqxSeC5jJg>
    <xmx:f6e-Y2Gs0kL9le7yVwS4TzFulB_12pmverpnyezaKh-fIUc0q8HAoA>
    <xmx:f6e-Y6VPQv6I1wpiV_54KDG9JnRbQnhMudrT1nzaoL6YDHWHn0xX2g>
    <xmx:f6e-Yze8Wn3jrAS4WZQZCTYT1F0Y8tRk8IQpIG115H0REwQxmaZgxg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2A8C6B60086; Wed, 11 Jan 2023 07:11:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <c8c65679-9d1b-456e-ab16-a2fd7622c30c@app.fastmail.com>
In-Reply-To: <20230111092828.958-1-lukas.bulwahn@gmail.com>
References: <20230111092828.958-1-lukas.bulwahn@gmail.com>
Date:   Wed, 11 Jan 2023 13:11:23 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Lukas Bulwahn" <lukas.bulwahn@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] MAINTAINERS clean-up after Arnd's rework
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

On Wed, Jan 11, 2023, at 10:28, Lukas Bulwahn wrote:
> Dear Arnd,
>
> please pick these two minor clean-up patches into your soc tree.
>
> These patches apply on next-20230110.

Applied both, thanks!

    Arnd
