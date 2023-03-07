Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0413A6AE36E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjCGOzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjCGOxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:53:49 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1929D85B09;
        Tue,  7 Mar 2023 06:40:09 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id j11so33625011edq.4;
        Tue, 07 Mar 2023 06:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678200007;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aLkpv4U5DhFbtYC//DvzfcWe8VxYBijR8fygzDt2UGg=;
        b=hKoNrQWKIih4A+q4lz3qoPkyojL0ehPDImCCAd9DdANLHtIazLNJDI251XRrTQxg2V
         f8eKVOS5Olg9orer/yzXY35GuGMBe+Q5PyqQvzwXvcu+13I7coEcMcSpo6kdoWZmLHi1
         4Q3EbQ2iKPHcTIj2wCzX3BqitclkBxjiiEA+vmNe+tR1L4sXPS29PLut64jJqMHrB721
         FeCmIj/zCZj01O3dwqZuflxXdPOZdFI2E1qcCwfahx5M7mD+vntTTknn0vU6ZeT4M1IL
         ghjIIowDLmL66hHf5vNlCpe41fT1pfBQwkkPNrTm8VHAgih9eVG9r1iWsSnpaEKzx6tw
         KkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678200007;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aLkpv4U5DhFbtYC//DvzfcWe8VxYBijR8fygzDt2UGg=;
        b=LLjmLIY8ghO6pBPIigbVR2xlIHE4slijgOUklrS01+SCXvh67S5EeBJWSSIGm3HroI
         PX6Qoo+GNYBNRy4oWtQXK8vOVFwfS8Nqym+7A3EbvSw0mU1Lgbss0lHoEvJJFPcwntqZ
         lYyaaWg9txnWOuQC/dneHnEIenM2eMOo7tnibGJoCsBv9C32Csxk7WraMILrvOzlxkoH
         nhVofOQ77Lw6ujlZgfaFsAQ9MSyXv6u27Eb+tWFSstTenWOIxwfp4eh97ZwkbQ8Ylov2
         xU5DxboNCGhr16IiH0t+08NXrdMDWEPWcW2kGAvxB4fUgPj7yWi5CM6RsXYS1L8o71MZ
         sp9Q==
X-Gm-Message-State: AO0yUKXC0Xbl4VWdDsCL9Eic8Lkb9vCLAZoyuYHLsxxSFDKex0E18eBX
        KJfty6dTV9PfjlrzzVjbNy7KEJiRRAAmhg==
X-Google-Smtp-Source: AK7set+r6GNbOufIZrXcASDSVRzmg2W+LK1GnEiNDF/zvw5eEYcGpNe9HVFT1WzhKl9H9+Izg/JkfA==
X-Received: by 2002:aa7:c0cd:0:b0:4ad:5276:8ea4 with SMTP id j13-20020aa7c0cd000000b004ad52768ea4mr15284146edp.20.1678200007181;
        Tue, 07 Mar 2023 06:40:07 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:a517:a52e:cdbc:e30d])
        by smtp.gmail.com with ESMTPSA id pv16-20020a170907209000b009079442dd11sm6183861ejb.154.2023.03.07.06.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 06:40:07 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        device@lanana.org, unicode@lanana.org,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 1/2] MAINTAINERS: remove historic section DEVICE NUMBER REGISTRY
Date:   Tue,  7 Mar 2023 15:39:59 +0100
Message-Id: <20230307144000.29539-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230307144000.29539-1-lukas.bulwahn@gmail.com>
References: <20230307144000.29539-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in Documentation/admin-guide/devices.rst, the device number
registry (or linux device list) is at Documentation/admin-guide/devices.txt
and no longer maintained at lanana.org.

The devices.txt file is basically community-maintained, and there is no
other dedicated maintainer or contact for that file nowadays.

Remove the historic section DEVICE NUMBER REGISTRY in MAINTAINERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Note: According to the get_maintainer script, Jonathan Corbet would be the
maintainer of those files, but probably everyone knows that the formal
role is really among various kernel developers, and not with Jon as
a benevolent dictator.

Jon, if that is fine for you, we just keep that with MAINTAINERS as-is.
Otherwise, I can send a specific change to exclude those two files,
Documentation/admin-guide/devices.{rst|txt} from the DOCUMENTATION
section in MAINTAINERS, but I do not see that critical, as only very little
changes happen to those files nowadays.


 MAINTAINERS | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 631fac6ab555..5d8f46f35aa4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5940,11 +5940,6 @@ F:	drivers/devfreq/event/
 F:	include/dt-bindings/pmu/exynos_ppmu.h
 F:	include/linux/devfreq-event.h
 
-DEVICE NUMBER REGISTRY
-M:	Torben Mathiasen <device@lanana.org>
-S:	Maintained
-W:	http://lanana.org/docs/device-list/index.html
-
 DEVICE RESOURCE MANAGEMENT HELPERS
 M:	Hans de Goede <hdegoede@redhat.com>
 R:	Matti Vaittinen <mazziesaccount@gmail.com>
-- 
2.17.1

