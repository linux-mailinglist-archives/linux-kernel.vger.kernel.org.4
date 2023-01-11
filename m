Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBF4665603
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 09:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjAKIZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 03:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236024AbjAKIYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:24:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C5513CD5;
        Wed, 11 Jan 2023 00:24:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EBCA61AE9;
        Wed, 11 Jan 2023 08:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860BCC433F1;
        Wed, 11 Jan 2023 08:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673425484;
        bh=sq87poyyQRDX2ZFDSf+R+MlxukjwQQCHq643o4gNmSY=;
        h=From:To:Cc:Subject:Date:From;
        b=IiH2XpOh/yZOOqKovVnnASNuANzssueTLYOOSrF0Io5j11Jcvl14pnMMZWzHp1kg8
         /Q7dyGa1F5GjKG1zJmL6WlrjiU2FCF9zlbMqi0dETmXwDKvRxbK5/Xa2KEDDg6WGaX
         97Cdvpe5eEmk/+kk7l/9V8HvceDbt0ohM0dgLMBiZaduVUdM5Ch3JCrYEaGWXieJCt
         7PTpVutQ6/fnyXMe1EeQVD0Q64aBx2JZWt6iKTqSV3pTFhqhNTP5XYKbUWN4crk559
         RcycQz3WPPwNuS3gUXXx2+uil1cM+H2nPGEj+qSt//ipfBsB4+2DR1MfoTD+ehS/Op
         /c/ahkV8xitLg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pFWPc-0005OW-HP; Wed, 11 Jan 2023 09:24:45 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Eric Chanudet <echanude@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/2] arm64: dts: qcom: sa8450p-pmics: rename pmic labels
Date:   Wed, 11 Jan 2023 09:23:29 +0100
Message-Id: <20230111082331.20641-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.38.2
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

These patches add a missing include to the new sa8540p-pmics dtsi and
rename the PMIC labels so that they reflect the actual name of the
PMICs.

Johan


Johan Hovold (2):
  arm64: dts: qcom: sa8450p-pmics: add missing interrupt include
  arm64: dts: qcom: sa8450p-pmics: rename pmic labels

 arch/arm64/boot/dts/qcom/sa8540p-pmics.dtsi | 25 +++++++++++----------
 1 file changed, 13 insertions(+), 12 deletions(-)

-- 
2.38.2

