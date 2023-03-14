Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13BA6B964A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjCNNch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjCNNcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:32:00 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82F97E8A4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:28:42 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id j11so19988871lfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678800518;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vXK51qJPH9Eciui7J6f0cshwdEc2yQA6IP/f+sAuhQ8=;
        b=sqWUxgtT8QYtmQHlOvWEAgqtfaenZqiQo3lN9Mb8ZxVp2DaaxbsZoFYBo0EyWRNayu
         pWZTDMKzDka/zHz19tPd4UarcNdfc40LCXTbBXoWJg4jNqN7bCSKGKoWsCXx8YdxfVQN
         BgtImpFdj/310Dy53Uo0NBbg2dLD/uRqVAtZyOd6XSq776xWRUGH5A5XofKoAQVTa61L
         61BuoPky7WJxnyv1AXT19AaHkiuW7VvjqZP4gZKTRhd/OJBI94OLdsEvftIKmU0ufkNc
         7UFNOB/lzdiChOpB7ehZ+jDOKm2+gq0YxLK2K1OU/5Np6ujCBsYA/FcI8seAb+Pf3T2v
         levQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678800518;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vXK51qJPH9Eciui7J6f0cshwdEc2yQA6IP/f+sAuhQ8=;
        b=nHHDqKHljtPrpmZCTF5KZb3XZze1E7OJLKWPk99l0m1xo4ez3jkY9LFxgB7EBCBA2Y
         N1dgxGO9xnKD0E2TTku5Z2k17oPDAOE397EI2redYERhceH8l2QgkuLxzXRvAZIzU8fi
         IFuJMg4Q1vh/9bz7ntdnC6UG4RQR5HlqNTBp9wwW5WxogUAc/C4l3teG66azzIcY9Fy6
         nRar+miNUotyhD5ZrspMrBrptbUySbsPldF1Pi3IBjf8TQ7wUR0j8yui7l4aBJz8OHg/
         Y1iVaAPPPgC9R/gTG57cyDCZ70XxyR4r/27WU4gWtfUmhAnvHydN5AomaMMo/zGQU2Xn
         xo8A==
X-Gm-Message-State: AO0yUKUmWTLEcYKWNww/8JzoYgsL/5OFiCX/E/lT3l6TH3zpFeExuhQu
        ArmvUDbPNjtnsmI2JUgeOJaNPg==
X-Google-Smtp-Source: AK7set+GjBKqxM43JoWLvF94/EfFDm8TwDEEpNaTnvO1qnvEm3OkMuA82aa7D30Mahb+MY/ugCIAEQ==
X-Received: by 2002:ac2:53a6:0:b0:4e0:2455:3ad8 with SMTP id j6-20020ac253a6000000b004e024553ad8mr917911lfh.52.1678800518164;
        Tue, 14 Mar 2023 06:28:38 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id s9-20020a19ad49000000b004dda74eccafsm406012lfd.68.2023.03.14.06.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 06:28:37 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/2] Use actual GPIO names on MSM8998 Yoshino
Date:   Tue, 14 Mar 2023 14:28:33 +0100
Message-Id: <20230314-topic-yoshino_gpio-v2-0-4cb80e187e38@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIF2EGQC/x2N0QqDMAwAf0XyvIKt3YT9yhijdqkNSFoaJw7x3
 xf2eAfHHSDYCAXu3QENNxIqrOAuHcQceEZDb2VwvRv6wXqzlkrRfItk4vKaKxVj8epvNo1+TAE
 0nIKgmVrgmDXlz7KorA0T7f/T43meP1gRCjR5AAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678800516; l=896;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=TPjCLKdyCtYzQ2xCXHd7Y0gQVdwFkv4C/yTdrfXKLzk=;
 b=GI+I9siZUXHrki8t+oNyR3wP8Uh8sRqDkeJmhvkppII+DZ2jhz0Pvf070GDT96WCIz10ZYe3MoAJ
 dnyO5LpMBRCfb0p4sxSAZbwOa8vnhYNOylukx+baCqGj5ncHjaVK
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SONY gives us an in-depth look into the actual GPIO wiring-up. Add and
use that information in our device trees!

v1 -> v2:
- Split the introduction of gpio-line-names and node/label renaming

v1: https://lore.kernel.org/lkml/20230102190157.970053-1-konrad.dybcio@linaro.org/T/

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      arm64: dts: qcom: msm8998-yoshino: Use SONY GPIO names
      arm64: dts: qcom: msm8998-yoshino: Use actual pin names for pin nodes

 .../dts/qcom/msm8998-sony-xperia-yoshino-maple.dts | 179 +++++++++++++-
 .../boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi | 260 ++++++++++++++++++---
 2 files changed, 406 insertions(+), 33 deletions(-)
---
base-commit: ec0fa9a0a6fac454745c930bdb8619d0a354bac9
change-id: 20230314-topic-yoshino_gpio-1e5461f747fa

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

