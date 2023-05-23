Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0590870E6B6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238564AbjEWUlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238523AbjEWUlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:41:45 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF22BB;
        Tue, 23 May 2023 13:41:44 -0700 (PDT)
Received: from [192.168.122.1] (84-115-214-73.cable.dynamic.surfer.at [84.115.214.73])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id D1B0ACFBBD;
        Tue, 23 May 2023 20:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1684874502; bh=giXrBVzuUN5UXjtoXlCOzbSist2F7n3Yj2uo5JvGp+4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=UN9gyzpp2uIHzA5h6eRrMwn7Nko9BO3Y+tD2JujsIvH/1rPzIRAp+gV1zpgWdmQTi
         tQeEyjD6m7QIRDQ8l+YRozY+5lprp0YSoG2PPepqnh2nG8F9dNcivStZ2CIroARg8H
         Av1bIY7Q9x4SREkm3qs5QPs8eQGRWqbs6q4ZSjuM=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Tue, 23 May 2023 22:41:30 +0200
Subject: [PATCH v3 3/3] Documentation: leds: Add "rgb:status" path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230414-pmi632-v3-3-079d2cada699@z3ntu.xyz>
References: <20230414-pmi632-v3-0-079d2cada699@z3ntu.xyz>
In-Reply-To: <20230414-pmi632-v3-0-079d2cada699@z3ntu.xyz>
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
        Jonathan Corbet <corbet@lwn.net>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=728; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=giXrBVzuUN5UXjtoXlCOzbSist2F7n3Yj2uo5JvGp+4=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkbSUBVFFH0z26jiRmoUzAK7tvmUyNshtKdDPIi
 M5BNeQdU9+JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZG0lAQAKCRBy2EO4nU3X
 VnrVD/9XFPcG2lQPkn6K14Fu1Wa6cjR5XeJSk33Njgomt8vMe4xTwRE2/HN2CHXn4zrGeMZDk54
 F8y8GWcY2sV/oE8m6dpJNReJbS+QjW4MP+mPgr1FdaPrmzMa3GmEmfwylJAfKTlOjdG2Qd2uhUi
 oqG/FD57rT3U7DeAizDCJt4qiunIh4+zA+x3zdrjZ2gngRGLe1YMcOyW9vjojULNlwCGJJntoqK
 iwbzsn6IfVXqQ+9sDcqMNH6XJDLRsToFx+tfRWT5TYOvqnFk1dUOGUXE/HKhP1t1D6ojYkb3+kx
 viz0rlHPK8YThGeKaVE5EwNTvVY+vcE0bxSLeDcBmjzTxOy1PFxFoIW0EkOR/zvEIE96tN2xj96
 voUuj5vkQvdEc6lIqQi5N9sRfMnCNyjdkwORBvIOj+vbIIg4l/z29wIIE6bAwBBW0WN4AYj/ZZO
 YlbIiqvQv5iHBrWmtDHzOKXP2KQcuW12PrS/4j2aATVmroV8Ri5YVu87ih9Rvh3fJ4Xk9JqYAi4
 j0ggJVW8H9lFn2VdaKPlYIuQ5R/nzFidgkO0IvvIC5bMstQbBvvQcDQX2udJ7RQL9OW0gbX5hO7
 YpuZfc22vXkoiZ/ZUdxQvxv9Sgc3+kuk/VvncDQ3tEMSn0QtozQ1obmDObIm6gTOcZgxkiBL3lv
 09xCJhywpLHGr5Q==
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
index e9c30dc75884..bfbb5892154d 100644
--- a/Documentation/leds/well-known-leds.txt
+++ b/Documentation/leds/well-known-leds.txt
@@ -58,6 +58,7 @@ LEDs on notebook body, indicating that sound input / output is muted.
 
 * System notification
 
+Good: "rgb:status"
 Legacy: "status-led:{red,green,blue}" (Motorola Droid 4)
 Legacy: "lp5523:{r,g,b}" (Nokia N900)
 

-- 
2.40.1

