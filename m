Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4E76580E1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 17:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiL1QWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 11:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbiL1QVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 11:21:24 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F631B792
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 08:19:22 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 228DE5C0185;
        Wed, 28 Dec 2022 11:19:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 28 Dec 2022 11:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1672244359; x=1672330759; bh=+MzbJuL0sz6xYgyGW+zwedxik
        v2ybOeYdYhDY6xmhzg=; b=EgjRXLVlzDO3JjcYyL+wRRhrOb013Iu2nzK8NjvUB
        voaTsi/8c8J/dPerwe9GRP0c6h2r7/1P8I7k5Dz3zjoLOLnzpRU8SUk2qbWKg9eR
        1MLzORr7BDUczDuHhNXZGhy2Ls45lPa2bO+liasLEz0WVrrvLuOCMkwMOzwqgpkk
        xDjtrwkaMw6kJU1+CEvyLflxq6Bl/fIOIpWbCzlTWp6sMCrcXqEt0NzY9HNfkcdI
        BC+oa0TYHK567p9JMYeWEO5tsv1ArfMmEid7eDcDNbkz3xlZ3OooQATV9Z/6pLom
        F4+X1oRNzJU9vXuKwWnRu0rYvf4M9OcwSBts1UTpbMNpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1672244359; x=1672330759; bh=+MzbJuL0sz6xYgyGW+zwedxikv2ybOeYdYh
        DY6xmhzg=; b=W7dQrHduKsuWY3JvJyYCqpaeZ5NviTqpcnpThpvNwbig6qO4O+g
        KSBtnpFupqSICqAVQ20+L2ya+/bB6kz0u2GCncnSukFUylW/6UZj7XNTvS79U6sm
        d6kbPvCMjIl+GndbnrU8dcctRC/WOF0oEPayQYUshOOGo7V6i3hVwVQ5M1oMFDP5
        g54UQjmMIcn994h6gbuJ1/lR14IxCLc4ZI9D0uDsWUaB3JcA2e7h+eFlKgco571U
        MPnEyq3zc0N/LBBbCHMgJVOy9pY5Wi8ZSD2YuPci1yORd68mrBlWDYONnuW7oj1C
        IPSlMlwJLsoWNTc3Ue7PpW/54De1kWPFOCw==
X-ME-Sender: <xms:hWysY_MIvyNk6Fl7igOS5ykwpW4bxcB89DCO3ihVnRYHh3-7L6yHmw>
    <xme:hWysY589Wxxp36pc5UhBaipoIkE80BSPT4j6zDXPzc_tINkYUzmqEzXCBv4ysu_-V
    9L-wUHbWopfsbcWxA>
X-ME-Received: <xmr:hWysY-RuKrR36tmIXILMS2__02PNQEw9NQKEpicgWMtt-1UUOY3hUzpJNu9MBIQv34FX_-kw-mZKGeRvF_KMQ3s0gkb6XY-zDHneg36afg7hIaox3OrWxfwa7SwW6NeEXZdqKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedriedvgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeekheffteehtdetfffgfeetteejvdefleeuvedufffguedtjedvheelvddv
    fffhveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
    ohhrgh
X-ME-Proxy: <xmx:hWysYzt7xQyw9T6XNt25TH7IQjKZOIfbKJeQAUP-Rt_kmi4eK3_wJw>
    <xmx:hWysY3c-dN0q47s7C4QR5Ukc8MPYVkiRLA4m5vMaOdI-eJVp6s3_dg>
    <xmx:hWysY_0eOANcwUIgRg9k078yiHZhIUVygSKTUt9PjsTdiGhxnb-UgQ>
    <xmx:h2ysYytkq0BX7Gc454wV-4bRuk35MyCM4_MOQl5VOg_xsJkRaTVbjA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Dec 2022 11:19:16 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Petr Mladek <pmladek@suse.com>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, tangmeng <tangmeng@uniontech.com>
Subject: [PATCH 0/3] riscv: sbi: Switch to the sys-off handler API
Date:   Wed, 28 Dec 2022 10:19:12 -0600
Message-Id: <20221228161915.13194-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I want to convert the axp20x PMIC poweroff handler to use the sys-off
API, so it can be used as a fallback for if the SBI poweroff handler
is unavailable. But the SBI poweroff handler still uses pm_power_off, so
done alone, this would cause the axp20x callback to be called first,
before the SBI poweroff handler has a chance to run.

In order to prevent this change in behavior, the SBI poweroff handler
needs to be converted to the sys-off API first, at a higher priority.

This series performs the conversion, after accounting for the fact that
the SBI poweroff handler is registered quite early during boot.

The first patch is a dependency for both this series and the PSCI
series[1], so I would like to get at least patch 1 merged soon.

[1]: https://lore.kernel.org/lkml/20221105214841.7828-1-samuel@sholland.org/


Samuel Holland (3):
  kernel/reboot: Use the static sys-off handler for any priority
  riscv: sbi: Share the code for unsupported extension warnings
  riscv: sbi: Switch to the sys-off handler API

 arch/riscv/include/asm/sbi.h |  1 -
 arch/riscv/kernel/sbi.c      | 63 +++++++++++++++++++++---------------
 kernel/reboot.c              | 10 +++---
 3 files changed, 41 insertions(+), 33 deletions(-)

-- 
2.37.4

