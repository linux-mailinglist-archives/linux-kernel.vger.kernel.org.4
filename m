Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0F85BBB56
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 05:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiIRDoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 23:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIRDod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 23:44:33 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE43208;
        Sat, 17 Sep 2022 20:44:27 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 52B8C320099E;
        Sat, 17 Sep 2022 23:44:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 17 Sep 2022 23:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxfierke.com;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1663472665; x=
        1663559065; bh=JNw+5gbeLx+VtE5TX56WLsuM3gmr3GoJ1cjwUH7Ro8U=; b=Y
        Xda0yKZadsG6bsX0dXzb35cTUAuoJqvJy8I6e547k8pI21f4lhfW6oRJDva9/ubt
        qOFUdQIJ5GCB2ovxSSXdVARdMBdHu5STqzxriEg+O8PyVs610wVQ5twOa1j+UAVG
        GRVIrB+2hLIOGz31E1LnnzU/6hTZykRV9OgLYYhRKL/Z0N3Cw50yGVwShzJsstez
        EwFObGrI7otBesyH8O/AV5PByoPZVnIMowyz3BW/ClAjMrNHrPKFWPzGorJF0jDo
        rIhmHgG5r38H4E2vIno2nZsx7SEk1H3Exx8XKZ02fjo5T2aCrkB/ONZcRrKO+7gq
        o/KYTuuBsDxpyZT+SRVrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1663472665; x=1663559065; bh=JNw+5gbeLx+Vt
        E5TX56WLsuM3gmr3GoJ1cjwUH7Ro8U=; b=t9M5rJCKxyUytymLMUZUKiHz19pku
        EA752QSIuLwy9TzXriwDyKJNa3eFN6Dq9ccd/Cor0dKHxdRdV3g+RO2orxNaxEXT
        Gs8ulzClaGt2eKhist9UBi2KoHLdSfP1vsZG/idy9mONDm+mINu22csQsAHAhCyI
        IKOU1sotxhkEhIZCqDWtZhr4Cr5BjZC1hXPmwvSa8br4Po6BOPJZBQz8di4YLs9R
        OImYmPNMWUAoFGO12zIIjH2V/OpOhX8Fa6uXQY0xWm8KAV0L6CpijIwmnKip1vQQ
        Hu08LwaYSdwdrY30HIdS99IX3M7/R0J1LBD/lWvsuT94obJvralvwk6bg==
X-ME-Sender: <xms:GZQmY4HEMaxKLIB-H9QesmRupVeKfv6WYwQSkzX2yacYfgqpeeZu_Q>
    <xme:GZQmYxWtnlTNXmp_behpErq-0l-cQHHiKLZnpr-N6lqM5f-Mlv8JqP0GwvBcJBXhi
    _pNql85skrnQBixfXo>
X-ME-Received: <xmr:GZQmYyLozFO_4MBR9kCriXGzgYXJgaW_Uqjr9NySKSWQmjGKvWlmIcDK2eaak4tcC6CL4qnmueZaQZZEBP69ZpmQNm370NT3-X34tjTwo1kv4xPHSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedvfedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgicu
    hfhivghrkhgvuceomhgrgiesmhgrgihfihgvrhhkvgdrtghomheqnecuggftrfgrthhtvg
    hrnhepudelvedvtdffhfeugfelieevvedvhefgvedtteefkeevvdfhieekudeuteefgeek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgi
    esmhgrgihfihgvrhhkvgdrtghomh
X-ME-Proxy: <xmx:GZQmY6HOCIdFp825OHeLnFUJfP6IcfvAiPYo6P8ZKmYmo-_T1D9xWw>
    <xmx:GZQmY-VkFL9lVJ9LiOBrTeTSym3Z2AFwtYgLCgJCrcwXh1YMK2iUog>
    <xmx:GZQmY9NPV8j2-AxUXoNyJLwrRYha2_w8fyXnKuVAjB_NQW1ny3JbwQ>
    <xmx:GZQmY3UF2rjh9w-7QyBDzoKTmqZMCocsCofqacOzaFtn8Eo0HKxYdw>
Feedback-ID: idee9475d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Sep 2022 23:44:25 -0400 (EDT)
From:   Max Fierke <max@maxfierke.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Max Fierke <max@maxfierke.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/4] dt-bindings: vendor-prefixes: Add prefix for ClockworkPi
Date:   Sat, 17 Sep 2022 22:44:12 -0500
Message-Id: <20220918034415.74641-2-max@maxfierke.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220918034415.74641-1-max@maxfierke.com>
References: <20220918034415.74641-1-max@maxfierke.com>
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

Add a prefix for Clockwork Tech LLC, known as ClockworkPi. They
produce a number of hobbyist devices, including the ClockworkPi
DevTerm and GameShell.

Signed-off-by: Max Fierke <max@maxfierke.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 2f0151e9f6be..64f4b899c40c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -258,6 +258,8 @@ patternProperties:
     description: Cirrus Logic, Inc.
   "^cisco,.*":
     description: Cisco Systems, Inc.
+  "^clockworkpi,.*":
+    description: Clockwork Tech LLC
   "^cloudengines,.*":
     description: Cloud Engines, Inc.
   "^cnm,.*":
-- 
2.37.2

