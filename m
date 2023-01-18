Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D73672832
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjARTaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjARTaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:30:21 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FE15411B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:30:20 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id s4so1742828qtx.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g7xDPjbRpbW/1Y146BUFy3rG1PlEHIGh3rZX85WmAFk=;
        b=YCT7NhsFTBwdjtcySMujXsQ9iT8sSkX9P2rJSOEi7MIf/vUZgLKWPIvYhDDJ5KX0h2
         04Y3Gb4+aqh+eqPj9AsvYA5GWlhSgRiEEgTn4XOEJ1fZkP+7FFANL24g7AWuZkMKqdRP
         aw1/btRMyKOiceej5xV2eo4/2E6hYFfTepV+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7xDPjbRpbW/1Y146BUFy3rG1PlEHIGh3rZX85WmAFk=;
        b=DLhp41zzrWwzN1SbfNcwJYcRVcpPyNbl4sUtVGv78f/B4C6GNDI3p6aJ58i2UL2l+D
         DRvA7mU0cUg7cQnhcUIxtnGYVtYs/kakxsk+5IqYAVi53G96E0WfmCNm9BsbUEQNBsi0
         Qcjy48+N6mhr+s5NQpDXFge4Tc721q3nF8XV1GLCO9ZNthGUtAp+aBrQgdyxjFr8j6Nx
         RbR++QuMiAJTbQck4YtzSmnpDtovUC5KXKkdEWq8Yrd+d/lre+NjngbS+Vjo1cSqi5sl
         Z7fn+UpMoJxC+R3OcFMk+YVfOpArjJbIQVMVMBHprLSppwM2MWeYNkm2O1N84b44XInt
         yu2g==
X-Gm-Message-State: AFqh2krS8IpnpbAaOgNgJA0zGA40PyqnmB62Zf9MoCYSXoI4dJdiqKqK
        DwaA+EvRw17lnV1HQip1DHxSQg==
X-Google-Smtp-Source: AMrXdXuZJIDRMFdvUl35vOCmEkGVlA3bW2dOxpF8adOcUqZuFBuN3qGMHLxiai/uwwErQRkgA/dCow==
X-Received: by 2002:ac8:6b88:0:b0:3b0:4084:d6ad with SMTP id z8-20020ac86b88000000b003b04084d6admr11101265qts.58.1674070219105;
        Wed, 18 Jan 2023 11:30:19 -0800 (PST)
Received: from localhost (29.46.245.35.bc.googleusercontent.com. [35.245.46.29])
        by smtp.gmail.com with UTF8SMTPSA id y2-20020a05620a44c200b006e42a8e9f9bsm8957331qkp.121.2023.01.18.11.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 11:30:18 -0800 (PST)
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
        abhinavk@codeaurora.org, seanpaul@chromium.org
Subject: [PATCH v6 00/10] drm/hdcp: Pull HDCP auth/exchange/check into helpers
Date:   Wed, 18 Jan 2023 19:30:05 +0000
Message-Id: <20230118193015.911074-1-markyacoub@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Yacoub <markyacoub@chromium.org>

Hello,

I rebased this series which is authored by Sean Paul.

A major rebase conflict was that drm/drm_hdcp was split to drm/display/drm_hdcp & drm/display/drm_hdcp_helper.

Another major one was in msm dp where drm_connector was no longer tracked, but it's replaced by msm_dp_bridge to carry over its functionalities.

The first 4 patches modify DRM. They've been reviewed.
Patches 5-7 are intel-only. Only patch 7 hasn't been reviewed.
Patches 8-10 are msm-only. Only patch 9 hasn't been reviewed.

Thanks,
Mark

Sean Paul (10):
  drm/hdcp: Add drm_hdcp_atomic_check()
  drm/hdcp: Avoid changing crtc state in hdcp atomic check
  drm/hdcp: Update property value on content type and user changes
  drm/hdcp: Expand HDCP helper library for enable/disable/check
  drm/i915/hdcp: Consolidate HDCP setup/state cache
  drm/i915/hdcp: Retain hdcp_capable return codes
  drm/i915/hdcp: Use HDCP helpers for i915
  dt-bindings: msm/dp: Add bindings for HDCP registers
  arm64: dts: qcom: sc7180: Add support for HDCP in dp-controller
  drm/msm: Implement HDCP 1.x using the new drm HDCP helpers

 .../bindings/display/msm/dp-controller.yaml   |    8 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  |    8 +
 drivers/gpu/drm/display/drm_hdcp_helper.c     | 1202 +++++++++++++++++
 drivers/gpu/drm/i915/display/intel_atomic.c   |    8 +-
 drivers/gpu/drm/i915/display/intel_ddi.c      |   32 +-
 .../drm/i915/display/intel_display_debugfs.c  |   11 +-
 .../drm/i915/display/intel_display_types.h    |   60 +-
 drivers/gpu/drm/i915/display/intel_dp_hdcp.c  |  348 ++---
 drivers/gpu/drm/i915/display/intel_dp_mst.c   |   16 +-
 drivers/gpu/drm/i915/display/intel_hdcp.c     | 1028 +++-----------
 drivers/gpu/drm/i915/display/intel_hdcp.h     |   36 +-
 drivers/gpu/drm/i915/display/intel_hdmi.c     |  270 ++--
 drivers/gpu/drm/msm/Kconfig                   |    1 +
 drivers/gpu/drm/msm/Makefile                  |    1 +
 drivers/gpu/drm/msm/dp/dp_debug.c             |   48 +-
 drivers/gpu/drm/msm/dp/dp_debug.h             |    6 +-
 drivers/gpu/drm/msm/dp/dp_display.c           |   52 +-
 drivers/gpu/drm/msm/dp/dp_display.h           |    5 +
 drivers/gpu/drm/msm/dp/dp_drm.c               |  108 +-
 drivers/gpu/drm/msm/dp/dp_drm.h               |   16 +-
 drivers/gpu/drm/msm/dp/dp_hdcp.c              |  456 +++++++
 drivers/gpu/drm/msm/dp/dp_hdcp.h              |   29 +
 drivers/gpu/drm/msm/dp/dp_parser.c            |   20 +-
 drivers/gpu/drm/msm/dp/dp_parser.h            |    4 +
 drivers/gpu/drm/msm/dp/dp_reg.h               |   32 +-
 drivers/gpu/drm/msm/msm_atomic.c              |   15 +
 include/drm/display/drm_hdcp.h                |  168 ++-
 include/drm/display/drm_hdcp_helper.h         |   33 +-
 28 files changed, 2667 insertions(+), 1354 deletions(-)
 create mode 100644 drivers/gpu/drm/msm/dp/dp_hdcp.c
 create mode 100644 drivers/gpu/drm/msm/dp/dp_hdcp.h

-- 
2.39.0.246.g2a6d74b583-goog

