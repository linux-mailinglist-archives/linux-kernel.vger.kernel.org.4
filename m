Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DF15F1BF7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 13:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiJALVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 07:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiJALVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 07:21:13 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3517CAA7;
        Sat,  1 Oct 2022 04:21:12 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id m3so8955126eda.12;
        Sat, 01 Oct 2022 04:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=TGofqtFHVCa6aXdr7dG+Ot3YJoKyUXFJfoosPaUFSd0=;
        b=KGmVIWxbnSV8akxMcyUnZxK64cPPh1g5C9vC9i4U7M9QHKjJ8GxEhvkeWjMgprg1ay
         W9gVi3GNiwAyTH7L1fMh7BDNRGQKYgMvP3bj9rDPOmavETUgM8fH48+KvHcv1P1N52s0
         3kMJlzNI6OARUQg+kLRjn3hjZS8AXHRGEANM/3sfChe7LEAbZ+kIgHj9zlsuTpE0X4Lg
         7Z+hwLfwnGi+q5HhUL1yC8J6kPtMCv5vfKrkRt/6tKQkPVfNInhQAQ6L8BOVoS5sJ+rQ
         qaiSVOuZT1L20rbOuyoSwknUKFDphqZxr3LNtkfjfSQYaY8+H0nzaP3NlX2leYTgbGjc
         7r4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=TGofqtFHVCa6aXdr7dG+Ot3YJoKyUXFJfoosPaUFSd0=;
        b=R8OdlKhlD8yF52Ta2of2fMzGsGOLj6vvo4/OPK46DDga9Di+5Advl50LhO1F1A0aXM
         NiS8bDPqRL5g/U6hw4ceUbltSi5K/pJdw/4w9zZtIC4niFy1cZZSglPqcPqn4LDb05TA
         lE3LIxJvFhIgBwnv3SCV4zzphgC9VgDmH8iKTFnodyYKaRdP+0LbPjwr7XqoT+7O9LJa
         T3QAlRc2YD0V2Z92TEhbumeadX0Rkad0X/mJcULJn5EYtllIIs/7r6Y8BVl3avIP6iB5
         /TygubKrTg4hYShMHWabCmpBwC8/vL8GuKxvfxJDUfRGAl+FShKyAUP/DwaINsIbsMH1
         8gcQ==
X-Gm-Message-State: ACrzQf114GBPgMyi/byWfv8DvdXV/GX6DQjME/iIW53eQ+0U3ocPJHJ0
        HTMRL5l3LimG56vOjtUC068CMseKb0t/7Q==
X-Google-Smtp-Source: AMsMyM4h+GLYvSMTjLLXqF9h18fSbGY0wD4IAG+sfT+hUiTwF34GO86YyCvZsYSxUjavsmO5OVebqw==
X-Received: by 2002:a05:6402:5406:b0:452:1560:f9d4 with SMTP id ev6-20020a056402540600b004521560f9d4mr11424357edb.333.1664623270862;
        Sat, 01 Oct 2022 04:21:10 -0700 (PDT)
Received: from localhost (252-168-166-62.ftth.glasoperator.nl. [62.166.168.252])
        by smtp.gmail.com with UTF8SMTPSA id kw22-20020a170907771600b0078250005a79sm2527776ejc.163.2022.10.01.04.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 04:21:10 -0700 (PDT)
From:   Jouke Witteveen <j.witteveen@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jouke Witteveen <j.witteveen@gmail.com>
Subject: [PATCH] Documentation: update urls to Linux Foundation wiki
Date:   Sat,  1 Oct 2022 13:20:58 +0200
Message-Id: <20221001112058.22387-1-j.witteveen@gmail.com>
X-Mailer: git-send-email 2.37.3
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

The redirects from the old urls stopped working recently.

Signed-off-by: Jouke Witteveen <j.witteveen@gmail.com>
---
 Documentation/networking/bridge.rst                           | 2 +-
 Documentation/networking/dccp.rst                             | 4 ++--
 .../networking/device_drivers/ethernet/intel/ice.rst          | 2 +-
 Documentation/networking/generic_netlink.rst                  | 2 +-
 MAINTAINERS                                                   | 2 +-
 net/ipv4/Kconfig                                              | 2 +-
 net/sched/Kconfig                                             | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index 4aef9cddde2f..c859f3c1636e 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -8,7 +8,7 @@ In order to use the Ethernet bridging functionality, you'll need the
 userspace tools.
 
 Documentation for Linux bridging is on:
