Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515E06FBF8D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbjEIGty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbjEIGtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:49:36 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15D110EA
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 23:49:35 -0700 (PDT)
Received: from SoMainline.org (unknown [89.205.226.248])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id D63791F4B7;
        Tue,  9 May 2023 08:49:32 +0200 (CEST)
Date:   Tue, 9 May 2023 08:49:31 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     freedreno@lists.freedesktop.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>
Subject: Re: [Freedreno] [PATCH v2 4/4] drm/msm/dpu: Set DATA_COMPRESS for
 command mode
Message-ID: <shb54ebrjuhl5xqhlbb2vlilnwckzm5x2wan7sa3sl2deyqjfg@3xjfe7txpbn6>
References: <20230405-add-dsc-support-v2-0-1072c70e9786@quicinc.com>
 <20230405-add-dsc-support-v2-4-1072c70e9786@quicinc.com>
 <j5wa45g4v6swvsiakl23azu7qgxtdllf2gav5wdc7s7zukxe4c@jkcu2wnyn6rn>
 <baa25817-4a0d-551d-a351-21cc1525a932@quicinc.com>
 <f99c5891-5d46-b39e-929a-00aedb068fb5@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f99c5891-5d46-b39e-929a-00aedb068fb5@quicinc.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-08 17:00:12, Jessica Zhang wrote:
> On 5/8/2023 4:17 PM, Jessica Zhang wrote:
> > On 5/7/2023 9:06 AM, Marijn Suijten wrote:
> >> On 2023-05-05 14:23:51, Jessica Zhang wrote:
> >>> Add a DPU INTF op to set DATA_COMPRESS register for command mode 
> >>> panels if
> >>> the DPU_INTF_DATA_COMPRESS feature flag is set. This flag needs to be
> >>> enabled in order for DSC v1.2 to work.
> >>>
> >>> Note: These changes are for command mode only. Video mode changes will
> >>> be posted along with the DSC v1.2 support for DP.
> >>
> >> Nit: the "command mode" parts of both paragraphs only apply to the call
> >> in dpu_encoder_phys_cmd, right?  If so, and the INTF op remains the same
> >> for video mode (but only the call needs to be added to the
> >> dpu_encoder_phy_vid), make this a bit more clear in your commit message.
> 
> (Sorry, forgot to address this comment in my initial reply)
> 
> The op will be available for video mode to use, but most likely video 
> mode will set DATA_COMPRESS (or call dpu_hw_intf_enable_compression()) 
> directly in dpu_hw_intf_setup_timing_engine().

Sounsds good, if you can clarify something along those lines so that it
is clear that the call is valid on video mode too, and that the callback
is also available there.

e.g. 
- Drop "for command mode panels" from "op to set DATA_COMPRESS
  register";
- "Note: the op is currently called for command-mode encoders only,
  video mode changes..."

Thanks!

- Marijn
