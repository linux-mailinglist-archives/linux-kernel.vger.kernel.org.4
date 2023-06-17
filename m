Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A14734181
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 15:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbjFQN4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 09:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjFQN4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 09:56:40 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41ED010D1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 06:56:39 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3112599fd5cso282298f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 06:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687010198; x=1689602198;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WrfA4PjxDsnF9cJAxM87icIyT8p3T29tCTGqeIrXL7Y=;
        b=J5JRW4X56P254eSYv7+tjxeNVUKjpy3Gdg/wIcdfTmCAI7aDGnba2iBCCDj+YQloh5
         6HF/j1+ORAWy0kMjRHGwg+I6X8b3xjlRYIGyKoqOFfFd1hDOgzx+vjFt2gD11QPpZCyI
         5t+4NoFGEdW9jRvgXyhkQjv5RzoPhRtBMY6NZgH4wTxMOCnZb8r5k1Pwm8RdfYUG3xsS
         9c7yS7GzbL//rvGeRaRJeQn+riy8GYVG4AbaZ52ea7zOijFhCbHdJ2yE4S8vxseJlaNG
         ByqcPWihyAxf5cNYoHZSa/L1QbUBdDqOrNvJ/4blR/8QULIGvpLwaCZupgTuXr5JL6/e
         N3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687010198; x=1689602198;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WrfA4PjxDsnF9cJAxM87icIyT8p3T29tCTGqeIrXL7Y=;
        b=g+9rPu69dhXz32ppMNkhWZcewpRF5CUdnb5qft6pnk4bhN5TEqPTY2B87/NUsQ8zBp
         vYwrxAHiyZ/vicvQf0sC//suobiBx90+76k/qrtdLw9S52WeQY4AvTvhSb1hS44OWw7L
         lMSohI2oqjFMLYtC2CAwecmur34bcnvZS+2eaW0hOe2W4LZcPPvbFMpylt0i5bLQtkgq
         akRRHihCrua4UiO/SUI/6jiZcj5kp6wuRpvsEdLiN3sZf8LVE7B+1rN0xWYzBZy4eQG+
         RPbj9gXsEms+qAl4ZJ0Grq3q5/ByOR7HWMWSElADXhZ7U9chuUy+Se0KYaSWsOBc4/Xo
         KDLg==
X-Gm-Message-State: AC+VfDzEgPEY4904RsdAECgtRRtU1sjvVPh4mJJ+p6j8L8goVtLjTpux
        92I5l2ua21MaRYYM2CiPWTI=
X-Google-Smtp-Source: ACHHUZ62CS8PD+HwPQ1CFJ/aFVv2V3Tndxp45mHcy93B4ZetJAYDpkkGbrpFdhIV9O2cOuVHznTa9A==
X-Received: by 2002:a05:6000:1104:b0:310:b62f:2379 with SMTP id z4-20020a056000110400b00310b62f2379mr3830530wrw.3.1687010197417;
        Sat, 17 Jun 2023 06:56:37 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id e10-20020a170906044a00b009845c187bdcsm2437346eja.137.2023.06.17.06.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 06:56:36 -0700 (PDT)
Date:   Sat, 17 Jun 2023 15:56:34 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] staging: rtl8192e: Remove unsupported modes a and 5G
Message-ID: <cover.1687007788.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unsupported modes a and 5G to shorten code. Change variable names
to align with rtlwifi driver as requested in TODO.

Tested with rtl8192e (WLL6130-D99) in Modes b, g, n (12.5 MB/s)
Transferred this patch over wlan connection of rtl8192e.

Philipp Hortmann (9):
  staging: rtl8192e: Remove variable stats->freq as it is constant
  staging: rtl8192e: Remove unsupported modes IEEE_N_5G and IEEE_A
  staging: rtl8192e: Rename constant IEEE_x to WIRELESS_MODE_x
  staging: rtl8192e: Remove unused enum led_ctl_mode
  staging: rtl8192e: Rename rtllib_state to rtl_link_state
  staging: rtl8192e: Rename state to link_state
  staging: rtl8192e: Rename RTLLIB_NOLINK to MAC80211_NOLINK
  staging: rtl8192e: Rename RTLLIB_LINKED to MAC80211_LINKED
  staging: rtl8192e: Rename RTLLIB_LINKED_SCANNING

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  24 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |  41 +++---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    |  18 +--
 .../staging/rtl8192e/rtl8192e/rtl_ethtool.c   |   4 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c    |   4 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    |  12 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c     |   8 +-
 drivers/staging/rtl8192e/rtllib.h             |  37 +-----
 drivers/staging/rtl8192e/rtllib_rx.c          |  43 +++---
 drivers/staging/rtl8192e/rtllib_softmac.c     | 122 +++++++++---------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c  |  18 +--
 drivers/staging/rtl8192e/rtllib_tx.c          |   2 +-
 drivers/staging/rtl8192e/rtllib_wx.c          |   4 +-
 13 files changed, 146 insertions(+), 191 deletions(-)

-- 
2.40.1

