Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CDD60FC49
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236273AbiJ0Ps5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbiJ0Psy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:48:54 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A3C1911D3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:48:53 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id f8so1234776qkg.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7bd2o65SJMz3i5RcjHxiT/cYGibvGVX6duHYP/0Qh1k=;
        b=cm7aFwKkZHCD6OoM+YEoDZXCH9vzy1bIwzrlS6smcZCpQrIdbxy9i74nm7AGoqyZT+
         2kaHC1NJfIb1owR4fblwFtimEy/eOXTGf0hmBri7WeqZAipVA+CO8CKcdKGB4j3DTHad
         IhQ4yW+dYrHc8wdKHvVf4yT8ZiEkjN/laQY71NbN6/JeqHgMDXwVfv27J+/9/A0uOht5
         OG3V7CAqhlXbJaXscctXNiN7THcpgslGiYtkN0bxtCUrn0vvN+DlxXSh7GaAop1EXH2p
         RV6ki5ReDChYY3/M210eBDG1KQkVj3DVsBDp1QiGzWkK/7eAqGIj+e2bZcgWuOIHIVfH
         aXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7bd2o65SJMz3i5RcjHxiT/cYGibvGVX6duHYP/0Qh1k=;
        b=MWHrqAUMSxURoJW9sdNV41rtkq6nm6Xn/M9FVodUWXhOSklBUout72MpDYnEF6mTJi
         htZtWKhKXM1Ia6kBA3m4009smeQsTsB9T2X+IUveYvwvCdaaNJgbvvk9OTscoY9VdxLz
         J+xl1Y7sNqrhHpi3ox4d6bNGmBMZxgfy4ytncMxm+JYI3016TGW0lPI6ed89QY6yDUZs
         blzXFxuexDqbYUPdO4gfE7+TbTHQwkY9d7rlb9ClQPFpbAr6ccbqcoNkKzm3kiFLUIea
         LeCpudhJ1bVagXzFMTh7akisQh9JxD2aXtuypa5EYRYBMoyXtGEMBiTvL5UYT8LJ1IDF
         iFzw==
X-Gm-Message-State: ACrzQf3rCnVXMIfnG7A5Ze0vLIC2WkFkyjQluOnJXsBOKx8urdsBwkkB
        VJjNr1ToqaCdKeHxQwZpCFTBPQ==
X-Google-Smtp-Source: AMsMyM5qEVOnPgHTsEpHls014vI8BMePU6289s67Xrr/CbE3MVgIguufqEtjNgKAdTuipUmjjBJw7A==
X-Received: by 2002:a05:620a:29c6:b0:6ee:cf89:40cb with SMTP id s6-20020a05620a29c600b006eecf8940cbmr35399092qkp.107.1666885732747;
        Thu, 27 Oct 2022 08:48:52 -0700 (PDT)
Received: from krzk-bin.. ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id w29-20020a05620a095d00b006eecc4a0de9sm1168531qkw.62.2022.10.27.08.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 08:48:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] interconnect: qcom: sc7180: fix dropped const of qcom_icc_bcm
Date:   Thu, 27 Oct 2022 11:48:46 -0400
Message-Id: <20221027154848.293523-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointers to struct qcom_icc_bcm are const, but the change was dropped
during merge.

Fixes: 016fca59f95f ("Merge branch 'icc-const' into icc-next")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/interconnect/qcom/sc7180.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qcom/sc7180.c
index 35cd448efdfb..82d5e8a8c19e 100644
--- a/drivers/interconnect/qcom/sc7180.c
+++ b/drivers/interconnect/qcom/sc7180.c
@@ -369,7 +369,7 @@ static const struct qcom_icc_desc sc7180_gem_noc = {
 	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
 };
 
-static struct qcom_icc_bcm *mc_virt_bcms[] = {
+static struct qcom_icc_bcm * const mc_virt_bcms[] = {
 	&bcm_acv,
 	&bcm_mc0,
 };
-- 
2.34.1

