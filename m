Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2845700C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 17:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241944AbjELPnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 11:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241907AbjELPnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 11:43:02 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1627440CF;
        Fri, 12 May 2023 08:43:02 -0700 (PDT)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 8F364CEE75;
        Fri, 12 May 2023 15:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1683906180; bh=Fid7yfw9t/u6WzqpvkhxPRW/PgqKY+ilcqxq2iSSnso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=byb3Azt5b60NPc42TTCeq14cYY8E3/f0ATm/iJ5NNlh0zmNouIpxr4JKo9V1VPcub
         awwwpN65xGFSP1+H9VAg39LNFrTRl9eM5/P15+EwjsBU4ZC2DRFTazF06TjvCwkeVM
         r1XUuxrIygGXw6fB7o1HRFi0c5eQiBSWfj4lHmx4=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexey Minnekhanov <alexeymin@postmarketos.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: Add BLSP DMAs for I2C
Date:   Fri, 12 May 2023 17:42:59 +0200
Message-ID: <7012043.lOV4Wx5bFT@z3ntu.xyz>
In-Reply-To: <ee580939-8334-4d86-e01b-54c6fd0b2f42@postmarketos.org>
References: <20230422-msm8953-blsp-dma-v1-1-0024801bb587@z3ntu.xyz>
 <ee580939-8334-4d86-e01b-54c6fd0b2f42@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Freitag, 12. Mai 2023 12:14:29 CEST Alexey Minnekhanov wrote:
> On 22.04.2023 14:39, Luca Weiss wrote:
> > MSM8953 has two DMA controllers for the various I2C, SPI and UART
> > busses. Add the nodes and configure all the I2C nodes so that the driver
> > can use the DMA.
> > 
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> > 
> >   arch/arm64/boot/dts/qcom/msm8953.dtsi | 48
> >   +++++++++++++++++++++++++++++++++++ 1 file changed, 48 insertions(+)
> 
> Hello,
> 
>  > arm64: dts: qcom: Add BLSP DMAs for I2C
> 
> to all qcom boards? Or only for msm8953? Commit title is unclear.

Right, missed "msm8953: " in the subject ;)

Thanks for catching that!



