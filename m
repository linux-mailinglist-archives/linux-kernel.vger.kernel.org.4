Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A1265949F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 05:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbiL3EVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 23:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiL3EVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 23:21:10 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEEA10EE
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 20:21:09 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 644215C0152;
        Thu, 29 Dec 2022 23:21:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 29 Dec 2022 23:21:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672374069; x=1672460469; bh=yn
        /S5ROEzSnOph0KuGPaeywtNTs872W1IHLPpJmU4iY=; b=N07qjmZ3Ji/7yGH5Hn
        EeQsn6g38OB6puVyAnveYv95+MlMyyoyTADCl80OkaUy2YtEF4WTfYrZp49qS8/q
        w3YWeREnapP1VV3bN7t1L+2CoeEwcuXf5OzC1CnlDwPRaxMbacZ2tRFvFzJJfutX
        2f/ogCvnsPLyB5cb+8oNz9mPLEmkrlTuWqBz0izdKsQWXJpmdvYlH1lTGJIVPeBM
        4FbhC50u4vHX2kjFE4zSqFXsp6Sx7SUYSIwtIS2Lg6QOCaiOesgAwjN1qcD7irif
        Inv2ue9MIwzKXZv1UPcAPQ0dVMCXmYFaLSAhFQ9oXnPuu9ngT+7yhcGw5BwfNLvZ
        Fv1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672374069; x=1672460469; bh=yn/S5ROEzSnOp
        h0KuGPaeywtNTs872W1IHLPpJmU4iY=; b=xFgzCHB6w5ubGeFsVdyWL5cGDdQUF
        h5/0yA/phVbZf7bjA+Fx0dUU8zg0XeDrH2oV5lt9QZ9KutKDjCjmZ7+rZxiCE1lX
        BYBoHALbo9nWqAZjGFPp0G+j+kfTvQ1LlhZO+mpc7KvFxGQAcjV9aMkjmLGbN/TZ
        luL/gHTjsWiYJ7SPrjmDcFp4vKZ6bPVATUmxO2lXPUsAtxOlcnAeSulGSD71KzvW
        wMuE7rjP/d1WfiTb3onnCWz5SvEMRg6LNu30rsMcoTMjcUQO7iXdjoFrpK+2smt0
        wjsGsGgQ6EuBPK1lfp7SNuBiCG4dwABnCy2U1rnVTuH+IlDs+qeg6nK+g==
X-ME-Sender: <xms:NWeuYysO2lKBiTsOjinYLXs7BE-CKEO_2e9YqnWPJYT_Cdzea4LJLQ>
    <xme:NWeuY3fGLNFKHyln5UstxW0vWCfhN4Zl0vIuWv-TqnG1pRqxWwRbOvF1JbnD6_u1b
    KAhlrzboXbfDNc7cw>
X-ME-Received: <xmr:NWeuY9zCc2mrcxhTJ0HgrEoHAbjIzuKL6JC76RO3Z2dsyEl4P6Uedvzy9cw6cbbUw_xldZh_NcoV2UVMnRLVrjI_S-YbQNfxqtaiHRU5uHV0PQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieehgdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdeftddmnecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhushhsvghllhcuvehurhhr
    vgihuceorhhushgtuhhrsehruhhsshgvlhhlrdgttgeqnecuggftrfgrthhtvghrnhephf
    dvuefgtddvieeigefffeffkeeigedvgfeitdejteffveefhfdtheejffeiiedvnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhhushgtuhhrse
    hruhhsshgvlhhlrdgttg
X-ME-Proxy: <xmx:NWeuY9MLD5cNOUiqfGO4D2W3LX6iVhc_ZCvNjWkNbTwfLWztN4oTHA>
    <xmx:NWeuYy9fz_Lh0uRHLWg6Wr6O-b1h0MI72RGNUrZU8bjofynZ94ytFw>
    <xmx:NWeuY1VdCrR6f0ANu2OpgKwj5kukuJQXlayKuFV0xLjProLq9BH9KQ>
    <xmx:NWeuY3PcQPYlkR1ZPGJvL3kkOY54vuRhYAfrysZQQCNyY8aaKdZZLw>
Feedback-ID: i4421424f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Dec 2022 23:21:06 -0500 (EST)
From:   Russell Currey <ruscur@russell.cc>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        ajd@linux.ibm.com, zohar@linux.ibm.com, mpe@ellerman.id.au,
        Russell Currey <ruscur@russell.cc>
Subject: [PATCH v2 1/7] powerpc/pseries: Log hcall return codes for PLPKS debug
Date:   Fri, 30 Dec 2022 15:20:08 +1100
Message-Id: <20221230042014.154483-2-ruscur@russell.cc>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221230042014.154483-1-ruscur@russell.cc>
References: <20221230042014.154483-1-ruscur@russell.cc>
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

The plpks code converts hypervisor return codes into their Linux
equivalents so that users can understand them.  Having access to the
original return codes is really useful for debugging, so add a
pr_debug() so we don't lose information from the conversion.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/platforms/pseries/plpks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index 9e4401aabf4f..820218eb894f 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -131,6 +131,8 @@ static int pseries_status_to_err(int rc)
 		err = -EINVAL;
 	}
 
+	pr_debug("Converted hypervisor code %d to Linux %d\n", rc, err);
+
 	return err;
 }
 
-- 
2.38.1

