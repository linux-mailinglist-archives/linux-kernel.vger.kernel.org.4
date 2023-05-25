Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11AE71046C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239308AbjEYExC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239085AbjEYEv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:51:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F7EE70;
        Wed, 24 May 2023 21:51:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D83CF6429E;
        Thu, 25 May 2023 04:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915E4C433A0;
        Thu, 25 May 2023 04:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990276;
        bh=7GrGCzTzY/SncgUFUFx2EG0zdqHZYnCycMbZlXmIvOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=htQmueNw3flGfEQWV2T32cPBqbmJuOO0VbvxBTD9QhenqW1kHLHjGAEtPOxlDDnZC
         RZTz+I35bfdHXoihUIPlP2SlG8sYotWdNi3VemdDm2UCDRgj4VNawXPSXDEGtWSWKO
         /jdImrZh+jFm+/Y5clrXC6GwOL7AUV4x1cpktaYmt8uFylb+v2k9gZW7zVEgiHy2+v
         el8Cwsmy/NNKpbE42CI1rn+TNruJhSk0UBbohiQfGDCC3ETiumFLeysQ4hEtPNibUn
         5rVJvhJv5PA18t4JHJfObQcsivPGnqVvshXsYtTzpgTIoItvPiT/JTC59kBChmN6y6
         gRjA4CJKLzriA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        marijn.suijten@somainline.org, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sm8450: Add missing RPMhPD OPP levels
Date:   Wed, 24 May 2023 21:53:56 -0700
Message-Id: <168499048185.3998961.2730731545280452176.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516005306.952821-1-konrad.dybcio@linaro.org>
References: <20230516005306.952821-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 02:53:06 +0200, Konrad Dybcio wrote:
> We need more granularity for things like the GPU. Add the missing levels.
> 
> This unfortunately requires some re-indexing, resulting in an ugly diff.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8450: Add missing RPMhPD OPP levels
      commit: ec8bb9c5b1c6963db3ed09e4a9148ae85804b962

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
