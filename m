Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75146953CE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 23:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjBMWVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 17:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjBMWVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 17:21:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FFD1C304;
        Mon, 13 Feb 2023 14:21:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90C7BB81993;
        Mon, 13 Feb 2023 22:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76035C4339C;
        Mon, 13 Feb 2023 22:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676326871;
        bh=X9fnuvRLjEf4tZ56Fcx2bwS5wWlvUEOe9Q4aSDX6JJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oK6Yk8aeyF6NbQPz/p65oYOwft1KT04rWXF8IM64s9EoGfDZvLECjYEXUZPmck2oq
         KDnBnrOgKZSXcY9lsRlal6xL7qrXGt4PyHxc6i6E+A9OTAXHLQtmV17hhTSutc537B
         2/1hCWqE4GD+h1K7hlHlRLj4XkxfRRpmcRZ2R10M/tqWxAdWbSaJ/NH1cqQpfuDbC8
         rYwyKD7BCCUSQCj+KO+0b6PuzdREQzBSL+M6EJy4apZdKa+ZwSLUpaHoEh9reMSqG/
         XUk70SlR6ab+4NuRXGCmekMrbQR9sFDafLVsxmAa6Uyt3siw0So5rBs9fG5xpgSQb4
         lVJ4wwRrr3Gww==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Will Deacon <will@kernel.org>
Subject: Re: (subset) [PATCH v4 0/4] arm64: dts: qcom: sc8280xp: Enable external display
Date:   Mon, 13 Feb 2023 14:23:07 -0800
Message-Id: <167632698310.557014.512023772903555933.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213215619.1362566-1-quic_bjorande@quicinc.com>
References: <20230213215619.1362566-1-quic_bjorande@quicinc.com>
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

On Mon, 13 Feb 2023 13:56:15 -0800, Bjorn Andersson wrote:
> This introduces support for external display on the SC8280XP laptops.
> 
> Support for swapping orientation and changing the mode of the SuperSpeed
> lanes is being implemented in the QMP driver, so at this point in time
> this is not supported.
> 
> Bjorn Andersson (4):
>   arm64: dts: qcom: sc8280xp: Add USB-C-related DP blocks
>   arm64: dts: qcom: sc8280xp-crd: Introduce pmic_glink
>   arm64: dts: qcom: sc8280xp-x13s: Enable external display
>   arm64: defconfig: Enable DisplayPort on SC8280XP laptops
> 
> [...]

Applied, thanks!

[4/4] arm64: defconfig: Enable DisplayPort on SC8280XP laptops
      commit: 85d81e15862a95d1a0de5a60f5ac8caba7068b9b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