-   http://www.linuxfoundation.org/collaborate/workgroups/networking/bridge
+   https://wiki.linuxfoundation.org/networking/bridge
 
 The bridge-utilities are maintained at:
    git://git.kernel.org/pub/scm/linux/kernel/git/shemminger/bridge-utils.git
diff --git a/Documentation/networking/dccp.rst b/Documentation/networking/dccp.rst
index 91e5c33ba3ff..cd661509d35d 100644
--- a/Documentation/networking/dccp.rst
+++ b/Documentation/networking/dccp.rst
@@ -41,11 +41,11 @@ specified in RFCs 4340...42.
 
 The known bugs are at:
 
-	http://www.linuxfoundation.org/collaborate/workgroups/networking/todo#DCCP
+	https://wiki.linuxfoundation.org/networking/todo#dccp
 
 For more up-to-date versions of the DCCP implementation, please consider using
 the experimental DCCP test tree; instructions for checking this out are on:
-http://www.linuxfoundation.org/collaborate/workgroups/networking/dccp_testing#Experimental_DCCP_source_tree
+https://wiki.linuxfoundation.org/networking/dccp_testing#experimental_dccp_source_tree
 
 
 Socket options
diff --git a/Documentation/networking/device_drivers/ethernet/intel/ice.rst b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
index dc2e60ced927..b481b81f3be5 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/ice.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
@@ -819,7 +819,7 @@ NAPI
 ----
 This driver supports NAPI (Rx polling mode).
 For more information on NAPI, see
-https://www.linuxfoundation.org/collaborate/workgroups/networking/napi
+https://wiki.linuxfoundation.org/networking/napi
 
 
 MACVLAN
diff --git a/Documentation/networking/generic_netlink.rst b/Documentation/networking/generic_netlink.rst
index 59e04ccf80c1..d960dbd7e80e 100644
--- a/Documentation/networking/generic_netlink.rst
+++ b/Documentation/networking/generic_netlink.rst
@@ -6,4 +6,4 @@ Generic Netlink
 
 A wiki document on how to use Generic Netlink can be found here:
 
- * http://www.linuxfoundation.org/collaborate/workgroups/networking/generic_netlink_howto
+ * https://wiki.linuxfoundation.org/networking/generic_netlink_howto
diff --git a/MAINTAINERS b/MAINTAINERS
index 17abc6483100..f9eecb2b6a84 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5717,7 +5717,7 @@ F:	drivers/scsi/dc395x.*
 DCCP PROTOCOL
 L:	dccp@vger.kernel.org
 S:	Orphan
-W:	http://www.linuxfoundation.org/collaborate/workgroups/networking/dccp
+W:	https://wiki.linuxfoundation.org/networking/dccp
 F:	include/linux/dccp.h
 F:	include/linux/tfrc.h
 F:	include/uapi/linux/dccp.h
diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index e983bb0c5012..ce458aba140a 100644
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -419,7 +419,7 @@ config INET_DIAG
 	  native Linux tools such as ss. ss is included in iproute2, currently
 	  downloadable at:
 
-	    http://www.linuxfoundation.org/collaborate/workgroups/networking/iproute2
+	    https://wiki.linuxfoundation.org/networking/iproute2
 
 	  If unsure, say Y.
 
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index 1e8ab4749c6c..4b63d3fff3ae 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -26,7 +26,7 @@ menuconfig NET_SCHED
 	  from the package iproute2+tc at
 	  <https://www.kernel.org/pub/linux/utils/net/iproute2/>.  That package
 	  also contains some documentation; for more, check out
-	  <http://www.linuxfoundation.org/collaborate/workgroups/networking/iproute2>.
+	  <https://wiki.linuxfoundation.org/networking/iproute2>.
 
 	  This Quality of Service (QoS) support will enable you to use
 	  Differentiated Services (diffserv) and Resource Reservation Protocol
-- 
2.37.3

