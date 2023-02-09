Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFBE68FF6A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjBIEha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjBIEhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:37:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCD04741E;
        Wed,  8 Feb 2023 20:34:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5635E617F5;
        Thu,  9 Feb 2023 04:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0DBC4339E;
        Thu,  9 Feb 2023 04:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916477;
        bh=+tYT/Xq2RtqEW1dvKjmg73dWzx6E/Mz71aA+fHo49uI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KqzBBWTmEfYQg2DNGDDzo6HAZ45tUZ70IZSnzz+Wylke+inh5h/Sas6xTfwRAkfbw
         4545DpSnqjvrMzooVov/LhXrg59VE2DA+4vL2yYIdcwHUsxOzftmhQkJQtI8O9wuHk
         UgUXaNsFPdAh1JFkX7V4OLeC2xfItZbSdj/BgAXWFKbQAUcqm4y7pJteEFkQazkFne
         ANztR+WsiSv5m/K5eC1Z1tqU5BDjaBm5dB/8P/tgKKhB9S0y96UHHv50OCDJF3nEC4
         ZREcnT7+yxCw1/4c0OYXjhz7fCPdxRhPWLgWp8mRJERtqKg/PQq2+nJ3W2VggQ3PdE
         jj4sgD4Ao0NYA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     konrad.dybcio@linaro.org, quic_shazhuss@quicinc.com,
        agross@kernel.org, devicetree@vger.kernel.org, bmasney@redhat.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH v2 1/2] arm64: dts: qcom: sa8540p-ride: Fix some i2c pinctrl settings
Date:   Wed,  8 Feb 2023 20:22:35 -0800
Message-Id: <167591660368.1230100.10469557592442274107.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230130154823.117542-1-ahalaney@redhat.com>
References: <20230130154823.117542-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2023 09:48:22 -0600, Andrew Halaney wrote:
> Some of the pinctrl groups were invalid for the selected pins. Select
> the proper qup group to fix these warnings:
> 
> [    6.523566] sc8280xp-tlmm f100000.pinctrl: invalid group "gpio135" for function "qup15"
> [    6.535042] sc8280xp-tlmm f100000.pinctrl: invalid group "gpio136" for function "qup15"
> [    6.597536] sc8280xp-tlmm f100000.pinctrl: invalid group "gpio158" for function "qup15"
> [    6.597544] sc8280xp-tlmm f100000.pinctrl: invalid group "gpio159" for function "qup15"
> [    6.597991] sc8280xp-tlmm f100000.pinctrl: invalid group "gpio0" for function "qup15"
> [    6.597996] sc8280xp-tlmm f100000.pinctrl: invalid group "gpio1" for function "qup15"
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: sa8540p-ride: Fix some i2c pinctrl settings
      commit: f187e989305a2d57dc0f750ebb63959151b66924
[2/2] arm64: dts: qcom: sa8540p-ride: Document i2c busses
      commit: f1d6f9d227a0fe887d6a5cc7773425b267e4deff

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
