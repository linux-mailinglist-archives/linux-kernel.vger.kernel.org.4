Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DCE70656B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 12:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjEQKiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 06:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjEQKiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 06:38:19 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F281897;
        Wed, 17 May 2023 03:38:17 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1ECC51EC055F;
        Wed, 17 May 2023 12:38:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1684319896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BatpuZgGB297seHuJ1mf9A2oYI8Ey7cYqz+SD9MShzA=;
        b=DTcdYb5tLQuCNKHO13AecWbgmkfxmuXtwxeDV+7wclnNFMSFy60iBnUdnkMrEDj8sRIhJ7
        hZTouQxaMTrZ6BzrEM+Fh7JnHlQNm383EDF0K4qylnp1goIvyV1ytD2TU4uQ0M7bR/4RVF
        lTDkzOhkrse5A27l1yz3bJdCqQty4DE=
Date:   Wed, 17 May 2023 12:38:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, mchehab@kernel.org, james.morse@arm.com,
        rric@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.baryshkov@linaro.org, stable@vger.kernel.org
Subject: Re: [RESEND PATCH v7 2/2] EDAC/qcom: Get rid of hardcoded register
 offsets
Message-ID: <20230517103815.GCZGSul9wCk4K8/XkN@fat_crate.local>
References: <20230517062859.57371-1-manivannan.sadhasivam@linaro.org>
 <20230517062859.57371-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230517062859.57371-3-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 11:58:59AM +0530, Manivannan Sadhasivam wrote:
> The LLCC EDAC register offsets varies between each SoC. Hardcoding the
> register offsets won't work and will often result in crash due to
> accessing the wrong locations.
> 
> Hence, get the register offsets from the LLCC driver matching the
> individual SoCs.
> 
> Cc: <stable@vger.kernel.org> # 6.0: 5365cea199c7 ("soc: qcom: llcc: Rename reg_offset structs to reflect LLCC version")
> Cc: <stable@vger.kernel.org> # 6.0: c13d7d261e36 ("soc: qcom: llcc: Pass LLCC version based register offsets to EDAC driver")
> Cc: <stable@vger.kernel.org> # 6.0
> Fixes: a6e9d7ef252c ("soc: qcom: llcc: Add configuration data for SM8450 SoC")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/edac/qcom_edac.c           | 116 ++++++++++++++---------------
>  include/linux/soc/qcom/llcc-qcom.h |   6 --
>  2 files changed, 58 insertions(+), 64 deletions(-)

In case Bjorn wants to pick this up:

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
