Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187EC6B0BB6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjCHOoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjCHOni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:43:38 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F700D08C3;
        Wed,  8 Mar 2023 06:41:57 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id g3so66799808eda.1;
        Wed, 08 Mar 2023 06:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678286496;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+JUoEiDjiVAF4hinlDEQAHLm42+5L3JayYCS+t/dGI=;
        b=YgQKkB5o9lGKdTSTzpvNGjP+WTSAbSw0TXvtkc7h+vfVXfnFJI38yNmcGSXm/tiofh
         llophtlweoJE7W4nLp9FgiJwy8ZhEhgGGxXUBLDcZDpMSWdovrcMHFv5ohV2mrs3V0XZ
         BFhD1ZTWgbF3vbSfWuso3+y4F2BXB36M1veC5K3ld0CYiniLKWNBauBLpWeSpUJMUou8
         wACGNw4jSpGhH94Xs3InBzv25yjxL5Jy9ERkfDrJ1ew5aKZvWckhAe4vhBMLpYHavYb5
         UgwkzK6i8lK4f1h1VmZetp9qgtJh44CFdpQU5O59vCAyCdCLefxYbkeEqWTdC7tStRmy
         rmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678286496;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+JUoEiDjiVAF4hinlDEQAHLm42+5L3JayYCS+t/dGI=;
        b=4jrKog4WDHLVrzyYyrrbKSC3FZ4vEO0vjqWNpgS/s5PIdtKzlSDPotReIF1U1VU7fP
         OPy7+xyeKc/qAMAlDd83b4FbuECdqQoKUKza0GbKvLXHR4IiV9+agev9ZBf/OEr7qOlu
         UM0/HJqG9QQ+4c4fHdh9dPwyKBcl4AS3oS2bXuzGnublRv14ZY5EbAtAaOVTnBzCBHcF
         gq1sWyzH+3UKfGAg2ZWlwTWT3qR8p6cDEevtYAuIJmcQ5KJXCU4bh4VsYsJOr+MYqNX5
         zMxlkt1egArXJD5uVRlkOcgKXJs3Ki7NZe3iyQQeaoiJdiJKT7bm9Bbp/GRZooPmkcXQ
         +TxA==
X-Gm-Message-State: AO0yUKURx2vI6iIUxm4Fi5RZF1zHVjPdzHYDt+kRorYRq4CzXo+ylcCI
        PaQFxs9kEsAGv/KVPIHyAt4=
X-Google-Smtp-Source: AK7set/F/vAHk6cQOofkDJMVBMZUYjEPMWZm+MonLPRbXoJZTwkysJFfvEfV1hELi/mA+jpIqFUbeg==
X-Received: by 2002:a17:906:fe07:b0:8b1:7de3:cfaa with SMTP id wy7-20020a170906fe0700b008b17de3cfaamr24945626ejb.3.1678286496524;
        Wed, 08 Mar 2023 06:41:36 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:c4be:f7db:77fd:b9e5])
        by smtp.gmail.com with ESMTPSA id j23-20020a170906255700b008d9c518a318sm7687620ejb.142.2023.03.08.06.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 06:41:36 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: repair malformed T: entries in NVM EXPRESS DRIVERS
Date:   Wed,  8 Mar 2023 15:41:32 +0100
Message-Id: <20230308144132.13368-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The T: entries shall be composed of a SCM tree type (git, hg, quilt, stgit
or topgit) and location.

Add the SCM tree type to the T: entry, and reorder the file entries in
alphabetical order.

Fixes: b508fc354f6d ("nvme: update maintainers information")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a51fdde146db..dd805e784e6d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14905,12 +14905,12 @@ M:	Sagi Grimberg <sagi@grimberg.me>
 L:	linux-nvme@lists.infradead.org
 S:	Supported
 W:	http://git.infradead.org/nvme.git
-T:	git://git.infradead.org/nvme.git
+T:	git git://git.infradead.org/nvme.git
 F:	Documentation/nvme/
-F:	drivers/nvme/host/
 F:	drivers/nvme/common/
-F:	include/linux/nvme.h
+F:	drivers/nvme/host/
 F:	include/linux/nvme-*.h
+F:	include/linux/nvme.h
 F:	include/uapi/linux/nvme_ioctl.h
 
 NVM EXPRESS FABRICS AUTHENTICATION
@@ -14945,7 +14945,7 @@ M:	Chaitanya Kulkarni <kch@nvidia.com>
 L:	linux-nvme@lists.infradead.org
 S:	Supported
 W:	http://git.infradead.org/nvme.git
-T:	git://git.infradead.org/nvme.git
+T:	git git://git.infradead.org/nvme.git
 F:	drivers/nvme/target/
 
 NVMEM FRAMEWORK
-- 
2.17.1

