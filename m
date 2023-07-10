Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DB874CC02
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjGJFI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjGJFHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:07:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3D626B3;
        Sun,  9 Jul 2023 22:05:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4625760DE5;
        Mon, 10 Jul 2023 05:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FD0C433D9;
        Mon, 10 Jul 2023 05:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965488;
        bh=CVRdQeSAbF0RhxqVgKYJtyQEIvj9yKS2zbDWp8RceFM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bUVy5ddT9lxk5pFp4qFn9xy8UBmKasEkG3yt4zqh9QVU2U6vsOktkm+A78DxyFwEA
         3Wyp65Mpyrc2oaK6o+Sa3jsvdsedBqpt8mCF4LvD6rQCM0iZ4Y5umnF6zV0Bmim0Pk
         D957lAPve5aNsPv64fuW/zta2ITrvD7fRY0EFLmAbOV5y/8ErR0pTwiYbAcW+8LfpW
         DILEfHW6B6tkFS3aeP/X8hb3maSyfxCGzmUDCyPmxEcsC0ZoK2dipKlp4kiMH03nAk
         KxJKDfii2upv+0xluuviQ1ZMecKD811mtlbCwnYWS09tcW3ARIUZ2+M/b/yB3QDVkZ
         JbkhbT7VjReeQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: apq8039-t2: remove superfluous "input-enable"
Date:   Sun,  9 Jul 2023 22:07:28 -0700
Message-ID: <168896565956.1376307.1642670676965106171.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230617112115.130024-1-krzysztof.kozlowski@linaro.org>
References: <20230617112115.130024-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 17 Jun 2023 13:21:14 +0200, Krzysztof Kozlowski wrote:
> Pin configuration property "input-enable" was used with the intention to
> disable the output, but this is done by default by Linux drivers.  Since
> commit c4a48b0df8bf ("dt-bindings: pinctrl: qcom: tlmm should use
> output-disable, not input-enable") the property is not accepted anymore.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: apq8039-t2: remove superfluous "input-enable"
      commit: 9e3a0c7acba5e1ec7b0730bac904ba820b70b5cf
[2/2] arm64: dts: qcom: sc8180x-flex-5g: remove superfluous "input-enable"
      commit: ba492bea16e2c036ef5725f166f1d20835b6e114

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
