Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E8E61FABD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbiKGRBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbiKGRBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:01:38 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C810313F79;
        Mon,  7 Nov 2022 09:01:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4185DCE1251;
        Mon,  7 Nov 2022 17:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B701C433D6;
        Mon,  7 Nov 2022 17:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667840490;
        bh=hW5HtiavKKhLFU331tKVF7/anr69KqLCpM+j22XixYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b0zIqaS0xIq/OBWnOkpyn8etuR61EBqu2RrxTm6GumqVLDZAvEPQ8pkFT7QG3DqPq
         hkhUbylzwPInHc5X7CQ6UpA44i2QvIn7L74F4VKc27J4bbfYnLfVSkd+yo/e5i3V56
         HRuUo6ye+NcGIkPNkvLQd0JDlXz6UV3CaldqGvxJSIzcRaX/7MtXgo9wwi5l2DFRri
         bqvXnl1yTxbZscpI4yGWQqZgepqVRPLMzH/lJZi7YST+skd/1Ln3ewgoJ8ERKhMkf1
         6K2cSawGbleCoVCDDAD5F2AMJh61zDLafJUR1A3/ErnIDB7jg0XfLHAOhIU6CDhIDt
         q3emBuqb5ifLA==
Date:   Mon, 7 Nov 2022 11:01:27 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     kernel test robot <lkp@intel.com>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        kbuild-all@lists.01.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] soc: qcom: rpmh-rsc: Write CONTROL_TCS with next
 timer wakeup
Message-ID: <20221107170127.i5bfkx45egaf2oh4@builder.lan>
References: <20221018152837.619426-7-ulf.hansson@linaro.org>
 <202210190144.WIiituiJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210190144.WIiituiJ-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 01:47:17AM +0800, kernel test robot wrote:
[..]
>    155	#define USECS_TO_CYCLES(time_usecs)			\
>    156		xloops_to_cycles((time_usecs) * 0x10C7UL)
>    157	
>    158	static inline unsigned long xloops_to_cycles(unsigned long xloops)

Any objections to me changing the type to u64 while applying the
patches?

Regards,
Bjorn

>    159	{
>  > 160		return (xloops * loops_per_jiffy * HZ) >> 32;
>    161	}
>    162	
