Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228E2712C2E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjEZSHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237043AbjEZSHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:07:40 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DEA125;
        Fri, 26 May 2023 11:07:39 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-96f6a9131fdso151985366b.1;
        Fri, 26 May 2023 11:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685124457; x=1687716457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AU/kd7w2jq/58XCHklASS4nJYK7BktctWkyMZw7QDd0=;
        b=miHus96sHqsD9vqUR8YA/lXell5dRmtsfCW10qrulYZDfcXOhRuzJkS+bOt0T+UEtZ
         x2rJg5+7aZcmjWUqT9a6MLUrONBxdQtNfzZE9VI/GoJXxg8RJ8lxGBjGUtM34GKyVNAF
         LRDDUe0N4gVDAzlZPyeT149M4QJqIryY6XnG0+qYIRHBNmGWu78+k2nZFWbKtLWjLIVL
         bm23iPAOtf240H4bJvZIHl9k+HlYwig2qGMlg/2CX+9/l+8mw8EOD2OGkpKjAsGCkr0i
         zd9kR/z9YhTvseuET4HC1arwTp6o8ifETeAWgb7zrOPsDM45j5A9C1iiprNEOyq1vDZL
         ro7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685124457; x=1687716457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AU/kd7w2jq/58XCHklASS4nJYK7BktctWkyMZw7QDd0=;
        b=LY/y2kr3TYz6pkdGrHIRXHs2PnUDZWQ6pRSBntcAYzy2jYWFSWMdswXI2Pz7nryzxu
         3Un0Ry31h/I8u2JQrjKX/V7ya5L41K1hiaceV3FTvIjY7bcnbn32ENqgyRgA9Sv+kzov
         z0RFDcec9N4keRnyaaPHZZ3KU9I15eNf0z1fWZfKYJny/LQWNN8Z6ciGyf22rDUnVU0V
         kgkjSqPE57UFoQ2RlFo/1cxheuIUim+YuCOJAUnmZ/DvKJ73HB9rn8Na0X4yGvg44Qm4
         zCsxRKptLtpH6STbhzWVTAZXaWQr06/Fq7lMakGOLb34b2BteRr1CuxKRBwqMJD7BQq5
         3oGw==
X-Gm-Message-State: AC+VfDwgrOQfRCJKmM36eLChGmFWvWgUWI6arvJVsitZg/EOyqWKZ1EI
        KmwCr/VZxVdTPKZX0xQvsP8=
X-Google-Smtp-Source: ACHHUZ7y1vyL2x97KeOBdjyi48JhXGfEs6M8gsyaewx0uOnlKs3ieunlNj4VjNhWLF/1c4eLTdKvaQ==
X-Received: by 2002:a17:907:c09:b0:971:eb29:a086 with SMTP id ga9-20020a1709070c0900b00971eb29a086mr3125022ejc.75.1685124457172;
        Fri, 26 May 2023 11:07:37 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.33])
        by smtp.gmail.com with ESMTPSA id j11-20020a170906410b00b0096f689848desm2410823ejk.195.2023.05.26.11.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 11:07:36 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hansverk@cisco.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] media: camss: Link CAMSS power domain on MSM8996
Date:   Fri, 26 May 2023 21:07:09 +0300
Message-Id: <20230526180712.8481-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

CAMSS on MSM8996 has been broken since commit
46cc03175498 ("media: camss: Split power domain management").
This would happen when trying to start streaming:

[  199.097810] ------------[ cut here ]------------
[  199.097893] camss_top_ahb_clk status stuck at 'off'
[  199.097913] WARNING: CPU: 3 PID: 728 at drivers/clk/qcom/clk-branch.c:91 clk_branch_wait+0x140/0x160
...
[  199.100064]  clk_branch_wait+0x140/0x160
[  199.100112]  clk_branch2_enable+0x30/0x40
[  199.100159]  clk_core_enable+0x6c/0xb0
[  199.100211]  clk_enable+0x2c/0x50
[  199.100257]  camss_enable_clocks+0x94/0xe0 [qcom_camss]
[  199.100342]  csiphy_set_power+0x154/0x2a0 [qcom_camss]
...
[  199.101594] ---[ end trace 0000000000000000 ]---
[  199.101736] qcom-camss a34000.camss: clock enable failed: -16
[  199.101813] qcom-camss a34000.camss: Failed to power up pipeline: -16

Turns out camss_top_ahb_clk needs the CAMSS power domain to be on. Before
the change, VFE power domains were enabled before CSIPHY enabled clocks,
and since the CAMSS power domain was their parent, it got enabled as well.
With the VFE power domains now enabled after CSIPHY is powered on, the
CAMSS power domain remains off and things go south when CSIPHY tries to
enable camss_top_ahb_clk.

Link the CAMSS power domain in camss_configure_pd to make sure it gets
enabled before CSIPHY tries to enable clocks.

Changes since v1:
  - Wrap commit messages at 75 lines.
  - Remove duplicate "media" from and shorten the subject of the first
    patch.
  - Expand the commit message of the second patch.
  - Fix "Fixes" tag in the third patch as well as other commit references.

Yassine Oudjana (3):
  dt-bindings: media: camss: qcom,msm8996-camss: Add CAMSS power domain
  arm64: dts: qcom: msm8996: Add CAMSS power domain and
    power-domain-names to CAMSS
  media: camss: Link CAMSS power domain

 .../bindings/media/qcom,msm8996-camss.yaml          | 13 ++++++++++++-
 arch/arm64/boot/dts/qcom/msm8996.dtsi               |  4 +++-
 drivers/media/platform/qcom/camss/camss.c           |  9 ++++++++-
 3 files changed, 23 insertions(+), 3 deletions(-)

-- 
2.40.1

