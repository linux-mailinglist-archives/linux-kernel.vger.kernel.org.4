Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E844665FFB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbjAKQEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236455AbjAKQDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:03:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44440DF89;
        Wed, 11 Jan 2023 08:03:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23EC5B81C87;
        Wed, 11 Jan 2023 16:03:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81DCC433D2;
        Wed, 11 Jan 2023 16:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673453019;
        bh=XYAggQ8KuPhGBX3TJw3GPpUoca0NVtRHF9alcTqjx4w=;
        h=From:To:Cc:Subject:Date:From;
        b=sdVyI+3fv+LCzXisQc7KZeP3/U+VbvioQeQm+RD+fPSz8YBixDt+0KYt2yXmlGP6j
         kYIRlJ3EU1UNIgtHLR2x0xRwyti2e5u2DvmO4moGEAuEZww4FTki1ZwIGXv6YWQiw7
         PNfbvuSNL+rCIBSr0nMYyj7cpbK3cQKgG/x/yCSS0DWqkMKcE5eTFsbIIkUGw62ttv
         +EZ/3sFpK5z4rpO2UzMyxY4sb/OyRXWslHcUZbTyCusDNoFFGoY5Bx21CZNT0UfSgP
         GVLX7o1srDevqs54FC2tgUl5KUUZr/gGtF4nIinjSfi2BG2uevhmOrR7OczcCrOr5H
         OVDRi4l6QB/kg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pFdZo-0001sQ-BU; Wed, 11 Jan 2023 17:03:44 +0100
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
Subject: [PATCH v2 0/2] arm64: dts: qcom: sa8540p-pmics: rename pmic labels
Date:   Wed, 11 Jan 2023 17:03:33 +0100
Message-Id: <20230111160335.7175-1-johan+linaro@kernel.org>
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


Changes in v2
 - fix patch summary prefix (Eric)


Johan Hovold (2):
  arm64: dts: qcom: sa8540p-pmics: add missing interrupt include
  arm64: dts: qcom: sa8540p-pmics: rename pmic labels

 arch/arm64/boot/dts/qcom/sa8540p-pmics.dtsi | 25 +++++++++++----------
 1 file changed, 13 insertions(+), 12 deletions(-)

-- 
2.38.2

