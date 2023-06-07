Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDEE7261DB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbjFGN7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240240AbjFGN7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:59:05 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76482E6B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 06:59:03 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 9415132009C2;
        Wed,  7 Jun 2023 09:59:02 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 07 Jun 2023 09:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1686146342; x=1686232742; bh=cy9Jga68WohofTSbYlBOAhJdHKuOZbvqm4s
        nnwowhdM=; b=Lo0aZFyL4g1kGn7ErImf1ytHiCwd4BpyrjhACzofAD4MYr/7rIC
        t3q87GHGWFF2oDRk4IPwZ4tH8PdXqlLRAty0jubLnchuXup0WJqMRjOK7abRylI7
        wUeo/h6SW5mi8DODcax7tglV6n4ARfIlllcOZIfP1v+Jo34y2NNfgNrs53fscfIk
        Myu0ei0RnzHRhuLYLem8Mzz4+usCl5bgknaN7+9a7uvgSB8Uv/fXthyPSApEy0qR
        ChNxKgc6NcFnPJlqdwz+ljyuHqYaBXR8c0hGBvPbyw7ykue52lzqtcCRnnKR7i4G
        9M8kt2iOb5ZegyxaSqD3gTcfo+5Vm3SFSzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1686146342; x=1686232742; bh=cy9Jga68WohofTSbYlBOAhJdHKuOZbvqm4s
        nnwowhdM=; b=rMR9IDBIsMdGJPujNX5aQoWuNuDXxxyFdsiU2CIB36L2MLSkpnx
        WKU5VzxMqRP4d7rA57jjD0gtJtyx0geUUjlwoB65OUnQFHm48eYP9uB12IgzOBLV
        ARo6pLHg+/z4OrpIgcFGM7gJ4/DZtrXmW3o35A9pv8LUl0szRMYLfb8uQcfzSp10
        UiSsje4vc4eIasNBR6fUN2U2O8inWeFFE2uEgttA/SwTZFupochNOeNurUlWc+c9
        sJS8q+9xQVxCPZMt8QeUFEGd4DACCxoHiWHkDjfIRe1hLPYISY5lULY9g6rw3N6r
        E18VBUzDM0YKdTLyfuiOV/zCrqKZoo58H/g==
X-ME-Sender: <xms:JY2AZCmvpKInSrAYX7TD5D6deC8evQTTi_upYJfqUvLxoZsfz6vpdg>
    <xme:JY2AZJ2GP4XiaaBQqyATQ-HyLiXzJCFXLJSYKcLvjRkrfCzxIz0lCq4x8FDjDed_l
    LrLZxdKyrbetAjzwnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtgedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Jo2AZAq3GQVDhC1reFhe4IvlOHtJonq4MVf1s_Sc2l1TvL_jSCxY_g>
    <xmx:Jo2AZGlXgfSncGe-o8-zCMHZqQpLf6pOo9OWdRPeVMGsx4M2Z9bhYw>
    <xmx:Jo2AZA1Sqi7Wx5x0GQtkMg38vSVXt15bHFHHhGpXbEeEpVhj6NF7vw>
    <xmx:Jo2AZOCzlngiLmKytmPdfE7LG5pSRq9x7n1N5kV9ElRlWn9HSXtEmg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DD117B60089; Wed,  7 Jun 2023 09:59:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <3ef35dd4-0c05-4705-823f-85e96a5a9b99@app.fastmail.com>
In-Reply-To: <CAHUa44E5RjMqeTp1Sr_7=Eavu3T+q2YVg-V-_gLWpO5sjJ-Vhg@mail.gmail.com>
References: <20230606075843.GA2792442@rayden>
 <0fac8e65-fe05-4dbf-a634-4620f764e2bd@app.fastmail.com>
 <CAHUa44E5RjMqeTp1Sr_7=Eavu3T+q2YVg-V-_gLWpO5sjJ-Vhg@mail.gmail.com>
Date:   Wed, 07 Jun 2023 15:58:41 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jens Wiklander" <jens.wiklander@linaro.org>
Cc:     arm <arm@kernel.org>, soc@kernel.org,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Subject: Re: [GIT PULL] AMDTEE fix for v6.5
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023, at 08:53, Jens Wiklander wrote:
> On Tue, Jun 6, 2023 at 1:47=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
>> On Tue, Jun 6, 2023, at 09:58, Jens Wiklander wrote:
>> > Hello arm-soc maintainers,
>> >
>> > Please pull this AMDTEE driver fix to add a return origin field to =
the
>> > struct tee_cmd_load_ta used when loading a Trusted Application into=
 the
>> > AMDTEE. This change is backward compatible.
>> >
>> > Note that this isn't a usual Arm driver update. This targets AMD in=
stead,
>> > but is part of the TEE subsystem.
>> >
>>
>> I see there is only one patch here, and it is marked as 'Cc: stable',
>> so I assume  you meant this to be include in v6.4, not 6.5. Can you
>> confirm that?
>
> If you don't mind taking it for v6.4 that's even better.

Yes, done that now.=20

       Arnd
