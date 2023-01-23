Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EE2677EB9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjAWPHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjAWPHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:07:14 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5E83ABA;
        Mon, 23 Jan 2023 07:07:13 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id n7so11103607wrx.5;
        Mon, 23 Jan 2023 07:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2r/jQsT2oEtOaIcS9vBErqTIfKM514JHFTcSRlzNiJk=;
        b=NI9VeMmKPpbbz0TCCZFqlACCyCjRtIQH1LXay4iHb5L7cwXC9C05rVzDy8t4boOARD
         ITqqWkdZFg7s2dhkfzDTO0PYouCczNUgmF+g0YNlPypmfQSuxkf3gwgc0duluEn5zYRe
         BGj9luGazljmvjSSK2kIM6dkPKipT0gSqF/d9p5/6Koa6Wid4/sy5ZPSc0XvxveIANNL
         OLmoxPLeorbSCHvaRFPquDrzvdacAeSEWCXY42GIyODGEhGAAU5kpNZnK9BZLN4alsXe
         6CCqQjhq0hAxdpyuOyKTM/TAiyOYtOiMc3Px61GIiQ0oL4dOz6mvsI/ahi9gmNe0cVeT
         buSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2r/jQsT2oEtOaIcS9vBErqTIfKM514JHFTcSRlzNiJk=;
        b=OV4h8bfhGhX8RuaTzKJ1IX8pUzKOZHZ/8mms97gCr9KVc2VljVoYxabJrVf5HFpe/c
         PGPNR53TRzl0W8cgJPyfj+bVuXVzCyQ+2U6WxsMLEu3Jn0YoQK7Rszm7TUnuZ+vrMEwy
         gxJf+/h9ElxWIufu2evQe3RvfsXFeUTfcl/GpTelpKdNYbyO007K7b6YtUfiCmL4+5+j
         3jS8RgErbd7PqsVqVide8VrAeFqwsew5JlBVKnvu+LtMLu11goJHxx573vrqSaDSkmol
         veHsadqP4PXQhSsVKcd4dpZPlIMrG3UnwXgmv39wCsaH+7rFncE4QO0X5TCV7J1XTLYg
         wA4A==
X-Gm-Message-State: AFqh2kqtegPVtG3d/g63bRLz0EWuWBLl28o7vjPUHWBGfuDPbxLCcqxw
        x6t0xANYWA/iQe7Rf33Z+p1Dhn74R3ElPA==
X-Google-Smtp-Source: AMrXdXsU5OJbMtMy8HopokShczr+JtKjkxOBLstZUM6HS5OjuWvTMCsoLgWmESZH43ffbscSu/cnPQ==
X-Received: by 2002:a05:6000:98d:b0:2bb:6d44:5d1 with SMTP id by13-20020a056000098d00b002bb6d4405d1mr24853979wrb.28.1674486431669;
        Mon, 23 Jan 2023 07:07:11 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id bu3-20020a056000078300b002be505ab59asm8888399wrb.97.2023.01.23.07.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:07:11 -0800 (PST)
Date:   Mon, 23 Jan 2023 18:07:07 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] firmware: arm_scmi: Clean up a return statement
Message-ID: <Y86im5M49p3ePGxj@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comments say "enabled" where "disabled" is intended.  Also it's
cleaner to return zero explicitly instead of ret.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/firmware/arm_scmi/driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index d21c7eafd641..703f16ef3953 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2739,8 +2739,8 @@ static int scmi_probe(struct platform_device *pdev)
 				if (ret)
 					goto clear_dev_req_notifier;
 
-				/* Bail out anyway when coex enabled */
-				return ret;
+				/* Bail out anyway when coex disabled. */
+				return 0;
 			}
 
 			/* Coex enabled, carry on in any case. */
-- 
2.35.1

