Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D34965AAF3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 19:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjAASRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 13:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjAASRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 13:17:24 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BC52BC4
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 10:17:22 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A8A565C0059;
        Sun,  1 Jan 2023 13:17:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 01 Jan 2023 13:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1672597038; x=1672683438; bh=6LDx433akbFpSiQ89PhisoZU8
        bENmFplx9mTGmrQgOM=; b=Q9EfSji/0XtghxbDEayzsGshv48PRiYKYF8ZD0tDm
        IfU1KTb/NnGFmyYNTIbzs0z5AYzd7yX0mTuMwkA+7NBZnBZPSr1PSO3yR1E+lkKa
        ll/fNvui0sLOrPrpW8syEtmXJFWkXYtgbH2oU+pOQYToLowD6tsqa/Qq6FrzduXr
        1CeIrzIzpF7ZM9aZ8r5ktr1vSDfoK9c8AsA7it/1Tnurc/gCV1Y+TKVA8xmDCIV/
        IO161AqfpN1e+J1ln2zuTLjZMdBpDixKCpEcOLwusaQV29eyKc/2ZOoNYWAFXzvL
        /iCQka2rQMDB+hzHAJg04iGxVEZ8yEVknke4nXQ07EhVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1672597038; x=1672683438; bh=6LDx433akbFpSiQ89PhisoZU8bENmFplx9m
        TGmrQgOM=; b=Fxmt4EEH6mO+pOE/4iOsKz5boymdNR5Tadith97AV1bnx8oEOaT
        cYOiYf6T52oXZSpMW1xeaBzixVoB3AKp+aCAMwB4Tm7iaqqIiQXSRYO2OXwG2osq
        8meYHYe9JON4n/UXDq+f+mV9PLXT3UkmSKiIHUSSgMjyeyk3cfYdTEDVitlrrfOE
        WgW08WSNLjMME+h6EWkblnoXjcJmhS0XzkTwRrvl0db38sTy0eDSIuShqymP7lw3
        pcZ73FV+24HBYQkgNPJnJtI2DaxZtf00S/AR1d0YlrxMFIWCA9TN7jM8T1ZXMEQn
        XXGDK2uR0CPlJ0HmZsl44AB0uc3Iui4hi0w==
X-ME-Sender: <xms:Lc6xY6Mwn9HGbq3-ipWCZSQJ-O_mn4bxc3s4ryiGbgt5jzrRABS8Kw>
    <xme:Lc6xY49DtL4IvpV8CxNxPcZq-9KcR0VvUQzeLk9d2BlEjjRDnqCFnhdyKZ5pCKRua
    yF_vqk1OwqpMayevA>
X-ME-Received: <xmr:Lc6xYxSWp2h8YNy3OLD_kWPeO2jd-z-PGwSdrBLIVVjVBn3lD-ajAT7NdmWiJdccy3tk2j5A798Pj5xSL9Tb7GaS3Is-OwSdhinjtBZ_-1CaOzYgWv7_dHa63UhxHL8oKbuZ2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjedtgddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeehffethedtteffgfefteetjedvfeelueevudffgfeutdejvdehledv
    vdffhfevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:Lc6xY6tKhBcL4F1GCA8IiTUG9CHagmSWir8GxtC6h2z8ewdeTnZTjg>
    <xmx:Lc6xYycxUTqPM4uF9h-s2f4TAw3NHTL3VRsjysapm6QPp1Cw8bdaag>
    <xmx:Lc6xY-2TlWlUqa0iMx09CPAhMmrUbzhO4Po3q1IIgjIfyqbWMps0pA>
    <xmx:Ls6xY401vvAY3SehBgWAc4WmWSp0FdtPgMmTOcvzAnDJ_Nw01t6F1w>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Jan 2023 13:17:16 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        John Ogness <john.ogness@linutronix.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        YueHaibing <yuehaibing@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tangmeng <tangmeng@uniontech.com>
Subject: [PATCH v2 0/2] firmware/psci: Switch to the sys-off handler API
Date:   Sun,  1 Jan 2023 12:17:13 -0600
Message-Id: <20230101181715.42199-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I want to convert the axp20x PMIC poweroff handler to use the sys-off
API, so it can be used as a fallback for the SBI poweroff handler on
RISC-V. But the PSCI poweroff handler still uses pm_power_off, so done
alone, this conversion would cause the axp20x callback to be called
first, before the PSCI poweroff handler.

In order to prevent this change in behavior, the PSCI poweroff handler
needs to be converted to the sys-off API first, at a higher priority.

This series performs the conversion, after accounting for the fact that
the PSCI poweroff handler is registered quite early during boot.

The first patch is a dependency for both this series and the SBI
series[1], so I would like to get at least patch 1 merged soon.

[1]: https://lore.kernel.org/lkml/20221228161915.13194-1-samuel@sholland.org/

Changes in v2:
 - Update commit messages

Samuel Holland (2):
  kernel/reboot: Use the static sys-off handler for any priority
  firmware/psci: Switch to the sys-off handler API

 drivers/firmware/psci/psci.c |  9 ++++++---
 kernel/reboot.c              | 10 ++++------
 2 files changed, 10 insertions(+), 9 deletions(-)

-- 
2.37.4

