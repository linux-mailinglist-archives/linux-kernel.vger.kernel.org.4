Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CCC663515
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbjAIXRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237801AbjAIXQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:16:26 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A436517595;
        Mon,  9 Jan 2023 15:16:24 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id bt23so15494425lfb.5;
        Mon, 09 Jan 2023 15:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUSIRNZZE79nkyMU9G9AqBIuhvo2pozCegvf/Srh544=;
        b=e5vEgs1AJgdX8KOL3CKz7nrWRVPue1VdOQbOGTsXxqs0J1Ygz1ssgdEMVmvs/YirWX
         LiwCOS72zz28SQ80nm3FhaRsPrW9Yd5eb53o+UvnMnlmxNknc7I3IV523jLxA7OWbGxa
         5M/T3fQP1Ms0UatoLVeCNBZW7a2C7C6BorIB+3xcb9lF/AMG4Lb5ZFWBRVm0CXtWeijb
         b/nEic1A/Smb3ZMm5DUyYMpdMhAaY1wVGn0ZDqkyt0ibU12xoz7ESSapK8jCqfo+uaBL
         kz+O7R4SHFgOmPjZJvU+XbEwNuSeyHQfR9kx8kx1JVYSfWFQbxYy6D90J1PIKz7lPoJJ
         fwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUSIRNZZE79nkyMU9G9AqBIuhvo2pozCegvf/Srh544=;
        b=GWAqpJ2Trf1SLW4IZ8D6rExICNs7J9P+RpijAgOlKOv16e12lJvuA9PWBFnknDq64v
         xAVB1aWmWymQvEziLWkU5Mbc62C4IbIoPpWwbG8K75IAX9WuzcMFDqdabW56Q44VQSJA
         hhvvG+Y/NOhlclq7WhDgvqSK3O4/4aMzdFQIhEfSo8ql9EzqV9yt9BljQUJ3edKuNFcz
         rbBCbUgGsv5YOwM3jQLTHlFOk10llJKH3vf+H4nIn3PZEpImTwG7eGNK18k2DwZZzhYS
         nn/HZfs1fm5NcGwmftmGVGR1zmlGG9EKrPuP96yrTW4dlzquFqMccR8JWdu1mDlx/FNg
         QGdw==
X-Gm-Message-State: AFqh2kos5Chi5jzHo+PbGdEqoGZlHQO26n2e/4NEmsj5HBBbl5VRShzm
        T2+1rUyt76rtVNT71w+hJgJNClSEjoMtfg==
X-Google-Smtp-Source: AMrXdXtYdkRxLWFDDMg2agf6WmqCxIDsX34LBmbp8EzWMeALY//PoXn597+tUcIDHgQlLj4GX221iQ==
X-Received: by 2002:a05:6512:694:b0:4cb:436b:a70f with SMTP id t20-20020a056512069400b004cb436ba70fmr7100128lfe.64.1673306182070;
        Mon, 09 Jan 2023 15:16:22 -0800 (PST)
Received: from localhost (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id g12-20020a0565123b8c00b004aa543f3748sm1822460lfv.130.2023.01.09.15.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 15:16:21 -0800 (PST)
From:   Dmitry Baryshkov <dbaryshkov@gmail.com>
X-Google-Original-From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jani Nikula <jani.nikula@intel.com>,
        sunliming <sunliming@kylinos.cn>,
        Sam Ravnborg <sam@ravnborg.org>,
        Haowen Bai <baihaowen@meizu.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221221231943.1961117-1-marijn.suijten@somainline.org>
References: <20221221231943.1961117-1-marijn.suijten@somainline.org>
Subject: Re: [PATCH v2 0/8] drm/msm: DSC Electric Boogaloo for sm8[12]50
Message-Id: <167330408773.609993.1753222329751720759.b4-ty@linaro.org>
Date:   Tue, 10 Jan 2023 00:41:27 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Dec 2022 00:19:35 +0100, Marijn Suijten wrote:
> This preliminary Display Stream Compression support package for
> (initially tested on) sm8[12]50 is based on comparing DSC behaviour
> between downstream and mainline.  Some new callbacks are added (for
> binding blocks on active CTLs), logic bugs are corrected, zeroed struct
> members are now assigned proper values, and RM allocation and hw block
> retrieval now hand out (or not) DSC blocks without causing null-pointer
> dereferences.
> 
> [...]

Applied, thanks!

[1/8] drm/msm/dpu: Wire up DSC mask for active CTL configuration
      https://gitlab.freedesktop.org/lumag/msm/-/commit/c2d2c62da1fc
[2/8] drm/msm/dsi: Use DSC slice(s) packet size to compute word count
      https://gitlab.freedesktop.org/lumag/msm/-/commit/bbd1bccdcf4e
[3/8] drm/msm/dsi: Flip greater-than check for slice_count and slice_per_intf
      https://gitlab.freedesktop.org/lumag/msm/-/commit/85b5a40991dd
[5/8] drm/msm/dpu: Reject topologies for which no DSC blocks are available
      https://gitlab.freedesktop.org/lumag/msm/-/commit/f52b965c9434
[6/8] drm/msm/dpu: Remove num_enc from topology struct in favour of num_dsc
      https://gitlab.freedesktop.org/lumag/msm/-/commit/9ce765395f41
[7/8] drm/msm/dpu: Implement DSC binding to PP block for CTL V1
      https://gitlab.freedesktop.org/lumag/msm/-/commit/086116ae1410
[8/8] drm/msm/dpu: Add DSC configuration for SM8150 and SM8250
      https://gitlab.freedesktop.org/lumag/msm/-/commit/8cc4c9de15f4

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
