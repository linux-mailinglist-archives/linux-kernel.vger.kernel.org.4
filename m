Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7970717831
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbjEaH2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234123AbjEaH2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:28:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187DB123;
        Wed, 31 May 2023 00:28:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DE076376B;
        Wed, 31 May 2023 07:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05087C433A0;
        Wed, 31 May 2023 07:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685518113;
        bh=UE35bN0SYktAgtulGtfRw0ZGksuMveOylG6L1tzctnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SGEvusDHV50xFpcIlZ1fNz5joNg7Q2NhNz97qTLqpKYfqfj3PcrVzptKrQlT5mzUy
         hxhCZUr8tkDTTox8iy4inhitrzU1oQ4JxFYmNlE40tcdNa8vYIxeKAubbBc4CZHAj+
         cNcmoljlW3a7V7NvHkWdh+xMcjkG/mUXhKckg/z8KjNyEkH4o2p7HvNNGiIO4RB1j1
         Yoki+MSxlYabo0hDhzuE0Zgj/qvqcAUwFYEemMOd63otKh4AcYsQcFhqTM2xAr0BYu
         D8mcbQErrxFK0EcNby/YjZvor33EHAiBFB+Fp48pygeQyRMbkmbCLQY6WrmnVNbbSc
         j/yIUKtBDaGtg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q4GG3-0006k2-F1; Wed, 31 May 2023 09:28:36 +0200
Date:   Wed, 31 May 2023 09:28:35 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, mani@kernel.org,
        Steev Klimaszewski <steev@kali.org>
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sc8280xp: Add GPU related nodes
Message-ID: <ZHb3I6NUcjHZ64wD@hovoldconsulting.com>
References: <20230531030945.4109453-1-quic_bjorande@quicinc.com>
 <20230531030945.4109453-3-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531030945.4109453-3-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 08:09:44PM -0700, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Add Adreno SMMU, GPU clock controller, GMU and GPU nodes for the
> SC8280XP.
> 
> Tested-by: Steev Klimaszewski <steev@kali.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> 
> Changes since v2:
> - Added missing opp level (both gpu and gmu)
> - Corrected opp-level for highest gpu opp
> - Added dma-coherent to gpu smmu
> 
> Note that in order for the GPU driver to probe, the last change
> requires:
> https://lore.kernel.org/linux-arm-msm/20230410185226.3240336-1-dmitry.baryshkov@linaro.org/

That's a pretty well-hidden notice about a critical dependency. I just
spent the morning debugging why this series broke the probe of the GPU
and only saw this when I was going to report my findings.

Please consider putting information like this in the cover letter in the
future.

> Changes since v1:
> - Dropped gmu_pdc_seq region from &gmu, as it shouldn't have been used.
> - Added missing compatible to &adreno_smmu.
> - Dropped aoss_qmp clock in &gmu and &adreno_smmu.

Changelogs are also preferably placed in the cover letter so that you
don't have to read through N patches to determine what changed from one
revision of a series to the next.

Johan
