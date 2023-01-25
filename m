Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE1667B317
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 14:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbjAYNQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 08:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjAYNQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:16:27 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7390C83FA;
        Wed, 25 Jan 2023 05:16:26 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 9FF7D5C0195;
        Wed, 25 Jan 2023 08:16:25 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 25 Jan 2023 08:16:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1674652585; x=
        1674738985; bh=J3dD+P3ROS7gUifupgz7KiHu9jwyCL/9UhObpiLxHuM=; b=E
        YpRLNIN2DmO0K2+Xq3RG4lbDUoQNqRjAdLKG94pXVaWZoJ/hPyjEwPpypJajl12W
        Qtkh2p2OUoYJqR85LwsqHClbugBtT9ln916pgelsJaUtHjYkX5tms9gSJX1vE2D1
        Hq9oQVu+37i4usCj/PdubqsxqBJGvuv0UpEypWCxY4ntXGgCvTm/l124YweacZcM
        A/tYawfx+KaxWjy9kosmw1mlJbu1SO89eakzQ1kJSIcOXDRyoEGX7cfn9Cl7d0RB
        DFuUNXn7J4dwtFa1CGzErfJYoY9E1E10ckW2bBccPSLMyI8fj2ywt7MZRiB0uGPK
        gLK5JXr4FxsUIoNBsceHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1674652585; x=
        1674738985; bh=J3dD+P3ROS7gUifupgz7KiHu9jwyCL/9UhObpiLxHuM=; b=e
        uIX5/YO42wR1jner+DCBCicWNCfb7Vw4lmv8nSfE42Rtz7JvY94hesFERMtdX4C3
        2Av86ipb82bmmCOki04tcbovtHn+zEvYr7YUOALm2L2QZb6q6EU6dZz8UySBQD7W
        KaRbUJY1i+6uh4d2VAFbL8ErWVJNeg+X9hqsjt3ZdVu1vYOoWyzi5G/83Ma95beq
        jnP/IQK6LvQw2WUQ0w9AMSuEMUXMAHIXvVvJGENxszSCibuyE/CVpHNkmF48aMAV
        8LNehevfgMTUevqlyWzjQxzTlSVM87QMvKVXbe6Ci71xxhPq6TV9arjQWLbKJgin
        Qy5C5dIqmUARWcYFNQ9iw==
X-ME-Sender: <xms:qSvRYwl-IOg1UKMZgs-KZMwQfa8TGikVS_QE25a1JvyQVSA6qG8w8w>
    <xme:qSvRY_3bU019FQA1D1qv2AzyZdThcSy44IuLM914mzAL3hss3cnzsdkym9lssZBY8
    2o6m6HIG9HCJkW6WrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvvddghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:qSvRY-pQ9m7SXm85zp1zzctAxTtQ_1uFtedA-wyjmuCjmajDzycwdA>
    <xmx:qSvRY8kbLlQmnNFbkG0oiIZhbNZrkRbBu5fNcUjUlk_xND-8Gqyu4g>
    <xmx:qSvRY-0uKGwOicd3-5Ll0NV8PUygHqHxtrUaLc9qDVoJLFJGda9ygg>
    <xmx:qSvRY3H-m1Y8jVSPPw4i7WbaaFzI_xknJvxuOupJYyubjuPFVQ6phg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 07B43B60086; Wed, 25 Jan 2023 08:16:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <43964d94-1c76-4c4f-b093-92a611518a87@app.fastmail.com>
In-Reply-To: <Y9EpNfZJ5irXZqvR@fedora>
References: <20230104133414.39305-1-m.zatovic1@gmail.com>
 <20230104133414.39305-3-m.zatovic1@gmail.com> <Y7WHjD4psjgAAyPd@kroah.com>
 <Y9EpNfZJ5irXZqvR@fedora>
Date:   Wed, 25 Jan 2023 14:16:05 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     =?UTF-8?Q?Martin_Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        "Manivannan Sadhasivam" <mani@kernel.org>, hemantk@codeaurora.org,
        quic_jhugo@quicinc.com, "Bjorn Andersson" <andersson@kernel.org>,
        Michael.Srba@seznam.cz, dipenp@nvidia.com,
        "Bart Van Assche" <bvanassche@acm.org>, iwona.winiarska@intel.com,
        "Oded Gabbay" <ogabbay@kernel.org>,
        "Thomas Zimmermann" <tzimmermann@suse.de>, fmdefrancesco@gmail.com,
        jason.m.bills@linux.intel.com, jae.hyun.yoo@linux.intel.com,
        krzysztof.kozlowski+dt@linaro.org,
        "Rob Herring" <robh+dt@kernel.org>
Subject: Re: [PATCH 2/3] bus: add Wiegand bus driver
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023, at 14:05, Martin Za=C5=A5ovi=C4=8D wrote:
> Hello Greg,
>
> thank you for your insights! The static lists are needed
> for matching wiegand_board_info structures to
> wiegand_controller structures for drivers of devices that
> do not use devicetree. I have seen this approach in the
> SPI bus driver, so I assumed it was okay. If there is
> a better way, please let me know.

We have removed most of the support for machines that come
without devicetree, and it is unlikely that we will be merging
any new ones, so I expect this can simply be left out.

Are there any corner cases where you you still expect to
add devices manually from another driver?

      Arnd
