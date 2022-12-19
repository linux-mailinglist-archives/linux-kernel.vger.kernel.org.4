Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E673565143D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 21:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiLSUqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 15:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiLSUqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:46:24 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936A012630
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:46:23 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id h66-20020a252145000000b0071a7340eea9so11934959ybh.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w/Gqg4YrMLjJiJaPudpqPxo3JMr/czsipkBHlpgnkpY=;
        b=ndN2I2jiGwpc8MXc/JM2wIcpg63LQ0N88uByf+lCP7EUUvNLgJ7/Aoy4qQFqYVpl0g
         SCKRXpZZOA0x3OsI8dVGtGuyvH0Zd6V45Fby6zPRuUq0lvbWZxJ+vlgXN6JzavmUfDAX
         1K7hMGMGnTMtZQ3v0pHazPH92wtCC81d53Snj/7oFlXwF0FJMY+n73/d776Hd3wIYK7s
         oXGmgH5QGBo0XfmYb4MElR763fEXMT3a+Z9EIa5gqIF108x2T43KfAiKVcurToqJiLPy
         4aLVTykL4Ud6W5RiukK3/hNmLb1DpIN/QWWHXsAtuErZQr+vfJ6ry8z2SvgYviEgCwO3
         P19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/Gqg4YrMLjJiJaPudpqPxo3JMr/czsipkBHlpgnkpY=;
        b=FlY40AXQtl3zN7OVNgWC4YizIyVozdp0Ys1Zzw6hnSDRYHstwN4cAK7rI4QuKx3mXD
         I2rULw949hy4g8g9PYbS+TOHZYu1lo8WjB23H4ps94ZyqlU3qoHuwXsvhJx6OpIThJko
         2WDICdfhAoYil/YKisxhyUyg0sTcFUGjvaBQiBg4s16ifVi9tmkHXrpJogxx6TNZlX1k
         /CMlOIEv0m8v11BkT+upZ6kvqcqBUPdEFt0BXy2h3ycUQG7FAQiRnYAM/oIjIJDc537J
         iZXROTKEJaQeTafjxDPdywGInOq2VsSlk1uyjQ8cB+idWcG+QEz+WQ+T6Sj2gj3X8eXm
         A9XA==
X-Gm-Message-State: AFqh2kpkti/FopBBncXjyUasG1No74Nf9+Kx7U/fzZOOc21L4hdOwBkw
        FLNurK9MSriOk9dX9jSR0M5Yvu0OUHMc/vI=
X-Google-Smtp-Source: AMrXdXtoAUdvut+1L/DmyRCpgsHs9tozY7MxSP5gsjsnTr5Y01RLIfxcnyAHBwKz5tgnxKA7krwwyyRtuqrtnpc=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a81:6dd0:0:b0:3e7:c742:f827 with SMTP id
 i199-20020a816dd0000000b003e7c742f827mr617806ywc.91.1671482782916; Mon, 19
 Dec 2022 12:46:22 -0800 (PST)
Date:   Mon, 19 Dec 2022 14:46:09 -0600
In-Reply-To: <20221219204619.2205248-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221219191855.2010466-1-allenwebb@google.com> <20221219204619.2205248-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221219204619.2205248-2-allenwebb@google.com>
Subject: [PATCH v9 01/10] imx: Fix typo
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Allen Webb <allenwebb@google.com>, stable@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A one character difference in the name supplied to MODULE_DEVICE_TABLE
breaks a future patch set, so fix the typo.

Cc: stable@vger.kernel.org
Fixes: 556f5cf9568a ("soc: imx: add i.MX8MP HSIO blk-ctrl")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Allen Webb <allenwebb@google.com>
---
 drivers/soc/imx/imx8mp-blk-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
index 0e3b6ba22f94..344a0a71df14 100644
--- a/drivers/soc/imx/imx8mp-blk-ctrl.c
+++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
@@ -743,7 +743,7 @@ static const struct of_device_id imx8mp_blk_ctrl_of_match[] = {
 		/* Sentinel */
 	}
 };
-MODULE_DEVICE_TABLE(of, imx8m_blk_ctrl_of_match);
+MODULE_DEVICE_TABLE(of, imx8mp_blk_ctrl_of_match);
 
 static struct platform_driver imx8mp_blk_ctrl_driver = {
 	.probe = imx8mp_blk_ctrl_probe,
-- 
2.37.3

