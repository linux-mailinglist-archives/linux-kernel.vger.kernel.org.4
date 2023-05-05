Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C8F6F8747
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjEERNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjEERNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:13:20 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ACD2D67;
        Fri,  5 May 2023 10:13:19 -0700 (PDT)
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx1.riseup.net (Postfix) with ESMTPS id 4QCchZ4Rs2zDqTP;
        Fri,  5 May 2023 17:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1683306798; bh=eSi3WUlOLZpOpliG+mKyLLFN8XvqBvBGPK0vZC39QSk=;
        h=From:Subject:Date:To:Cc:From;
        b=UrbkyoxCy9pyPx2OZ3RjYXbe3VbPl+/DTdgcQocchkljGKarpk2BUoY7zOW4xsGI6
         ccEUGoQ/hp1ZQmp7Tll8RqWcvNpcfEZj66CpalfRQtrmAfHvdPApVAurTTjdGEmVrT
         5v7r4kNpElAHl614xb2TIAXVQLGSDQljbURs4wcc=
X-Riseup-User-ID: C914164F47E2FF18657AD20A4487CC900B030506F8F0107575D941C66991DA44
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4QCchX1g2MzJn8c;
        Fri,  5 May 2023 17:13:15 +0000 (UTC)
From:   Dang Huynh <danct12@riseup.net>
Subject: [PATCH v2 0/2] Add F(x)tec Pro1X (QX1050) DTS
Date:   Sat, 06 May 2023 00:12:57 +0700
Message-Id: <20230505-fxtec-pro1x-support-v2-0-0ea2378ba9ae@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABk5VWQC/32OzQ6DIBCEX8VwLg0iVu2p79F48GepewGyoKExv
 nvB9tzM6ZvM7OzOPBCCZ/diZwQberQmgbwUbFoG8wKOc2ImhaxELWquY4CJO7Jl5H51zlLgjW5
 aqYVqBXQsNcfBAx9pMNOSu9+wgRh+V1QOOQKN8Zx+9okX9MHS+/xkK7P7f3QredLcqaYa1XwD9
 SD0sLqrgcD64zg+zIAGJdwAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dang Huynh <danct12@riseup.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1085; i=danct12@riseup.net;
 h=from:subject:message-id; bh=eSi3WUlOLZpOpliG+mKyLLFN8XvqBvBGPK0vZC39QSk=;
 b=owEBbQKS/ZANAwAIAWbKt+qkXdeBAcsmYgBkVTkruTZvUxeaI96TcCRJAlKc0cHR8MgGftFbz
 N5/5cX9KhuJAjMEAAEIAB0WIQTwmpM8D+AzHlWMpOFmyrfqpF3XgQUCZFU5KwAKCRBmyrfqpF3X
 gdZSD/wNnXwtsP+hXiWb0W/F3bN24ose2KFQZYETq2C6g5h+DrtzAFuLTidOBSQz9wHaE1hmrKO
 yKgQmQJi5N2rFUf34s7rG8MKilYRl30aRK18MMuA/k6B/MFjn2uFa4kkvhkHhyVBBNm0MKaxgt1
 Kp70yN84gQQ0IguktXDhz1OYhTSOIbd8V9wOTpNH3ovRR9Y2Lrh5O5crX0j0vM96ibl3DXEDUAs
 YENBdBpo7RvJebKpTEfqA9XhuSI+Xf0XMMcHKpzyrORtDa7//H9bej3n4BnKC4uMFJwn4InYpt1
 GcRcipP4dEMEN65gGgs4aDdUYfC0ZBmCy2GOdZJnkjle5fJQuOGMhK6qNMO6wlTgs0yPyJ/FuoF
 VjxxyoHXwlwFld/FxsZneiuBrhFND12XJ5sL1NjXcfDCGEk+7SBaxJeXyGwTCymdeI/mKHYARt/
 yvA63L0gEI+Gl00D7EVUs1cGmfKXqUjPCJXbvpaMGecE0nvvEfp7jBFLeWOhEH4cWI+qktxsSjs
 Cv+LxaWDTYa5PepXsBUcctb5AExlUF2GPvsXrgu+rL6hD/4OG4BHXZ7igCFN7hLARn/grZL1hg5
 pFCIgfHcRooHrBG8zsbbIQ10d5MCw4gQ5HzqWq3XILRFW/aiAx2pXBcwIpIvAC4gK2hMBp4so9Q
 5jZUyKumpaJk9pA==
X-Developer-Key: i=danct12@riseup.net; a=openpgp;
 fpr=F09A933C0FE0331E558CA4E166CAB7EAA45DD781
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The F(x)tec Pro1X is a mobile phone released by FX Technologies Ltd
in 2022.

The phone is exactly the same as the Pro1 released in 2019 with some
changes:
- MSM8998 -> SM6115
- Camera button is no longer multistate
- Only one 48MP back camera
- A new keyboard layout picked by the community.

Signed-off-by: Dang Huynh <danct12@riseup.net>
---
Changes in v2:
- Corrected model property in DTS. 
- Changes requested by Caleb and Krzysztof. 
- Link to v1: https://lore.kernel.org/r/20230505-fxtec-pro1x-support-v1-1-1d9473b4d6e4@riseup.net

---
Dang Huynh (2):
      arm64: dts: qcom: Add Fxtec Pro1X (QX1050) DTS
      dt-bindings: arm: qcom: Add Fxtec Pro1X

 Documentation/devicetree/bindings/arm/qcom.yaml |   1 +
 arch/arm64/boot/dts/qcom/Makefile               |   1 +
 arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts | 248 ++++++++++++++++++++++++
 3 files changed, 250 insertions(+)
---
base-commit: 145e5cddfe8b4bf607510b2dcf630d95f4db420f
change-id: 20230505-fxtec-pro1x-support-7f782f0480e9

Best regards,
-- 
Dang Huynh <danct12@riseup.net>

