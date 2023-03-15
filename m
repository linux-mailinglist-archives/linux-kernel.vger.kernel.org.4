Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1EF6BB0FF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjCOMXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjCOMXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:23:24 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B03A968E5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:22:20 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ek18so43581755edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678882936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=an/apiKnnf6j37nOP1Xq7Z6MZ50pKDsSAi66GrBqtBc=;
        b=mVL65eONLHYX1OUZQduFPTkQaS+ywjuG0/rfDmFAzZZtj/tsrnmbkFB/zPzvhJ/0pW
         WFIbCKWRcEw9a1h1LQR57+XEWW/rAKz4GBQkhJRVGx74FIpw7fo7Y+MPvWj1O3TzpFI+
         Y8WEuHcpKbv9XQx+vOq9k+dKKhMmbiD7MQR33VGu7zbKSxj+Uy6SUGpytdOidCIjLnlT
         oarwnuf2C1N4ZwT9903xAtBAxVt+EJQptm0FIT/YcDbWOZ2glt6SSe28rS5jPdjd+YQh
         eXoCBE3S1j4fq2J8wfNkm9jcrIBHOajhGKaTTNepQyVCLRF08Wojl2QWGl3YSHqeaPMO
         Sopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678882936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=an/apiKnnf6j37nOP1Xq7Z6MZ50pKDsSAi66GrBqtBc=;
        b=PK1AKm8NC13swDsbihl0uoE5/EohDsZDSruFN5yCcF/klr/M7mNpMzaQFmGFOn2odm
         N5SD4pLNtLjTSy+lTaJSlkYqKx3AiMLL4g2SV6hTqAwVCdLSGgLlqbtIFCr39uy/6oCa
         rJ2OYs3yf23Gcrw0XGW7sQm8+f0ncSkVOUbPdkNdFzJMiPTqO4zSF25W9pIoDXOAofCe
         KUuD/FXV8SNo8tCQyiMXSM+eaDc3Dl9vXHUjjjo9LnP63E2nVuBWFak60ST1KrwHtMid
         r+iAEs0PYHQthrMBhJhj1spDn+Zs9KdYv6bgveX1MNXyJkh5NOTBH93VCG5VbiJXyd+L
         ZBzw==
X-Gm-Message-State: AO0yUKUptJEBx6aYimgoYJo0XsF4g3D5+8iU2nynj164+cFNoUZ6F3kQ
        9VvJE8qH5vxuwB7DdWj7aBs=
X-Google-Smtp-Source: AK7set8PENzz3XTAQa0XPJGPYXvNL9r5nhBLH8iTnJBN4c3tp7zSVnXIUQp4eJYdE7FZqQxe52VyCA==
X-Received: by 2002:a05:6402:14da:b0:4fd:2b0f:8765 with SMTP id f26-20020a05640214da00b004fd2b0f8765mr2058408edx.12.1678882936442;
        Wed, 15 Mar 2023 05:22:16 -0700 (PDT)
Received: from alaa-emad.. ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id m1-20020a50d7c1000000b004fc856b208asm2383663edj.51.2023.03.15.05.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 05:22:16 -0700 (PDT)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, martyn@welchs.me.uk,
        manohar.vanga@gmail.com, zoo868e@gmail.com, jerrykang026@gmail.com,
        cuigaosheng1@huawei.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        eng.mennamahmoud.mm@gmail.com
Subject: [PATCH 2/2] staging: vme_user: remove unnecessary blank lines
Date:   Wed, 15 Mar 2023 14:21:33 +0200
Message-Id: <8958127fc8fdb4fede7867f38579578af924b719.1678882204.git.eng.mennamahmoud.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b56c7b94e59a4051373af8b5d90a0685dfc9233a.1678882204.git.eng.mennamahmoud.mm@gmail.com>
References: <b56c7b94e59a4051373af8b5d90a0685dfc9233a.1678882204.git.eng.mennamahmoud.mm@gmail.com>
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

remove unnecessary blank lines before a close brace
as reported by checkpatch script

CHECK: Blank lines aren't necessary before a close brace '}'
+
+}

CHECK: Blank lines aren't necessary before a close brace '}'
+
+}

CHECK: Blank lines aren't necessary before a close brace '}'
+
+	}

CHECK: Blank lines aren't necessary before a close brace '}'
+
+}

CHECK: Blank lines aren't necessary before a close brace '}'
+
+}

Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
---
 drivers/staging/vme_user/vme_tsi148.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
index bfa604043355..2f5eafd50934 100644
--- a/drivers/staging/vme_user/vme_tsi148.c
+++ b/drivers/staging/vme_user/vme_tsi148.c
@@ -1023,7 +1023,6 @@ static int tsi148_master_set(struct vme_master_resource *image, int enabled,
 err_res:
 err_window:
 	return retval;
-
 }
 
 /*
@@ -1741,7 +1740,6 @@ static int tsi148_dma_list_add(struct vme_dma_list *list,
 				  list);
 		prev->descriptor.dnlau = cpu_to_be32(address_high);
 		prev->descriptor.dnlal = cpu_to_be32(address_low);
-
 	}
 
 	return 0;
@@ -1773,7 +1771,6 @@ static int tsi148_dma_busy(struct vme_bridge *tsi148_bridge, int channel)
 		return 0;
 	else
 		return 1;
-
 }
 
 /*
@@ -2220,7 +2217,6 @@ static int tsi148_crcsr_init(struct vme_bridge *tsi148_bridge,
 	}
 
 	return 0;
-
 }
 
 static void tsi148_crcsr_exit(struct vme_bridge *tsi148_bridge,
@@ -2530,7 +2526,6 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	kfree(tsi148_bridge);
 err_struct:
 	return retval;
-
 }
 
 static void tsi148_remove(struct pci_dev *pdev)
-- 
2.34.1

