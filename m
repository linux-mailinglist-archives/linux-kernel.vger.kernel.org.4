Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E50E62B7EA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238809AbiKPKWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238266AbiKPKV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:21:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B9923EA1;
        Wed, 16 Nov 2022 02:21:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D435B81CCC;
        Wed, 16 Nov 2022 10:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3D0C43146;
        Wed, 16 Nov 2022 10:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668594114;
        bh=aifN2hfD2UgQ5/nFqlOTGeqXOWXvnG1r7DJvWCwcqV8=;
        h=From:To:Cc:Subject:Date:From;
        b=I44ltYAYqyE1zMbc/AUvS3nxuGu5L/oTLVjTQRBnMsF5UofAxHtR/xCZtNoZm7r02
         tuOcNxG8/cMj6zwZBtL9Nct3mRQywe0yiGgI4BOzAKJD7b8+WKJvLJma9Q6AiiyT9T
         goRvgBqsO5JTHbidUF2T3BHgrbqKxOIisnKAc5MP36K8Ox2c/nF1AAysKr7GkDOD3v
         7vUh3kwjwpkdA9iTKmvS9f8UPatAcxxeLc/4gotSA3bc2K065VjCup8L7PhxlsJ5Le
         D/evhu0cr51tZJFbUF3Q3t88Ioa2g/jel/0uZzJxqlv8Zto/yo8kP+UGpgvLPpBq9f
         oD9KT/y1tvIbg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ovFXo-0001Ek-Jd; Wed, 16 Nov 2022 11:21:24 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Parikshit Pareek <quic_ppareek@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/2] arm64: dts: qcom: clean up 'regulator-allowed-modes' indentation
Date:   Wed, 16 Nov 2022 11:20:52 +0100
Message-Id: <20221116102054.4673-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reviewing a new devicetree for sa8540p-ride I noticed that the
indentation for the 'regulator-allowed-modes' properties was off and
realised that this had been copied from the recent patches adding the
missing modes properties.

Let's clean up the binding example and current devicetree sources to
avoid this pattern being reproduced further.

Note that the patches adding the missing properties have not yet made it
into 6.1-rc.

Johan


Johan Hovold (2):
  regulator: dt-bindings: qcom,rpmh: clean up example indentation
  arm64: dts: qcom: clean up 'regulator-allowed-modes' indentation

 .../regulator/qcom,rpmh-regulator.yaml        | 10 ++++------
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts      | 20 ++++++++-----------
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts      | 20 ++++++++-----------
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     | 10 ++++------
 .../qcom/sm6350-sony-xperia-lena-pdx213.dts   | 10 ++++------
 .../boot/dts/qcom/sm7225-fairphone-fp4.dts    | 10 ++++------
 .../dts/qcom/sm8150-sony-xperia-kumano.dtsi   | 10 ++++------
 .../boot/dts/qcom/sm8250-sony-xperia-edo.dtsi | 10 ++++------
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts       | 20 ++++++++-----------
 9 files changed, 48 insertions(+), 72 deletions(-)

-- 
2.37.4

