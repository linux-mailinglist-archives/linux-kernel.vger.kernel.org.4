Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34EC6A4629
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjB0Pfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjB0Pfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:35:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DCC15C90;
        Mon, 27 Feb 2023 07:35:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35AB760EA5;
        Mon, 27 Feb 2023 15:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DC9C433D2;
        Mon, 27 Feb 2023 15:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677512128;
        bh=9c4uq9wOs3GsNrUYMpDTYt/Y5TsB8KfI9Jand078aUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eP05/3UvGR5IEurbM/Qu4aEHvsQsmLbhRwbOpA4AGzS9XGEmKibP3m0AcW8qO5KdP
         gSHQeDFH6qoeexqQM73PPEID23Iydn+llTCahxZDbPGjcPqkkx14+30yrc2NK0uBjC
         72dZfqI1YzU24Y3zlikB+yEwT1ZA+y3KPVqD6HaJxG5K29YaY4N4XOzMA+KLRiQ8/C
         KBVTOFC5JTRFqb2IOkJhz8yP0isRduWsZtivc4Laew82ZUcIgEmUdtqfBgjfKf+9Ud
         UMJqPFxJYFBkmiBRHAJFV/jk+XXqycmmPO3v+iqe9SWE08CC6sWif5l++b2joVieau
         /qj3UpXvihO6g==
Date:   Mon, 27 Feb 2023 07:38:48 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Maulik Shah <quic_mkshah@quicinc.com>
Cc:     ulf.hansson@linaro.org, dianders@chromium.org, swboyd@chromium.org,
        wingers@google.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_lsrao@quicinc.com,
        quic_rjendra@quicinc.com
Subject: Re: [PATCH 0/1] Use PSCI OS initiated mode for sc7280
Message-ID: <20230227153848.auqs4e5hf2qmwmg2@ripper>
References: <20230215071649.9078-1-quic_mkshah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215071649.9078-1-quic_mkshah@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 12:46:48PM +0530, Maulik Shah wrote:
> This change adds power-domains for cpuidle states to use PSCI OS
> initiated mode for sc7280.
> 
> This change depends on external project changes [1] & [2] which are under
> review/discussion to add PSCI os-initiated support in Arm Trusted Firmware.
> 
> I can update here once the dependency are in and change is ready to merge.
> 

Please do, I will drop this from the queue for now.

Thanks,
Bjorn

> [1] https://review.trustedfirmware.org/q/topic:psci-osi
> [2] https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/19487
> 
> Maulik Shah (1):
>   arm64: dts: qcom: sc7280: Add power-domains for cpuidle states
> 
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 96 +++++++++++++++++++++-------
>  1 file changed, 72 insertions(+), 24 deletions(-)
> 
> -- 
> 2.17.1
> 
