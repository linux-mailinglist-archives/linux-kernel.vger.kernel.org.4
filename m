Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C0B6C4E27
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjCVOn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjCVOm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:42:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B350C6701D;
        Wed, 22 Mar 2023 07:42:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B698B81D1A;
        Wed, 22 Mar 2023 14:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB5EC4331E;
        Wed, 22 Mar 2023 14:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679496134;
        bh=QBKh08SzPBX7n8/6sa/QdvNoUoFa4e0PDHjVrkK26ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b8uPWnYah50GVlgumNc+o0PtRQebRaB14WxPcy6V3+seftN25cJarTCHwzw4nW0Df
         pg3IY6Q6oVDEEWzsgAMwvd5qJ1hLtjZp65DB3d6I7oC7PaXcYlCqzx8Ql3d8FUqEgs
         n+nkQ8k7M6QD/bqpd1yLBhGD325JIq/RPfv4F5tRKBR/Jd7PSnmJEhfZroj5eW0Be9
         1Z+eMXE8C26TYipSFtWSroCl6U51XrOYABTXvOX+u7VY5kH7Y/tPCsssw0l3DXje0T
         s3tWbsprHnYlOn6nXkV1dFkuaGsuyDTpNrvzqfiYo3JFP1RhntlIxlxaTEpuyeT/6G
         3DtWSrIb9/srg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v5 0/9] arm64: dts: qcom: sa8775p-ride: enable relevant QUPv3 IPs
Date:   Wed, 22 Mar 2023 07:45:04 -0700
Message-Id: <167949631652.1081726.12219408780857323357.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309103752.173541-1-brgl@bgdev.pl>
References: <20230309103752.173541-1-brgl@bgdev.pl>
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

On Thu, 9 Mar 2023 11:37:43 +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> This enables the QUPv3 interfaces that are exposed on the sa8775p-ride
> board: I2C, SPI and the Bluetooth and GNSS UART ports.
> 
> v4 -> v5:
> - remove board-specific interrupt from UART17 in SoC dtsi
> - rearrange node properties to have various *-cells properties come right
>   before status
> - collect more tags
> 
> [...]

Applied, thanks!

[1/9] arm64: dts: qcom: sa8775p: add the QUPv3 #2 node
      commit: dc3ad22112de7fe76352ef2aa2943b62eb1836a3
[2/9] arm64: dts: qcom: sa8775p-ride: enable QUPv3 #2
      commit: 4926a8e93f321760fa265f91d78aa2a2163e222b
[3/9] arm64: dts: qcom: sa8775p: add the i2c18 node
      commit: a23d122572a4ad1292e60d4a87e6f0238aaa0505
[4/9] arm64: dts: qcom: sa8775p-ride: enable i2c18
      commit: 12f35f74ad6da53d94fcbc1bbb2adff60b31a71f
[5/9] arm64: dts: qcom: sa8775p: add the spi16 node
      commit: cfd975f588400e0942d55dc4bb84c12c6f217fb4
[6/9] arm64: dts: qcom: sa8775p-ride: enable the SPI node
      commit: a3b31b0e0f76326bfa4bc81577f52738ad8e072b
[7/9] arm64: dts: qcom: sa8775p: add high-speed UART nodes
      commit: 41ae5ca448c21a82a2f07e10954b043a0d45a811
[8/9] arm64: dts: qcom: sa8775p-ride: enable the GNSS UART port
      commit: 4b6c4249069694a593f3b4c3d81c75a5053b7693
[9/9] arm64: dts: qcom: sa8775p-ride: enable the BT UART port
      commit: e1988af7a646aafe8075b179c00fd8053ced2add

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
