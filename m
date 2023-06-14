Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD407304FA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbjFNQc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbjFNQcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:32:19 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE49C1A3;
        Wed, 14 Jun 2023 09:32:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686760325; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hOndUb/y7+FYDHND6o4HtEidA3dlWnXmPYHWSzGBZmfZNuyrjWA/iFHxlwhWwQaKYA
    m91PrAgCyBehvxhx054ajMj5NAwwvJz95uvyBn1ckkm07wU2SewId1+UQXWtnGc+FH8H
    XQsQxTi5F3uVZHnZgMbw38NKE8cfWXrOtz2ylCKHiVjsEvTBJK6fyQuDrK4gqHsGgpNT
    e7so93vKVRRT/AkdfOwJ/uuu+pdLDdC4V3Ei1CLEhFCEK2IsuxcIu2zSLg+EGvZeaQwy
    BHn4WnQK6owZV9WMZArXgkes4RFrgbu7CplxqyQTqtDAmzOUHVpRrKVQUz+RMiSE2N2h
    O1mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686760325;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=+mbk/aoGF1cxafxQrmnrqQYLPhOg+LPpMWgeAsoqNFI=;
    b=kggcKKMP0d8i7yIQJ5xhN+jERDpgM+uHPNl3jzsEost4iUru5ZsWXOTigUvIpJONio
    rdvLpGu2CxDw3Po+xh9/5fTuWIjobutSlLknTlSNxPRyaANmv/RtwmN9K7GWYnfN/S0J
    dphWIsnbeQ5Ri6i5MXZrlT7MJggVSteftZ+5Oy5WAH7Li52QVrj90daZ+asZGcsVzAZh
    6WWLMb5/A30zWyLF2qnP+UDPCGLn/bVZGJX21V3qscn8kOF5fEq7hp5iWXGH/HrieU88
    6oMyxcc1Ot3jXcGi0haZudDGkMK9NriYsd8ELYfbZXgzm3rbb1StNwkqAElVHKzhDdmU
    R7/w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686760325;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=+mbk/aoGF1cxafxQrmnrqQYLPhOg+LPpMWgeAsoqNFI=;
    b=XPKiUm/adpLckW3woYucjEL9LfFv2cT8Dd+k7qYvyfBGPZL2ommNHujhYevDzmTTMp
    bfp4bGK7Dfqmm1tnaemAcbh8oEWqRkYJuWSVSXbNhIdKHAH/EvJuIaLJSX7/Gwkw5sF2
    eGtE2Cj2wj0aX2mv5dc1EvGvPeQYp/GxEQ8HxbOZcWEFGTNYeHAs5WPDGOpp7bTGPuM7
    18WhRkUe+bH1mx1KJsdnwETRJvqhjMDxQ9bMtgSwK8aBGtGWDHoRHoXoUCN4aYVw3w3p
    xqQJYW8Xfdo3mAJyoGYfUR4K/gUb97VAIi01ZBppXChjXw5Kw5iegkg4cYAk1kFmc+Wk
    gOvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686760325;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=+mbk/aoGF1cxafxQrmnrqQYLPhOg+LPpMWgeAsoqNFI=;
    b=lrWDo+JUzK2svFuy1bKLyW4l735AvsuEmuDLQ2GWlAD5jUJrzFeQyTmRdg76QGpCQw
    GPpE5JGWSk/45YoY95AA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4xxmw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z5EGW50U2
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 14 Jun 2023 18:32:05 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 0/2] remoteproc: qcom: Use of_reserved_mem_lookup()
Date:   Wed, 14 Jun 2023 18:31:53 +0200
Message-Id: <20230529-rproc-of-rmem-v2-0-95e39b959585@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHnriWQC/3WNwQ6CMBBEf4Xs2TW0iIIn/8NwaGGhTaAlWyQaw
 r+7cjeZy5vkzWyQiD0luGcbMK0++RgE9CmD1pkwEPpOGHSui7zUNfLMscXYI0804a2rC9VfJRc
 CcaxJhJZNaJ1Y4TWOUs5MvX8fJ89G2Pm0RP4cn6v6tf/mV4UKS6uoqKoqN9Y8BmIXx+4caIFm3
 /cvORgOh8EAAAA=
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of_reserved_mem_lookup() instead of of_address_to_resource() inside
the Qualcomm remoteproc drivers. This has the advantage that it ensures
that the referenced memory region was really reserved and is not e.g.
status = "disabled".

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Changes in v2:
- Add missing check for rmem (Bjorn)
- Add checks for rmem->size to ensure dynamic reserved memory was 
  really allocated
- Link to v1: https://lore.kernel.org/r/20230529-rproc-of-rmem-v1-1-5b1e38880aba@gerhold.net

---
Stephan Gerhold (2):
      remoteproc: qcom: Handle reserved-memory allocation issues
      remoteproc: qcom: Use of_reserved_mem_lookup()

 drivers/remoteproc/qcom_q6v5_adsp.c | 24 ++++++++---------
 drivers/remoteproc/qcom_q6v5_mss.c  | 35 +++++++++++++++----------
 drivers/remoteproc/qcom_q6v5_pas.c  | 51 ++++++++++++++++++++-----------------
 drivers/remoteproc/qcom_q6v5_wcss.c |  2 +-
 drivers/remoteproc/qcom_wcnss.c     | 24 ++++++++---------
 5 files changed, 71 insertions(+), 65 deletions(-)
---
base-commit: 1ca04f21b204e99dd704146231adfb79ea2fb366
change-id: 20230529-rproc-of-rmem-7d931f61f64e

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>

