Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A975B9AFD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiIOMjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiIOMiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:38:55 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598DB80487
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 05:38:54 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id ay36so4219757wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 05:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Zia5PwPjvTpWqvNWhun5tKRspbVbRhZxzacUZUNqQiU=;
        b=LEWcsEPgF6HIafqmWf43ZmzIXZJKMJkx93tfpFRNdRGFx73qobC4DXt6nEN9rlpDbU
         UHyOoEkh45rRDUwLn7BNi3wpL/5wRgFPDsiYgeF6wNwlwIBvBmzT/HLv2vceAE8Sh99o
         lxjzgM30++pHNSjAClJJqC9cGr9PEzE3rYXy6DoEp8jA6RoYJES04whqHHjOo7KUpps5
         LfB3IWvVwLLbW8+BR9Pkq7sIYWMDGacrQZipe6vLNLy4B8C4nzSHrMixV9OFbKixqNyT
         RfcVsHR8cCsGEHRIEX1WYRWE/WKKw2txjIQHxOtkJjUlkpJlCygqlVNuKd1LjaFdPC62
         RerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Zia5PwPjvTpWqvNWhun5tKRspbVbRhZxzacUZUNqQiU=;
        b=i/C/8ei9ifXGWqkrtb6QF3iy2Kg0LsFO+r9aXAVVM3hMYllD4GyhvNg5Zhad0h/6Td
         KXKrLbHR1tUFS5IbHeC03hwfc/IN6jmMHDx7B4v7+Jpno1ll8pphs45FpWLk3JF6pjt7
         BpPg4735ms3Fw2e3s4JKbYOpXCK6gaY5J5eemW9wa2fJ6vIntg2Ok5tMZQUlFgMQZx02
         /HvtmpOZFhX8QB4MLwKip43k8l7Yl7UFOsAJTkuufQ3+pittl5bL3n3rng+HtAQPecR5
         OoyCQVOAq560uoP1WOAbHP0XCKcRihvesxWFNJFfgeRF5vO7fH1Rh9aYUxYEZbNZk4AM
         HQog==
X-Gm-Message-State: ACgBeo0uIYUT47giUo+6WgYG2qeS3mClnjn88x5KqBzKWDHx4Uh8ReUZ
        UAF0vZDu0Y8knovNGzMCZrFuJw==
X-Google-Smtp-Source: AA6agR5ND0ehbZKyqmCXUJNn0CM7WfvUwi3EWXaMkwhqaapsS1+QAdUuIyDZgg3MTZCRmLF8cYL6Zg==
X-Received: by 2002:a05:600c:22c7:b0:3b4:92ba:ff99 with SMTP id 7-20020a05600c22c700b003b492baff99mr6939278wmg.190.1663245532832;
        Thu, 15 Sep 2022 05:38:52 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id bg13-20020a05600c3c8d00b003a5f4fccd4asm3112559wmb.35.2022.09.15.05.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:38:52 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, bgoswami@quicinc.com, perex@perex.cz,
        tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/9] ASoC: qdsp6: audioreach: update dapm kcontrol private data
Date:   Thu, 15 Sep 2022 13:38:31 +0100
Message-Id: <20220915123837.11591-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220915123837.11591-1-srinivas.kandagatla@linaro.org>
References: <20220915123837.11591-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update kcontrol private date to include more information like graph id
and module instance id which its connected to. Also maintain this virtual
dapm mixer widget in a list so that we could lookup while FE and BE connection
are added.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6apm.c    |  1 +
 sound/soc/qcom/qdsp6/q6apm.h    |  1 +
 sound/soc/qcom/qdsp6/topology.c | 19 ++++++++++++++++++-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 794019286c70..81e2d7090fb4 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -731,6 +731,7 @@ static int apm_probe(gpr_device_t *gdev)
 	apm->gdev = gdev;
 	init_waitqueue_head(&apm->wait);
 
+	INIT_LIST_HEAD(&apm->widget_list);
 	idr_init(&apm->graph_idr);
 	idr_init(&apm->graph_info_idr);
 	idr_init(&apm->sub_graphs_idr);
diff --git a/sound/soc/qcom/qdsp6/q6apm.h b/sound/soc/qcom/qdsp6/q6apm.h
index 54eadadf712c..96ad5ea2ae07 100644
--- a/sound/soc/qcom/qdsp6/q6apm.h
+++ b/sound/soc/qcom/qdsp6/q6apm.h
@@ -58,6 +58,7 @@ struct q6apm {
 	struct mutex lock;
 	uint32_t state;
 
+	struct list_head widget_list;
 	struct idr graph_idr;
 	struct idr graph_info_idr;
 	struct idr sub_graphs_idr;
diff --git a/sound/soc/qcom/qdsp6/topology.c b/sound/soc/qcom/qdsp6/topology.c
index 9a3d9e0eae53..0c4886d30131 100644
--- a/sound/soc/qcom/qdsp6/topology.c
+++ b/sound/soc/qcom/qdsp6/topology.c
@@ -16,7 +16,11 @@
 #include "audioreach.h"
 
 struct snd_ar_control {
+	u32 graph_id; /* Graph ID */
 	u32 sgid; /* Sub Graph ID */
+	u32 module_instance_id; /* Connected Module Instance ID */
+	struct snd_soc_dapm_widget *w;
+	struct list_head node;
 	struct snd_soc_component *scomp;
 };
 
@@ -692,6 +696,7 @@ static int audioreach_widget_load_mixer(struct snd_soc_component *component,
 	struct snd_soc_tplg_vendor_value_elem *w_elem;
 	struct snd_soc_tplg_vendor_array *w_array;
 	struct snd_ar_control *scontrol;
+	struct q6apm *data = dev_get_drvdata(component->dev);
 	struct snd_soc_dobj *dobj;
 	int tkn_count = 0;
 
@@ -711,6 +716,9 @@ static int audioreach_widget_load_mixer(struct snd_soc_component *component,
 		case AR_TKN_U32_SUB_GRAPH_INSTANCE_ID:
 			scontrol->sgid = le32_to_cpu(w_elem->value);
 			break;
+		case AR_TKN_DAI_INDEX:
+			scontrol->graph_id = le32_to_cpu(w_elem->value);
+			break;
 		default: /* ignore other tokens */
 			break;
 		}
@@ -718,6 +726,9 @@ static int audioreach_widget_load_mixer(struct snd_soc_component *component,
 		w_elem++;
 	}
 
+	scontrol->w = w;
+	list_add_tail(&scontrol->node, &data->widget_list);
+
 	return 0;
 }
 
@@ -819,7 +830,10 @@ static int audioreach_widget_unload(struct snd_soc_component *scomp,
 
 	if (w->id == snd_soc_dapm_mixer) {
 		/* virtual widget */
-		kfree(dobj->private);
+		struct snd_ar_control *scontrol = dobj->private;
+
+		list_del(&scontrol->node);
+		kfree(scontrol);
 		return 0;
 	}
 
@@ -998,6 +1012,9 @@ static int audioreach_control_load_mix(struct snd_soc_component *scomp,
 		case AR_TKN_U32_SUB_GRAPH_INSTANCE_ID:
 			scontrol->sgid = le32_to_cpu(c_elem->value);
 			break;
+		case AR_TKN_DAI_INDEX:
+			scontrol->graph_id = le32_to_cpu(c_elem->value);
+			break;
 		default:
 			/* Ignore other tokens */
 			break;
-- 
2.21.0

