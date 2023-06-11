Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C58D72B1B2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 13:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjFKLlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 07:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFKLlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 07:41:44 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AA419BB;
        Sun, 11 Jun 2023 04:41:43 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-977cc662f62so488782966b.3;
        Sun, 11 Jun 2023 04:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686483701; x=1689075701;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4F42X28cPOOOe2ZAcaL8nHvp5WVPsAhFgmUSvRppkM=;
        b=M9PRMX2XRt9dtsCQhJsPt9tR1m5I9V0B8MIwNQQ7VI+SGBIa9AVqeTIhK0M6bpDiSb
         nRvYQOX4xatrKjOUNS4wVIO4+8APb+FjocpflVYNWYxFGHIV5dEyUfBSJR/pqpoyCqyh
         0m0G8bKJ6IKNNBd44cqr/zktl2isAQrZyxOJxByQSQ984YvWJul1O7mjVNdA+K/bjpOH
         1nLM0H9UE6G0gqXPIWuYj29ZfPNCCDIjMgKFauR33gQ7TWzy009QrDvXboFlWhIFi569
         4C/uk1bCG9tnfEEb9cjJHtMP8Czoz+6Ow/tfP7PZEaTp0m4zjdE/wquOdIaJZVrYDNfs
         yh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686483701; x=1689075701;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G4F42X28cPOOOe2ZAcaL8nHvp5WVPsAhFgmUSvRppkM=;
        b=Cg+cFn9kpW2rmRIyu3MHdIXajupFG4WRzUn4wkt1Z3md+BgI5P+MTaxdwBebhL7O+3
         8qzaYY9CJrmO5F3CuQkEQudxIrAhCXWeUQqiPXlAye/+nCeWesJPz++dsCA5FP4DadBQ
         +Se/pE3o5+YrszYTU+p9r8YE+vB1WHt0XC7grEIq8Gznbiq+E1PUOPKmWFg47TDS+YKn
         20l1g+BR3l3srpA3Vcj1DywBbqMYuVcIzMsF0Afypx5SxCMjEK4aojLcQQ0e62sUYfHA
         apd7TlrGWoud4rUw9yuVwYHNkdFq2k+lu0Byx6R1fkTxg5KTLj7+gTDpVhL/iumvevNG
         dN+w==
X-Gm-Message-State: AC+VfDzMAbUtCHwupGs+FZV4XulFmkZCFLx/BuYTy1ocH9ysc1T+p99S
        m29JnmBV1ME3bQD1AV1NwgnMSCm67+RPPBcR
X-Google-Smtp-Source: ACHHUZ7PoiVe7AbBq40hxFbakP4HF1ARLZGu43MozI4Fcmp73CNEaRCdXbh/WgW0zF2kawniy8Ek3w==
X-Received: by 2002:a17:906:58d2:b0:96f:f19b:887a with SMTP id e18-20020a17090658d200b0096ff19b887amr7230557ejs.56.1686483700663;
        Sun, 11 Jun 2023 04:41:40 -0700 (PDT)
Received: from ?IPV6:2a02:908:825:7380:d41a:eda:b7e2:a0de? ([2a02:908:825:7380:d41a:eda:b7e2:a0de])
        by smtp.gmail.com with ESMTPSA id f16-20020a170906825000b0096ace550467sm3780377ejx.176.2023.06.11.04.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 04:41:40 -0700 (PDT)
Message-ID: <b99a5149-c3d6-2a9b-1298-576a1b4b22c1@gmail.com>
Date:   Sun, 11 Jun 2023 13:41:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     stable@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
From:   Nils Kruse <nilskruse97@gmail.com>
Subject: [PATCH] nvme-pci: Add quirk for Samsung PM9B1 256G and 512G SSD
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Add a quirk for Samsung PM9B1 256G and 512G that reports duplicate ids 
for disk.

Signed-off-by: Nils Kruse <nilskruse97@gmail.com>
---
  drivers/nvme/host/pci.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 60f51155a6d2..de5e4c7e4bc9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3395,7 +3395,8 @@ static const struct pci_device_id nvme_id_table[] = {
      { PCI_DEVICE(0x1d97, 0x2263),   /* SPCC */
          .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
      { PCI_DEVICE(0x144d, 0xa80b),   /* Samsung PM9B1 256G and 512G */
-        .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+        .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES |
+                NVME_QUIRK_BOGUS_NID, },
      { PCI_DEVICE(0x144d, 0xa809),   /* Samsung MZALQ256HBJD 256G */
          .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
      { PCI_DEVICE(0x1cc4, 0x6303),   /* UMIS RPJTJ512MGE1QDY 512G */
-- 
2.41.0


