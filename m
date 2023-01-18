Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7E4672D34
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjARX4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjARX4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:56:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464284ABCC;
        Wed, 18 Jan 2023 15:56:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D48C7B81FA0;
        Wed, 18 Jan 2023 23:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336EAC433F0;
        Wed, 18 Jan 2023 23:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674086157;
        bh=A1ubqZXFOcnpFews4eu0oa3vCuuFB6B8Nu+k8/uxFiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VYBmgR7Uxqe0vk+eVjZVeJmJ0g6aCCZG1Td8iQdvz1Bbp+zpAEX43Kajhre2Cpyov
         9kJi0Ql3zDdEP+73xu77EJjeWp98qLzzwFd5wUtgis67subIWoCSRky+C4VASPiyC/
         6W4MwovN1/ERuxeG8svbYGM8e3Nosc7Wn0R4gbE1FCqdkARxA3MOFewl0ByoiDB0we
         SvT98a1RAaAyunMJST2YWBurKbPoiVZp/sqZf7aQKji87hrTHsKxEX56EeUl6KB+3Y
         L8fX0m6oSBLDHcFgNCIVa6YpzxJfMnQL5flM9ttbTeZ1YY+CUxy8R35ZgsQhDYb65e
         D+g4Cpisq2Hqg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     quic_pkondeti@quicinc.com, abel.vesa@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] arm64: dts: qcom: sm8550: fix xo clock source in cpufreq-hw node
Date:   Wed, 18 Jan 2023 17:55:41 -0600
Message-Id: <167408614065.2989059.9369460744171738991.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230117093533.3710000-1-quic_pkondeti@quicinc.com>
References: <20230117091446.GA3704192@hu-pkondeti-hyd.qualcomm.com> <20230117093533.3710000-1-quic_pkondeti@quicinc.com>
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

On Tue, 17 Jan 2023 15:05:33 +0530, Pavankumar Kondeti wrote:
> Currently, available frequencies for all CPUs are appearing as 2x
> of the actual frequencies. Use xo clock source as bi_tcxo in the
> cpufreq-hw node to fix this.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8550: fix xo clock source in cpufreq-hw node
      commit: 66129812050b17567c3447c34f797c32a575be30

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
