Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A2C60F863
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbiJ0NFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbiJ0NFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:05:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03A85317CF;
        Thu, 27 Oct 2022 06:05:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F0B423A;
        Thu, 27 Oct 2022 06:05:26 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 567363F7B4;
        Thu, 27 Oct 2022 06:05:18 -0700 (PDT)
Date:   Thu, 27 Oct 2022 14:05:15 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8250: Disable the not yet supported
 cluster idle state
Message-ID: <20221027130515.uixhr4a7axmvtabe@bogus>
References: <20221027115745.240516-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027115745.240516-1-ulf.hansson@linaro.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 01:57:45PM +0200, Ulf Hansson wrote:
> To support the deeper cluster idle state for sm8250 platforms, some
> additional synchronization is needed between the rpmh-rsc device and the
> CPU cluster PM domain. Until that is supported, let's disable the cluster
> idle state.
> 
> This fixes a problem that has been reported for the Qcom RB5 platform (see
> below), but most likely other sm8250 platforms suffers from similar issues,
> so let's make the fix generic for sm8250.
> 
> vreg_l11c_3p3: failed to enable: -ETIMEDOUT
> qcom-rpmh-regulator 18200000.rsc:pm8150l-rpmh-regulators: ldo11: devm_regulator_register() failed, ret=-110
> qcom-rpmh-regulator: probe of 18200000.rsc:pm8150l-rpmh-regulators failed with error -110
> 
> Reported-by: Amit Pundir <amit.pundir@linaro.org>
> Fixes: 32bc936d7321 ("arm64: dts: qcom: sm8250: Add cpuidle states")

Thanks for the patience and fixing it this way :). I take it is only the
cluster states that has the issue because [1] only disables the CPU level
states which was confusing and I had asked the same.

Anyways for this,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
