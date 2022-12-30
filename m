Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB46B6594A0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 05:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbiL3EVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 23:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiL3EVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 23:21:10 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE5610BA
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 20:21:06 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1002D5C0349;
        Thu, 29 Dec 2022 23:21:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 29 Dec 2022 23:21:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1672374066; x=1672460466; bh=aLzYj8JN/PIAmvGq/IWPmLbUt
        GLRXTzBljfdoNIT5Rw=; b=aTRdbzgNjXA57LKV6b+KFAN4csrtqw5INxBsHctIU
        xtL0KcPiQD34LlvEHRo7gCNfs2wn09lW7n67CFHbScz7X+bWOBxZD2FgZo4q+T46
        Gw+1U49XGcVCaLL8PeGa19bePKygqn/RLtPuIHAijq0NP+RuqPgHaUebw0uDuPbg
        v5DAW2CCZOBF3diraYTje5klmU3lLAkWk/81sC0QohlKiMvXjGIRcQH7kM+y4Nut
        I+FKvoBKW42zljXAWAwSJ1n8IrV9sEqpyKLyeTtuMhwP4X50fLvl5YpXH/kFMrEE
        mC4o0Fp5p+ZvVCTSelhKN2DqsbvnKd8viVVXE0gKFC42Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1672374066; x=1672460466; bh=aLzYj8JN/PIAmvGq/IWPmLbUtGLRXTzBljf
        doNIT5Rw=; b=PzyLXu/HcKiVdllAo+BphPNr60RHC5Qo/4oiWi5gf3KTcQlyeQD
        R6JSXkhFL35G/PQKaEu+4oUnbm08j6nCMrcuXXuTX7evFKQL1mKc23Zr7xdh5io+
        Dyf2kkzJ2eoL8brhr5LiE0NLyb2xikL/IMUBs0hjIBA8rePFm8/k/WFeyx63331B
        m4z1K4oiMyYbj5mNFmqgZjQWEm/qrcHFVvhd2cNnsmnaHsFYrLGkv8Pmnse4jz72
        Ib1hCat2r5Y2iPAbjAfacHUHJQMBCBI9WshiQbUbl5x/vRuOgPBZmBDpFpgffVQd
        Cj1DeXjaNa2EOJmK3z/F6lDLdUbA8crysJg==
X-ME-Sender: <xms:MWeuY9Eet0U8AlUhak2u-g-Qwp2XjfhZf99xuVDPMFaJWRuSsigG2A>
    <xme:MWeuYyUBSiPH4D6Szg2NHVqGegoAIjW6Eu9aFMSApzmYcNrrpToVYUJOSQnCJtfVK
    SSWS0aHZz48A35lFA>
X-ME-Received: <xmr:MWeuY_ISBp-Q3MuQDVAHKYVdRqx8IYGKQ7mxuhbbK3UlHkMk4CXXm6_A4Nbakq7pvfTpYMpfOSsElcvP7tub_dypH9A9hlBnqwG4fn49570jRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieehgdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdduhedmnecujfgurhephffvve
    fufffkofgggfestdekredtredttdenucfhrhhomheptfhushhsvghllhcuvehurhhrvgih
    uceorhhushgtuhhrsehruhhsshgvlhhlrdgttgeqnecuggftrfgrthhtvghrnhepjeetvd
    dtgedvueevgedulefggfejleetveetffeiveejvdevhfeukeeklefhheelnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehruhhstghurhesrhhushhsvghllhdrtggt
X-ME-Proxy: <xmx:MWeuYzHplsLFe-mhYuAKlWMxxMfEEn0ZYHUo5XQDDkgcMXdFIeC0kA>
    <xmx:MWeuYzUUMyNmonqgVBQ63I1j_dY_cwG5xnO5UUtrajy91bbPnG4c8w>
    <xmx:MWeuY-PUqfgnSXTIFxZcrZxJXmzNkhR5HeE_pQX3xqgs3rSsQH9Qpg>
    <xmx:MmeuY6Ee-uAxrGN5t4ytswYZBYNH2NCfwr3WqWYpDeGXMKAWbQ2b0g>
Feedback-ID: i4421424f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Dec 2022 23:21:02 -0500 (EST)
From:   Russell Currey <ruscur@russell.cc>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        ajd@linux.ibm.com, zohar@linux.ibm.com, mpe@ellerman.id.au,
        Russell Currey <ruscur@russell.cc>
Subject: [PATCH v2 0/7] pseries dynamic secure boot interface using secvar
Date:   Fri, 30 Dec 2022 15:20:07 +1100
Message-Id: <20221230042014.154483-1-ruscur@russell.cc>
X-Mailer: git-send-email 2.38.1
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

Changes in v2:

    Remove unnecessary config vars from sysfs and document the others,
    thanks to review from Greg.  If we end up needing to expose more, we
    can add them later and update the docs.

    Use sysfs_emit() instead of sprintf() for all sysfs strings

    Change the size of the sysfs binary attributes to include the 8-byte
    flags header, preventing truncation of large writes.

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

v1: https://lore.kernel.org/linuxppc-dev/20221228072943.429266-1-ruscur@russell.cc/

Russell Currey (7):
  powerpc/pseries: Log hcall return codes for PLPKS debug
  powerpc/secvar: WARN_ON_ONCE() if multiple secvar ops are set
  powerpc/secvar: Use sysfs_emit() instead of sprintf()
  powerpc/secvar: Handle format string in the consumer
  powerpc/secvar: Handle max object size in the consumer
  powerpc/secvar: Extend sysfs to include config vars
  powerpc/pseries: Implement secvars for dynamic secure boot

 Documentation/ABI/testing/sysfs-secvar        |  67 ++++-
 arch/powerpc/include/asm/secvar.h             |   5 +
 arch/powerpc/kernel/secvar-ops.c              |   4 +-
 arch/powerpc/kernel/secvar-sysfs.c            |  78 +++---
 arch/powerpc/platforms/powernv/opal-secvar.c  |  44 ++++
 arch/powerpc/platforms/pseries/Kconfig        |  13 +
 arch/powerpc/platforms/pseries/Makefile       |   4 +-
 arch/powerpc/platforms/pseries/plpks-secvar.c | 245 ++++++++++++++++++
 arch/powerpc/platforms/pseries/plpks.c        |   2 +
 9 files changed, 419 insertions(+), 43 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/plpks-secvar.c

-- 
2.38.1

