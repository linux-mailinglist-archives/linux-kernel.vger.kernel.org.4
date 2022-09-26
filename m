Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2865EA86C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbiIZObN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbiIZOaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:30:46 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAEB10BB30;
        Mon, 26 Sep 2022 05:43:19 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso6603992pjm.5;
        Mon, 26 Sep 2022 05:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:from:to:cc:subject:date;
        bh=2AabGUL0Br5YICw1JFuVvftFuTUQ/EAqwxrV1oNwEpg=;
        b=gV0TgiLvVN18Z7oqqL+K30h6ukAQLF3fLgo6VpUwIXswPgKS/dC1zLTpG4w+1dybyP
         5g+EUy4DNPdTupoLPMba/dadlLg6qHQ3JF0WQ0725/3miUrdENZxx8PKQJbMCauPYJHb
         KIyon3s24MK0fciq3al2cC10UM0OcRAEJ3U6Xlzq20V4vQdwOSXzQEd2LEB4dknmScs1
         WPjEZ2PBucah670hSc2FDMcnMWw5/FuZgi6FrBBL+FANhXsegYJO0XrAMsfpWMJNZEYD
         SsiaBhPDC22FGXxc8d2Bcs3GrLfLlEERPVMDfdadu4hOavk0zWe7S/+zZQAEd0z0SJL6
         TwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=2AabGUL0Br5YICw1JFuVvftFuTUQ/EAqwxrV1oNwEpg=;
        b=TCwXgyMegx3xcM7RE6COJ8oPmTu99UIQudCiYG8bytC8LSNtWC+C79F2jVaeynd91b
         uzFSuDbv65HfW9VSZx2SmNc2ahbvPa21wtALlu4LnPz7f4W0lOaSBZK4nVSpT4TZ8uTc
         QpbHc78BHxZAgiAIVjBFrjxhfjhVOheTLImrbnpFlEO1PJplPOsc3CZ8s0qFNvSz2jQG
         5CXD8QgCtnedZJnKHCOke1z+dBejgFLTSO/8wuFw9fs3to0fyNvIgBwrdvCRfs36cnGg
         jhH4zzUzFh5l5wyoF+dMFjnZf6zn4WvWaXLGu/ZOhYGW+5JSPHV+TaSD3AjmWiKrasvW
         QJmw==
X-Gm-Message-State: ACrzQf2c+RgU+s8TQsj7xU8ePWfhb+iqYPnhDG6YrfTOTVnRDHlfhPtS
        w9AB4qLVWjUHkw6rhlNwZXk=
X-Google-Smtp-Source: AMsMyM5RdeRGaIsVQucKXp8iHx60CYMSRbrZ3Y8OAN1jkEZLfeiKEvivTVNUW4YV7JdtqiHMDZMggg==
X-Received: by 2002:a17:903:240b:b0:178:a475:6644 with SMTP id e11-20020a170903240b00b00178a4756644mr22150458plo.96.1664196198668;
        Mon, 26 Sep 2022 05:43:18 -0700 (PDT)
Received: from hcl-ThinkPad-T495 ([2401:4900:1ce2:8789:cdbd:fcea:ad98:effa])
        by smtp.gmail.com with ESMTPSA id g8-20020a170902934800b00177f8f234cesm11021877plp.258.2022.09.26.05.43.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Sep 2022 05:43:17 -0700 (PDT)
Date:   Mon, 26 Sep 2022 18:13:13 +0530
From:   Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: [PATCH v5] ARM: dts: aspeed: Yosemite V2: Enable OCP debug card
Message-ID: <20220926124313.GA8400@hcl-ThinkPad-T495>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added IPMB-13 channel for Debug Card communication.
which improves the readability of the machine and makes
it easier to debug the server and it will display some
pieces of information about the server like "system info",
"Critical sensors" and "critical sel".

---
--- v5- Updated commit message
--- v4- Resolved syntax error
--- v3- Updated the title and commit
--- v2- Updated the title
--- v1- Initial draft
---

Signed-off-by: Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
index 8864e9c312a8..84236df522dc 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
@@ -215,6 +215,17 @@
 	};
 };
 
+&i2c13 {
+	status = "okay";
+	// Debug Card
+	multi-master;
+	ipmb13@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
+};
+
 &pwm_tacho {
 	status = "okay";
 	//FSC
-- 
2.17.1

