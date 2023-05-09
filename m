Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF0F6FBF80
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbjEIGqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbjEIGqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:46:31 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF9419B1
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 23:46:28 -0700 (PDT)
Received: from SoMainline.org (unknown [89.205.226.248])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 584721F713;
        Tue,  9 May 2023 08:46:24 +0200 (CEST)
Date:   Tue, 9 May 2023 08:46:22 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 4/4] drm/msm/dpu: Set DATA_COMPRESS for command mode
Message-ID: <tucqk6alt7bcxhk63bwobnswrag4dhx7srj6hzhqvky3trclwv@jbq5hdzfa5of>
References: <20230405-add-dsc-support-v2-0-1072c70e9786@quicinc.com>
 <20230405-add-dsc-support-v2-4-1072c70e9786@quicinc.com>
 <j5wa45g4v6swvsiakl23azu7qgxtdllf2gav5wdc7s7zukxe4c@jkcu2wnyn6rn>
 <baa25817-4a0d-551d-a351-21cc1525a932@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baa25817-4a0d-551d-a351-21cc1525a932@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-08 16:17:54, Jessica Zhang wrote:
<snip>
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> >> index 73b0885918f8..a8def68a5ec2 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> >> @@ -70,6 +70,7 @@ struct intf_status {
> >>    * @get_autorefresh:            Retrieve autorefresh config from hardware
> >>    *                              Return: 0 on success, -ETIMEDOUT on timeout
> >>    * @vsync_sel:                  Select vsync signal for tear-effect configuration
> >> + * @enable_compression: Enable data compression
> > 
> > Indent to match above.
> 
> Sure, is the plan to correct the whitespace in the first half of the 
> comment block in the future?

I couldn't see the first part of the block in the diff context here, but
indeed that's a broken disaster so we will have to fix that up :(

I think it is fine to leave the latter ones as it is, as long as it is
consistent:

- Only using spaces;
- Colon directly after the word (and an @ before it, see kerneldoc
  specification);
- Aligned to existing entries.

- Marijn
