Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CD661DEFE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 22:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiKEVtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 17:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiKEVsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 17:48:45 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E916B13D5D
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 14:48:44 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 097DD32003D3;
        Sat,  5 Nov 2022 17:48:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 05 Nov 2022 17:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1667684923; x=1667771323; bh=s+pdBoQbiwpKAIIB+oAbcaTA6
        YS444zDU3WzHbz8XM4=; b=CtzJlsRLFv4TPmZbXoy6s0eTuqHwZ6mUYfPJ077oY
        CuYBs1/bwThMKONbJ0Y2yiR8fP561idl8SxqmvItLWB2iYx1EEkwUTYfyCBjF9Cz
        XibjEPDrWv0+YdxoujJNbFe+azUkxIdWgux4IO4R1G4P36RPyE1ERhn4p/NvkLAt
        MdLX0ru0GPSJgoPZ6x7G3epgSybHLX7SX0OgIAeu76nQgRt4YQiVurjoNJ8CjNzo
        hxTfa/Nl4wxxoibt+FYL3b3IarqBKidxOCgWil1wyHktnWRW328Nu2O6rW+SE2mh
        uSgvN9KQTUHITbZxsyh1Y0/7diZKc5NLAqscDE3nGxy3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1667684923; x=1667771323; bh=s+pdBoQbiwpKAIIB+oAbcaTA6YS444zDU3W
        zHbz8XM4=; b=Q7MKvu+ZYbhCipByUzJg8syDU86MNt83H/cEaPzCqU1M9j6dqfQ
        glI2upT4a/uEf5AnovRw6IQr43drswOOPsXSJt+UNBai330eTfEG4r058gu7oBDw
        w5Ih78oiCK9FxF6KF6iSEGHLpfFTr6HgZtN4QSyOfB2Hq4422WrbsIdMU2uqrUrV
        lhFY/vC0Q3HVcXOsRh2GAPX4yPSFSgLOR9Z0WLhIMjjPKkVykLlZw85Z2onCYh33
        3gTmdoE3zLMB4m3ULhSLA6fB2+nNNaZ4BLWraHfJE/o52tB/pFllqXsoulKTmBw1
        tj38tID0wiLpNQihFORmPfs2jx8KEDjLofA==
X-ME-Sender: <xms:OtpmYzTZiBga0NWza-IbFiDwY3mH2yZ7o7P76kfaCt9m02ppWZuMpQ>
    <xme:OtpmY0xPTwHbUpkrJ-hCP9nc5Guewma55uB_aLSkPEAvzTMdjOQGPSKSEi_-9-jKI
    oPpjCKmW3AUKfz5sQ>
X-ME-Received: <xmr:OtpmY41jc8mw5bASS8GINaJRI_prPwEwFQeA9Udp4uHx4mL2SfbBWdoxoieHbcCjqsJO_T_w4EZNUG_q3odC8zYDa8TjvGuUI9apg943RX8X9a3KUgI0jV3S-Dhh-7GmlUXOag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdeggdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeehhffh
    keekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:O9pmYzB9ccLZyhBaQuJeQhBchd9Is56IpseXTHj0SFjzKE-SPoA9cg>
    <xmx:O9pmY8gxTwV9dRKnMc3QIif5DWp_qkx01l5GJqaIArVWhLZ88rAUqQ>
    <xmx:O9pmY3p-uD5BltmaaiVe0Lvs-RLUrIUYfJ0PU6NcQt3vNEtqeI4Nmw>
    <xmx:O9pmY2Znh0nIh1gBSmxSGW0pZUdfYzKCCiwlvzfqZ5vxL2spdNUUvA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Nov 2022 17:48:42 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 0/2] firmware/psci: Switch to the sys-off handler API
Date:   Sat,  5 Nov 2022 16:48:38 -0500
Message-Id: <20221105214841.7828-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am interested in converting the axp20x PMIC driver to use the sys-off
API for its poweroff handler, so it can be used as a fallback for the
SBI poweroff handler on RISC-V. But the PSCI poweroff handler still uses
pm_power_off, so done alone, this would cause the axp20x callback to be
called first, before the PSCI poweroff handler.

In order to prevent this change in behavior, the PSCI poweroff handler
needs to be converted to the sys-off API first, at a higher priority.

This series performs the conversion, after accounting for the fact that
the PSCI poweroff handler is registered quite early during boot.


Samuel Holland (2):
  kernel/reboot: Use the static sys-off handler for any priority
  firmware/psci: Switch to the sys-off handler API

 drivers/firmware/psci/psci.c |  9 ++++++---
 kernel/reboot.c              | 10 ++++------
 2 files changed, 10 insertions(+), 9 deletions(-)

-- 
2.37.3

