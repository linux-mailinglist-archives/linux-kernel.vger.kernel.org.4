Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27A06F9D33
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 03:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjEHBGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 21:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjEHBGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 21:06:19 -0400
Received: from devico.uberspace.de (devico.uberspace.de [185.26.156.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F77C93E8
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 18:06:16 -0700 (PDT)
Received: (qmail 8302 invoked by uid 990); 8 May 2023 01:06:14 -0000
Authentication-Results: devico.uberspace.de;
        auth=pass (plain)
MIME-Version: 1.0
Date:   Mon, 08 May 2023 01:06:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From:   "Leonard Lausen" <leonard@lausen.nl>
Message-ID: <ebbcd56ac883d3c3d3024d368fab63d26e02637a@lausen.nl>
TLS-Required: No
Subject: [PATCH] Revert "drm/msm/dp: Remove INIT_SETUP delay"
To:     regressions@lists.linux.dev,
        "Bjorn Andersson" <quic_bjorande@quicinc.com>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        "Rob Clark" <robdclark@gmail.com>,
        "Abhinav Kumar" <quic_abhinavk@quicinc.com>,
        "Stephen Boyd" <swboyd@chromium.org>,
        "Kuogee Hsieh" <quic_khsieh@quicinc.com>,
        "Johan Hovold" <johan+linaro@kernel.org>,
        "Sankeerth Billakanti" <quic_sbillaka@quicinc.com>
Cc:     "Sean Paul" <sean@poorly.run>, "David Airlie" <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, "Nikita Travkin" <nikita@trvn.ru>
X-Rspamd-Bar: -
X-Rspamd-Report: MIME_GOOD(-0.1) BAYES_HAM(-2.999968) SUSPICIOUS_RECIPS(1.5)
X-Rspamd-Score: -1.599968
Received: from unknown (HELO unkown) (::1)
        by devico.uberspace.de (Haraka/3.0.1) with ESMTPSA; Mon, 08 May 2023 03:06:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=lausen.nl; s=uberspace;
        h=from;
        bh=Ew+ga4R4XmyLDd+z40yzIO7CFGKrkhYk+0CcdiQL9Sw=;
        b=od7KhyxiI988/H0wo80l6KXEewxhiWVhz0SfXY/weB6DUvv7GRv3Rb/20C0sRcopopbYInGJAy
        u0LpHpGjdT10DN1ywJ9gw54CY4sTZ1EK+qfwoWlK6Lse+2EHQ/egTwgmIjUs+3z5u3Wwgf2Iy6Ov
        8+JjmHzraSUXx1gN376lVMSrsd5uBADfq6ae0aeSTI+rNg4zf6AV1xa3l5aiQndVbCH6lE0WEeEm
        zYVDBem9t6Hx3ZS8gyRPqIkcfQbP90eDXu/W0EeiG19jKZPa/Y3Co/7K7W63phd7QdspH60A9w7K
        VwwVw/VfIp+qZk7/k1/P+Ml6xftCKNVMRj0wvXjVH2HF+ZiYSdtQCAuN2GHBFd/loesiMFjEzv+I
        0HosD/qeYweyP2l7P8Zo5M9BCVOS5D+sQ7hANY/c0S9Gs+r1qOHyYh7Ao3RIPYs40pW2Dkyg2jEQ
        aHQ0tdpJavp7CCkSAp/9YrYiLAwe3X5B7EZtR/Ps98/1/vbTd/qmkEGg92iF9QRm/5ksjayNrbY7
        /bELzo3Iku+i5IQJi3ViM9T2NYaNUCbY2b3VCzRVNM6rEuAIGMOjqs3/oNj+fY9fwnQ54frY+pk0
        l6ggn2GIbzVozsNkDoO3VfNBRY9HlabFLpLiNVWt7loWZDv2y3sxN83aeCKOHQIdTZq+mLtgvcaJ
        E=
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit e17af1c9d861dc177e5b56009bd4f71ace688d97.

Removing the delay of 100 units broke hot plug detection for USB-C displa=
ys on
qcom sc7180 lazor devices. Lazor uses mdss for hot plug detection and dec=
lares
dp_hot_plug_det in the dts. Other sc7180 based devices like aspire1 were =
not
affected by the regression, as they do not rely on mdss and dp_hot_plug_d=
et for
hot plug detection.

Signed-off-by: Leonard Lausen <leonard@lausen.nl>
Tested-by: Leonard Lausen <leonard@lausen.nl> # Trogdor (sc7180)
Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

---
 drivers/gpu/drm/msm/dp/dp_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
index bde1a7ce442f..db9783ffd5cf 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1506,7 +1506,7 @@ void msm_dp_irq_postinstall(struct msm_dp *dp_displ=
ay)
        dp =3D container_of(dp_display, struct dp_display_private, dp_dis=
play);
=20
=20       if (!dp_display->is_edp)
-               dp_add_event(dp, EV_HPD_INIT_SETUP, 0, 0);
+               dp_add_event(dp, EV_HPD_INIT_SETUP, 0, 100);
 }
=20
=20bool msm_dp_wide_bus_available(const struct msm_dp *dp_display)
--=20
2.30.2
