Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C35658FC2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbiL2RY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbiL2RYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:24:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DDC15F02;
        Thu, 29 Dec 2022 09:24:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 474A0B81A1A;
        Thu, 29 Dec 2022 17:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23670C43392;
        Thu, 29 Dec 2022 17:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672334639;
        bh=IsBgGd6yYUI12H3NgKcjge8lmTz7gfIijYVByG0cous=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ljnkKKyt4Cd2nemyk9Ow0lDKXb+O/+LICKLaW8cRuCMW2u+fbvXfvCQoFdavmmX32
         l/vSoHkbJgfJtvwT1fNLJ5LOnUPuZExCancmwHxZMnAF3+uhdpu6/diuKyU8NWDKna
         SioL7FOUNftl/TJWMCqhbYAkJ7u0xCxicDFBMzQeTah54nrw2C9pe77xyokv+JrXzB
         cxJUIP1VP/kEKdTL6xAIaJoC6EufrcF6G9Ys54kQvduVYKnOnUTyPlQePg/W5T4kge
         KrT6TJ5F7cYXDsv+e14Sxm45lSEdW89uEXNgQPwI4Q5cSUrC+u+929QSGWi0iEoRhH
         D7+txskQ2NX5w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     phone-devel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        martin.botka@somainline.org, jami.kettunen@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        angelogioacchino.delregno@somainline.org, konrad.dybcio@linaro.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sm6350-lena: Flatten gpio-keys pinctrl state
Date:   Thu, 29 Dec 2022 11:23:37 -0600
Message-Id: <167233461767.1099840.14493618735670025270.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221222215906.324092-1-marijn.suijten@somainline.org>
References: <20221222215906.324092-1-marijn.suijten@somainline.org>
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

On Thu, 22 Dec 2022 22:59:06 +0100, Marijn Suijten wrote:
> Pinctrl states typically collate multiple related pins.  In the case of
> gpio-keys there's no hardware-defined relation at all except all pins
> representing a key; and especially on Sony's lena board there's only one
> pin regardless. Flatten it similar to other boards [1].
> 
> As a drive-by fix, clean up the label string.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sm6350-lena: Flatten gpio-keys pinctrl state
      commit: a40f5ae1ea64ab9e981faf47c31817dc4d7923e4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
