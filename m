Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E685E9C03
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbiIZI1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbiIZI12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:27:28 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF24371B8;
        Mon, 26 Sep 2022 01:27:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MbbRj5Klgzl7ZR;
        Mon, 26 Sep 2022 16:25:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.102.38])
        by APP4 (Coremail) with SMTP id gCh0CgAHf45oYjFjX1aNBQ--.36343S7;
        Mon, 26 Sep 2022 16:27:22 +0800 (CST)
From:   Wei Yongjun <weiyongjun@huaweicloud.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] gpio: sim: document use case for interrupt controller
Date:   Mon, 26 Sep 2022 08:44:28 +0000
Message-Id: <20220926084428.1792815-4-weiyongjun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926084428.1792815-1-weiyongjun@huaweicloud.com>
References: <20220926084428.1792815-1-weiyongjun@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHf45oYjFjX1aNBQ--.36343S7
X-Coremail-Antispam: 1UD129KBjvJXoW7urWDXrWrZr1rCry7XF1fJFb_yoW8Wr4fpF
        1DKryIqw1kGF17C3yFyF4Sk3sxZw1rGrZ5u3Z2kF4rJFyrtryvq3yjyryrXF18XrWUXay5
        ZrZa9F10kr1qyw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjxU2PEfUUUUU
X-CM-SenderInfo: 5zhl50pqjm3046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Add document for using GPIO sim as interrupt controller.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 Documentation/admin-guide/gpio/gpio-sim.rst | 44 +++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/admin-guide/gpio/gpio-sim.rst b/Documentation/admin-guide/gpio/gpio-sim.rst
index d8a90c81b9ee..7ccb3f80c90e 100644
--- a/Documentation/admin-guide/gpio/gpio-sim.rst
+++ b/Documentation/admin-guide/gpio/gpio-sim.rst
@@ -132,3 +132,47 @@ group there are two attibutes:
     ``value`` - allows to read the current value of the line which may be
                 different from the pull if the line is being driven from
                 user-space
+
+An example device-tree code defining a GPIO simulator as interrupt controller:
+
+.. code-block :: none
+
+    gpio-sim {
+        compatible = "gpio-simulator";
+
+        bank0 {
+            gpio-controller;
+            #gpio-cells = <2>;
+            ngpios = <16>;
+
+            interrupt-controller;
+            #interrupt-cells = <2>;
+
+            line0 {
+                gpio-hog;
+                gpios = <0 1>;
+                input;
+                line-name = "irq-sim";
+            }
+        };
+    };
+
+    spi: spi {
+        compatible = "spi-mockup";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        can0: can@1 {
+            compatible = "microchip,mcp2515";
+            reg = <1>;
+            interrupt-parent = <&bank0>;
+            interrupts = <0 IRQ_TYPE_EDGE_BOTH>;
+        }
+    };
+
+Trigger irq by writing value to pull setting:
+
+.. code-block :: none
+
+    $ echo pull-down > /sys/devices/platform/gpio-sim/gpiochipX/sim_gpio0/pull
+    $ echo pull-up > /sys/devices/platform/gpio-sim/gpiochipX/sim_gpio0/pull
-- 
2.34.1

