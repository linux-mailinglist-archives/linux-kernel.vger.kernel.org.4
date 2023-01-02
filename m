Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0571065B418
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236326AbjABPWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236317AbjABPWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:22:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CC233E
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 07:22:01 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1pCMdF-0005jz-F4; Mon, 02 Jan 2023 16:21:45 +0100
Received: from pza by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1pCMdB-0007uo-Tn; Mon, 02 Jan 2023 16:21:41 +0100
Date:   Mon, 2 Jan 2023 16:21:41 +0100
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/5] drm/msm/a6xx: Remove cx gdsc polling using 'reset'
Message-ID: <20230102152141.GA30338@pengutronix.de>
References: <1672656511-1931-1-git-send-email-quic_akhilpo@quicinc.com>
 <20230102161757.v5.4.I96e0bf9eaf96dd866111c1eec8a4c9b70fd7cbcb@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230102161757.v5.4.I96e0bf9eaf96dd866111c1eec8a4c9b70fd7cbcb@changeid>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: pza@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 04:18:30PM +0530, Akhil P Oommen wrote:
> Remove the unused 'reset' interface which was supposed to help to ensure
> that cx gdsc has collapsed during gpu recovery. This is was not enabled
> so far due to missing gpucc driver support. Similar functionality using
> genpd framework will be implemented in the upcoming patch.
> 
> This effectively reverts commit 1f6cca404918
> ("drm/msm/a6xx: Ensure CX collapse during gpu recovery").
> 
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
