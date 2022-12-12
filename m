Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388A564A2EE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 15:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiLLONJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 09:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbiLLONF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 09:13:05 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88A3DF65;
        Mon, 12 Dec 2022 06:13:02 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-144bd860fdbso8536688fac.0;
        Mon, 12 Dec 2022 06:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a9rfKTTYo4jfNFMQT0vPoE9C87G5mdKIDQuVUwzPMq0=;
        b=ZizvXih1N7i56aqVMm60hittl1I2LnJA+l70gFz1+fA/ej68ogfO4oSSJ3KHITwR3/
         D2zI/rlPe3WWJKAQYvqx6xlOaItHcpOKXeS0eRek1yZsxHuRWdF7yikkGqLtd/esZMXe
         eg5gl/XTCVr4MSMLO8H1dlRFHFuFQnHx0GRDzXUaRg9XzZUSC/GU7gpGpdloHDC0NzEU
         wKuwMZDRUtNRAb2Sj95ituBbpqKmLYGwxsiwTPt3Q6Z+kR6QdfpRRh0RyNt8XTrLJLtF
         0VCLnvEqWsoaQmfYLiMccBG8QYapw7cSnEsot0/WRjgAo2O5sMwkUCUAlZ1+31MguCXP
         bvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a9rfKTTYo4jfNFMQT0vPoE9C87G5mdKIDQuVUwzPMq0=;
        b=eho1AUL2dOLy0QPFho2YGCJLJgEYbuWN/6o4pjXT1GM3mP92pIuwmy0ZUk+YtCftFq
         ys9hr7qA2qUjIT5/VrM9LMjjAFWlPKeLBZ7CeZuM2LUfKLL/bjAMcpE9EB8YOUCd4s6e
         JQXnQK71TlqOlAOmASJLqCTZF3EzWP+9qJ5l4XAzXR9DJp5Epc4NEzE7rDrK2Soz46Jv
         IbXGPE40VDhIkissGfTSAQJSRK21FgvieJJfLm+g5QH3TaGZeebDlky+7V1qBUH/i8QM
         5J4ys6l+JYuFfyNN2AHgFzGKFC4zsLNzo7wQxtjcaqlET+ieikY5+s0YqAdxXPa9KDfv
         lPVQ==
X-Gm-Message-State: ANoB5pmoCbCxgRuphxtsdp3++HMqd35yejodvPon0TNjqMB2Z+fiQBpu
        hV7JZa+JJM5f2+6NfmB1tRw=
X-Google-Smtp-Source: AA0mqf565XGm8oqtIG2kadWuBQ6sV79yu7/2q7IiIpCASNBwnlCFJOMILtsqR4jPjV2nAszYV59M9w==
X-Received: by 2002:a05:6871:450c:b0:144:870e:5859 with SMTP id nj12-20020a056871450c00b00144870e5859mr8007379oab.57.1670854381815;
        Mon, 12 Dec 2022 06:13:01 -0800 (PST)
Received: from smeagol.fibertel.com.ar ([201.235.4.68])
        by smtp.gmail.com with ESMTPSA id e14-20020a056870d10e00b00144e18d8525sm4934164oac.25.2022.12.12.06.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 06:13:00 -0800 (PST)
From:   =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
To:     jdelvare@suse.com
Cc:     linux@roeck-us.net, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
Subject: [PATCH] docs: hwmon: Use file modes explicitly
Date:   Mon, 12 Dec 2022 11:12:46 -0300
Message-Id: <20221212141245.52935-1-samsagax@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

As stated in the mainling list[1] and by checkpatch output, the file modes
for is_visible_func should be returned explicitly. Change that in the
documentation to avoid confusion.

[1]https://lore.kernel.org/linux-hwmon/506a6e7f-4566-2dcf-37f3-0f41f4ce983b@roeck-us.net/

Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
---
 Documentation/hwmon/hwmon-kernel-api.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/hwmon/hwmon-kernel-api.rst b/Documentation/hwmon/hwmon-kernel-api.rst
index f3276b3a381a..26cf55303c61 100644
--- a/Documentation/hwmon/hwmon-kernel-api.rst
+++ b/Documentation/hwmon/hwmon-kernel-api.rst
@@ -299,7 +299,7 @@ Parameters:
 
 Return value:
 	The file mode for this attribute. Typically, this will be 0 (the
-	attribute will not be created), S_IRUGO, or 'S_IRUGO | S_IWUSR'.
+	attribute will not be created), 0444, or 0644.
 
 ::
 
-- 
2.38.1

