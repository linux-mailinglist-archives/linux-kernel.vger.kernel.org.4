Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876DC644B5C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiLFSVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiLFSUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:20:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0161223BDC;
        Tue,  6 Dec 2022 10:20:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF99EB819F3;
        Tue,  6 Dec 2022 18:19:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FE4C43143;
        Tue,  6 Dec 2022 18:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350798;
        bh=zdK1cABvoMSZCkV2mvUDQYW8mi7UDt6Ua0y7YXwGPTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SH67hgLWG81o8ZZIA62oClGnuXl5KLcXM0zcQ6RKEeepIKNJVBsy6uDcQB232xhB6
         hGJSvX3U9ZSNwIRbatzl5n+NhUKtRXFuq2d6fsrV2JnyRqTUq8Rx8mcDu8GDd0RzQ+
         cjyZd+ILuJd+gYYp+HYeAhGRoanbWyqGW6PRk/dEYCe4Hr5AtidY3z4B0hT63z+YKz
         osm6Zc9KekoxNuftc3393nk6bvHWgxcm2c2S2FXYQYbFvrDbOmqBJJpo1VzSf3p5sp
         7aeYoVE2LWbO12/YVx/pUkVf5uBBBj39mkrKdbh5hHs5tw8dIQZZKJZ6ZR04LepGXo
         LJ50Rg/zQs4hg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski@linaro.org
Cc:     robh+dt@kernel.org, konrad.dybcio@somainline.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, patches@linaro.org
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: sm8450: Use defines for power domain indices
Date:   Tue,  6 Dec 2022 12:19:02 -0600
Message-Id: <167035076334.3155086.6449098314714737683.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221115130936.6830-1-konrad.dybcio@linaro.org>
References: <20221115130936.6830-1-konrad.dybcio@linaro.org>
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

On Tue, 15 Nov 2022 14:09:35 +0100, Konrad Dybcio wrote:
> Use the defines from qcom-rpmpd.h instead of bare numbers for
> readability.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sm8450: Use defines for power domain indices
      commit: 3d530a0f4c43d7a31bf723363e4ea2edd883e035
[2/2] arm64: dts: qcom: sm8150: Use defines for power domain indices
      commit: a94ed9f38e49e7a459725340e630d87e194c814a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
