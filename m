Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0322C6512BC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbiLSTTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbiLSTTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:19:01 -0500
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D7011C0D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:19:00 -0800 (PST)
Received: by mail-il1-x14a.google.com with SMTP id x10-20020a056e021bca00b00302b6c0a683so7193204ilv.23
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JPHDmjOz4kw82vudyh2gpNSeY/P1g0Ll1cHkuMKd04M=;
        b=Hl9NxWeWRbBMNIcYbJvo9h4lOhGhAZEsdPi5MbDF9oJxtlLgXY3/mwkDZQWTaIwfkQ
         uRsDLcZ4I/U1gY4gCmXSISAxWk/Q+4bC9AjBLvXBDAGpdcTe6ZvPzE244kYMz+eA42M7
         wUWTlTn5N9Ycs5PdWjiOwiuS4D24OyLvoF1F0RZuvYaBBxdnihvlB8yySBabO1K/gMER
         IlHNuvhH7i1NM5Zkqc62EZrJphOMVnPQVdcgqbAIpZbhRekeIOeieN7xMd/0cZm4sCYW
         wHN2yrmAvyiCOSq4m09u35HFC2IdBGxzUUkasE0xaZ33SnBQTRz5fBVfqCSpGlQ3qR0I
         8geg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JPHDmjOz4kw82vudyh2gpNSeY/P1g0Ll1cHkuMKd04M=;
        b=jhPAlyBNoWjGI/lYQmvSmSxA3qCODwv5mv3etLInu1b20lHqet+hSqgAqAGke9OA3G
         lkKonBdu/qUiPqpaikCtuXGxT1t7yKLt0WtHQ3H7ky+KxEp//mpUSoJ/rCoBiOs6OPx7
         sJKJDYfHcJwcGdQzinu5yIZW0Tde+gnvGJ/9qfEFUonuDHH4MGfMYgQVCivpQsTjOhfo
         4HBj7TrCkHeYxpgrCA3b3cHGruFgY70XLSFKu4Ki84CtlY37xoSzNIMbjyegd/Qu/Plv
         gDbGdSDk9khXCuv9Y5TNbc5G83/76DKWIHFwZbcKT2MOr0UdhUT0aYv9K737bDTym2Ny
         wEyw==
X-Gm-Message-State: ANoB5pmF7BM4bvvrbMmKOesZxlymPGNE1Mfg7TtIbFCr+3XdrpUOjf00
        Xx7zCCrKYR8D271OSDDjsENjtnvURBYqFEU=
X-Google-Smtp-Source: AA0mqf7amPioeMnlA+AUyAIaYb0aW6unNmd1qq3ubnJMOsmcaI05zjSC6BLtBwo3k1pZCRKGf3aTO/JDpU7ONFw=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a02:a117:0:b0:38a:7675:fd26 with SMTP id
 f23-20020a02a117000000b0038a7675fd26mr5696278jag.300.1671477540032; Mon, 19
 Dec 2022 11:19:00 -0800 (PST)
Date:   Mon, 19 Dec 2022 13:18:47 -0600
In-Reply-To: <20221219191855.2010466-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221216221703.294683-1-allenwebb@google.com> <20221219191855.2010466-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221219191855.2010466-2-allenwebb@google.com>
Subject: [PATCH v8 1/9] imx: Fix typo
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Allen Webb <allenwebb@google.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A one character difference in the name supplied to MODULE_DEVICE_TABLE
breaks a future patch set, so fix the typo.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Allen Webb <allenwebb@google.com>
---
 drivers/soc/imx/imx8mp-blk-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
index 0e3b6ba22f943..344a0a71df14a 100644
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

