Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155C670F592
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjEXLqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjEXLqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:46:32 -0400
Received: from devico.uberspace.de (devico.uberspace.de [185.26.156.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AA3189
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 04:46:23 -0700 (PDT)
Received: (qmail 19997 invoked by uid 990); 24 May 2023 11:46:21 -0000
Authentication-Results: devico.uberspace.de;
        auth=pass (plain)
MIME-Version: 1.0
Date:   Wed, 24 May 2023 11:46:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From:   "Leonard Lausen" <leonard@lausen.nl>
Message-ID: <3a11741c9cc699e178f9b705a34342add03ea0df@lausen.nl>
TLS-Required: No
Subject: Re: [PATCH v6] drm/msm/dp: enable HDP plugin/unplugged interrupts at
 hpd_enable/disable
To:     "Kuogee Hsieh" <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        andersson@kernel.org, regressions@lists.linux.dev
Cc:     "Kuogee Hsieh" <quic_khsieh@quicinc.com>,
        quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        quic_sbillaka@quicinc.com, marijn.suijten@somainline.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1684878756-17830-1-git-send-email-quic_khsieh@quicinc.com>
References: <1684878756-17830-1-git-send-email-quic_khsieh@quicinc.com>
X-Rspamd-Bar: /
X-Rspamd-Report: MIME_GOOD(-0.1) BAYES_HAM(-1.80269) SUSPICIOUS_RECIPS(1.5)
X-Rspamd-Score: -0.40269
Received: from unknown (HELO unkown) (::1)
        by devico.uberspace.de (Haraka/3.0.1) with ESMTPSA; Wed, 24 May 2023 13:46:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=lausen.nl; s=uberspace;
        h=from;
        bh=yvML/N3WJWiB2LyumltXUYRXVUY6T1Z0/T8xB4Juop4=;
        b=BW79TuMU14I2zQ1/iZDlcMklY9d8hFqDFVqNll7kptlo750aTKf/9+xmPYQuVKOK8D1pPFwgoG
        CtO/GUTdpodwO1GVY1pDTvEzL8g4Lw0aoz4aNSjSaluTfpqig+jW1v6adCTpPzuI4dw/TJpOGTJe
        xfemmQFpSMpDe251TKcjHIxN4DJEDRaWfBzPmicXBrooUdIF/dIb2KZND/uh3stRVnqsqJ1nSZnK
        gMwoWQ8CGwjdBmC/exGcwRpsbUuezc7WRwa+cdR/wT7Qq6o9c9/bkqkHlrObjKYiXeNs+nUF+C4w
        RFZpIj6UxXScvs1Eg+LvT8VUNnApNhgr8riIg32AAE/67TgFGxMIFV8I9moIUPmwezY022c5adm9
        KDkx/fQi5VIp1aHEwuPVraOFI4apNz/gaBjt2Vb73DGaZfX6Hyf5a8L1kttx+r9dxOgy9pW2R7oz
        nqbGNGbBSD16wYwsJ6wPtp05fRBSswm9J8Yjs3dT49YGRJdlGPnWP/Og/UdB/u2jtU0dM4a9cU/Z
        Suut2A4cQqYzlbFv5oQ+Hl1OIETlT9E1GW5hXrl1m/s6qn1G3rI4p76ZPCKAFskxPRKgcYlQ4fyE
        eUXQdOGRBnvug3exP9XNUqiB9gQsmh4J6sRE5WCpwPZsy/MZfYsJy65wqW/1Xdz1Hg0uIuOLqztv
        w=
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kuogee Hsieh <quic_khsieh@quicinc.com> writes:
> The internal_hpd flag is set to true by dp_bridge_hpd_enable() and set =
to
> false by dp_bridge_hpd_disable() to handle GPIO pinmuxed into DP contro=
ller
> case. HDP related interrupts can not be enabled until internal_hpd is s=
et
> to true. At current implementation dp_display_config_hpd() will initial=
ize
> DP host controller first followed by enabling HDP related interrupts if
> internal_hpd was true at that time. Enable HDP related interrupts depen=
ds on
> internal_hpd status may leave system with DP driver host is in running =
state
> but without HDP related interrupts being enabled. This will prevent ext=
ernal
> display from being detected. Eliminated this dependency by moving HDP r=
elated
> interrupts enable/disable be done at dp_bridge_hpd_enable/disable() dir=
ectly
> regardless of internal_hpd status.
>
> Changes in V3:
> -- dp_catalog_ctrl_hpd_enable() and dp_catalog_ctrl_hpd_disable()
> -- rewording ocmmit text
>
> Changes in V4:
> -- replace dp_display_config_hpd() with dp_display_host_start()
> -- move enable_irq() at dp_display_host_start();
>
> Changes in V5:
> -- replace dp_display_host_start() with dp_display_host_init()
>
> Changes in V6:
> -- squash remove enable_irq() and disable_irq()
>
> Fixes: cd198caddea7 ("drm/msm/dp: Rely on hpd_enable/disable callbacks"=
)
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>

Cherry-picked on top of v6.3.3 and verified fixes the USB-C DP
regression on sc7180 lazor. Thank you!

Tested-by: Leonard Lausen <leonard@lausen.nl> # on sc7180 lazor
