Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11E75F165B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 00:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbiI3WyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 18:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbiI3WyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 18:54:02 -0400
X-Greylist: delayed 150 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 30 Sep 2022 15:54:01 PDT
Received: from resqmta-h1p-028589.sys.comcast.net (resqmta-h1p-028589.sys.comcast.net [IPv6:2001:558:fd02:2446::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952F81A40A0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:54:01 -0700 (PDT)
Received: from resomta-h1p-028516.sys.comcast.net ([96.102.179.207])
        by resqmta-h1p-028589.sys.comcast.net with ESMTP
        id eMOsoAaciPrBBeOqxoYtGT; Fri, 30 Sep 2022 22:51:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1664578291;
        bh=HNVafGkuTXNZfhdbSamPN6JaP53LoGqa/nsvRivQiiU=;
        h=Received:Received:Received:From:To:Subject:Message-ID:Date:
         Content-Type:MIME-Version;
        b=vartL7niCSrd6lL8w4KbHk3s/COLpQNBIjZE8+ZW3Qvtqo1hWScJn/MGzRkUkGlbK
         /Uo7Vx8lWTOjuKljHwj/79YcX65JaJyDWBKYX2nasPMl50hK/0b2HJ0vbfZjfVfHhQ
         yIf2hgzBxJAjJ1JUiG0Yak02tV5HEDpAAKDAU4bu3TNlqpSA+rUk6QEXlIj6bo3May
         oJELEib/cnXt1W20SKYYUutpWS33pH425wK9V3zSQEoXAxivx58nab8EDuN13Fp2eP
         XalAch0yl9+ObSnzaafWqbKGl/Ast2BOoj5fvX2E0hxqOOYAK7+2LLPAlaTaJn/9pO
         fvjasqJschNtA==
Received: from Outgoing.brak ([69.249.67.241])
        by resomta-h1p-028516.sys.comcast.net with ESMTPSA
        id eOqtompRuQ8sQeOqvoacWc; Fri, 30 Sep 2022 22:51:30 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehfedgudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvehomhgtrghsthdqtfgvshhipdfqfgfvpdfpqffurfetoffkrfenuceurghilhhouhhtmecufedtudenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuffkfgfftggggfesthekredttderjeenucfhrhhomheprfgruhhlucflohhnvghsuceophgruhhlsehsphgrtggvfhhrvggrkhdukedrgiihiieqnecuggftrfgrthhtvghrnhephedvvdelheffjeelhfejfeevhefhgeeghfegtddttdfgkeeiteeiueeiveettdeknecukfhppeeiledrvdegledrieejrddvgedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghlohepqfhuthhgohhinhhgrdgsrhgrkhdpihhnvghtpeeiledrvdegledrieejrddvgedupdhmrghilhhfrhhomhepphgruhhlsehsphgrtggvfhhrvggrkhdukedrgiihiidpnhgspghrtghpthhtohephedprhgtphhtthhopegrnhhsshhirdhhrghnnhhulhgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhikhhosheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidquhhssgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-Xfinity-VMeta: sc=35.00;st=legit
Received: from cloud.brak.space (Nextcloud21.brak [172.18.18.201])
        by Outgoing.brak (Postfix) with ESMTPSA id 8F263B317F2B;
        Fri, 30 Sep 2022 22:51:27 +0000 (UTC)
From:   Paul Jones <paul@spacefreak18.xyz>
To:     jikos@kernel.org, anssi.hannula@gmail.com
Cc:     linux-@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] HID: usbhid: hid-pidff: Set Replay Length to Infinite
 when set to 0
Message-ID: <20220930225127.Horde.AdDRdase1XW5AUKNNLyXVo3@cloud.brak.space>
User-Agent: Horde Application Framework 5
Date:   Fri, 30 Sep 2022 22:51:27 +0000
Content-Type: text/plain; charset=utf-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,FROM_SUSPICIOUS_NTLD,FROM_SUSPICIOUS_NTLD_FP,SPF_HELO_PASS,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,
 
Started using my Accuforce v2 Sim wheel on Linux. I was getting no response from racing simulators through Wine, but native linux test tools worked fine. It seems that many real-world applications will send 0 as the replay length, which was resulting in the behavior I was experiencing (nothing). It makes sense to interpret 0 as an infinite effect and therefore set the replay length of the effect to 0xffff. While the PID document does not explicitly state that 0 should be infinite, it does hint toward null values being interpreted as infinite.
 
---
 
diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index 3b4ee21cd811..70653451c860 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -301,7 +301,7 @@ static void pidff_set_effect_report(struct pidff_device *pidff,
 pidff->block_load[PID_EFFECT_BLOCK_INDEX].value[0];
pidff->set_effect_type->value[0] =
 pidff->create_new_effect_type->value[0];
- pidff->set_effect[PID_DURATION].value[0] = effect->replay.length;
+ pidff->set_effect[PID_DURATION].value[0] = effect->replay.length == 0 ? 0xffff : effect->replay.length;
pidff->set_effect[PID_TRIGGER_BUTTON].value[0] = effect->trigger.button;
pidff->set_effect[PID_TRIGGER_REPEAT_INT].value[0] =
 effect->trigger.interval;
 
-- 
 
- Paul
 
