Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25D568650F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 12:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjBALKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 06:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjBALKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 06:10:36 -0500
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CA5470B3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 03:10:35 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 0B05820206;
        Wed,  1 Feb 2023 12:10:33 +0100 (CET)
Date:   Wed, 1 Feb 2023 12:10:31 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Kalyan Thota <quic_kalyant@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, dmitry.baryshkov@linaro.org,
        quic_abhinavk@quicinc.com
Subject: Re: [v1 1/3] drm/msm/disp/dpu1: clear dspp reservations in rm release
Message-ID: <20230201111031.dqdketybw3pqpywx@SoMainline.org>
References: <1675092092-26412-1-git-send-email-quic_kalyant@quicinc.com>
 <1675092092-26412-2-git-send-email-quic_kalyant@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675092092-26412-2-git-send-email-quic_kalyant@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-30 07:21:30, Kalyan Thota wrote:
> Clear dspp reservations from the global state during
> rm release

DSPP, and a period at the end of a sentence.  Also noticing inconsistent
linebreaks across these patches, stick to 72 chars.

> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

Should this be considered a fix to be backported, or is it harmless?  If
so:

Fixes: e47616df008b ("drm/msm/dpu: add support for color processing blocks in dpu driver")

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> index 73b3442..718ea0a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> @@ -572,6 +572,8 @@ void dpu_rm_release(struct dpu_global_state *global_state,
>  		ARRAY_SIZE(global_state->ctl_to_enc_id), enc->base.id);
>  	_dpu_rm_clear_mapping(global_state->dsc_to_enc_id,
>  		ARRAY_SIZE(global_state->dsc_to_enc_id), enc->base.id);
> +	_dpu_rm_clear_mapping(global_state->dspp_to_enc_id,
> +		ARRAY_SIZE(global_state->dspp_to_enc_id), enc->base.id);
>  }
>  
>  int dpu_rm_reserve(
> -- 
> 2.7.4
> 
