Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423DF6D89C7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjDEVsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjDEVs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:48:27 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13EA7ABA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 14:48:18 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9333b408ee7so6786266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 14:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680731297; x=1683323297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JGf4CDz/ojeKgq8HqlEbK5p5WGgynUCEomlEJjCxWhM=;
        b=aghOJD4TuORdaH/ZUiY+JDoFWh3nrYi3NeUlaYtq/KLt7TYl0mM8AcXkee9Ho5PKUC
         NkWPS5ZfJEjKU8PH2cvxqzgPdHeYnvPk0Fl2bjbIKHQUvgu1OKwh/Hyvgb8lgk1QAU4u
         zJaxcHbIvjYZZBjQ5PzrXHS55I8XMI/D6gU+OLv1ufgczgt6pBB9hVXRWgmW0+jY/aPG
         URRp++npKhL2RPM9oaFW8p1hZ0BxWbUp5PZlhKy77QzPcGS0F1b1MfBD3EG3YsQoEEAE
         uI9BCGsJnik/QEB8RUYafedIjtC5OqMmAK09FAplhBRB2R0GAF5eavKIZgZ89qRTHpTP
         ThiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680731297; x=1683323297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGf4CDz/ojeKgq8HqlEbK5p5WGgynUCEomlEJjCxWhM=;
        b=4zNoyXfzKflUvQlvLJSoP1i/U3wpHz3ReTJQ1R/8J0X01T90E7VpDAFf4dRTdD+p4u
         ZIleMCiw9nJAuYOmGW10aj3+h7EVCJX9iW2e8ZG0xFfPBv8NkLm9XoaqMF1jY1gTqkTE
         bKiqEmpu1ksDQ3CNX2doqfbycph5qyFZ49zao4O7eowPPlKryQVh0a2Ep3XGa6kVrvEG
         EQ+PHjyMDBf5q9NaSaPYVesBUWtqQg1Qv0bOkqW5qEXTaUjEUtVJlinLOjU+TwPXmRem
         YdHx9bKoG0ApHh6YxWjyUyCncTPbFoONZdGFJZqu3UaIwN/1xkxeW4+GMdmeVX1Y37bt
         K/Dg==
X-Gm-Message-State: AAQBX9e4lUTL3n2mRuHpSZ9VR7XEBAjqLhqC4HA69XZxBRP9E5BxpiTj
        1tLNhIBLySwBSkxA/jucP0o=
X-Google-Smtp-Source: AKy350aL32Ata6jTzeVFU+FFgZdQzbZAcE5vD6P7WpyYuKK35Q/PXqvwYGS8MKPO1PheAtfXzBEFcg==
X-Received: by 2002:a05:6402:268b:b0:501:ea97:519c with SMTP id w11-20020a056402268b00b00501ea97519cmr3797657edd.4.1680731296918;
        Wed, 05 Apr 2023 14:48:16 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id u3-20020a509503000000b005024a7013ecsm7755606eda.35.2023.04.05.14.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 14:48:16 -0700 (PDT)
Date:   Wed, 5 Apr 2023 23:48:13 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] staging: rtl8192e: Remove one of two checks for hardware
 RTL8192SE
Message-ID: <ca07333d0d03878935183025ffab969759aff3cd.1680729715.git.philipp.g.hortmann@gmail.com>
References: <cover.1680729715.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1680729715.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check for hardware RTL8192SE is done in function _rtl92e_pci_probe()
directly and also two lines later in function rtl92e_check_adapter().
Remove top level check to increase readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 7506d7eb7b4c..45989a77a27c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -2130,7 +2130,6 @@ static int _rtl92e_pci_probe(struct pci_dev *pdev,
 	struct r8192_priv *priv = NULL;
 	unsigned long pmem_start, pmem_len, pmem_flags;
 	int err = -ENOMEM;
-	u8 revision_id;
 
 	if (pci_enable_device(pdev)) {
 		dev_err(&pdev->dev, "Failed to enable PCI device");
@@ -2189,11 +2188,6 @@ static int _rtl92e_pci_probe(struct pci_dev *pdev,
 	dev->mem_start = ioaddr;
 	dev->mem_end = ioaddr + pci_resource_len(pdev, 0);
 
-	pci_read_config_byte(pdev, 0x08, &revision_id);
-	/* If the revisionid is 0x10, the device uses rtl8192se. */
-	if (pdev->device == 0x8192 && revision_id == 0x10)
-		goto err_unmap;
-
 	if (!rtl92e_check_adapter(pdev, dev))
 		goto err_unmap;
 
-- 
2.40.0

