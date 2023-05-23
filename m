Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A71A70E103
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbjEWPwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235682AbjEWPwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:52:02 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C65AC2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:52:00 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id A024A5C025F;
        Tue, 23 May 2023 11:51:57 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 23 May 2023 11:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1684857117; x=1684943517; bh=IZt8D0cKx8Wt+SUWyeaYqCgFBquCK/LV/4e
        dJ17+9iI=; b=fBwNBOmYGjtTwgq9Q1VX6jfJoEWy8CBnDuwNEHAp9jhqr9qMQHz
        A3b3WFaENpUVbrJdvCTk7fbjydtSajuA/MvSBMasiFnCz7zyZMbyVecqgPrEmzEb
        YSsjnErn1jguxiuM0DEB4pW+SEsWTbMc2K4bmuNd0CXH9IoB2Mi6XRvh6R8ZNzZ4
        8z8pr6l2KrhQ08gdCbQSvFCXq71r8OsV3Jb2p7ggRXc3l92WMRq63el6ykmcgUvz
        0uIhLdH4rdxuRfUWO4kMi7oOiLT8QNhFTu4su+8BvqQ4O9aqG59K41fRRSb54NdO
        8VACcrDmIRjbDNfieYugnc12cD6JxmKCBxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684857117; x=1684943517; bh=IZt8D0cKx8Wt+SUWyeaYqCgFBquCK/LV/4e
        dJ17+9iI=; b=e7qH1cSPxB6LQ4xbfbg5oUULYFO2tJ/actUwD7T9p/st3/i3/jv
        CyS+s9gmVlyeEk9EUKRjurC/pWzhlaQ2iCPzDh49shKVr2OmUnZz6zfv4TDmu4hJ
        z6cbkiLvckybwMdYOyWRa+XroN2cBn7UbCFBpo9dvROrSYGZrRg1IZnvhOxFkxOS
        ONK8TIRyPaWn6u3JRFohV97jJMV+lhfeMn4lKnsleovRArcSUNeTulpmIVAMhZUo
        CkM43/+Gzq0XGuiMVljkWicf7AmGmJg9BjvgitIOzNGUhWZtb/uOhgIKHW6Hkaac
        qDDRnsGZquEw1MVTUqiAzx6M/Nh5QcAb4tw==
X-ME-Sender: <xms:HOFsZLiqoaHbWx0hWl_Caz3mfCEahsOsp0p00-bpmMHcFSUNS19RqQ>
    <xme:HOFsZIAczUqhYgKNuwaNQDrQU0ReN-cy7G6x6Em0rSsCLarS3weo2fL4LYgVYuoSh
    jIpHMO3xRKwuctxTAo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejfedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkeeuleegieeghfduudeltdekfeffjeeuleehleefudettddtgfevueef
    feeigeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:HOFsZLF6UF4MEbmyIKBk5hx_nolOJd6UfHBiMiFzgru51HPhMRVKNw>
    <xmx:HOFsZISvjlTRxR15pnLf516fmYgJ24tu-D-0rQWh7tVHcedKRBDY6g>
    <xmx:HOFsZIwXZbQeTJBtkjIl23M4Y34jDmvcpNNEBG2RQPsCKqCJRqiFFQ>
    <xmx:HeFsZNqksFM2iWY602fjv0NwnUyntLamKo1T4QOfdW15O8ZGRg_kqA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9D697B60086; Tue, 23 May 2023 11:51:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <559288c4-ed44-4d13-80af-6c73ffb6bb47@app.fastmail.com>
In-Reply-To: <CAD=FV=XS6ZXbZvMVYTm8p46SauE6t_qsE7o2AUOJLbsTzK3Jpw@mail.gmail.com>
References: <20230522114922.1052421-1-arnd@kernel.org>
 <CAD=FV=XrTVVEP8gLx3e7Sqa_3fod3Ox79Ao5fk3S_ORH7jHS9Q@mail.gmail.com>
 <CAD=FV=XS6ZXbZvMVYTm8p46SauE6t_qsE7o2AUOJLbsTzK3Jpw@mail.gmail.com>
Date:   Tue, 23 May 2023 17:51:36 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Doug Anderson" <dianders@chromium.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Pingfan Liu" <kernelfans@gmail.com>,
        "Sumit Garg" <sumit.garg@linaro.org>,
        "Lecopzer Chen" <lecopzer.chen@mediatek.com>,
        "Petr Mladek" <pmladek@suse.com>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: watchdog_hld: provide arm_pmu_irq_is_nmi stub
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023, at 17:47, Doug Anderson wrote:
> On Mon, May 22, 2023 at 7:31=E2=80=AFAM Doug Anderson <dianders@chromi=
um.org> wrote:
>> On Mon, May 22, 2023 at 4:49=E2=80=AFAM Arnd Bergmann <arnd@kernel.or=
g> wrote:
>
> Breadcrumbs: since I didn't see a patch this morning and I'd love to
> get this resolved, I've posted the Kconfig fix:
>
> https://lore.kernel.org/r/20230523073952.1.I60217a63acc35621e13f10be16=
c0cd7c363caf8c@changeid
>
> Assuming people think that's OK, it should land instead of ${SUBJECT} =
patch.

Looks good to me, I've replaced my patch with yours now in my randconfig
build setup, I assume it's fine but I'll let you know if another regress=
ion
comes up.

Thanks for addressing it,

   Arnd
