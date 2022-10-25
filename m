Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C620360D203
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 18:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiJYQyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 12:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJYQyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 12:54:36 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3865017040
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:54:35 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z14so8634774wrn.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uS90p+hsrRE9B1prQWjGTxZ3q09/vh+vkeEVG+A77cc=;
        b=D1P9GpRfJZNcT1U+eUclmqyHKr0Tvag/y5A8g1b+zEoYaI4TE/mM3lculExvJuyXMm
         DNUxNOY3XFeHgkiXYwRFZH16I0iRPwM/ygbyjmanVd6hRKz7X2CCrkS8UpCkM0sh7vc1
         nTZlqG6wyfvNNXGiXamEvkUfEeVjlWhn0hmm13XdBzpT/hSiDqt3S1nBYJaJxBNNCGkC
         Wk0HFGiybyd19SirggP/sTW9Dv6Y0OOZsnE5NwiwCO8XOve7200agX8Df2oU8OwwKLCv
         +TqtwlkmbKWt+t6m5xZ+Ae+jFS16VpoBZDOyiN1guR8s5tHm29bW7TjoenZY+oHjpcC7
         n51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uS90p+hsrRE9B1prQWjGTxZ3q09/vh+vkeEVG+A77cc=;
        b=nwl0fkQu5WpVKtSfQN1Ff7G7ZylLc4sYS90Mm/9Gspts0hyqLYwOZNcjnS1eQEM997
         pbAQZKaBpztl0zCU7A8JfzS+AWhCJ28vGQzL2u2MhrjCm7QpN/MI2a6innKwtm60qlf+
         6Xl31SjA6qrVyHh68MpuA2qFu9sS4ynX3pWNgjap7peFPeFhQiTCSMlAGTNMNHgS8o5j
         LPigr/RsFlsEETAkF84U3qIQI/Hrjsn25ORJcBK2j1dI0PJadfLUhjURBLcRIl0Ahtvb
         NVVX9rIqJ9FBBO5o1uActPq4++6Y0YD4yu7V3Ea23tF2ZMcGPDnjR6Fuf16rr/mKF8yM
         InaQ==
X-Gm-Message-State: ACrzQf3OqURPDoQ/Q/ytmjHTLN54gXK07Gm+vvc8N8HRDdXKnNftqUoQ
        ++2fJvAKAN/6Am915+nfKjY=
X-Google-Smtp-Source: AMsMyM7osCtL7dKCqolh+3Z3vX4GYaQzlWb1z13VKMCG2LFb9T5Quv+2EobiuqiVwzTyaKKbjmbzBw==
X-Received: by 2002:a5d:59a8:0:b0:22e:d6ff:3a7c with SMTP id p8-20020a5d59a8000000b0022ed6ff3a7cmr24909840wrr.128.1666716873721;
        Tue, 25 Oct 2022 09:54:33 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id a20-20020a05600c349400b003a6a3595edasm3023989wmq.27.2022.10.25.09.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 09:54:33 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     maxime@cerno.tech, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com
Cc:     wens@csie.org, samuel@sholland.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 0/5] iommu/sun50i: Fix various fixes
Date:   Tue, 25 Oct 2022 18:54:10 +0200
Message-Id: <20221025165415.307591-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
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

Testing IOMMU together with video decoder (Cedrus) exposed many bugs in
sun50i-iommu driver. This series addresses all issues so video decoder
works well with IOMMU.

First two patches address recovery issues in interrupt when either page
faults or permission errors were reported. Third patch fixes permission
domain assignment. Fourth patch fixes dma sync size. Sometimes sync also
touched some other buffers and kernel generated warning in dmesg. Fifth
patch fixes issue with syncing PDE and PTE tables. Without it, page
faults were randomly generated even with valid iova addresses.

Please take a look.

Best regards,
Jernej

Changes from v1:
- rebase on top of v6.1-rc1
- replace last patch with new one - Implement iotlb_sync_map instead
  of invalidating each page at each allocation

Jernej Skrabec (5):
  iommu/sun50i: Fix reset release
  iommu/sun50i: Consider all fault sources for reset
  iommu/sun50i: Fix R/W permission check
  iommu/sun50i: Fix flush size
  iommu/sun50i: Implement .iotlb_sync_map

 drivers/iommu/sun50i-iommu.c | 88 ++++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 5 deletions(-)

--
2.38.1

