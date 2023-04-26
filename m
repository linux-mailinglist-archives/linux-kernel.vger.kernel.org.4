Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238346EFAA1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 21:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbjDZTIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 15:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjDZTIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 15:08:34 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [5.144.164.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160E4133
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 12:08:32 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id A1F3C3F7C9;
        Wed, 26 Apr 2023 21:08:29 +0200 (CEST)
Date:   Wed, 26 Apr 2023 21:08:28 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Adam Skladowski <a39.skl@gmail.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Robert Foss <rfoss@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
Subject: Re: [PATCH v3 06/21] drm/msm/dpu: Use V2 DITHER PINGPONG sub-block
 in SM8[34]50/SC8280XP
Message-ID: <vwejuayy7ulq3frpqpqetkyhyefgrmgo6222how4hp4bissepx@uauvwlhsekgn>
References: <20230411-dpu-intf-te-v3-0-693b17fe6500@somainline.org>
 <20230411-dpu-intf-te-v3-6-693b17fe6500@somainline.org>
 <d44022e0-bc09-122e-5a48-1994cb025ba8@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d44022e0-bc09-122e-5a48-1994cb025ba8@quicinc.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-26 09:24:19, Abhinav Kumar wrote:
> 
> 
> On 4/25/2023 4:05 PM, Marijn Suijten wrote:
> > According to downstream sources this DITHER sub-block sits at an offset
> > of 0xe0 with version 0x20000.  The PP_BLK_DITHER macro is _not_ used as
> > downstream still says the size of the PINGPONG block is 0xd4 and not 0.
> > 
> 
> the PINGPONG block size is 0x0 on sm8350, sm8450 and sc8280xp.
> 
> and length of dither is 0x20 and they all start at 0xe0.
> 
> So now does anything prevent us from using PP_BLK_DITHER macro for these?

Nothing prevents it from being used (if you are referring to our
previous conversations) besides this information not being available in
public DTS (I simply did not know) and the fact that all these many
fixes - however necessary they are - distract from the main topic of
this series: bringing INTF TE support to DPU1.

I'll fit in that patch though, as I have to send v4 anyway.

- Marijn
