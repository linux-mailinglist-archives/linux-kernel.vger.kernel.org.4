Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6327C70D1F6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbjEWC7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjEWC7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:59:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BD0CA;
        Mon, 22 May 2023 19:59:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9179162E66;
        Tue, 23 May 2023 02:59:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333FAC433EF;
        Tue, 23 May 2023 02:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684810770;
        bh=DA3Uj4Jl/Zw7nwH8jERldx4u4Btolqs/ALOoYkfcr2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PEcQkErVoVEYjaF2ZbUXkSujT/jrNY4yiTXKObVKvNSFkSFCRlWGqiyyaT6SPEKvs
         C94azMM3iBBjm7olymFkM7xjvvXQOOrwfJeDH/7A7dQ4lCD91o0wi8IlAR1SkjOIK7
         dUyXteoNDb9AVoWQtW6LeUpVwy59ttg4vBHFqEaLvkVF8DUxcuIHQLFS3FHwRk0RHW
         UUF8Vry4APyZsNzj/sxAom0QD6JwYXxiY0jB/1HAiK1puiPbaXLRc++/sLcQV8yVth
         OY6FZTDhapOhRAp/JYeD4tPR+cOuJTpfVzN0EeDAeBCquVxfsik4v93j49IBXll4LZ
         basEWXzKo8r6Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: Re: [PATCH] arm64: dts: qcom: sm6375-pdx225: Fix remoteproc firmware paths
Date:   Mon, 22 May 2023 20:03:18 -0700
Message-Id: <168481094822.1229550.2578857722922936417.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230517-topic-murray-fwname-v1-1-923e87312249@linaro.org>
References: <20230517-topic-murray-fwname-v1-1-923e87312249@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 19:06:13 +0200, Konrad Dybcio wrote:
> They were previously missing the SoC name. Fix it.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm6375-pdx225: Fix remoteproc firmware paths
      commit: a14da6144d16ef27e3022835fa282a3740b8ad7b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
