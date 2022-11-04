Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9106197D0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiKDNZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiKDNYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:24:54 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB08E2EF33;
        Fri,  4 Nov 2022 06:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1667568257; bh=GjtYcdMrX2qIjTv6WMFaXcr3Gh4Sjz4PkOUI+NIclMM=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
         MIME-Version:Content-Transfer-Encoding;
        b=OF/6hWrV/+i5mH2monUHRAYZnPOL3rTOFxZG7fvf2h3fM/62cscjfN2aubu+jGKCd
         32FrGosev/pQUpRtHsJAhUcD7vijIezrV5ow3Jbz427B/BDQpo4glD/19r8M1Eu4zB
         LakGhPIqUQQlGuLnqdEU+kpaXFkWr0gmzM3/MM34=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Fri,  4 Nov 2022 14:24:17 +0100 (CET)
X-EA-Auth: tiVZ3DCZGiBkU8pwyqR3Q4ALni5eE+5xpq+p0j3GwKkLt2MiHj/4isV4+uxl4qI8j3ISD+rn0led2zhHryucifjAjl6tzBSmN7MOcu+PYD4=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vincent Knecht <vincent.knecht@mailoo.org>
Subject: [PATCH v2 0/3] Add msm8916-alcatel-idol347 torch and LED support
Date:   Fri,  4 Nov 2022 14:23:57 +0100
Message-Id: <20221104132400.1763218-1-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for GPIO torch LED and si-en,sn3190 white LED indicator.

Changes in v2:
- Added patch 1/3 to use -state suffix in GPIOs states node names
- Changed patch 2/3 and 3/3 to also use -state suffix

Vincent Knecht (3):
  arm64: dts: qcom: msm8916-alcatel-idol347: Add GPIOs -state suffix
  arm64: dts: qcom: msm8916-alcatel-idol347: add GPIO torch LED
  arm64: dts: qcom: msm8916-alcatel-idol347: add LED indicator

 .../boot/dts/qcom/msm8916-alcatel-idol347.dts | 80 +++++++++++++++++--
 1 file changed, 73 insertions(+), 7 deletions(-)

-- 
2.38.1



