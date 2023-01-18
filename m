Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE2667285D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjARTbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjARTai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:30:38 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7505154B0A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:30:36 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id o5so9678493qtr.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qy72HLragdKKsAlVqQe+Eds7xMX1u8GGBw8aEtaI0ZE=;
        b=ChMcOZkWnhvIoGCvrWgE0kc5X3lFXKoI/3Ml+sCZSQnO1ueslzwK2y9S7t0O+eaqiI
         Wu+33+yqnC7OfKacIwaQEfL7Lhnm53eiMMm/416nfvJbTJJOUUQCI/YgXCLcnTK4rQh4
         Zpd6L48MGkDY4nVsZmfu35kHH571dA5dGNfo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qy72HLragdKKsAlVqQe+Eds7xMX1u8GGBw8aEtaI0ZE=;
        b=oS99F2DLGENPp3priTnoIyq/Wgj8JlxAXmfnyh1oxjfJuq0YBp+fqJj6wGwd6xdRh8
         7EXvWtC//8Yq1gFDQlt6p7vEOdXQWqjgNWa3afyX50o+hH6Z+ICtoMW63qMpT9oSlisn
         SZO81AUlg5v8SYfgCQP8BAjVeC5o/TgCh1M7pcs27qLTncYi23jj6b+1IVarSMOjw8/5
         CRydOL3fylSwamc4zZJNncx2KjkswA5iqw/UrIaKb+FOZ4HAGOeqVUjKS7/NMpi/5XZs
         ZGeIMM8aiYK+SvqanfDh4cHVmtSVUqawYW3TPrbvta3lNSR+rMUuFqNdQ+nH/EsTacad
         w5Xg==
X-Gm-Message-State: AFqh2kql07RvCFTxVYqVDQ/8mVHGTgZDuRdZATdw4Y+OzdjwoNNByks8
        u1ccX1YnunvQTCRhLlAyYhmJtQ==
X-Google-Smtp-Source: AMrXdXu2vrUMP92aOea8CLzCaUWzDsB7wiMKTVTrm03BYSbZZ4QWqxxZxshSk3BE/duePBa1M/wXjQ==
X-Received: by 2002:ac8:6650:0:b0:3b3:9d7f:1489 with SMTP id j16-20020ac86650000000b003b39d7f1489mr11541209qtp.56.1674070235256;
        Wed, 18 Jan 2023 11:30:35 -0800 (PST)
Received: from localhost (29.46.245.35.bc.googleusercontent.com. [35.245.46.29])
        by smtp.gmail.com with UTF8SMTPSA id bl3-20020a05620a1a8300b006fa9d101775sm17366qkb.33.2023.01.18.11.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 11:30:34 -0800 (PST)
From:   Mark Yacoub <markyacoub@chromium.org>
X-Google-Original-From: Mark Yacoub <markyacoub@google.com>
To:     quic_khsieh@quicinc.com, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        markyacoub@chromium.org, tzimmermann@suse.de,
        ville.syrjala@linux.intel.com, stanislav.lisovskiy@intel.com,
        matthew.d.roper@intel.com, imre.deak@intel.com,
        lucas.demarchi@intel.com, manasi.d.navare@intel.com,
        swati2.sharma@intel.com, bhanuprakash.modem@intel.com,
        javierm@redhat.com, jose.souza@intel.com, lyude@redhat.com,
        hbh25y@gmail.com, arun.r.murthy@intel.com,
        ashutosh.dixit@intel.com, ankit.k.nautiyal@intel.com,
        maxime@cerno.tech, swboyd@chromium.org,
        christophe.jaillet@wanadoo.fr, quic_sbillaka@quicinc.com,
        johan+linaro@kernel.org, dianders@chromium.org, marex@denx.de,
        quic_jesszhan@quicinc.com, bjorn.andersson@linaro.org,
        abhinavk@codeaurora.org, seanpaul@chromium.org,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v6 03/10] drm/hdcp: Update property value on content type and user changes
