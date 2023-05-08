Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1A26FA235
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbjEHI0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjEHI0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:26:02 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337481A12C;
        Mon,  8 May 2023 01:26:00 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1aaf21bb427so29649455ad.1;
        Mon, 08 May 2023 01:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683534359; x=1686126359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtLgsCbQA18vCCbTX233GJS8Y1W6cCFoICqxu5DDlZ0=;
        b=hhPPUp4ugNyRQ4Hgv6YmYt0UkPsbXat2Wp/4UfMwgu05qY7ISuZ+3ajXIoojG8oZzU
         V6v3GdFDWcmpl/08fKuYjJfSy8cI4GeVXAHXoQVMTuOl9ncXrGof5DgTGzmvz3TaHFGm
         VCX0rDr9VAT0DL+JyWUyr9E8cvKes1+JkwnInaqRu68I7Z65nmZU4AJk1cULibB9Zyul
         //GNzCMuiw+l7W6zC/PiOVf4ni0/JrT/O4kYdzglSE6XSkbQKgJrREHBDBMlCAILKg4L
         QQnRI5Y1LkhQJGultdccn74LsXgGoJ9C/N0PZlCJjlvz4kDq7VSncnmUiHQAyQZdEtN+
         ITTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683534359; x=1686126359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtLgsCbQA18vCCbTX233GJS8Y1W6cCFoICqxu5DDlZ0=;
        b=GNFaWNfHatmIlMNtkBnvELWyQ0S/z8oWX5GWwwd9+XA9t8I6PQn3dzu7UE+vFXbM2h
         /1tm8HcaqZSan/TfmfqVUP9XU0UCfzD/ssVqO81q7BUi8Lu9A8sHhnZH2BY/lsbjlAh4
         1cdsvz0L3CbuhEKBAnzXw4HfI8ceEdZtZ4qN6qAOVFWfO8zWlcpdq0vVlKZ2ww+zh1/1
         8Ep3bQYJs8FB9zneM+HGj+z5TK/gl6C4a+TkO6HSuTfhTb5uUeHL9vsyI+rR2i8tIoLp
         VUuU2BYp8axjPg8U0l3Y5LObQ7D4zWK1ig/pPLZ9+8XHw6Dx2zGAXjNrPIC2AMCga7qt
         9L6w==
X-Gm-Message-State: AC+VfDygZ3+9i2k/eI55g06fHOluIRY67LIBGJuRVYaQLm+5Yk1Xcorq
        PMyAjAzE5idPkaS6XiQ/H7XfwjI/4BI=
X-Google-Smtp-Source: ACHHUZ5+jlpMmX7LKvwkl9yszBMjKgJFmGkEJ5GaZWvYWHhDssp8dKf32SSYOv1NXFIdZDjSh/x0fA==
X-Received: by 2002:a17:902:f68c:b0:1ac:8148:8c50 with SMTP id l12-20020a170902f68c00b001ac81488c50mr1928154plg.28.1683534359287;
        Mon, 08 May 2023 01:25:59 -0700 (PDT)
Received: from cxl-test.. ([103.181.222.211])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902ea8600b0019c13d032d8sm6497933plb.253.2023.05.08.01.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 01:25:58 -0700 (PDT)
From:   Raghu Halharvi <raghuhack78@gmail.com>
To:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        raghuhack78@gmail.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] cxl/region: Remove else after return statement
Date:   Mon,  8 May 2023 08:25:31 +0000
Message-Id: <20230508082531.136281-3-raghuhack78@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508082531.136281-1-raghuhack78@gmail.com>
References: <20230508082531.136281-1-raghuhack78@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Issue found with checkpatch

The else section here is redundant after return statement, removing it.
Sanity and correctness is not affected due to this fix.

Signed-off-by: Raghu Halharvi <raghuhack78@gmail.com>
---
 drivers/cxl/core/region.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f29028148806..a46d6ad9ef0a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2666,11 +2666,11 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
 				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
 			clear_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
 			return 0;
-		} else {
-			dev_err(&cxlr->dev,
-				"Failed to synchronize CPU cache state\n");
-			return -ENXIO;
 		}
+
+		dev_err(&cxlr->dev,
+			"Failed to synchronize CPU cache state\n");
+		return -ENXIO;
 	}
 
 	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
-- 
2.39.2

