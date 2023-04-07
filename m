Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBCD6DB1D6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjDGRi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjDGRih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:38:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370C9B45E;
        Fri,  7 Apr 2023 10:38:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD3A76534F;
        Fri,  7 Apr 2023 17:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89119C433A0;
        Fri,  7 Apr 2023 17:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680889115;
        bh=xRCCTTV5IAKnMz5Ad1wqi9GFN4GPIt9Df992NxEEhAA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nUy/rydg9BZWRtrzsC+PAmApVL3usFqn4mlwNC+oRlVPtEbrA9h6cxTyFXfsVc+Z4
         k+OFxekFaZMFVFJTfq742ynJEiU2oPapyTokhBxaahAnoeXs1MukNTGvVjpe1vehU3
         a/AgljKmkwYGxOhJk5D+r8zrqChXIqFrladRA0XYgE8YU9to8+80REro4yJ9e/niMz
         RXKbp7qYRXGQ3hoDI1J7DEpnbe24XvuLJLxTuexZ/E9zxdfu2ZxFR55ezKUZQIyUg7
         dyxo10yX+M/8yLotS6lIYmC954l8jLq7IV3B4U0LaM7G0fE7yjupupEaVYPIpoDR7D
         OrZq9SBYB+oTg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8550: add ADSP audio codec macros
Date:   Fri,  7 Apr 2023 10:41:12 -0700
Message-Id: <168088927578.2561591.3045698622219332255.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310134925.514125-1-krzysztof.kozlowski@linaro.org>
References: <20230310134925.514125-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 10 Mar 2023 14:49:25 +0100, Krzysztof Kozlowski wrote:
> Add the Low Power Audio SubSystem (LPASS) / ADSP audio codec macros on
> Qualcomm SM8550.  The nodes are very similar to SM8450, except missing
> NPL clock which is not exposed on SM8550 and should not be touched.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8550: add ADSP audio codec macros
      commit: a10e2244f49a838e2274672dfeb4ab1bc9349230

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
