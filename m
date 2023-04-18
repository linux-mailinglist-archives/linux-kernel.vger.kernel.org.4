Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976626E5BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjDRIKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbjDRIKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:10:16 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890E659DF;
        Tue, 18 Apr 2023 01:09:52 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 012765C01D1;
        Tue, 18 Apr 2023 04:09:30 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 18 Apr 2023 04:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1681805369; x=1681891769; bh=Ta
        bM1MA8pfDpJqUW/8/8Nla77e3Xl6HsgEhF5ucRElE=; b=eb7EZBPlYZE2OiqG9e
        WUImhRfufcrSeTZPK10L3dlJTKkoiNEzpeSS+/ge/oeU7cBj6jrrhH48mL6LnhFz
        aWx/SVtjUBVaC581wMk9i3BNQhdBZdkWuxTXP8G+stMluOy9lzRSroV2MWQX2MFS
        TN5NCWma8b2ar2pvf0KtceKEL+OKFAlaHfGS+i0xYKrOQcCOQ+YXQiAz134gNPom
        ri3ARwap2AJMMOqm3hiZV29d41Ai34/6QRLNOocl8BqAEShJ0iJndOszjKxKKccW
        +k5jzQ0E2tAeotcoEph06ndZYy5G7XLIpkX7lcmQ/+YR5u/hLRRqXQQrBLLvR8a1
        YjQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681805369; x=1681891769; bh=TabM1MA8pfDpJ
        qUW/8/8Nla77e3Xl6HsgEhF5ucRElE=; b=Nvyki73Xx9xnirN1avv9olW4xcW/B
        WyuJE2HzPPRz0Quw00Vn4TJzXZM+gjp6fb8185Hu6oYy+FbHSTNoalrPYHl2RCkS
        ZXAA5ncDUyss3kenlV0eUtAFasPLUBwxj+AZyaGjr4S8A0d9lpxNlkryElUd3cJL
        K9Nj6bbIL8X0P9hVWAoKflm3pgmUzjzN+u4P6VImJUHgxJ/6rdfdE0sJ+5d3Vd+o
        X50k5c8wPDlVO7uvSmi7r1k+eNue3OxAAOadw1ByBirNnAdgjuRydqrbm46F1gSK
        0lfEGCjuRmrNCv9aO5rliZp3ZmuVQ8J6jSeRHmgU747jubGfGviLlh0mQ==
X-ME-Sender: <xms:OVA-ZMefecNW_VYTfJm47H3EX67QaMbhn7tiuJvRmoSNRJD3wjFRYA>
    <xme:OVA-ZOPtv6Up0Pqo3Faqy4zpeqrH8zOg5-4vLNvGXqP2xkiE1_gou2OF-zSJnqYUh
    HORjGlXuRwBwmz6qf8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdelkecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeetffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggv
X-ME-Proxy: <xmx:OVA-ZNiTFiFOIUYKo3_EK-wusPItkVL6MQlHBB0Lwq_2ZRnL82oncg>
    <xmx:OVA-ZB9vdD9LDQXWjwKtkQ5MYA9S5Ix-tvvx306sHJsF_-WUreoUtQ>
    <xmx:OVA-ZIvuQC9MYwdE-kqFXBZzA0gXCvK5Ydc1F94BpMhfFpBEyBTXcQ>
    <xmx:OVA-ZIE9Xo2smsOMuFglDo3yrVYiQdocg-0z1enNazrPBD3_-CsxIA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 402A6B60086; Tue, 18 Apr 2023 04:09:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-372-g43825cb665-fm-20230411.003-g43825cb6
Mime-Version: 1.0
Message-Id: <6b5f7b17-6365-4791-b6e9-8505acb476f7@app.fastmail.com>
In-Reply-To: <695e9f88-5a79-7ca4-645f-047b78495a80@xs4all.nl>
References: <20230418071605.2971866-1-arnd@kernel.org>
 <695e9f88-5a79-7ca4-645f-047b78495a80@xs4all.nl>
Date:   Tue, 18 Apr 2023 10:09:08 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Hans Verkuil" <hverkuil@xs4all.nl>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "laurent.pinchart" <laurent.pinchart@ideasonboard.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Shawn Guo" <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        "Dong Aisheng" <aisheng.dong@nxp.com>,
        "Guoniu Zhou" <guoniu.zhou@nxp.com>,
        "Stefan Riedmueller" <s.riedmueller@phytec.de>
Cc:     "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        "Christian Hemp" <c.hemp@phytec.de>,
        "Jacopo Mondi" <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: nxp: ignore unused suspend operations
Content-Type: text/plain
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

On Tue, Apr 18, 2023, at 10:04, Hans Verkuil wrote:
> On 18/04/2023 09:15, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> gcc warns about some functions being unused when CONFIG_PM is
>> disabled:
>
> ???
>
> The Kconfig has a:
>
>         depends on HAS_DMA && PM
>
> So how can this be compiled with CONFIG_PM not set?
>
> Am I missing something?

My mistake, the warning only shows up when CONFIG_PM_SLEEP is
disabled.

     Arnd
