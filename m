Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84B568FE85
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjBIEXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjBIEXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:23:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959A71A97E;
        Wed,  8 Feb 2023 20:23:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C69E6B81FF8;
        Thu,  9 Feb 2023 04:21:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97426C433A0;
        Thu,  9 Feb 2023 04:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916483;
        bh=0PgbM3kYQO8jc3WOdfmAKdwSdWho7Szv9Q19Z52L5PA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L6Lx6EIDPvHFyQk18gV8uUCsaB7x9LrObM13sDMkT4iDAEwhofAgS0q1/JTEG7Y9y
         oCgAnT6C3JpV9ulW9eqQOwM6POaIE/qlgEjq8Rc8AfDf7zA1iwNUsdiBJAxP6IMM+/
         MK87/at1PqQfiyV4XkNINbSn7xpGtL3exWPJuh40TAqvl4LEKovjGtiuI2cuXct12s
         9d9Bcq9zHmXwCvuA/a32a7xAC+t7FaG/x1BEURnq82QfCKovt/0KexvJJsxuIcCnpA
         I4r+qxQ4BjlkKecleIiaebQXIf/yocxwRLkta1CIlgeqYUwMA/62D1wdEb0UbTRtQh
         7bN9tkhFtrFUA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     konrad.dybcio@linaro.org, agross@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com
Subject: Re: [PATCH v2] arm64: dts: qcom: sm6115: Add geni debug uart node for qup0
Date:   Wed,  8 Feb 2023 20:22:41 -0800
Message-Id: <167591660364.1230100.17186702813217007552.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208122718.338545-1-bhupesh.sharma@linaro.org>
References: <20230208122718.338545-1-bhupesh.sharma@linaro.org>
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

On Wed, 8 Feb 2023 17:57:18 +0530, Bhupesh Sharma wrote:
> qup0 on sm6115 / sm4250 has 6 SEs, with SE4 as debug uart.
> Add the debug uart node in sm6115 dtsi file.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm6115: Add geni debug uart node for qup0
      commit: 25aab0b852d63784586ed99148d9af37a820a0c8

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
