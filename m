Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46F66CA850
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjC0O4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbjC0O4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:56:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8046F30F8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:56:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C8096130A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802D1C433EF;
        Mon, 27 Mar 2023 14:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679928980;
        bh=2QDriybfok28zgEIOBPq16NBqwdvGyH821rDD9mIx0M=;
        h=From:To:Cc:Subject:Date:From;
        b=brFZTdzbRCEJKhn/gixnOI7R3/N5P9HVm/0P4E4JsRnzL4oyI4qiXPv2EJ2oH6O2k
         xB4+Dl/nsUWxx/F1iujnEROwvQxsY8sLMrSqjtUtv94z05xfhU7nhJ5d0kQiFuK5py
         18eGd8iJ8GH4eGv1C3qtCsG9kq0SqWnzaPWiFwzKfEmKpWVsFt5tAkmdDdaWA2hsTo
         GH6MfXbJakVM86+TGz3xeHrYjW6ckFq8Hz84yMfDP74lPvlJ98VMs1bGhd32Ra692D
         nXn+kMdPYq1nErt8ITK/GWk4hzrVctwoBOMmyD4r+1831iFEJfumCWj/3W+4bqTpxi
         Znsy0YiPL4uKA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pgoGr-000537-AR; Mon, 27 Mar 2023 16:56:30 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] ASoC: qcom: audioreach: drop stray 'get' from error message
Date:   Mon, 27 Mar 2023 16:55:55 +0200
Message-Id: <20230327145555.19351-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the stray 'get', which appears to be a copy-paste error, from the
registration-failure error message.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/qcom/qdsp6/q6apm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 994c9e823a88..a7a3f973eb6d 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -676,7 +676,7 @@ static int apm_probe(gpr_device_t *gdev)
 
 	ret = devm_snd_soc_register_component(dev, &q6apm_audio_component, NULL, 0);
 	if (ret < 0) {
-		dev_err(dev, "failed to get register q6apm: %d\n", ret);
+		dev_err(dev, "failed to register q6apm: %d\n", ret);
 		return ret;
 	}
 
-- 
2.39.2

