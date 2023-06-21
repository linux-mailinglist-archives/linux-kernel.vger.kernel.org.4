Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827907389DA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbjFUPkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbjFUPk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:40:27 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D0519AB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:39:59 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f7677a94d1so8371955e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687361954; x=1689953954;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yU4DV2qo9BxVFrJ0f3oHAMCv7phtgI3uu2fRJ4KVI1I=;
        b=RABOo37gtI2gSDuyRxUhcC9bRFMK+Azm0M9SbVGWxO5NkcEi2tcTgK6zRIySUGfa3W
         8o/bvaSsJS0sqC4B0CqqyBJXVVWEojIHawe75FrmtpH0mFx4W2Z4BjZgptosXUjK+uBd
         P5UoqPcon2JfRdOkdSzFQZKOMqXwVBfiHbqwA3xqDds0mBn0xWD4+AIamkFL3fXa0o9w
         v6W1JD8lFD7jDzazhcFZ1Eyqf2njZc5+DKZy9buPZiEUx0sxNP2aZOITKGW5yOej+4bp
         aXNYixcYqAz7hGfM2kgLQmAkOWYGtAZQ89xJ1Tq8LRlOB95grFyDcX8Xpk39/YI6zcZz
         Ixlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687361954; x=1689953954;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yU4DV2qo9BxVFrJ0f3oHAMCv7phtgI3uu2fRJ4KVI1I=;
        b=YEYxuD5TB1B0a++52JHq3PgwBH5lgBtMfwLuxh2p+DnQBVmR6mPU4e6sKxXPKdncuY
         /+H148HR1SEvHHN0gBH3xsaQv8v7no8rGzOkdz+keAWfQPxMEtDM/cf5QB+UYgSKQvO3
         QIG5HvYiykpO00B0QBJKpvxxu6+De1hDJIPVvvBFV2cIKADzS7jLxNk8JDcfw+Ybnb+E
         ITqkOn4PmaLge3u8N/bQkUUTxqskEYLJVYP1hK6PRWaYhEzU9tWZFAt5QKuDT2bZ/6AQ
         QwDy3/YE4opKb0ArAvw5dJMrGpCJw7DwEX+2YbUWSE9VUjAwllDXH0XqQLFc2UHcOE2Y
         BCJw==
X-Gm-Message-State: AC+VfDwd+Uqsd+QnLFgXY09KyE906HqRok1KkzcTKysuVtMJwBsZo2JQ
        KEP8uIN3nxbVc8HBypsOgwWygQ==
X-Google-Smtp-Source: ACHHUZ5ENZHzRzdViOmmayq8OUmXpLToc/yyrOxLYyDp5e/YRB+phDLb9Zb3+5TpILvzqtnY5HwPRQ==
X-Received: by 2002:a19:644e:0:b0:4f8:442d:6335 with SMTP id b14-20020a19644e000000b004f8442d6335mr9815058lfj.46.1687361954131;
        Wed, 21 Jun 2023 08:39:14 -0700 (PDT)
Received: from [192.168.1.101] (abxj193.neoplus.adsl.tpnet.pl. [83.9.3.193])
        by smtp.gmail.com with ESMTPSA id l15-20020a19c20f000000b004f73eac0308sm821078lfc.183.2023.06.21.08.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:39:13 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/3] MM8013 fg driver
Date:   Wed, 21 Jun 2023 17:39:09 +0200
Message-Id: <20230621-topic-mm8013-v1-0-4407c6260053@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ0Zk2QC/x2NywqDMBAAf0X27EIeVGN/RTwkca0LGiWxpRD89
 y49zsAwFQplpgLPpkKmDxc+koBuG4irTy9CnoXBKGNVZzRex8kR990pbdH2Xf8YaHDBOJAk+EI
 Ysk9xlSi9t03kmWnh7/8xTvf9A5tOsqlzAAAA
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687361953; l=947;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=wlDoFGQ2X3QoRRnQnmr+8jyUX0iHnnC3N7J/uAgmyW0=;
 b=Lz6Tr/zNos6A7HdUs7FmQehcXQuDKZH2FHJlBZ9FzrYWASEAB3PocnmW+4916ymvQocmkCUjA
 pgVaRmC1mIdA0+DvpHrQdOLkqVBKbKkT3za2908lbrS6AKlt+/iM5fU
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series brings support for the Mitsumi MM8013 Li-Ion fuel gauge.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (3):
      dt-bindings: vendor-prefixes: Add Mitsumi Electric Co., Ltd.
      dt-bindings: power: supply: Document Mitsumi MM8013 fuel gauge
      power: supply: Introduce MM8013 fuel gauge driver

 .../bindings/power/supply/mitsumi,mm8013.yaml      |  35 +++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |   5 +
 drivers/power/supply/Kconfig                       |   9 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/mm8013.c                      | 280 +++++++++++++++++++++
 6 files changed, 332 insertions(+)
---
base-commit: 15e71592dbae49a674429c618a10401d7f992ac3
change-id: 20230621-topic-mm8013-376759e98b28

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

