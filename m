Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F2868FF14
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjBIEch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjBIEbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:31:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52453FF1E;
        Wed,  8 Feb 2023 20:31:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5ADCB82006;
        Thu,  9 Feb 2023 04:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D1BC4339E;
        Thu,  9 Feb 2023 04:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916504;
        bh=3nWlu+c3LMBMPNGVqPmzxeNkjgxbGmSJFEnr8rH4Xo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nyy9sv4nNB9V7YuLEmhRzDe2A3RBFRah3axQf1azXLx4/Sn9W4XxAlyOcxOwId3kH
         8qJ9G0PrX9pKlEBJ0zICnDfqFsAEdQPNGa7+Dn9Br/xDOQfVDG3opQR8PKK/54rCZt
         +Jckv/Uo9I0PC3nivcnEl6FtAQuK7oXYz0zvbwazjGvboOqNyysNDQ+JMTvOj/RWHm
         ajmxkO9BGF7g2S3E3h8UJsyJvHlyMbNokl3rfc6u0CDTaFdbXYBmS5z5hRcoOjGxqI
         ADRNBSFoCXN6pnbCR0fg8LobaNBoE84phJpjfnULY/tb4T3PdAqDnj/WsUlOCL1xRi
         m8QL0XzFw2u5w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, krzysztof.kozlowski@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        marijn.suijten@somainline.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: sm8450: Fix DSIn PHY compatible
Date:   Wed,  8 Feb 2023 20:23:00 -0800
Message-Id: <167591660366.1230100.15055308817797224998.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230123200552.553181-1-konrad.dybcio@linaro.org>
References: <20230123200552.553181-1-konrad.dybcio@linaro.org>
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

On Mon, 23 Jan 2023 21:05:52 +0100, Konrad Dybcio wrote:
> Use the correct compatible so that the driver can probe properly.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8450: Fix DSIn PHY compatible
      commit: cce9c1d0b0168a08a3fe49bed6ac78731c69914c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
