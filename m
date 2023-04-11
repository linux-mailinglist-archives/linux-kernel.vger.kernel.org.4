Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677E16DE3A4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 20:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjDKSOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 14:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjDKSOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 14:14:48 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604E2E4E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 11:14:47 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id a23so12059564lfk.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 11:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681236885; x=1683828885;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=haHDBJYeen17j/Bq6goKahiOKwrx+coG/GAwlvtLVe0=;
        b=sOL4tw1Yw5xOC/4BQ5YVkcjtyJadeVPB6DbU6JbQtDmnYZ8pbLJsBrd8CdimjkeFh0
         JA1z1eZD7p+6T57OCyXJ5gHBAuRa2QtCzt9kYg4h3I30VvMohfRGOhi5L1EwWEwYqCmz
         jcze6icyktJgPTrFlrPZZlN1A2YiEGUT1Fp1mNR4kQNxUak2SXwsh79KZdATWchhuWbt
         1TfRFiVCIQLhBAkxUnMsWoEi4JCR2SQzYird5CVVjDuLFpDwC9+cAlBUduzbiwMMRm2v
         UIRhQehxgHBbE9k9VA6/vNR6GjOT7ANajy9VchGjw/CaRDXc8QXHmS/l5GPuPeCXvhru
         91vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681236885; x=1683828885;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=haHDBJYeen17j/Bq6goKahiOKwrx+coG/GAwlvtLVe0=;
        b=OUl+UdRpRkZqNlIfjtdPifEqujliCTHCvWTaVqfbV/1kIdxOqCnP7NgQg0sPSYvfdu
         J42SHie+EUvQGTSaFypuO8qLUsxuK8HesBLI4B49PoLrFICdaXUwDZ91TTvF58jTXbJr
         mK0r/+mX7yy8WQC9xr1FaFnaVb/hNRhYevQCeGIv3dchxyKVEQLjNqrnytdxhXZqE/lq
         9l2Z3o4+HuYsYz4Cw6iCnKmvpk6Ez03BxTFvpIg/+JgH8oKmOJJjD1s40szmYI1myOlJ
         rRJW/WBlEzRxdw8fg6GK9dhvSDl3WzNoMj8gLQtEM5t839Eyvlue+tJrzWmB3w3DKhCR
         5Z+A==
X-Gm-Message-State: AAQBX9eVUs6JNXayI+TxCBcl5mrGBuW3xUp7fLQ9g45Z8wcuyXKKvBc2
        vl8bgPYBBT/alK8d4119CODj/w==
X-Google-Smtp-Source: AKy350ZQzPKxuKGLQpIcA9a9HqcsrQZ/SI+4riXrgp6kYJX3QHuQfF1Pt2LykxCCNn7tHjzWpkEybA==
X-Received: by 2002:ac2:44b5:0:b0:4e8:3fc7:9483 with SMTP id c21-20020ac244b5000000b004e83fc79483mr872270lfm.23.1681236885634;
        Tue, 11 Apr 2023 11:14:45 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id u25-20020ac243d9000000b004da8168eba2sm2593868lfl.237.2023.04.11.11.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 11:14:45 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/4] SM8150 Kumano updates
Date:   Tue, 11 Apr 2023 20:14:40 +0200
Message-Id: <20230315-topic-kumano_dts0-v2-0-0ca7fa521b86@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJCjNWQC/4WN0Q6CIBRAf8XxHA2uodZT/9FcAwS9y8CBuprz3
 0OfeqrHc7azs5BoAppILtlCgpkxoncJ4JAR3UnXGopNYgIMcpZzQUc/oKaP6SmdvzdjZNQUmpc
 gtAWhSOqUjIaqIJ3uUummvk9yCMbiax/d6sQdxtGH9/6d+WZ/LWZOGS1Pha1AnSW36tqjk8Eff
 Wi35b/U8kqABgl5WX2n9bquH6YVXH0DAQAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681236884; l=905;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=v5tfXJotop1vZ13L1OHEWWgybeV36LIK+/49LO+00s8=;
 b=dfVQDnRMzYsqqzsGb3x70DK5vT4jAyAtwWl9+p7PSj4tK0qTXCB3F69bVAmRoyDjY5yO3hULy19y
 tsEOJ/N3BxkvGEg+xEpnCPJfixrKYo/SQPU8TU41Dalwg52O6kv1
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2:
- no-emmc -> no-mmc [4/4]
- drop superfluous input-enable [3/4]

v1: https://lore.kernel.org/r/20230315-topic-kumano_dts0-v1-0-f1852c2a2378@linaro.org

Add gpio-line-names, set up fixed camera regulators and enable SDHCI2
on Xperia 1 / 5.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (4):
      arm64: dts: qcom: sm8150-kumano: Add GPIO line names for PMIC GPIOs
      arm64: dts: qcom: sm8150-kumano: Add GPIO line names for TLMM
      arm64: dts: qcom: sm8150-kumano: Set up camera fixed regulators
      arm64: dts: qcom: sm8150-kumano: Enable SDHCI2

 .../boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi   | 335 +++++++++++++++++++++
 1 file changed, 335 insertions(+)
---
base-commit: 009795d283d1f9f043e5a4ff97d4140cde17e2d3
change-id: 20230315-topic-kumano_dts0-e6c1725cf25b

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

