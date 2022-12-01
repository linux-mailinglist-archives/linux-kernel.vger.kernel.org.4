Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE77863F83E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiLATaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiLAT3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:29:49 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D83C82EA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:29:49 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ha10so6647869ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 11:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7p4ZRoKY8KyAbeLZ3D9FFno3zQClogoAoc0aT3MOswk=;
        b=cmKp5+osxcEKb3tLLjX5pcnFM5ol/fAQnZO4HPmZBJJzl0r8kVyCNT/d9/wiRLPgnR
         80vh9xs1IGdIvR61A03RKhTL8jlZ3bQRWCAWgF4C++Etw+u+eFH0dBZo34pp2Prtzccq
         zcsPUfNnHLHl5JDlxhSJenqQtFCU6UVADMotPapVRkIrv+jGSvGyuiJqFIybgavAE5dT
         xA1lxEi/f+1Zb7yEulIgSaPBBLbL57ElIiwUSt0nETKM1WyyZXxUjen8RuYherN6QjYo
         VF7e31ZTseFdg+2zPJgcv83oYFY0etQ4O8ZMa1jQPAMwCOEiSf9e78OT32ZjS8l+NvwG
         o45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7p4ZRoKY8KyAbeLZ3D9FFno3zQClogoAoc0aT3MOswk=;
        b=cvP1zTPAdeur8de1Nd5iY0tLmBZMOserwtVMy0tns2ESP9NEg9oqMTdznZyHpqa+y0
         tv5Yq/wCMH1maGDjz3ptzzzFNh9jOTipZAfrod9+KPpwz63bXuKA5bokRRFNTNOJ2oTm
         pHY4OK8Oz381xFyytili/b75qXvhRuvB/5ojiu1buEKEf7GkVtkKZbjnN/hhk05mVvVt
         AxU1IqRari9LiVfBOKHxPsTn7JLFpgTB/YCBnpZfa97YPXi4vKtNbpkyoW5nMnr2eLFD
         NzWxFEH49Ocjs54MaxI+IU4D7Yi0RUy/uIaKQHaL2iaJgSd7vQzhAYH0YfpHrFxxj5ix
         Xrbw==
X-Gm-Message-State: ANoB5pny/D5YXaB+fLy+1kM60CllST2T9W1TTN6PPiHlLPLMtzEUMgGA
        CctsV7JYqlEBhkIxjL7j0Vcglw==
X-Google-Smtp-Source: AA0mqf6wJMguBRZ+3RDQjOzLIrbL3+wV5RnCVYcQsQFAXhVegf130StesPXX9DTehUn93DFb09aOCA==
X-Received: by 2002:a17:906:c259:b0:7b5:9670:ae0 with SMTP id bl25-20020a170906c25900b007b596700ae0mr42906077ejb.321.1669922987667;
        Thu, 01 Dec 2022 11:29:47 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id i13-20020a17090639cd00b0073022b796a7sm2141380eje.93.2022.12.01.11.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 11:29:47 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v4 5/5] hwmon: (pmbus/core): Notify regulator events
Date:   Thu,  1 Dec 2022 20:29:39 +0100
Message-Id: <20221201192940.1584012-5-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221201192940.1584012-1-Naresh.Solanki@9elements.com>
References: <20221201192940.1584012-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Notify regulator events in PMBus irq handler.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index daf700210c68..dbdf8c8187db 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -3159,6 +3159,11 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
 		if (ret)
 			return ret;
 
+		if (event) {
+			regulator_notifier_call_chain(data->rdevs[i], event, NULL);
+			ret = IRQ_HANDLED;
+		}
+
 		page = rdev_get_id(data->rdevs[i]);
 		mutex_lock(&data->update_lock);
 		status = pmbus_read_status_word(client, page);
-- 
2.37.3

