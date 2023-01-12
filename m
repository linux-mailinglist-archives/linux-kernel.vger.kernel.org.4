Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBB8667A8C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjALQPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjALQPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:15:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D226655A7;
        Thu, 12 Jan 2023 08:12:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84B5BB81EC1;
        Thu, 12 Jan 2023 16:12:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70EAC43392;
        Thu, 12 Jan 2023 16:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673539947;
        bh=29Sxm39B+01WIU0jVfA39bwm136dLsQ3RyDOx181Pv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V0fVdenUoke9M1d3AOMx3rB8Pf/++KdcGC2UP7jpfsRf0i57aS9YNggfSWjekBZfQ
         ZgTf4kRjO9kg7h/oUxD0tETw0aQkATlYVyFMtPavi9NBjkrWjwG+942C+nBLFZHBuR
         zDxoujRy1XLWQQCXQfG1tjlKDPuTL3plhkwLmDmsGHPT1muD8vw28u7Q41U+M2rNyB
         E25p2HQKntVWwJLIg1urZ14CGlT5RP+NvGat2rxSs4gpXf/A+RZy0n1bn0gApIh0dP
         zPzzsjkrE6U0IUEGTSdaz1r/LV52YzfH5D6J58k1QZzREy97Fdnjn0SU5b1zd3woIo
         GAqciEiA8GEiw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@linaro.org, quic_bjorande@quicinc.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Use MMCX for all DP controllers
Date:   Thu, 12 Jan 2023 10:12:21 -0600
Message-Id: <167353993749.2393683.8750028930982188331.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230112135055.3836555-1-quic_bjorande@quicinc.com>
References: <20230112135055.3836555-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2023 05:50:55 -0800, Bjorn Andersson wrote:
> While MDSS_GDSC is a subdomain of MMCX, Linux does not respect this
> relationship and sometimes invokes sync_state on the rpmhpd (MMCX)
> before the DisplayPort controller has had a chance to probe.
> 
> The result when this happens is that the power is lost to the multimedia
> subsystem between the probe of msm_drv and the DisplayPort controller -
> which results in an irrecoverable state.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp: Use MMCX for all DP controllers
      commit: bb45bb9705372d9335ccd7e3fc5436770ec6d846

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
