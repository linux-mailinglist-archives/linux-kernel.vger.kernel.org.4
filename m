Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA312717846
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbjEaHbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbjEaHbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:31:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C343D125;
        Wed, 31 May 2023 00:31:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 208D56377E;
        Wed, 31 May 2023 07:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B29C4339B;
        Wed, 31 May 2023 07:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685518265;
        bh=fJz7lxGK5Ska27iQ8eKIC8CyRP69QFpkWxtkM6c5CWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h+W4Fajj33S1kLocdt2Sc31gFSgcB4Didwm9lJPXtCbRXwbAhcFDl9Itrrbgpgd9a
         yr0p2oT449/TKQbxTqHa4ouq8ida+TsZUaKTxxaV/YdCr78/R1jiLJ/bZ00kd5RV6x
         hiEBZd+QN0YQPOtgAQKSbMSh9U9uCTucWcWyIb7XUG3vfykGC/MwdxVPG4gRJc1njQ
         gNTU1jJdLWIIza0JP0KSa6EKADZhHEM4gV8/VNEAJIDT0w+EtQz/KMyJTOQNOolgfn
         1omC6F2PKcxzmo7mahsOsc/Ad2CkLVvE5Vfz6HZs69UfQo+eOmL5i/NsgPbucyzCde
         FX+JQF3kw0N7Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q4GIW-0006lM-Qd; Wed, 31 May 2023 09:31:08 +0200
Date:   Wed, 31 May 2023 09:31:08 +0200
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
        freedreno@lists.freedesktop.org, mani@kernel.org
Subject: Re: [PATCH v3 0/3] drm/msm/adreno: GPU support on SC8280XP
Message-ID: <ZHb3vKjWcgWhvCoi@hovoldconsulting.com>
References: <20230531030945.4109453-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531030945.4109453-1-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 08:09:42PM -0700, Bjorn Andersson wrote:
> This series introduces support for A690 in the DRM/MSM driver and
> enables it for the two SC8280XP laptops.
> 
> Bjorn Andersson (3):
>   drm/msm/adreno: Add Adreno A690 support
>   arm64: dts: qcom: sc8280xp: Add GPU related nodes
>   arm64: dts: qcom: sc8280xp: Enable GPU related nodes

Seems to work well (after applying the dependency mentioned in the dtsi
patch):

Tested-by: Johan Hovold <johan+linaro@kernel.org>

Johan
