Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CBC6E69E7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjDRQny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbjDRQnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:43:49 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C414740EE;
        Tue, 18 Apr 2023 09:43:46 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id F202ECB3CB;
        Tue, 18 Apr 2023 16:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1681836225; bh=vIuKvsLduKbdJuLqS3gE6yL7XCUiBq1e88KkTbfWTJA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=ItGVjgWcNdo/Uswib8zZNt18Zfz4kbVzUdCqBxQ5VGD5vchb9bo68cvDKGviLBb3u
         H2BX/Z6zBC524zyumfeDRa9e7Roqht+9iRXI8zfkmXi9FCBI0QYf4E83Usn0G6hO/d
         zu5FkfnhmbS+6mjGkAG92V1oCjiqJWI/4CjASH/s=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Tue, 18 Apr 2023 18:43:24 +0200
Subject: [PATCH v2 8/8] Documentation: leds: Add "rgb:status" path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230414-pmi632-v2-8-98bafa909c36@z3ntu.xyz>
References: <20230414-pmi632-v2-0-98bafa909c36@z3ntu.xyz>
In-Reply-To: <20230414-pmi632-v2-0-98bafa909c36@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=728; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=vIuKvsLduKbdJuLqS3gE6yL7XCUiBq1e88KkTbfWTJA=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkPsi9m5afxit5T1vzibsBn+zy17heWoOlFzh0L
 dsKpRleV7eJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZD7IvQAKCRBy2EO4nU3X
 Vr2qD/9mYq9OTIzbUKwzqEA/BbJJX5bd0Oe7VKDxIfeNJ40qCYV//lXBjQIJamulELHCBuS0HtO
 jHDFmjksMA3gg1I+A7QmpTLn9TQY5AdnR5Oo+1XRd5O6135LfzAe/AGUaNdTOnzFK/opBAjyXH8
 EY3tBL3M9Rb1nHaa/i4AGL0Md1iEaUs58Z5euTzf1Rp4XNy/VcOtoNRkSKOvDz+JGKn4RSVT/rh
 2PkgVswxeQVsp5jLe/hha1BdKdsuzn13RwkRt8i8IjIFCVdtNODlo2dVc+KqafCIWBBf1QsW0dP
 gPtDlMVAdUX9KFUy8HbIkFxqwMHspc+fRtbg5G1Oxlo1cx/qCjiraYXLw2E8NSznd41ICyglBYa
 S8rRRLIQyys/1IgsF8o8qNtB/5BcZV4TVCNo5DjMkXSuDNZ/QfyDIcI5W8Lh5HMSn3wrBDPsfAE
 1dz3tS8V5pgXgXiq0t0x7ZFMAqZUKXWLqZt/uGAnORnSDRzhzciiCm6QYqLq+AbKy7bxVhagyBu
 /Mt4FH78hED1WjSTe2tbCQRSeQ5fUqJB2pWhbC6uenH6PaI6XMMib/ev5cLVaR+cZPskqYBQRc8
 e5wpPamgx7kwA3bP+NJ6Uw82+dC00rCSXhMB0nGzCSeNgc4FNKE3Us4DFdMdQjErFr6C8zj9+WD
 tn5NejdQLbgjE1w==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The path /sys/class/leds/rgb:status is already widely used with the
qcom-lpg driver and others. Document it.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/leds/well-known-leds.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/leds/well-known-leds.txt b/Documentation/leds/well-known-leds.txt
index 2160382c86be..439d4dac4472 100644
--- a/Documentation/leds/well-known-leds.txt
+++ b/Documentation/leds/well-known-leds.txt
@@ -58,6 +58,7 @@ LEDs on notebook body, indicating that sound input / output is muted.
 
 * System notification
 
+Good: "rgb:status"
 Legacy: "status-led:{red,green,blue}" (Motorola Droid 4)
 Legacy: "lp5523:{r,g,b}" (Nokia N900)
 

-- 
2.40.0

