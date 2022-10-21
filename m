Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38FB607CD8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiJUQxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiJUQxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:53:23 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A079628C33C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:53:10 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b4so5956799wrs.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cF5Zvj+Kzci/ADALngKgDuePH0r1ubNxIDC6FLO5nXI=;
        b=TZiNQE3XOaoDBX4SGKjXJnsnREkA/Fg8Z+lZBP851P+khMnJWvm5pwsMg3gW4Nu+kv
         yi/ilKE+4pQpSnPy9Fqi3UUUtvr51QKSuFo69OcDKVQGSoxwDcWdaPiRsz1Tf7rfMpLU
         eSU01OyMfnU2y5Fm3UP+jUqRCP1NJqMOfztW+MqBsJmkihO/bfqs4rQYiflQxt4cZycI
         aZ/rrAe7sX9qLQgXYnJ1LEFNH598L8hifJMiav5DxAfiLEhH1JLlcO8BhWxwxN+eBXz6
         xjhygwwSpq2uGXjZmTrKRdgCY1EZ0ZqhQjjIGWht3MZuYoTiDBR67Y6KRYLC0a+ma8B3
         n9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cF5Zvj+Kzci/ADALngKgDuePH0r1ubNxIDC6FLO5nXI=;
        b=gH9dKD3yrMM7uRRXQTB1dkTqytvVzDouiIvVCNWezrcEMHg8B38iSnCEYOtkbskigH
         PmnthFXFHp4P+R3AjnK4N2eS7Va8iQIJ0i9y/Jzns9GcUMDHzxiTgVtAglBfOE/AkrTM
         ZFlS3PGak9XeBzgOmOJC60dCEfqOAnU33Z3Vgyg/MM5dX/ZgLgrNstYkjh5blo5APAJT
         tGcGsqlKRDkkCNibryDqDHxH9IYWmbEdla9ajCyLqUMQILn1cxRbBTq59qI4RT1Wf2K8
         T9wTiIMQdq3tOtiRFwis0VGyLdI1zbWsNI8NiZpYydmg033o7ao5n9NaB8GNZ9+u7HHG
         OfOw==
X-Gm-Message-State: ACrzQf1nvxsUKtq/lPjdv8VPN+/oF+M9v+AbbQvKwdzW5kRG6a551PZs
        Fzg5tK2iDNyTP09nk4HVHoNCMA==
X-Google-Smtp-Source: AMsMyM7RMk9WjIX1PpFSeoepvlaVRwPBQ71LL5x0bYoQ1ZwIPDc+gwEiUrmdSb4AwWh7mL7wo6Fb0w==
X-Received: by 2002:a05:6000:144c:b0:230:816f:3167 with SMTP id v12-20020a056000144c00b00230816f3167mr12832842wrx.532.1666371185752;
        Fri, 21 Oct 2022 09:53:05 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id n14-20020a5d400e000000b0022ae401e9e0sm19541773wrp.78.2022.10.21.09.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:53:04 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, bgoswami@quicinc.com, perex@perex.cz,
        tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 2/9] ASoC: qdsp6: audioreach: remove unused connection_list
Date:   Fri, 21 Oct 2022 17:52:00 +0100
Message-Id: <20221021165207.13220-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20221021165207.13220-1-srinivas.kandagatla@linaro.org>
References: <20221021165207.13220-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused connection_list parameter.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/audioreach.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
index 3ee8bfcd0121..36779ad1952d 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -595,7 +595,6 @@ struct audioreach_graph_info {
 	int id;
 	uint32_t num_sub_graphs;
 	struct list_head sg_list;
-	struct list_head connection_list;
 };
 
 struct audioreach_sub_graph {
-- 
2.21.0

