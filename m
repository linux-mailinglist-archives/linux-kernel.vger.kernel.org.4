Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10FA6F0FF9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 03:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343716AbjD1BW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 21:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjD1BWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 21:22:54 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8442703;
        Thu, 27 Apr 2023 18:22:49 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b8b19901fso11082781b3a.3;
        Thu, 27 Apr 2023 18:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682644968; x=1685236968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MPajQmXQGIwF2HyN1A4/AnHxv20zylpy6p+xELO3g+g=;
        b=BvJ89HWTbn3AmTAoQhva07IVXRNpf0XcKbpMBNJmk9DTry5Tk3hxGTJZT+45XE/g2V
         9dNWQ8GNgpb2zUbwmfjuLNp5iKrNkxX6bMgUPEqnlZchDyVfn7wQwZlzxbKK7XeWh1cD
         ljXj6yvRiK8wTYAZdyCYO35hIf1QmFhaiVYQMsKMOsvC1BWlySBAaW3isnbe++gtcMxw
         fq5E0WjQ7NnZHg/SSHFHhEl8Epdaep3lOrJi8wi9KIHZu2v5HKm2247BEUAhYP8oHgOp
         B37N1Jo40dT/g2Wni5Oqz3mQFC2zCpmokux4XZJ7KSn63LB1wzlNdzZKcV72c3l4EgbO
         zLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682644968; x=1685236968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPajQmXQGIwF2HyN1A4/AnHxv20zylpy6p+xELO3g+g=;
        b=IuQu6z8fEM6+WofHVzffWe1B2Ld5mlOBXVFJenFV1NBUg4bJf9fOgNvUB7Ov6mQqTq
         6wuciDwQHPqjGuSbFLFrAfY9yzz+U7E6OFDMWQx3K5SFxtovX4tmGzkH52HUmkJK1mYm
         vjwgBeVZnoxkF41BsIdfBWh0JkCVCcwBwEd5XMhozUZzGntfY7BdwDLcF24yFeNhtmK3
         yzJssSBsBFl64dyhrac8vBG0XYck5BHtywvY2wCqOLtoFtHxu7qmFbYH4aEK8WPWdGzi
         8R/fRa/8JpSk2EGNEmdiSXB8w8jBqyIiIROoZUJ2QxX2JSlsRlJMdKmgOvIGh0mfxWdI
         Cv3A==
X-Gm-Message-State: AC+VfDz7h7AwCTX5ViUSuvLiNQVBGLliwtP32TrpYwMifXkKHms3IQ7R
        kSMXjB/bxiL84rjAFVThlId7+apxvLc=
X-Google-Smtp-Source: ACHHUZ76nVc91TRWfs+rdK7rULrVvLw6fw1D+yXLukyxd0lRoC6CrMxtG0+05N81yuVIRuEwVKoNsQ==
X-Received: by 2002:a05:6a00:b84:b0:63d:3a18:4a03 with SMTP id g4-20020a056a000b8400b0063d3a184a03mr5040002pfj.5.1682644968623;
        Thu, 27 Apr 2023 18:22:48 -0700 (PDT)
Received: from cxl-test.. ([103.181.222.211])
        by smtp.gmail.com with ESMTPSA id t65-20020a628144000000b0063b8b8580a7sm13691356pfd.29.2023.04.27.18.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 18:22:48 -0700 (PDT)
From:   Raghu H <raghuhack78@gmail.com>
To:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        raghuhack78@gmail.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Fixing check patch styling issues
Date:   Fri, 28 Apr 2023 01:22:33 +0000
Message-Id: <20230428012235.119333-1-raghuhack78@gmail.com>
X-Mailer: git-send-email 2.39.2
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

v2 changes:
Thanks Alison, Ira for your comments, modified the v1 patches as suggested.
Dropped the patch containing tab changes in port.c

v1 cover letter:
The following patches are cleanup or fixing the styling issues found
using checkpatch

In cxl/core/mbox.c, in case of null check failure, returning errno or
-ENOMEM in this case is good enough, removing the redundant dev_err
message.

In cxl/core/region.c, the else is not required after the return
statement, cleaned it up.

Verified the build and sanity by booting the guest VM using the freshly
built components.

Raghu H (2):
  cxl/mbox: Remove redundant dev_err() after failed mem alloc
  cxl/region: Remove else after return statement

 drivers/cxl/core/mbox.c   | 4 +---
 drivers/cxl/core/region.c | 8 ++++----
 2 files changed, 5 insertions(+), 7 deletions(-)

-- 
2.39.2

