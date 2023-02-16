Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E4E698AE3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 04:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBPDCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 22:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBPDCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 22:02:45 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FA8233F6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 19:02:44 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id i137so689823ybg.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 19:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UmfoGNmoydQLu/4gLeD4ecXj20LBp85h/89oL/+L10E=;
        b=Q/KqDmrg1GbuXRaTxw0oDwkSDjBxP4Ae+nf6X7sbOxXNH0eD0wl8/M6FexUVCbi88W
         zG2CbhcfEHXgFgPZg1xntAm61fIipkbd5y2y4AHDcvd9/Q45+S0L4PrITYjwN5fnhWl9
         cluu0f9dhWYoit9BCQsz4c25kC13XVsv/ECcrJK/OBY0Yy9d+VjixjI7KeEI4+u6eutk
         I0KrrQcpfxCWG4OFz5ILWRHlI9KoYahrIvj9Uw57V9nsJIKSmS64zK7ELoqZyKttAlov
         HyzQgQtNBCkc0MbCzxDrMcSxmXsTrPWpMKI8PvVsVH6MwUBhhM5TLFdqDhJlsJp4Z2cU
         rvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UmfoGNmoydQLu/4gLeD4ecXj20LBp85h/89oL/+L10E=;
        b=WuzA5GfAws2/9DVF91Iit9JoIl8r9jMOVX/+8iMgNkWBpTPAO7IaIQRrcmkifLTdY4
         fp8Shs/Qh02k/CyU0WrDniFMU1ytUUrIWNAe9wJAh2WGNzFQYIO5teYw6pdNAWLQp1Ey
         Pw7lezysYNNZTOtHxxMUurIbowey9UboSAEb2YIJwuHiZQ5ApzXD9+OXGUdsGgxp5D9t
         jm16gpcX2qSGPz9+ULEnscBFjfo9xJzBvPBkrs5a9n38X2bGwOoQmeKxzbjFU5C8tl+b
         yy9SzwMAfTFDmsMcIaEDOccvH3qEHsbe16ECbqFBp+3phZmCLsFqrxd5DuJGMMjkIN7o
         IClw==
X-Gm-Message-State: AO0yUKX/uuTDMB0bAjFbzMZU00W8fKznFc/6BhkORBXaxILdOI2BI6Z8
        9loYMsv8HJ8Nq2ATR/NjJP7Y/QOYliZM3uwE4FT96A==
X-Google-Smtp-Source: AK7set+wevyweJgk6/FESwWZUqeOoq8hRyKir3CGjvMKeXHLg9TcJFZU8wMezt7btRCXjLKWkqQ2a5assUlQmuvevrQ=
X-Received: by 2002:a25:f50c:0:b0:90a:8ba9:3ac3 with SMTP id
 a12-20020a25f50c000000b0090a8ba93ac3mr509152ybe.333.1676516563474; Wed, 15
 Feb 2023 19:02:43 -0800 (PST)
MIME-Version: 1.0
References: <20230215-sspp-scaler-version-v1-0-416b1500b85b@somainline.org>
In-Reply-To: <20230215-sspp-scaler-version-v1-0-416b1500b85b@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 16 Feb 2023 05:02:32 +0200
Message-ID: <CAA8EJpqL-Vsq7dbK7tfJAGgg2_nV463QYv5zgvRLx_8T2bsXxA@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/msm/dpu: Initialize SSPP scaler version (from
 register read)
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Archit Taneja <architt@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        phone-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2023 at 01:02, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> Random inspection of the SSPP code surfaced that the version field of
> dpu_scaler_blk was never assigned in the catalog, resulting in wrong
> codepaths to be taken within dpu_hw_setup_scaler3 based on a 0 version.
> Rectify this by reading an accurate value from a register (that is not
> equal to the values represented by DPU_SSPP_SCALER_QSEEDx enum
> variants) and deleting dead code around QSEED versioning.
>
> Future changes should likely get rid of the distinction between QSEED3
> and up, as these are now purely determined from the register value.
> Furthermore implementations could look at the scaler subblk .id field
> rather than the SSPP feature bits, which currently hold redundant
> information.
>
> ---
> Marijn Suijten (3):
>       drm/msm/dpu: Read previously-uninitialized SSPP scaler version from hw
>       drm/msm/dpu: Drop unused get_scaler_ver callback from SSPP
>       drm/msm/dpu: Drop unused qseed_type from catalog dpu_caps

The cleanup looks good. However as you are on it, maybe you can also
add patch 4, dropping DPU_SSPP_SCALER_QSEED3LITE and
DPU_SSPP_SCALER_QSEED4 in favour of using QSEED3 for all these
scalers? As we are going to use scaler_version to distinguish between
them, it would be logical not to duplicate that bit of information
(not to mention all the possible troubles if scaler_version disagrees
with the sblk->scaler_blk.id).

>
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 12 ------------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h |  4 ----
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c    | 12 ++++++++----
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h    |  9 +++------
>  4 files changed, 11 insertions(+), 26 deletions(-)
> ---
> base-commit: 9d9019bcea1aac7eed64a1a4966282b6b7b141c8
> change-id: 20230215-sspp-scaler-version-19f221585c5e
>
> Best regards,
> --
> Marijn Suijten <marijn.suijten@somainline.org>
>


-- 
With best wishes
Dmitry
