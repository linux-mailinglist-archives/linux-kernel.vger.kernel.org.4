Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC1B6C7F80
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjCXOHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjCXOGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:06:38 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82011207E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 07:06:34 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id o12so8334238edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 07:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1679666793;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NSRH/whhkHasG61CV9A5MEslEc9VQHATlvFYwxjFGj8=;
        b=5mNGte52FnpY3FXONGnlJ78wo0d7WWnd3PiT/98GxWyuU6hahwLQOypkA1gcdxBvc1
         XVboBPlBnu1JdD/nMAw7FK6LsvhxhRrf3ZlRybwCLyBEVh+wwGQ6lna1yHdiVbJRikVk
         9GDqw0Cu2le/0yYwhIjYsIJ7dIrXXZyoVQotRhYamq9wFEPq2rXoYYD3T2IVUDb0IP6z
         1dVkmLlbRrZ4iCm4uyvIXTJtuli2Au3UrrXuU959V9+1wctRukkogPE38otZ0MINqNMQ
         xIhnDDm9A994HmlVasqfqRpp77HPs16+9xkz0FIqD1wwE8msZNN9xV/tBoaNWlY9Pize
         /bJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679666793;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NSRH/whhkHasG61CV9A5MEslEc9VQHATlvFYwxjFGj8=;
        b=p4wh/CST7wlNqTRRFIbODpipqscvLEr/8P0dZHtb4lFrlaLzDuuZ71rmCabWFwvFmE
         +8L9K3DUnLJNHkUy47A6OHtruOZsEYs4n6XJQB2hF39o1rmv5EuIiWciWADjSDUSo5KL
         Ejgy4RYm8PgureJdxPqBaB/bSgSGTy3KamXOas8x128ta5PMws8rt5r+tItJ2PhVdTKL
         OGCRexMp4DroiJ/3mMjkueZv5OSL4dNR5LvOPk85wcdHRUnuBI8UQydob1CqRjjohrDP
         du5pyvd39gLgDtTGD8UlX8nv21NW9Fcgnhs9xkUF2byRe95ba4rmq5NVlmcCZQ1ZVS3c
         8VWg==
X-Gm-Message-State: AAQBX9dJI4IM2/UITx0CJW153HcRI7lpkj5pfHLrweNdbd/h0Rm6CGTk
        x78Oh3fPF8+euHzfUlcu1ps7IQ==
X-Google-Smtp-Source: AKy350aSSQNUKP8+F3tSCmiOeC2fY+aNnCrd8kWjimpqxpgdGJmkQx3EO2E13p/C7DmSUvT+MBojvg==
X-Received: by 2002:aa7:dd50:0:b0:4ac:bd84:43d9 with SMTP id o16-20020aa7dd50000000b004acbd8443d9mr2908854edw.2.1679666793317;
        Fri, 24 Mar 2023 07:06:33 -0700 (PDT)
Received: from [192.168.0.29] (84-115-214-73.cable.dynamic.surfer.at. [84.115.214.73])
        by smtp.gmail.com with ESMTPSA id ch19-20020a170906c2d300b00933d64cd447sm7645192ejb.121.2023.03.24.07.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 07:06:32 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 24 Mar 2023 15:06:24 +0100
Subject: [PATCH] cpufreq: Add SM7225 to cpufreq-dt-platdev blocklist
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230324-sm7225-cpufreq-v1-1-7c2e9a4ab7e3@fairphone.com>
X-B4-Tracking: v=1; b=H4sIAF+uHWQC/x2Nyw6DIBAAf8XsuWtwQWv6K6YHoEvdg5RCnzH+e
 7HHSWYyKxTOwgVOzQqZX1LkFit0hwb8bOOVUS6VgRRppclgWY5EPfr0DJnvqMiNqqdh7IyGGjl
 bGF220c97FpLBoaX2i29J+PBpod1KmYN8/tvpvG0/xbJACIYAAAA=
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm SM7225 platform uses the qcom-cpufreq-hw driver, so add
it to the cpufreq-dt-platdev driver's blocklist.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 5ac6b9e5270e..452181434735 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -152,6 +152,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "qcom,sm6115", },
 	{ .compatible = "qcom,sm6350", },
 	{ .compatible = "qcom,sm6375", },
+	{ .compatible = "qcom,sm7225", },
 	{ .compatible = "qcom,sm8150", },
 	{ .compatible = "qcom,sm8250", },
 	{ .compatible = "qcom,sm8350", },

---
base-commit: e5dbf24e8b9e6aa0a185d86ce46a7a9c79ebb40f
change-id: 20230324-sm7225-cpufreq-02b805268143

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

