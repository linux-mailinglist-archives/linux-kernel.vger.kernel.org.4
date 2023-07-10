Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A1674CB9B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjGJFEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjGJFEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:04:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC4918B;
        Sun,  9 Jul 2023 22:04:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF79D60DE5;
        Mon, 10 Jul 2023 05:04:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C82C4339A;
        Mon, 10 Jul 2023 05:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965470;
        bh=XzxrupZYEg5u91fplxhzGIaOik6b6dGRQ+uQNsA8vpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SdJpQpSHA/I2lANUo8J/L+g5OOvUj+gKyBz7ydD2Mg5I8cN72JtVBim6X00mq13jm
         LYDx+H4hot6UbV7lEIh9NrW1VDsTZymo2pyv6SOv5nJIeR8gReN47A89cS+lSZmihW
         fuMlDQZd34k2N4Hx8ZRi/+M5CiiVrhrHzM6UlFOOE1p3FiX32v7wOvefnTGyvmQ7uz
         IHG4yK09A5pbfkWzowOLMSN/8EhLf3h2ZKjW5dGG+TFKYKNO0SHzF77X+ESllHeMMS
         EDCB3YcYAspRjJgOV5di21weT39HQl7J8XOXuzLQnJ8/vnwXspuY4gxN9orgnlBYIm
         nn4bALF/CvQ+Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] 8250 dma-coherent
Date:   Sun,  9 Jul 2023 22:07:11 -0700
Message-ID: <168896565986.1376307.3057904241066729151.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230704-topic-8250_pcie_dmac-v1-0-799603a980b0@linaro.org>
References: <20230704-topic-8250_pcie_dmac-v1-0-799603a980b0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 04 Jul 2023 14:23:16 +0200, Konrad Dybcio wrote:
> SMMUs and PCIe hosts on SM8250 are cache-coherent. Mark them as such.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sm8250: Mark PCIe hosts as DMA coherent
      commit: 339d38a436f30d0f874815eafc7de2257346bf26
[2/2] arm64: dts: qcom: sm8250: Mark SMMUs as DMA coherent
      commit: 4cb19bd7c6329c4702f92c6dd4e7c02eb903ca13

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
