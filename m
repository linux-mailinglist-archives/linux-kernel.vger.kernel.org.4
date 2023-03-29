Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E00A6CED9F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjC2PxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjC2PxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:53:10 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF774C13;
        Wed, 29 Mar 2023 08:52:59 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id o26-20020a4ad49a000000b0053964a84b0fso2496041oos.7;
        Wed, 29 Mar 2023 08:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680105178;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaKQY99G3HY+F9cltbrOFgoelmJMxNBfQJcO0sLBgas=;
        b=PKDFlgAjacJH7C1CRe1m0Q/BWtr57PTdq7iEGG8xwqMX68KjF8kKS/WJo4ITAT0hOU
         aGwliu2FVDDg+3QXHcI8zsZEt2GfM9lB1/QfOa0avByoJ3rv0CEDJqBMHfFfjBQQ2/Sh
         hBFtQjjAvbdmAfr3EULWxF910GnmrDUC8yZhBAonDGKKZRKxV5ypSfpG33RehXWDYgu4
         VXGQttPWOAMFNIWxNfUqQnjPGF+axRf51orBaCy1BJV2UuoITU0e+Ul6/hLRrUw8ty0Z
         Q7y9uisGKVN+n/tzhhNEQ/hQ+sB1TAja2NEpU+FhhEDBKZ2/kTkSdSPWJXBKNzbkWFTW
         QMDQ==
X-Gm-Message-State: AO0yUKWOBvSw1LJ23fQo/U8R814Yem1pVgc1zy/bri661zHx+46plfXX
        ti50etPI3Y+YteUOsnQipQ==
X-Google-Smtp-Source: AK7set/NHlve/5dROzrE0RjwFIfWzeZwZim5jtRZxJnjvVhB2968rp1PLl6KK6w8FucuWDAPMr2x9Q==
X-Received: by 2002:a4a:890d:0:b0:51a:6ea9:5053 with SMTP id f13-20020a4a890d000000b0051a6ea95053mr8240938ooi.9.1680105178376;
        Wed, 29 Mar 2023 08:52:58 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c192-20020a4a4fc9000000b0053b88b03e24sm8091146oob.18.2023.03.29.08.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 08:52:58 -0700 (PDT)
Received: (nullmailer pid 3198071 invoked by uid 1000);
        Wed, 29 Mar 2023 15:52:45 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 29 Mar 2023 10:52:02 -0500
Subject: [PATCH 05/19] of: Drop unnecessary includes in headers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230329-dt-cpu-header-cleanups-v1-5-581e2605fe47@kernel.org>
References: <20230329-dt-cpu-header-cleanups-v1-0-581e2605fe47@kernel.org>
In-Reply-To: <20230329-dt-cpu-header-cleanups-v1-0-581e2605fe47@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Marc Zyngier <maz@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-tegra@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-mips@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop unnecessary includes in DT headers. Some simply aren't needed and
some can be replaced with forward declarations.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 include/linux/of.h          | 5 ++---
 include/linux/of_device.h   | 3 ++-
 include/linux/of_platform.h | 5 +++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index 1f1e847a1c13..96979c67c5fa 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -16,13 +16,10 @@
 #include <linux/errno.h>
 #include <linux/kobject.h>
 #include <linux/mod_devicetable.h>
-#include <linux/topology.h>
-#include <linux/notifier.h>
 #include <linux/property.h>
 #include <linux/list.h>
 
 #include <asm/byteorder.h>
-#include <asm/errno.h>
 
 typedef u32 phandle;
 typedef u32 ihandle;
@@ -1517,6 +1514,8 @@ enum of_reconfig_change {
 	OF_RECONFIG_CHANGE_REMOVE,
 };
 
+struct notifier_block;
+
 #ifdef CONFIG_OF_DYNAMIC
 extern int of_reconfig_notifier_register(struct notifier_block *);
 extern int of_reconfig_notifier_unregister(struct notifier_block *);
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index 910951a22eb4..5cdafe19dc80 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -7,9 +7,10 @@
 #include <linux/of_platform.h> /* temporary until merge */
 
 #include <linux/of.h>
-#include <linux/mod_devicetable.h>
 
 struct device;
+struct of_device_id;
+struct kobj_uevent_env;
 
 #ifdef CONFIG_OF
 extern const struct of_device_id *of_match_device(
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 8ac5cb933dc3..d8045bcfc35e 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -6,12 +6,13 @@
  *			 <benh@kernel.crashing.org>
  */
 
-#include <linux/device.h>
 #include <linux/mod_devicetable.h>
-#include <linux/pm.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 
+struct device;
+struct of_device_id;
+
 /**
  * struct of_dev_auxdata - lookup table entry for device names & platform_data
  * @compatible: compatible value of node to match against node

-- 
2.39.2

