Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3141E6DB3C0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjDGS5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbjDGS46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:56:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B9CD510;
        Fri,  7 Apr 2023 11:54:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FD1D61219;
        Fri,  7 Apr 2023 18:49:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83AEC4339E;
        Fri,  7 Apr 2023 18:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680893348;
        bh=6yx3kBkzOOFOIXrZ5IlOXinROnMpeUBN2SLNMieLd0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G7UiPTGKJVLey1Y31us6wLu6kINwZhvkpdpBmbqsngHbe2RUmy5IyYmcw4w9n4mGz
         JTIujWy4c9nO48ZPu1oB0DjRcj1WIs7a3PTSCRMdqzkOsR23424wOL8IJYxo1qe5LM
         xKQCmZuuyAmHAps61p9IXqSpWMBd7nnjjnIiqTu3m1MHZmf0uJgw5ky2G3JNkeppYP
         7jTOYLiPsg24b/EFWV98/bu42dwHYiRz9xRcFMMnp/ddNtNpP2BV7TTTESXM6UzF0z
         mOKsgAgbPH+id1BL+3Cr72niYRjcO9GQqvMQxvov03i5DyQCpatBmRhlYY0hRiplWZ
         L8ir50CiwOSuA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     tony.luck@intel.com, kishon@kernel.org, keescook@chromium.org,
        Lux Aliaga <they@mint.lgbt>, konrad.dybcio@linaro.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, vkoul@kernel.org,
        agross@kernel.org, gpiccoli@igalia.com, bvanassche@acm.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        martin.botka@somainline.org, linux-phy@lists.infradead.org,
        linux-hardening@vger.kernel.org, marijn.suijten@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v7 0/6] arm64: dts: qcom: sm6125: UFS and xiaomi-laurel-sprout support
Date:   Fri,  7 Apr 2023 11:51:55 -0700
Message-Id: <168089350725.2675207.12664655613060591288.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306170817.3806-1-they@mint.lgbt>
References: <20230306170817.3806-1-they@mint.lgbt>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2023 14:08:10 -0300, Lux Aliaga wrote:
> Introduce Universal Flash Storage support on SM6125 and add support for the Xiaomi Mi A3 based on the former platform.
> 
> Changes since v6:
> - Add struct for v3-660 UFS PHY offsets and replace the v5 offsets in sm6115 UFS PHY config to these
> - Set ufs_mem_phy reg size to 0xdb8 in sm6125.dtsi
> - Drop "#address-cells" and "#size-cells" properties on reserved-memory node in xiaomi-laurel-sprout dts
> - Move "status" last on &pon_resin node in xiaomi-laurel-sprout dts
> - Modify "&pm6125_gpio" pointer to "&pm6125_gpios" in xiaomi-laurel-sprout dts
> 
> [...]

Applied, thanks!

[4/6] arm64: dts: qcom: sm6125: Add UFS nodes
      commit: f8399e8a2f80adfac2e7f5dbe223eb428fdb6fe9
[6/6] arm64: dts: qcom: sm6125: Initial support for xiaomi-laurel-sprout
      commit: b76c8ceabe871470cee17990289e8dd39b96054e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
