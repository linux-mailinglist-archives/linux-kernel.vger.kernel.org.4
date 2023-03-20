Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3335B6C2389
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjCTVXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCTVW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:22:59 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922C2AD39
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:22:58 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h8so52220677ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679347377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lqRaegmbeCf2kbh11GbjLCZS+M4vcbsjfGajJu8diwk=;
        b=KhVSFpFXeulhrdGaxWNRz3NWL6uI9060cya9RKxF6xj9+59whgTzAtpNRXSM5MExAe
         R3CFwHvHNs+3hPz5Ev4g/3ckzc8ovdGdMGNd/49XY+iLw30PzPPDECL1dZf+TrXsmHIz
         Gyuf0LONalf4ge7eXIzz0qpe1ZTzVjM2SwMwDY2VMNNrPmP+mPlC9hO4zceMMFFpjOnO
         V6WLLDPNuh1GKWzPHH4phe3gloEaI/oeO49/HkAiQ4nJMSb1hhO/wqo6EfOO41BgRjIA
         5boPel7mzB1qLYlcJNLWWAVkPqAyb0rgHprVEHogNE5Fi5R6Ct7aWjTdNHHYszLrYfmN
         vucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679347377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lqRaegmbeCf2kbh11GbjLCZS+M4vcbsjfGajJu8diwk=;
        b=lQoL+Zui/vsmD1XErVD0NmQUTtV3Sx+OdHqG6EnrjBoB3xNLSAfYYd1chtzBpDEp8/
         kOFeXyKSm9Vl1xDmkX8jZJAx/L/Ifqm4ViL5a0+ZiYRM8I6goHsBX+tLHmGm2piWgnZV
         jvZuI0rt2jVamWq1yMQoCr2q0TiE143gtcVza/tBqrv8QnJtbqPgxRBW8cbr0dcbtn9x
         RaV3e862s2+S1gm5ijbbdq/FnZLuLyefYB0jPmAjpmECJevb353cUH7/SMmyJABkXegr
         XrTLscGY2eWJChabbvs5jvCCB2VIYKWuIFVzp6D9s7JasNEkUlikh3mix1HXEupJRkp7
         xBQg==
X-Gm-Message-State: AO0yUKVqpRyJtqU062H9FDsGWjOclvyFj6cvZ0JvDQqzTVc6OCjQU3lo
        y9R3DX9pmNK8UAPfwDa+cEE=
X-Google-Smtp-Source: AK7set8T1dbl4BU/G/2eVqCdpbq0D2nos11d4yxMGWJR+Um1h0wZ05P7DWd22lA3C8Co7nznT/kpug==
X-Received: by 2002:a17:906:dfea:b0:930:9cbd:4e88 with SMTP id lc10-20020a170906dfea00b009309cbd4e88mr555049ejc.8.1679347376960;
        Mon, 20 Mar 2023 14:22:56 -0700 (PDT)
Received: from alaa-emad.. ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id hb6-20020a170906b88600b0093120a11a5dsm4924159ejb.92.2023.03.20.14.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 14:22:56 -0700 (PDT)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, parthiban.veerasooran@microchip.com,
        christian.gromm@microchip.com, drv@mailo.com, dave@stgolabs.net,
        yang.lee@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, eng.mennamahmoud.mm@gmail.com,
        Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH v3] staging: most: define iface_to_hdm as an inline function
Date:   Mon, 20 Mar 2023 23:22:39 +0200
Message-Id: <20230320212239.22452-1-eng.mennamahmoud.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Convert `iface_to_hdm` macro into a static inline function.
it is not great to have macro that use `container_of` macro,
because from looking at the definition one cannot tell
what type it applies to.

One can get the same benefit from an efficiency point of view
by making an inline function.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
---
change in v3:
        edit subject line.

change in v2:
	edit subject line.
---
 drivers/staging/most/dim2/dim2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
index b8bd01ca1f11..21d1c9f24c3d 100644
--- a/drivers/staging/most/dim2/dim2.c
+++ b/drivers/staging/most/dim2/dim2.c
@@ -108,7 +108,10 @@ struct dim2_platform_data {
 	u8 fcnt;
 };
 
-#define iface_to_hdm(iface) container_of(iface, struct dim2_hdm, most_iface)
+static inline struct dim2_hdm *iface_to_hdm(struct most_interface *iface)
+{
+	return container_of(iface, struct dim2_hdm, most_iface);
+}
 
 /* Macro to identify a network status message */
 #define PACKET_IS_NET_INFO(p)  \
-- 
2.34.1

