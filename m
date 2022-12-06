Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D66B644B74
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiLFSVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiLFSUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:20:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EA9D138;
        Tue,  6 Dec 2022 10:20:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 140B1B81AD7;
        Tue,  6 Dec 2022 18:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E244C433C1;
        Tue,  6 Dec 2022 18:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350808;
        bh=Dy7R7gZyzBm1kbKWn0gnsrYZueXDy1+2pcr/9v/MisQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bOR8mudhVHz714D6L35SufDYkiw0FHbv0qGPLgL0RVWiZ/GDqW3MY4RpioWoDShKr
         xHiMp8Diw8GBo0KM32qoRGFzldK1pccQewCEkQeU45B7kxQ3yIvriTe668hNH7PI/A
         eQd4fC8/a5MfYHsY77JlTXnuMh+3HOWdTZtYUsg8IPDayAP2GtzyQDDbzW93pEQQSg
         E4B/EP8bszhLVY+65HJZMOQumivWQ4Qz7e6HazBQd4t0KNcbY2/k0iciwjBoq+LaHM
         Klk0KxL9ROhaE0q4MYqjrp0SDXeomsrc78fHP00dgDNn1zlTbvo12KRmHGWx0Dn+cK
         6mBM8wuKNj2VA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        konrad.dybcio@linaro.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7180-trogdor: use generic node names
Date:   Tue,  6 Dec 2022 12:19:14 -0600
Message-Id: <167035076354.3155086.7088959327404347394.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221203161443.97656-1-krzysztof.kozlowski@linaro.org>
References: <20221203161443.97656-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Dec 2022 17:14:43 +0100, Krzysztof Kozlowski wrote:
> According to Devicetree specification, the node names should be somewhat
> generic.  Use "amplifier" for max98360a and "-regulator" for fixed
> regulators.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc7180-trogdor: use generic node names
      commit: b62dfbf8e6b58ebac86a26ae98b68e9e96f3615c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
