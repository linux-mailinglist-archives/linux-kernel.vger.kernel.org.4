Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090106CFFE9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 11:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjC3JiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 05:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjC3JiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:38:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1809E4204;
        Thu, 30 Mar 2023 02:38:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D5292F4;
        Thu, 30 Mar 2023 02:38:57 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3851C3F663;
        Thu, 30 Mar 2023 02:38:11 -0700 (PDT)
Date:   Thu, 30 Mar 2023 10:38:08 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Maulik Shah <quic_mkshah@quicinc.com>
Cc:     andersson@kernel.org, ulf.hansson@linaro.org,
        dianders@chromium.org, Sudeep Holla <sudeep.holla@arm.com>,
        swboyd@chromium.org, wingers@google.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, jwerner@chromium.org,
        quic_lsrao@quicinc.com, quic_rjendra@quicinc.com
Subject: Re: [PATCH v2 0/2] Use PSCI OS initiated mode for sc7280
Message-ID: <20230330093808.iytdskjjawgnvu23@bogus>
References: <20230330084250.32600-1-quic_mkshah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330084250.32600-1-quic_mkshah@quicinc.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 02:12:48PM +0530, Maulik Shah wrote:
> Changes in v2:
> - Add new change to Move enabling OSI mode after power domains creation
> - Fix compatible string to domains-idle-states for cluster idle state.
> - Update cover letter with some more details on OSI and PC mode comparision
> 
> The dependency [2] is now merged in trustedfirmware project.
> 
> Stats comparision between OSI and PC mode are captured at [3] with usecase
> details, where during multiple CPUs online the residency in cluster idle
> state is better with OSI and also inline with single CPU mode. In PC mode
> with multiple CPUs cluster idle state residency is dropping compare to
> single CPU mode.
> 
> Recording of this meeting is also available at [4].
> 
> This change adds power-domains for cpuidle states to use PSCI OS
> initiated mode for sc7280.
> 
> This change depends on external project changes [1] & [2] which are
> under review/discussion to add PSCI os-initiated support in Arm Trusted
> Firmware.
>

I will wait for your response to understand the issue in 1/2. If it is
firmware issue, I prefer we fix it in the firmware and no quirks or work
around for this in the kernel while it is still fresh out of oven.

-- 
Regards,
Sudeep
