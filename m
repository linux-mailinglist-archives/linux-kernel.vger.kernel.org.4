Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA232623AE1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 05:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbiKJEJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 23:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbiKJEJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 23:09:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E729229346;
        Wed,  9 Nov 2022 20:09:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C941B820C6;
        Thu, 10 Nov 2022 04:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782EFC433C1;
        Thu, 10 Nov 2022 04:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668053360;
        bh=GL91r0QnIOcubxlJy+F4wLaiGK3WMThPQ1RrboIlEXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ki/IWRkhR3se+Obw9sDj48JQU3UD96vBuiYidfvS75dpg8mS5yWuHKfc8yliO+ICi
         Cr3CqFiu4vZWPwQ88qAPLbokXejiFQvhxeZDYN7BGUrRi0S9XUSpDVMs5qtpZrhLny
         N39BCXtETzSi/WGfmfb4Xr9tP63Ltg1lC2146rGqh5+J71WvUbQwAPGh5fnpSIge0z
         QkPtO02f+eyQNLhdMbvCg1ad5k+xgGKnPSeggLo4vDTW8ODBpeNGFRVsOlwON0wTpj
         safDNJZmsq9QWv/1+9yVos9UKcZrt5HsHoLvDQHFgdhIzv9fUKZ6MpH94aF+SGzuZn
         w3zbShC7WAdTA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@somainline.org,
        ulf.hansson@linaro.org
Cc:     quic_rjendra@quicinc.com, sudeep.holla@arm.com,
        quic_mkshah@quicinc.com, dmitry.baryshkov@linaro.org,
        linux-arm-msm@vger.kernel.org, amit.pundir@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v3 0/6] soc: qcom: Add APSS RSC to the CPU cluster PM domain
Date:   Wed,  9 Nov 2022 22:09:12 -0600
Message-Id: <166805334839.800572.7879483288918799032.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221018152837.619426-1-ulf.hansson@linaro.org>
References: <20221018152837.619426-1-ulf.hansson@linaro.org>
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

On Tue, 18 Oct 2022 17:28:31 +0200, Ulf Hansson wrote:
> Changes in v3:
> 	- Re-worked the genpd patch (patch4) and updated the commit-msg.
> 	- No other changes.
> 
> The APSS RSC is a part of the CPU cluster PM domain and it's responsible for
> flushing 'sleep' and 'wake' votes to avoid wasting energy. In particular, this
> needs to be done when last CPU in the cluster enters a deeper idlestate.
> 
> [...]

Applied, thanks!

[3/6] arm64: dts: qcom: Add power-domains property for apps_rsc
      commit: 2ffa0ca4d37a1fef0b423f32007067fbce8708a3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
