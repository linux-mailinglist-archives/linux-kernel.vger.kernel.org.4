Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C520692D7F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 04:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjBKDHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 22:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBKDG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 22:06:59 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E320D301BC;
        Fri, 10 Feb 2023 19:06:56 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id j9so4905989qvt.0;
        Fri, 10 Feb 2023 19:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2TDBKZBTZbMMfOeZNMhoUJ0z+JUybx5iBV75f0j4k6w=;
        b=my9udRAu7tl5AKlQTTKUpXKYFYyDxf6i0zL73CHjD+FBgCWUT6iPzXaoexuVd0VYbk
         VzwqR3Ko6LQ3ubMKUATiCwN1VpxV5+h43QvYLcSixtmItSaSgbof31a6tKpU8LjFs/Qu
         iQHNzwIO6JmNtHz+46Ydvy5IIwM5/jXMWO2jQfI6nOmrniRA25FApW+oczAUrY33WowX
         x2/FygFMPx5eBGGdgbA130uZ+6M8sf2CFfaD0Rp3hz3EPdG33IMDKXCtCAc+9btWPQlN
         SIEMVWSzMyGrT8UCbp8B2h3w/pvJxro9itX1jKCMvBIHLM0AXXsHILyIYsK/Zt0n02J4
         lHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2TDBKZBTZbMMfOeZNMhoUJ0z+JUybx5iBV75f0j4k6w=;
        b=wDyCWVOXCC3LoWHFhoP7IQGsppV8JfOrKv1TRsBd18WWmwHmCnS7CnZTcuOBvg+8op
         9rPgg0m/JU5hPaxqo3T/m45CvBAyJ9XOkESM/Itv8wfjRyqC13Tf4rr161aNTdeSZ8wf
         Qhs2jT9lr9AnDEElfdaTluQh8kqnJV5WbOLCpluEOMbH8TJx99edy2kz3nHHezvEUh2+
         a+uqmHdG6J6DIUdd9b+hwj0UFPzkuYCLWSAQTidZNGcUDqbkXWTu2bAM2GyAtAFE0Ev2
         oMWI0BJexprDJiI2ZheDReJv7cOe9w0FhIvxsllwdj3OY/V1InqNLre6+p0iRam3+E78
         PiXQ==
X-Gm-Message-State: AO0yUKV2cZa1zSJVnaa1W4G6EjEI73rbNUtjtp8fwPXgVESD6yglT9J3
        jcbGTo3WW8XPIac9Mq2DlBuc2qvu/Ck=
X-Google-Smtp-Source: AK7set+kgKbpFVSNtNOPmhbT8NjZxv0/pYhecNq9UhpKCadjuBsXvflUav52R3KCeDP3s9dkQohzww==
X-Received: by 2002:a05:6214:29e2:b0:56c:22d7:3906 with SMTP id jv2-20020a05621429e200b0056c22d73906mr18322447qvb.25.1676084815727;
        Fri, 10 Feb 2023 19:06:55 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id t73-20020a37464c000000b007186c9e167esm4789186qka.52.2023.02.10.19.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 19:06:54 -0800 (PST)
From:   Trevor Woerner <twoerner@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: gpio.txt: expand gpio-line-names recommendations
Date:   Fri, 10 Feb 2023 22:06:45 -0500
Message-Id: <20230211030646.24549-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.17.g4027e30c53
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide more guidance to differentiate between recommendations for names of
lines which are hard-wired to on-board devices, versus recommendations for
names of lines which are connected to general-purpose pin headers.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 .../devicetree/bindings/gpio/gpio.txt         | 41 +++++++++++++------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio.txt b/Documentation/devicetree/bindings/gpio/gpio.txt
index 5663e71b751f..d82c32217fff 100644
--- a/Documentation/devicetree/bindings/gpio/gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio.txt
@@ -154,18 +154,35 @@ of the GPIOs that can't be used.
 
 Optionally, a GPIO controller may have a "gpio-line-names" property. This is
 an array of strings defining the names of the GPIO lines going out of the
-GPIO controller. This name should be the most meaningful producer name
-for the system, such as a rail name indicating the usage. Package names
-such as pin name are discouraged: such lines have opaque names (since they
-are by definition generic purpose) and such names are usually not very
-helpful. For example "MMC-CD", "Red LED Vdd" and "ethernet reset" are
-reasonable line names as they describe what the line is used for. "GPIO0"
-is not a good name to give to a GPIO line. Placeholders are discouraged:
-rather use the "" (blank string) if the use of the GPIO line is undefined
-in your design. The names are assigned starting from line offset 0 from
-left to right from the passed array. An incomplete array (where the number
-of passed named are less than ngpios) will still be used up until the last
-provided valid line index.
+GPIO controller.
+
+For lines which are routed to on-board devices, this name should be
+the most meaningful producer name for the system, such as a rail name
+indicating the usage. Package names, such as a pin name, are discouraged:
+such lines have opaque names (since they are by definition general-purpose)
+and such names are usually not very helpful. For example "MMC-CD", "Red LED
+Vdd" and "ethernet reset" are reasonable line names as they describe what
+the line is used for. "GPIO0" is not a good name to give to a GPIO line
+that is hard-wired to a specific device.
+
+However, in the case of lines that are routed to a general purpose header
+(e.g. the Raspberry Pi 40-pin header), and therefore are not hard-wired to
+specific devices, using a pin number or the names on the header is fine
+provided these are real (preferably unique) names. Using an SoC's pad name
+or package name, or names made up from kernel-internal software constructs,
+are strongly discouraged. For example "pin8 [gpio14/uart0_txd]" is fine
+if the board's documentation labels pin 8 as such. However "PortB_24" (an
+example of a name from an SoC's reference manual) would not be desirable.
+
+In either case placeholders are discouraged: rather use the "" (blank
+string) if the use of the GPIO line is undefined in your design. Ideally,
+try to add comments to the dts file describing the naming the convention
+you have chosen, and specifying from where the names are derived.
+
+The names are assigned starting from line offset 0, from left to right,
+from the passed array. An incomplete array (where the number of passed
+names is less than ngpios) will be used up until the last provided valid
+line index.
 
 Example:
 
-- 
2.36.0.rc2.17.g4027e30c53

