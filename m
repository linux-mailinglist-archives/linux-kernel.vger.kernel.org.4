Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCA165F060
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbjAEPpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbjAEPo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:44:58 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBEF5C92E;
        Thu,  5 Jan 2023 07:44:49 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 476225C0040;
        Thu,  5 Jan 2023 10:44:49 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 05 Jan 2023 10:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1672933489; x=1673019889; bh=yJasFzj7Ub
        yu3xnPMmreuLikXp9Yy5BrAnRkfxjeKSg=; b=Ejl4sYu6BIn9+rlCuv9lmkiF0V
        ogtorRQS1NHfW4sTtp3EjgdHGGjDtAdDNHva2LuTuMx2pvIbQABEiDqFOopYKN7Q
        29NfTHndUM0hr10Pgkf5hTStxejF39/gEYnHRpApjLYu5rB0qEal+gT3utYhBhZQ
        GNSc1WQD7RO23b/OHi95CWwPvXPXmUar7kmc2+ycwo+40lCWAEvtb49BzT5AV1ME
        8iCTk2fJsCf1vcd5ut8QRUk3yuJIMAd9rg0gjBm5jCPOWvQtLISQQeqUtmCgBKok
        BD2Zr2zTEqVDc/damYts8JTNd9ATg1W5veRvN4JK1eOS0LvxwZSccvrIPazA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672933489; x=1673019889; bh=yJasFzj7Ubyu3xnPMmreuLikXp9Y
        y5BrAnRkfxjeKSg=; b=S2yjKyih49XS3MCO4CN9ZnGc7EpCqIajLeGEZTFX1HgN
        DefVPbNnnSRI1fe5LUa1nLlYLemZC3ibfdlvVzHr07BRRBakizWtK2bh5ZlJqlQA
        wU5aXb7XcfkCByoQnCEWUybiZumQd4QoJdTLLQOfO3j0r5tXfdf3xJey8V6NLI1N
        DHVRD7IpsvkIAreQV6/rD5IY5sLM+JASJnntAj3XMGLHw25d4RhLA1OA9FLBdxwX
        9qTLqUh5pHx6VnPYPjqYkLC22+8RdF3Iu+gPCpifCbRPSQCCHgTD36Lxl+OCVM2M
        6Kf5kNrPxgQXrMwIe4UgzF4TGX5DcuvY9jD4qi1jjQ==
X-ME-Sender: <xms:cPC2Y78CsT-9iYTtFnMPyuH-5PRC7LJ1P3FDHqjhX7F5YEinGKZwxg>
    <xme:cPC2Y3vh35hoeJw_XZWAa72iM35jfjC9naCH_b0qA7cp6VF4XmtUl-hezLX5_bW5-
    2XpIJt9iZvPJgQ1Wzc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeekgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:cPC2Y5Dbq7oytmXOVEWQWXDpmNSuzfUJYi5uZ8e5Zq3y8HxojDE3XQ>
    <xmx:cPC2Y3dIE3BwhEt_ALir4P3W_y5UD5eyhMWB94JIFeP_EF3-R2N2cQ>
    <xmx:cPC2YwOJSEc7xKxIPWje6uwzeoDrc03WNIsir_v47idOQ-v2cFAvqA>
    <xmx:cfC2YxjISHKBjXCR_CUI9Lt1uTwUMpnpUxrTd_hrfBO-RovjLYMWkQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BA435B60086; Thu,  5 Jan 2023 10:44:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <694be013-6769-438f-b85d-e7cda1b0c4fd@app.fastmail.com>
In-Reply-To: <CAPDyKFoNrtZSDm2Ry+7_74uGLqz8KpbtEC0Z6WNxv7G9JruKtA@mail.gmail.com>
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-22-arnd@kernel.org>
 <CAPDyKFoNrtZSDm2Ry+7_74uGLqz8KpbtEC0Z6WNxv7G9JruKtA@mail.gmail.com>
Date:   Thu, 05 Jan 2023 16:44:28 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Robert Jarzmik" <robert.jarzmik@free.fr>,
        "Daniel Mack" <daniel@zonque.org>,
        "Haojian Zhuang" <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Ian Molton" <spyro@f2s.com>,
        "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
        "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 21/27] mmc: remove tmio_mmc driver
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

On Thu, Jan 5, 2023, at 16:01, Ulf Hansson wrote:
> On Thu, 5 Jan 2023 at 14:47, Arnd Bergmann <arnd@kernel.org> wrote:
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> With the TMIO MFD support gone, the corresponding MMC host driver can
>> be removed as well. The remaining tmio_mmc_core module however is still
>> used by both the Renesas and Socionext host drivers.
>>
>> Cc: Ian Molton <spyro@f2s.com>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> Cc: linux-mmc@vger.kernel.org
>> Cc: linux-renesas-soc@vger.kernel.org
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> I intend to pick this up via my mmc tree, just awaiting an ack from Wolfram.

Actually I think it would be easier to just take this through
my tree along with the rest of the series, unless you expect
conflicts with other patches.

    Arnd
