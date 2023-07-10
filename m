Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194F674CBBE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjGJFF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjGJFFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:05:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C5D10E9;
        Sun,  9 Jul 2023 22:04:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE8A360B71;
        Mon, 10 Jul 2023 05:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60314C433CA;
        Mon, 10 Jul 2023 05:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965480;
        bh=LZ/lpmSlzwoPUpiKbFv8QetZfYHvoTAq4CIsh0Ksz70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SvjGN390fTtEZ/40sDZRpMv3f8mwmrlmQJ0YHi5DJUXO7rk2th1Sl9rgOwqyqcArt
         AxI3ewJ6o1VFNWARtdkaRdJ373zrZxLj/NfYBrewH1Tp2twmYjZJstzte/gvagMQK3
         V+KJR/UnakEjqmu+V5YfCiGOaE8iFgK7qSFcOQWa/vUUzosK/Jw/5FO1lhPF69Id2r
         6ihdC1h/cnd4JtKc/zVygHckaAgFmQG70ld4YxSvHd3qO59fl8AgGfx1Eyk2SAlkU0
         qW5XdQYbbEUpT2j6Gg837HPP+G2XGgOxbbjc4yFykdV94SULMgvsEvB+N80GXE7UOK
         tDHYd8RjtYzsw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8350: Use proper CPU compatibles
Date:   Sun,  9 Jul 2023 22:07:20 -0700
Message-ID: <168896565990.1376307.14629293439452030793.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706-topic-sm8350-cpu-compat-v1-1-f8d6a1869781@linaro.org>
References: <20230706-topic-sm8350-cpu-compat-v1-1-f8d6a1869781@linaro.org>
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


On Thu, 06 Jul 2023 18:35:37 +0200, Konrad Dybcio wrote:
> The Kryo names (once again) turned out to be fake. The CPUs report:
> 
> 0x412fd050 (CA55 r2p0) (0 - 3)
> 0x411fd410 (CA78 r1p1) (4 - 6)
> 0x411fd440 (CX1  r1p1) (7)
> 
> Use the compatibles that reflect that.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sm8350: Use proper CPU compatibles
      commit: 4390730cc12af25f7c997f477795f5f4200149c0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
