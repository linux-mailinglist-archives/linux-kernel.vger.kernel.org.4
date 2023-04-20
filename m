Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BAC6E9DFB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 23:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjDTVjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 17:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjDTVjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 17:39:16 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8274D10D9;
        Thu, 20 Apr 2023 14:39:15 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 8C81120571;
        Thu, 20 Apr 2023 23:39:13 +0200 (CEST)
Date:   Thu, 20 Apr 2023 23:39:12 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        freedreno@lists.freedesktop.org
Subject: Re: [Freedreno] [PATCH 1/3] drm/msm/dpu: Drop unused members from HW
 structs
Message-ID: <2ujeakobg7oulzarvzjktx5elo4ckpjq5pbknr3jx3h43snmry@yd4j64s7tqy5>
References: <20230418-dpu-drop-useless-for-lookup-v1-0-b9897ceb6f3e@somainline.org>
 <20230418-dpu-drop-useless-for-lookup-v1-1-b9897ceb6f3e@somainline.org>
 <7ad86cd9-4b30-e7f1-780f-2c1c7093087e@linaro.org>
 <cd308be9-5420-6d75-da23-e844107ec275@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd308be9-5420-6d75-da23-e844107ec275@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-20 08:46:46, Abhinav Kumar wrote:
> 
> 
> On 4/20/2023 7:33 AM, Dmitry Baryshkov wrote:
> > On 18/04/2023 02:14, Marijn Suijten wrote:
> >> Some of these members were initialized while never read, while others
> >> were not even assigned any value at all.  Drop them to save some space,
> >> and above all confusion when looking at these members.
> >>
> >> Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
> >> Fixes: 84a33d0fd921 ("drm/msm/dpu: add dpu_hw_wb abstraction for 
> >> writeback blocks")
> > 
> > The fixes headers are slightly questionable, as unused fields are not a 
> > bug. Nevertheless:
> > 
> 
> Yes, I would also not treat this as a "fix" but just cleanup.

Ack to both.  This seems like a fine line to me as the fields are not
contributing to anything except confusion.  Specifically hw_mdp which is
never initialized and may accidentally be used without realizing that
it'll stay NULL, but that is again up to the developer using the field
at that point.

Feel free to drop them while applying, or should I reword the message to
at least still link these commits to mention the origin of the unused
fields?

- Marijn
