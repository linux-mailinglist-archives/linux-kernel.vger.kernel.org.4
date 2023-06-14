Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DCD730806
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbjFNTU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjFNTUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:20:55 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A6B213B;
        Wed, 14 Jun 2023 12:20:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686770450; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=EFbXxSUGekfWR6MwUXGRZhWs4rlgAgD8D5gszALsI6y00wMZCgsTV0Dz7GSQ+1WShE
    40YOQ7Jg6JWrraKBICxQWLtVUU3K0rvhQg1w7qdh6oj5YPxuDZyJQ2U4tptHkqzqsSXN
    jX1Rq2qHJj6UxlFJLHN2gDAKJLmNHuiZr1DeSK366R7fUfxdXTOrNWO9b4N9sEMBhgC4
    zXFOa7bFM/eF5GLOjRttKzMPL7eCFgZUHDoiRsd86u5UvYgJDJuZ1r0ljIq5p2D5Mh+o
    ri7Q4KgJgfj+2mlv/0MCg6ayvRIPzINnKbtqhwqEROcKyZxm3BY6uk5AiNlEfuVhBuOj
    C63g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686770450;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=neT+DUbNGXFd7YKRPRpjpjhGQIXjCgnsy9pZLG/vLm4=;
    b=pu8vsnwXkTh2BO6lEqh3oG6pTN3QG1Euntxh9R0Rr3fUELZutOVRKq6Y292xrjZS6w
    CGU2J8HpJ5M+Wq0sesI3MakJCr6tg6hNGFVIRBBsSKoUgc326CdF9VoOlkOG0UxvBmql
    W6+2ds5VNwcmqoU34euNgpCgZMIC3cfpjIKMWllYAhleeP1g+L2LsZrXlw3/VXTGCgKj
    pivjceAdoqODpj1h/W28lbWaOfztW5xM3O/sQZJup5LPCDFMyY0JOC6MP49KufIMS5ya
    EGxRWy8ekVqbA1moSJfit0lUr8xsXbKukdXpkyjMgOCfZ7e4Za/L3prkV4gHrJmcIkZG
    YKSQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686770450;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=neT+DUbNGXFd7YKRPRpjpjhGQIXjCgnsy9pZLG/vLm4=;
    b=X7KvdbOmhGO+0OOTZWBq8HzMelMX9FHmfXUKM6CfQ3t5F/J/VndmrOSTAGVYMgIqe6
    xUO4SrOnM9Ky1QpPmhosywor8AgUWa0F0H/aCkB8CVzyk0o9uf2Csp7KsGcWB3RZAFIH
    fX3PbDJRotywZpqrlvFJMUmqJLVuu3C/y6OHQKl5TLC3IN7HW67uhQQIjF9fEDmubRyS
    DOLUY4U+Hh79fkxCF4eRsW0miUOC6aAOO2ms6vrvWXGmSDMhiL2gHrKBMO+Xexl8CRYW
    81pfuxYTX/ycWKW15I6Nb2rWeZj0UR/0jvGAAYTUfA6FE4nXvgraH9fG9S4oZMi33jJf
    r05w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686770450;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=neT+DUbNGXFd7YKRPRpjpjhGQIXjCgnsy9pZLG/vLm4=;
    b=EXiQ/bZ71kQlrQ1nP9Wlb1U+xaTpZLk10kg7vn6/CPmKDd7sflwoq70S0zKMiYgwg1
    rzIfypzsPp7K0ZYIYHAA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4xxmw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z5EJKn0hr
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 14 Jun 2023 21:20:49 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 0/2] of: reserved_mem: Improve range allocations
Date:   Wed, 14 Jun 2023 21:20:41 +0200
Message-Id: <20230510-dt-resv-bottom-up-v2-0-aeb2afc8ac25@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAkTimQC/32NQQrDIBQFrxJc9xc11EhXvUfJQuM3Co0GtdISc
 veaHKDLeY9hNpIxeczk3m0kYfXZx9CAXzoyORVmBG8aE055T2+MgimQMFfQsZS4wHsFIc3ArBW
 CS0uap1VG0EmFyR3monLBdBxrQus/Z+w5NnY+l5i+Z7uyY/2XqQwo9NoKKYfeaDSPGZOLL3MNW
 Mi47/sP/7X0dM0AAAA=
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, devicetree-spec@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try to allocate dynamic reserved memory regions with "alloc-ranges" 
close to other static regions by choosing between allocating them 
bottom-up or top-down. This keeps the reserved memory regions closer 
together rather than potentially having them spread all over the RAM.

Also make the allocation order of dynamic reserved memory regions 
deterministic so it doesn't change randomly when adding unrelated 
reserved memory regions.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Changes in v2:
- Drop explicit "allocate-bottom-up"/"allocate-top-down" properties
  Instead, try to guess in the implementation based on the already 
  available information in the DT. (Rob)
- Drop examples that were just included to show the motivation.
  They are still available on v1 if needed.
- Link to v1: https://lore.kernel.org/r/20230510-dt-resv-bottom-up-v1-0-3bf68873dbed@gerhold.net

---
Stephan Gerhold (2):
      of: reserved_mem: Try to keep range allocations contiguous
      of: reserved_mem: Use stable allocation order

 drivers/of/of_reserved_mem.c | 60 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)
---
base-commit: b16049b21162bb649cdd8519642a35972b7910fe
change-id: 20230510-dt-resv-bottom-up-68d71ff6628f

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>

