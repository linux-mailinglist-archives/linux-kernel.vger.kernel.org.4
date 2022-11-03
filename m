Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7C8617E60
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiKCNuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiKCNuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:50:06 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D07D95B8;
        Thu,  3 Nov 2022 06:50:06 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bs21so2878026wrb.4;
        Thu, 03 Nov 2022 06:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A37ZMyjpowuBe5MIQCPdhqkQNV0cmCgOXOGo/5OfEzI=;
        b=FW0aTI7nEnBdu0iXyT1ZmpklKbrCtLZZguo/PWau6OjNRKqe6nZsE4H8rvx9b5Tus5
         wPMVC7ZxTWE8VqxFK1lOKImJwhQ5vzYTyEiYb619yHBDdcwrB2a9UMAZMmKoZc8ghn2Z
         OsXqDyIo19ypM3/IBE6c+nkFpXRFSJdmOSxRaMaM14kAoZYGzzX5O76oEjALfacSfQcw
         SVUv2IhFWhtCnS1MEnirlQVX15oPbbOlK7fx8qflHM4X35zRwX0IWUaM0oT6zWTaaWuc
         hkPNiGB0cO5YQ9aGuCqUj4nbvqdCWrERoXgsgZd49AGUPgUWIHBTtUm0sXL5HjQuZyI2
         dItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A37ZMyjpowuBe5MIQCPdhqkQNV0cmCgOXOGo/5OfEzI=;
        b=4cay0xNQqvYBLxKIPBiFf+GjpcZOwWbsfDosI9wccnl64/r7GDqbmkYtxpdGNQmjI3
         whkrJZ5JbANVgx/M55xmfYrxXJ+gJScKtM1YWgcJQaahGc2keQ/t3vnNhRfJZgH5m9aq
         xBfyZnela6ybHkL+d4p/4QyPNtIjXfPndm5JJUxB4Dd1asnbfNHUJ+CQPW4iVGunByjL
         flq0KhpZtXoTNWvgp91uv+c6CAOEEEmB37Kv/ibqDkUxTzRzj7oPQJwWCKwq1Hhr0PPB
         qq3W1VoJ6npu+5SPZgnskGKc/eVazH88Fbygs0x2+kIq6xoNDS79TNj5LByZ1IoNtRbX
         r2sw==
X-Gm-Message-State: ACrzQf3q3CgirsGyktTJgyAnzISUD01nhvqniud2fomsABzvYsWoqjIf
        EKP9Y/9bL93Ucr/VbShud9g2vr3g8xQ=
X-Google-Smtp-Source: AMsMyM7AhTVOSV+Ga94VoTuFy4oB9Ti5NKQx5CTsfoWVYAb0mTQIMkTiwF3qvlj8qgyipv9+1AwDIg==
X-Received: by 2002:a5d:4e88:0:b0:236:590:f5a9 with SMTP id e8-20020a5d4e88000000b002360590f5a9mr17658547wru.126.1667483404655;
        Thu, 03 Nov 2022 06:50:04 -0700 (PDT)
Received: from localhost.localdomain (93-42-71-18.ip85.fastwebnet.it. [93.42.71.18])
        by smtp.googlemail.com with ESMTPSA id bt12-20020a056000080c00b00236576c8eddsm957414wrb.12.2022.11.03.06.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:50:04 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v2 1/4] clk: qcom: gcc-ipq6018: drop redundant F define
Date:   Thu,  3 Nov 2022 14:49:41 +0100
Message-Id: <20221103134944.23275-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221103134944.23275-1-ansuelsmth@gmail.com>
References: <20221103134944.23275-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same exact F frequency table entry is defined in clk-rcg.h
Drop the redundant define to cleanup code.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq6018.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq6018.c b/drivers/clk/qcom/gcc-ipq6018.c
index 3f9c2f61a5d9..350ead66914c 100644
--- a/drivers/clk/qcom/gcc-ipq6018.c
+++ b/drivers/clk/qcom/gcc-ipq6018.c
@@ -26,8 +26,6 @@
 #include "clk-regmap-mux.h"
 #include "reset.h"
 
-#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
-
 enum {
 	P_XO,
 	P_BIAS_PLL,
-- 
2.37.2

