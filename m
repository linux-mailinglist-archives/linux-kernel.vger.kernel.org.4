Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66985B54E4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiILG5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiILG51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:57:27 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D686129836;
        Sun, 11 Sep 2022 23:57:21 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id z187so7688046pfb.12;
        Sun, 11 Sep 2022 23:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=RH/VDeel2O1YnlzpP/dZvddnsVEsPqbgyyssL39vics=;
        b=gOb/2EOHn/DXorTgYSkaeK/VP0b+XX5cx8PHCJXZwWKVQ/UlOotxXM2VVtmKmdcJqr
         01FQqzVaQHC+N0ptiQjT/sTCtY5ZhOua1T3KdBpBc9wqNixcEhVA5FsiUcY64S9vfmvf
         xM/QCRBFfBjzHB0Mf2uVlZLMclOKmqegY6rn6rKWYls9USHG345uJbaVzKjqBVYl8r9r
         OdKDLuP9bxEUY8EWJt8mhgOyVOQtNCG08xImsPvYQ6do50kbpEjdCu9XROp0UycaBVMQ
         Z9mMUqFhOu/lCHxqnOlmftitCXlEcXCCTAUJphXYhB8HNscg+/6QHhJHdfY4yuH1Rf+9
         2CSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=RH/VDeel2O1YnlzpP/dZvddnsVEsPqbgyyssL39vics=;
        b=GdPcGmMz+qOOzrDiG/bZhdhT1Ug+TbNLlIaMc/8fXw3t7hIfuQbc/lFRm0LAcOpUVa
         fNi6nDT5fvqhJ8vtVnbWP343gv+cuzm0UbwAmc7l98pPgm0Ix/XenwhA6Mgo1Ki5Kg+l
         a5roOW0N91M/kob2mm7wDMnsadoNPPT3KgrLGljOdIksOVjbCMOeKqzJhKpRcMnrCtXW
         rjzSMG3Kno5Q4P9b30A6iCq2W3IGXBGh71dKDtthteDxCxPBfXtth37hzZ0UUCyN4ywA
         5LnonRiZ4Mo/6mJrUSR4ngPCZ8rB2tDkTh6KeqaTOrgWIh3ns+x2e5BkOpdpZM4RCUDP
         Fcqg==
X-Gm-Message-State: ACgBeo0MlqLZNALV/WDiZFCCUigS5v4G+4MUhV99Dx5faWyOZYJlZiZt
        gPf7U3uHr2JcB0HeEITLefo=
X-Google-Smtp-Source: AA6agR7KjZMWdwPDH/jae1lbcmTSopZmpnSqprgC0cuM0EYlmKFfX7MGzzvOWi7Gh5tpVwrGcgLpeA==
X-Received: by 2002:a63:5620:0:b0:429:9ad7:b4f2 with SMTP id k32-20020a635620000000b004299ad7b4f2mr21948494pgb.162.1662965840685;
        Sun, 11 Sep 2022 23:57:20 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:7171:597e:5b7:9ff9:1cd5])
        by smtp.gmail.com with ESMTPSA id l12-20020a170903244c00b001743be790b4sm5044611pls.215.2022.09.11.23.57.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Sep 2022 23:57:20 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     mazziesaccount@gmail.com, alina_yu@richtek.com,
        cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v4 3/3] Documentation: power: rt9471: Document exported sysfs entries
Date:   Mon, 12 Sep 2022 14:57:03 +0800
Message-Id: <1662965823-17760-4-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1662965823-17760-1-git-send-email-u0084500@gmail.com>
References: <1662965823-17760-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Document the settings exported by rt9471 charger driver through sysfs entries:
- sysoff_enable
- charge_term_enable
- port_detect_enable

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 Documentation/ABI/testing/sysfs-class-power | 44 +++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index a9ce63c..1f8afe5 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -768,3 +768,47 @@ Description:
 
 		Access: Read
 		Valid values: 1-31
+
+What:		/sys/class/power_supply/rt9471-*/sysoff_enable
+Date:		Sep 2022
+KernelVersion:	6.1
+Contact:	ChiYuan Huang <cy_huang@richtek.com>
+Description:
+		This entry allows enabling the sysoff mode of rt9471 charger devices.
+		If enabled and the input is removed, the internal battery FET is turned
+		off to reduce the leakage from the BAT pin. See device datasheet for details.
+
+		Access: Read, Write
+		Valid values:
+		- 1: enabled
+		- 0: disabled
+
+What:		/sys/class/power_supply/rt9471-*/charge_term_enable
+Date:		Sep 2022
+KernelVersion:	6.1
+Contact:	ChiYuan Huang <cy_huang@richtek.com>
+Description:
+		This entry allows enabling the charge termination function of rt9471 charger
+		devices. If enabled, the battery charging current, and the battery voltage
+		reachs charge termination condition, the internal battery FET will be turned off
+		to optimize the battery life. See device datasheet for details.
+
+		Access: Read, Write
+		Valid values:
+		- 1: enabled
+		- 0: disabled
+
+What:		/sys/class/power_supply/rt9471-*/port_detect_enable
+Date:		Sep 2022
+KernelVersion:	6.1
+Contact:	ChiYuan Huang <cy_huang@richtek.com>
+Description:
+		This entry allows enabling the USB BC12 port detect function of rt9471 charger
+		devices. If enabled and VBUS is inserted, device will start to do the BC12
+		port detect and report the usb port type when port detect is done. See
+		datasheet for details.
+
+		Access: Read, Write
+		Valid values:
+		- 1: enabled
+		- 0: disabled
-- 
2.7.4

