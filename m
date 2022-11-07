Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027BA61E970
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiKGDP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbiKGDOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:14:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEAA1274E;
        Sun,  6 Nov 2022 19:13:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1EA360E86;
        Mon,  7 Nov 2022 03:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C18C433C1;
        Mon,  7 Nov 2022 03:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790798;
        bh=83GTRwlu2gfkliGEqQF2Jq2R0k3r5oQOl17bVJ75hYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZAUgntmTZ6ZagkN2nl/qLfIe0eEP0mJfKU442374fK7EldL2oKVtmSANQN3n7IIOm
         JHQT9evyNRHxjWotF0z2l0hfxw2U2Ud1HF4hGARi9vGTjEW140oMPcXrs+aqC+OSii
         64I2sHrIUCGMgq/VjcrGVhh9pcekoh9vGJwvUO0QvMlchfNh0mDYmC1qsry8ZlYm/A
         JXYThVFB+mgW0BoL5qgWMzKOVD0QdSEoHJDzuZeUeJRHyf0Lp7cWv6ttsx/fOdAxm7
         57gjdv2wUdBJX99dtfAWtrSQo7SCKRdZSwxwU59uM5aLsLgUIrSCXDjxXQUr2LUmWa
         4sVmcUZM93EzQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, ulf.hansson@linaro.org,
        konrad.dybcio@somainline.org
Cc:     dmitry.baryshkov@linaro.org, sudeep.holla@arm.com,
        quic_mkshah@quicinc.com, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        amit.pundir@linaro.org, quic_rjendra@quicinc.com
Subject: Re: [PATCH] arm64: dts: qcom: sm8250: Disable the not yet supported cluster idle state
Date:   Sun,  6 Nov 2022 21:12:34 -0600
Message-Id: <166779074268.500303.10369639779721394913.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221027115745.240516-1-ulf.hansson@linaro.org>
References: <20221027115745.240516-1-ulf.hansson@linaro.org>
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

On Thu, 27 Oct 2022 13:57:45 +0200, Ulf Hansson wrote:
> To support the deeper cluster idle state for sm8250 platforms, some
> additional synchronization is needed between the rpmh-rsc device and the
> CPU cluster PM domain. Until that is supported, let's disable the cluster
> idle state.
> 
> This fixes a problem that has been reported for the Qcom RB5 platform (see
> below), but most likely other sm8250 platforms suffers from similar issues,
> so let's make the fix generic for sm8250.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sm8250: Disable the not yet supported cluster idle state
      commit: 5c7fa5de12a31c1425cc87ba2ef27e6ae0a1788c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