Date:   Wed, 18 Jan 2023 19:30:08 +0000
Message-Id: <20230118193015.911074-4-markyacoub@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
In-Reply-To: <20230118193015.911074-1-markyacoub@google.com>
References: <20230118193015.911074-1-markyacoub@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

This patch updates the connector's property value in 2 cases which were
previously missed:

1- Content type changes. The value should revert back to DESIRED from
   ENABLED in case the driver must re-authenticate the link due to the
   new content type.

2- Userspace sets value to DESIRED while ENABLED. In this case, the
   value should be reset immediately to ENABLED since the link is
   actively being encrypted.

To accommodate these changes, I've split up the conditionals to make
things a bit more clear (as much as one can with this mess of state).

Acked-by: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Reviewed-by: Abhinav Kumar <abhinavk@codeaurora.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20210913175747.47456-4-sean@poorly.run #v1
Link: https://patchwork.freedesktop.org/patch/msgid/20210915203834.1439-4-sean@poorly.run #v2
Link: https://patchwork.freedesktop.org/patch/msgid/20211001151145.55916-4-sean@poorly.run #v3
Link: https://patchwork.freedesktop.org/patch/msgid/20211105030434.2828845-4-sean@poorly.run #v4
Link: https://patchwork.freedesktop.org/patch/msgid/20220411204741.1074308-4-sean@poorly.run

Changes in v2:
-None
Changes in v3:
-Fixed indentation issue identified by 0-day
Changes in v4:
-None
Changes in v5:
-None
Changes in v6:
-Rebased: modifications in drm_hdcp_helper.c instead of drm_hdcp.c

---
 drivers/gpu/drm/display/drm_hdcp_helper.c | 29 +++++++++++++++--------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdcp_helper.c b/drivers/gpu/drm/display/drm_hdcp_helper.c
index a3896b0904b5..ce92f1cac251 100644
--- a/drivers/gpu/drm/display/drm_hdcp_helper.c
+++ b/drivers/gpu/drm/display/drm_hdcp_helper.c
@@ -485,21 +485,30 @@ bool drm_hdcp_atomic_check(struct drm_connector *connector,
 		return true;
 
 	/*
-	 * Nothing to do if content type is unchanged and one of:
-	 *  - state didn't change
-	 *  - HDCP was activated since the last commit
-	 *  - attempting to set to desired while already enabled
+	 * Content type changes require an HDCP disable/enable cycle.
 	 */
-	if (old_hdcp == new_hdcp ||
-	    (old_hdcp == DRM_MODE_CONTENT_PROTECTION_DESIRED &&
+	if (new_conn_state->hdcp_content_type !=
+	    old_conn_state->hdcp_content_type) {
+		new_conn_state->content_protection =
+			DRM_MODE_CONTENT_PROTECTION_DESIRED;
+		return true;
+	}
+
+	/*
+	 * Ignore meaningless state changes:
+ 	 *  - HDCP was activated since the last commit
+	 *  - Attempting to set to desired while already enabled
+ 	 */
+	if ((old_hdcp == DRM_MODE_CONTENT_PROTECTION_DESIRED &&
 	     new_hdcp == DRM_MODE_CONTENT_PROTECTION_ENABLED) ||
 	    (old_hdcp == DRM_MODE_CONTENT_PROTECTION_ENABLED &&
 	     new_hdcp == DRM_MODE_CONTENT_PROTECTION_DESIRED)) {
-		if (old_conn_state->hdcp_content_type ==
-		    new_conn_state->hdcp_content_type)
-			return false;
+		new_conn_state->content_protection =
+			DRM_MODE_CONTENT_PROTECTION_ENABLED;
+		return false;
 	}
 
-	return true;
+	/* Finally, if state changes, we need action */
+	return old_hdcp != new_hdcp;
 }
 EXPORT_SYMBOL(drm_hdcp_atomic_check);
-- 
2.39.0.246.g2a6d74b583-goog

