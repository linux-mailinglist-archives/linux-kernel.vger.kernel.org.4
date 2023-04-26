Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2456EF0CC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240203AbjDZJNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240035AbjDZJMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:12:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949F040F4;
        Wed, 26 Apr 2023 02:12:34 -0700 (PDT)
Date:   Wed, 26 Apr 2023 09:12:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682500351;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0QW/Hw22ofhf5EXzxdGNoFzICaov435fT9xDjOYq4pA=;
        b=ttmPi9HpNFJI/kPMkNMy8l85pcJvZs4QQN1Z05+cdwh49Pmss5MwVvoGzsyV8YjxQaJIUe
        ScsL5zix+w+NVW/HXI98la8R7eppuxOB4mQ2wAPimW2itVQD6k2kmet6AgNog0jZVfNm9C
        b5OzeCPJYVbky5J7SoYWugEPUFcHiXAVo457DR9CyreDPWhHQv+rYdQA5grOIfcU7lTdbG
        9ucZEN7V0RoZs9PC8prFwHyknsNyNYQRYM4XbYUzPE1y1of6pmarAJ3YDCEsA3xfEzTi8b
        B70AxkvEVuOjS3qMkXC1SC/USezT7vfuAykogb2LlsI8YOieYh0VnEQHeMFr3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682500351;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0QW/Hw22ofhf5EXzxdGNoFzICaov435fT9xDjOYq4pA=;
        b=d79VZRJSyh+JsNeON4s/rOlpYENYhFm/RtzypTLaFk6CU4ACrqKTKxFj+oKM/k/IjT3o+1
        VeCo0jCceilG0rBA==
From:   "tip-bot2 for Krzysztof Kozlowski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/stm32-lp: Drop of_match_ptr
 for ID table
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230311173803.263446-1-krzysztof.kozlowski@linaro.org>
References: <20230311173803.263446-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Message-ID: <168250035138.404.3777716060477300436.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b6f228e800ccf285906bb1c4c366ce3848a5443e
Gitweb:        https://git.kernel.org/tip/b6f228e800ccf285906bb1c4c366ce3848a=
5443e
Author:        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
AuthorDate:    Sat, 11 Mar 2023 18:38:03 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 24 Apr 2023 16:56:13 +02:00

clocksource/drivers/stm32-lp: Drop of_match_ptr for ID table

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it might not be relevant here).

  drivers/clocksource/timer-stm32-lp.c:203:34: error: =E2=80=98stm32_clkevent=
_lp_of_match=E2=80=99 defined but not used [-Werror=3Dunused-const-variable=
=3D]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230311173803.263446-1-krzysztof.kozlowski@l=
inaro.org
---
 drivers/clocksource/timer-stm32-lp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-stm32-lp.c b/drivers/clocksource/timer=
-stm32-lp.c
index 0adf22d..d14a175 100644
--- a/drivers/clocksource/timer-stm32-lp.c
+++ b/drivers/clocksource/timer-stm32-lp.c
@@ -205,7 +205,7 @@ static struct platform_driver stm32_clkevent_lp_driver =
=3D {
 	.probe  =3D stm32_clkevent_lp_probe,
 	.driver	=3D {
 		.name =3D "stm32-lptimer-timer",
-		.of_match_table =3D of_match_ptr(stm32_clkevent_lp_of_match),
+		.of_match_table =3D stm32_clkevent_lp_of_match,
 		.suppress_bind_attrs =3D true,
 	},
 };
