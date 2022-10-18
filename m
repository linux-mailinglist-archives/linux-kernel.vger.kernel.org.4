Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFDF602201
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiJRDJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiJRDH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:07:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD44889972;
        Mon, 17 Oct 2022 20:06:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 192D36136C;
        Tue, 18 Oct 2022 03:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B919BC43143;
        Tue, 18 Oct 2022 03:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062416;
        bh=31lfRGStGHv4WO/BVvDNXLMQ8FyKI8OGpuAlLTJAOko=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OKbAGz4VtGlGCo8spmoL3bAYCzXjeuS2353RpEERQo0B4H4QCGq+OLWBuKjN9r5I7
         7kQ/qShQJp22yEkWbbNikKizkf7M+V6AGKxozXvlcfjPpTKVzRA1Jl4H/A2/fmfTEK
         Rb66CM7HlnQp4h8aEn1s7+3H8z1Hbf9MC6pn/Jw/vGRXsuyqM2OGkLqDrM4BxJYdMA
         kAO3YZw+0yqeItXeskjfHKNmCZ48i1WMxoAysqfxtME5kn1cI3Ym8RD299p/Vk1xOR
         Cpj2nh6G0wLXJnrFEJ79JEMAMg1g8X/VX4u60dHmNj/mRkhe0CjCc88ZmuiFsLjAQD
         NlU2HWrE0N7sQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: sm8150: align TLMM pin configuration with DT schema
Date:   Mon, 17 Oct 2022 22:05:30 -0500
Message-Id: <166606235839.3553294.332512936249945561.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221006144518.256956-1-krzysztof.kozlowski@linaro.org>
References: <20221006144518.256956-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Oct 2022 16:45:17 +0200, Krzysztof Kozlowski wrote:
> DT schema expects TLMM pin configuration nodes to be named with
> '-state' suffix and their optional children with '-pins' suffix.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sm8150: align TLMM pin configuration with DT schema
      commit: 028fe09cda0a0d568e6a7d65b0336d32600b480c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
