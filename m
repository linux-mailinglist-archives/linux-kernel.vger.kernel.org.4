Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC1F6573A7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 08:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiL1Haj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 02:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbiL1HaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 02:30:25 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD999EA6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 23:30:24 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id CDE2C3200904;
        Wed, 28 Dec 2022 02:30:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 28 Dec 2022 02:30:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1672212620; x=1672299020; bh=kg/f9U9Ol4UD+1uc3IGmsV2dd
        QbQ6QRH+cPwJ6R0wEk=; b=GQcC6LqX9bOe7C6/VfGcwdWWCcYYpKAcVwi5Sl1Nq
        1eNL1f0lK5vgpC4d2a3aoXePQqOvivn1QRgzt5rEKKzol9gSVIfY0x5LFMmQWOBJ
        SHCFBMnHeRcrWDwtWRYSkeZ31F6tZc/5G4JQjIjx9kEaFHcviMd1AOhbUKsHJ9Fo
        5giFMOggshB8VZQdTTlNauoHokceLN8nkzMVbYn7R7ZtFKlryXepeNTSrOePwzPF
        idDy0w9V1E4jVANL3AAzylifu/svtWMi5Z0tqsZY2QR/BrS5bmaXDxNQhsyxxaew
        GXEsSrIJenlKS+1N6CR/xZMNCjRteYVzJOA4Ib+R/NgDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1672212620; x=1672299020; bh=kg/f9U9Ol4UD+1uc3IGmsV2ddQbQ6QRH+cP
        wJ6R0wEk=; b=q4FIVeqBvszFlxGwGJzkQvrKHGMqfSK3LjpxiTehFWF81Vzzfax
        ur86BYxhRyHMAnQ91pc3I7kwQIThGyTEZi9pjtJnDAT0nCpXNg0BEhOU+MWaI0a8
        LWb7F8tb6G8xOwJDTTDw8HM5A56ZnykhZQHDFAXuG+sZFfdYa/fp6TW66KgCy8dH
        N3FIr3KMOXuC7bnjCWskiy1kN14x8XizHalwMApvWRPgPFNX11ySWfQXQA5XrWON
        OJrEmCycM8QjxELYO8S15lY+InBl7xvWvyjp7tiNQDJp0Myaq4j7vouUGhz6xNd5
        tJKxrSaqFZ73czFcumbBu1WTn5z/6X30Z+A==
X-ME-Sender: <xms:i_CrY5D8PDmfB27uMNgFuYjdYIVVe1fTyUH3JzMNUxU8gDnA02zz2g>
    <xme:i_CrY3gFlyYF6UYZi-d2MbGQ19exMQDRtaid6HWyfOLSl0MbyyMKGPiQzm5sOm19p
    nVIZIZ-0-01au3hAw>
X-ME-Received: <xmr:i_CrY0l8Ny_IxehNDvYbUwoZ8Arek5CXbdc0tIRNvRh003D4dd4QLqCibIUIK41bLEgw7eyUW9bDP9v-HTmbpKYs0cE8WKTJw-HlMlJb1q5USg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedriedugdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdludehmdenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftuhhsshgvlhhlucevuhhrrhgv
    hicuoehruhhstghurhesrhhushhsvghllhdrtggtqeenucggtffrrghtthgvrhhnpeejte
    dvtdegvdeuveegudelgffgjeelteevteffieevjedvvefhueekkeelhfehleenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprhhushgtuhhrsehruhhsshgvlhhlrdgttg
X-ME-Proxy: <xmx:i_CrYzzteBqcA9f6fTDxR5gAaxN9SuofXN5XKD5IL5piKJWimuuCAA>
    <xmx:i_CrY-SuNOI-JX-WQnTtaHVtZxLnNJyAU_ydcN_xXtgDxlBDcB6bHw>
    <xmx:i_CrY2brpRjwpRDxP8zn6OCKmHMJ2QvR8kcxW9-GXIZksgEkalze2Q>
    <xmx:jPCrY7TdLGfdpjzMSSW9vVW3Eb334ixQHBMi1NKnXtNbBd9NW_LW4Q>
Feedback-ID: i4421424f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Dec 2022 02:30:16 -0500 (EST)
From:   Russell Currey <ruscur@russell.cc>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        ajd@linux.ibm.com, zohar@linux.ibm.com, mpe@ellerman.id.au,
        Russell Currey <ruscur@russell.cc>
Subject: [PATCH 0/6] pseries dynamic secure boot interface using secvar
Date:   Wed, 28 Dec 2022 18:29:37 +1100
Message-Id: <20221228072943.429266-1-ruscur@russell.cc>
X-Mailer: git-send-email 2.38.1
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

This series exposes an interface to userspace for reading and writing
secure variables contained within the PowerVM LPAR Platform KeyStore
(PLPKS) for the purpose of configuring dynamic secure boot.

This series builds on past work by Nayna Jain[0] in exposing PLPKS
variables to userspace.  Rather than being a generic interface for
interacting with the keystore, however, we use the existing powerpc
secvar infrastructure to only expose objects in the keystore used
for dynamic secure boot.  This has the benefit of leveraging an
existing interface and making the implementation relatively minimal.

This series needs to be applied on top of Andrew's recent bugfix
series[1].

There are a few relevant details to note about the implementation:

 * New additions to the secvar API, format() and max_size()
 * New optional sysfs directory "config/" for arbitrary ASCII variables
 * Some OPAL-specific code has been relocated from secvar-sysfs.c to
	powernv platform code.  Would appreciate any powernv testing!
 * Variable names are fixed and only those used for secure boot are
 	exposed.  This is not a generic PLPKS interface, but also
	doesn't preclude one being added in future.

With this series, both powernv and pseries platforms support dynamic
secure boot through the same interface.

[0]: https://lore.kernel.org/linuxppc-dev/20221106210744.603240-1-nayna@linux.ibm.com/
[1]: https://lore.kernel.org/linuxppc-dev/20221220071626.1426786-1-ajd@linux.ibm.com/

Russell Currey (6):
  powerpc/pseries: Log hcall return codes for PLPKS debug
  powerpc/secvar: WARN_ON_ONCE() if multiple secvar ops are set
  powerpc/secvar: Handle format string in the consumer
  powerpc/secvar: Handle max object size in the consumer
  powerpc/secvar: Extend sysfs to include config vars
  powerpc/pseries: Implement secvars for dynamic secure boot

 Documentation/ABI/testing/sysfs-secvar        |   8 +
 arch/powerpc/include/asm/secvar.h             |   5 +
 arch/powerpc/kernel/secvar-ops.c              |   4 +-
 arch/powerpc/kernel/secvar-sysfs.c            |  76 +++---
 arch/powerpc/platforms/powernv/opal-secvar.c  |  44 +++
 arch/powerpc/platforms/pseries/Kconfig        |  13 +
 arch/powerpc/platforms/pseries/Makefile       |   4 +-
 arch/powerpc/platforms/pseries/plpks-secvar.c | 250 ++++++++++++++++++
 arch/powerpc/platforms/pseries/plpks.c        |   2 +
 9 files changed, 365 insertions(+), 41 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/plpks-secvar.c

-- 
2.38.1

