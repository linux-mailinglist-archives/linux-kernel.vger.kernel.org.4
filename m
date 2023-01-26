Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5448D67D09C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjAZPtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjAZPtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:49:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C127DAA;
        Thu, 26 Jan 2023 07:49:21 -0800 (PST)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9FB3B66018E4;
        Thu, 26 Jan 2023 15:49:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674748160;
        bh=g+Oj2+JQl5wV7jLxmGEkz6OGP2VZYC0NvlMxCkm94xI=;
        h=From:To:Cc:Subject:Date:From;
        b=asNQ0b0J1MLwPOIKDgPcba2oKj8VPzWFySGYMeZFS8KXv81NvKSKdOlAwDaweFTjk
         vf1rDfJwrlGAFnT5Ris2KvNGn6aVkWQg4bup5voNDOm3yh4UC8RtpEIwc4VRhuXSOV
         w0piSrktqdluSHKbi/buQUzpzrWpO82PqNTZ81sNMfJ4fdSRSNid1YmbYyw/EfOoz2
         JyfKeOXknVh7QF7/V42/sgDiPg1MBlLJA2LutnNMz9qpHdwMa2vDfvC+QQJyG5d6xR
         bxH3pFa3mV7WIy6dtQrE0UeoFn0ocCPA/w7JWVcLHzZdo0+qjpvgoxo/Yb3z5nmiI1
         8S0GFoynrGqpA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH] cpufreq: mediatek-hw: Register to module device table
Date:   Thu, 26 Jan 2023 10:48:56 -0500
Message-Id: <20230126154856.1322193-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register the compatibles for this module on the module device table so
it can be automatically loaded when a matching device is found on the
system.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 drivers/cpufreq/mediatek-cpufreq-hw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index f80339779084..115b0eda38c1 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -324,6 +324,7 @@ static const struct of_device_id mtk_cpufreq_hw_match[] = {
 	{ .compatible = "mediatek,cpufreq-hw", .data = &cpufreq_mtk_offsets },
 	{}
 };
+MODULE_DEVICE_TABLE(of, mtk_cpufreq_hw_match);
 
 static struct platform_driver mtk_cpufreq_hw_driver = {
 	.probe = mtk_cpufreq_hw_driver_probe,
-- 
2.39.0

