Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66A15EFD6D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiI2Svd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiI2Sv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:51:29 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C57213D850;
        Thu, 29 Sep 2022 11:51:28 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bq9so3553624wrb.4;
        Thu, 29 Sep 2022 11:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=oF8quAZt/UGI/XaB3QdYWqoNI2fEzHCMZrTFMKPpS00=;
        b=hHPE3Vrqa5zd3aovFYAl7iTjau1sdZPNAMDXX0C8eoZJvQ4pXlmqJv/iBERl818oNk
         PEJ8wBo0etQRl/DQ6N0QziiBfymzs9KWYSJH5aIrnSB2OPuUVsmUz+qKCzFZ9s7n8FCJ
         k3EGnR3IWsKbGTjDEAwMzG1Vlivy3Usyv028LhcUHjjcJ0hAfwSBDprJqOWXijPxXBmY
         A2Jn7kOb/IB2ymF26ncKaAQXRseTj7zQWAUvvL8EvRKbqDlJu20cTJ9/9zcQ1/uONdZ9
         MiGxvpGhcd+4OQJ6vD+0catOD7vYaR+ME4LRKV3fNpmdbaJjvDM5UdaMIQ8cR+ZDHHmB
         nt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=oF8quAZt/UGI/XaB3QdYWqoNI2fEzHCMZrTFMKPpS00=;
        b=nYWmL+8eeX+00s9EMT5UcjTqONQs7cap10L4qOiZC8W+2dsmdId4QQO0Tl788aSYq8
         0EdsXs6J33ao2WQhAHics8nyH+vMrZ4zFSBTfExWYCoHEpO9RQWKkfSvGL4T06jmi9iO
         wHplU+3aikdop7loA8JLLdr8wmGBDO6L9HtaDcIKGtzh3dFTZz7o4tLKWDu9am9E5gb4
         uI8o9qZv04oDo3OvTsKkjZb/Pm9jbWFUJObtEU22TDbPD0kPAg17X7FU5o8IewRVeMpz
         e5J74wtbO8ZMPHyIOTb1Jx16s7f5WARbJFlhOys94VdCR2BJBVCGV6ptXZWQQVlzRp7V
         7LEQ==
X-Gm-Message-State: ACrzQf0aXaj45EO5MD3NePK51L9jgNmwnQf2NnVd4Vx6Vl+MNAuSI2Je
        AgO6vCaOkOgaX/Z13jyzu/MT0SCXKkdtPQ==
X-Google-Smtp-Source: AMsMyM5u3MU7IkUl/3giiBY9aAYbeujw/w0boefz8Epp0nDuIGd7zm4BVXnBQ3Xn/nty1moxYelbYA==
X-Received: by 2002:adf:e187:0:b0:22c:981d:5528 with SMTP id az7-20020adfe187000000b0022c981d5528mr3457960wrb.407.1664477486790;
        Thu, 29 Sep 2022 11:51:26 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:9174:aca4:83d8:90fd])
        by smtp.gmail.com with ESMTPSA id v10-20020a5d43ca000000b00228aea99efcsm167301wrr.14.2022.09.29.11.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 11:51:26 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/2] clk: renesas: RZ/G2L: Add support for no PM clocks
Date:   Thu, 29 Sep 2022 19:51:17 +0100
Message-Id: <20220929185119.335273-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This patch series adds support for indicating MOD clocks as no PM (if any). 
Patch#1 adds DEF_NO_PM() macro to flagup no PM clock and patch #2 switches
sysclk and vclk clocks to no PM.

Sending it as an RFC as there wasn't any way we could obtain the priv data
due to which I had to create a static global var for rzg2l_cpg_priv.

RFC->v1
* Added no_pm_mod_clks and num_no_pm_mod_clks members as part of
  struct rzg2l_cpg_priv so that we dont loop the entire mod clocks
  array for each device probe.
* Patch#2 unchanged

RFC: https://patchwork.kernel.org/project/linux-renesas-soc/cover/20220927203044.751611-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (2):
  clk: renesas: rzg2l: Don't assume all CPG_MOD clocks support PM
  clk: renesas: r9a07g044: Mark CRU_SYSCLK and CRU_VCLK as no PM

 drivers/clk/renesas/r9a07g044-cpg.c |  4 +--
 drivers/clk/renesas/rzg2l-cpg.c     | 45 ++++++++++++++++++++++++-----
 drivers/clk/renesas/rzg2l-cpg.h     | 12 ++++++--
 3 files changed, 49 insertions(+), 12 deletions(-)

-- 
2.25.1

