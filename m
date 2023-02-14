Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083E5696712
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjBNOi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbjBNOiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:38:15 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E50725B98
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:38:09 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id a10so17665835edu.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSHlBADaeK5eFrFjJgn2OtkHxC346mVqKTE4q7ml+Fw=;
        b=JOZ8rJWtYrzYeN0+rGbqI/wx8EuNL3DrY3GjN2dAlPM7z3Sb/R+cgOEkntfp6Y9Ix+
         BiQDAp8wTkrzFkYjBT39wGovWXz6Rdob/U6aMFGB51hLaelvNuYW1tPz9c5MSennNG+9
         STbVdcm8DctY2vEuMBi4C0Ws8CPKfzzaxGEttI/4trrjnZ9KEPRvv5v7mkP5WhIgQcSg
         ukU0vDm91gUQRdwujboW/Q0Gu5TTTqfPXPX4frBmtGIMfR08/H8h6LAOA4ZtP3PW5mgY
         se7pyyXBG9Uzr6FqUyZnBxw4NO+RdMugjo3jcZ5w1/mIabQOSKU5VMnVO+eIM4SjOMNM
         mRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LSHlBADaeK5eFrFjJgn2OtkHxC346mVqKTE4q7ml+Fw=;
        b=7smvXAxITgTXuZXZX86GcS9DzQOyivvYCz5YNw9o1/b2VB15ZGYV6AUBD7xB0O0r/3
         ZgmZp70xgAv0xqYvorBp6Tcgw4iIgIKwIyQJgIHC8YFO0iaEaSxhvFDf4vLjuspellSQ
         mA2tqcpHE+yTvsSiy6X0aYcj24M01425wDgGOWGVuFgALV8rtOHCFLQvDIM0AxaJMsrO
         vDx6pbJRN/Engx61FT06LtYxJSs+NwP7SzNpKovnpZlZ6b5FrjAySjHykAlKs1SM/Mx8
         aeTmSM7zF2PcyemfL+eBuvFAeUdCUdUOhKsgiqyxS3nO5lBQVn9Zn0Jmj7ks5ti39MIY
         nIWw==
X-Gm-Message-State: AO0yUKUalG+2SWayATBxUGVxDKs933RyB2CSlMgwvpo7HCHpu5TckMMo
        4V4t2gxt6mXIpevQPnYkBbhYYg==
X-Google-Smtp-Source: AK7set9uuTJEmNmbrlKkvp5NQcZ4mib7QOYAsmrJV7OxGCpp3r1RJfIzRFqNDfbjKT6/dmMN6KRs7g==
X-Received: by 2002:a50:8e4f:0:b0:4ac:d2b3:b724 with SMTP id 15-20020a508e4f000000b004acd2b3b724mr2581423edx.27.1676385488086;
        Tue, 14 Feb 2023 06:38:08 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id eg21-20020a056402289500b004acb6189693sm5378052edb.83.2023.02.14.06.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 06:38:07 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/12] interconnect: qcom: icc-rpm: Allow negative num_bus_clocks
Date:   Tue, 14 Feb 2023 15:37:15 +0100
Message-Id: <20230214143720.2416762-8-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214143720.2416762-1-konrad.dybcio@linaro.org>
References: <20230214143720.2416762-1-konrad.dybcio@linaro.org>
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

In some rare cases, buses will not have *any* bus-scaling clocks,
which is "fine", as the voting can be done through RPM provided that
the necessary QoS clocks are enabled. Allow specifying a negative (-1)
number of clocks to make the driver accept such cases, without having
to add a lot of boilerplate to all existing ICC drivers for SoCs with
SMD RPM.

FWIW this value was previously being assigned to a >>signed<< integer
as well.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 729573f0d9fe..9dd631964b8c 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -96,7 +96,7 @@ struct qcom_icc_desc {
 	struct qcom_icc_node * const *nodes;
 	size_t num_nodes;
 	const char * const *bus_clocks;
-	size_t num_bus_clocks;
+	int num_bus_clocks;
 	const char * const *intf_clocks;
 	size_t num_intf_clocks;
 	bool has_bus_pd;
-- 
2.39.1

