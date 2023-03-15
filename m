Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C2E6BC14B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjCOXeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbjCOXdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:33:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F0AA54C9;
        Wed, 15 Mar 2023 16:32:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BED661EAD;
        Wed, 15 Mar 2023 23:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6495FC433D2;
        Wed, 15 Mar 2023 23:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923156;
        bh=+YAjggYPMIMFzS2s0i4vOJVcRpRIRhcFzyxIXJgll7I=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GkENUOjTwYq1fl253mizZwLvqpNVvkFJdwukGX1kn/Dg22iwbuzXONArNJgMkNaiV
         OkxkoriJP9Kr+IoPFCHZIloqUh6lYqmu/vCUrpJPIpbNv8dsgpOoiIXB2iOGZ5BRL1
         RXCCX/PCfZMCxu/M8LaIcjcVRKrUeljpwdGpMRYbh4c7JLeS3WvwT+eRP6utSvsAIy
         wg01aoRWXzUrCcWlksUFISCiDm9ZN/uiPupzoPBS/Z8SUa1KlgO5+vXuELZdh6VY4X
         wyu0PdzFqLRl1pennL/6SiZfu1onJ5uc2+1A01IqysicLyIT1/9s0qAvzr+MYXtwaX
         3FqcNwRNnSTpw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sm8550: fix LPASS pinctrl slew base address
Date:   Wed, 15 Mar 2023 16:35:07 -0700
Message-Id: <167892332561.4030021.8220167893365746546.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230302154724.856062-1-krzysztof.kozlowski@linaro.org>
References: <20230302154724.856062-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 2 Mar 2023 16:47:24 +0100, Krzysztof Kozlowski wrote:
> The second LPASS pin controller IO address is supposed to be the MCC
> range which contains the slew rate registers.  The Linux driver then
> accesses slew rate register with hard-coded offset (0xa000).  However
> the DTS contained the address of slew rate register as the second IO
> address, thus any reads were effectively pass the memory space and lead
> to "Internal error: synchronous external aborts" when applying pin
> configuration.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sm8550: fix LPASS pinctrl slew base address
      commit: a5982b3971007161b423b39aa843bdb6713a9d44

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
