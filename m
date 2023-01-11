Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F18C666273
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 19:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbjAKSF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 13:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjAKSFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 13:05:50 -0500
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE8115FC6;
        Wed, 11 Jan 2023 10:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1673460346;
        bh=UdPnM9sqO97FbEbwIzKC53KQNJMmfNvLCQaiSudzT0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=yQAZ/iZeF+JmXnGOeegTnQa/7QeaTMOkLOr41ZVJOA/XblmbBa7LQj6vVBS24Dnzy
         2Idj6mMjXxtXCnESYyB73qZCMGH0a6d6XgdkvlfCGjEad5wUpR1qr4y7j39wCEAp8c
         qFpwkyCMuGSnetJUBKwnTEsyCve4U61c2lZjM49U=
Received: from localhost.localdomain ([111.60.247.106])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id 14F2600F; Thu, 12 Jan 2023 02:05:15 +0800
X-QQ-mid: xmsmtpt1673460343tedbiqwcm
Message-ID: <tencent_6147438537D63EA09B0143B80FF163CC450A@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjavfJFvD2tj5f8GJCaB496TyKA6/hqSFOqjypyWpf0RMhRKrCfg
         hZJGmbHCZfy/igkrQdg29PIucDyTJdMmfOX6JhQmSPp25qY7etihnzL99lQNIB3DvDwoSe2X8wHU
         px9hnpr967dTHGNdYteODya5Wvkjrg642S1Kj4/x7NzSKi3ft3zHTL8AEcIt0Wk0xM37lXqm7yfd
         uJeO4lQqifMdKhyiEOoUd51TlYjmfj6HT8evfEbxYRdQQpji/FA61+xNGJook82rsx3Btj6TneK7
         r+xyktPmKsOGj0M1NoDb9aoELLQkOR8DYZJ/TYkBjzcUyM5v0e1XjPf2EntM44KpF9/iEmnLAzGJ
         aHK5ldaWzOe1hpVcepmSgsNevNQhji6t43EUgYJdN/N8QRKFfgs8nzzzgn/emOSzHI6ZTK80hzzS
         lRTwbjUbxgTyLvFmxC56b7PFEoqIsvNjCnGcppEGbROr1DVpvHq6/uLR+GfcFl7T9Tzw08zBHFyp
         vQZX7Bd7XKY1P4rwY2wPH95DCLsQrX/X0gr/EhViXHWR8meXQ6BO0N0FJGUhU4oNplQmcxLS+ewe
         Rhj6KFaA1UISQ7dDTIwR7uri3vIYtz3bM5gD+sJfBV8asvDcmb0LQMsq78aqF2MLnjPWVQcOeFxx
         pyvN773BCWqxxb5L//tv6cctPwxn1PibMVwoyMuUvNuOZIOIXKBU0ktW8XvW6k31sn16Q2cDEEZb
         8vvyIi9Ada19JYvaq+CYF74xKNyYK0B1znuhmo6Iqq5t8zN1jmKhWIGUszueEgzBMK+hoaoXMwsX
         /ivAuHndlCZyD+UVZNLf2yGf63tAlltVx7HcoRU2bXK98s7pwTQ3iK+0mEuW71cQl2w18J42yHM5
         K0ooIEu8NJuqbm7lm4T0qBcFECff4ssP8JlS6Pyhn6LPN9l4tonwDpLbUAr02+aCaSyG8CYCct4A
         1CS3ioEHf7TP+XqupB8wl0M6Md3Cz9EVJmfPtAG6EZQ42YQxHBim3TWoQfDLyJfo2fzR7+y+Vqsc
         YEBGOBmcEYO+Fx8rKbPpB9jIoN9+c=
From:   Yang Xiwen <forbidden405@foxmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Yang Xiwen <forbidden405@foxmail.com>,
        Jaime Breva <jbreva@nayarsystems.com>,
        Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/3] dt-bindings: qcom: Document msm8916-thwc-uf896 and ufi001c
Date:   Thu, 12 Jan 2023 02:03:21 +0800
X-OQ-MSGID: <20230111180322.21874-3-forbidden405@foxmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111180322.21874-1-forbidden405@foxmail.com>
References: <20230111180322.21874-1-forbidden405@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new thwc,uf896/ufi001c device tree bindings used in their device
trees.

Signed-off-by: Yang Xiwen <forbidden405@foxmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 263913d2451d9..8cb60a5b83e0d 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -210,6 +210,8 @@ properties:
               - samsung,grandmax
               - samsung,j5
               - samsung,serranove
+              - thwc,uf896
+              - thwc,ufi001c
               - wingtech,wt88047
           - const: qcom,msm8916
 
-- 
2.39.0

