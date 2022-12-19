Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964C365145B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 21:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiLSUrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 15:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbiLSUqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:46:53 -0500
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDEA13D3C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:46:33 -0800 (PST)
Received: by mail-il1-x14a.google.com with SMTP id a10-20020a056e02180a00b0030bc09c6b94so900162ilv.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ffbS/pv8mbkzwi7BuDuXxKBVWgm3Q+ZGzVMRzNeN5+Y=;
        b=nqnUkMASlYpMM28opAhWoAU1NBwY2jEzGkvUjYSnlp7J3g7LFTrfsGOZtIYLEdhmdi
         Nj0kimdtanY+nZdYkSCLG8zQFU5mpiAGqiQ4/RBijOk2L3W2nziZqNXJ7WrHg4TDWzPF
         Y0zsYFU7krvm141/cij+TsvNPr2hxM4hsLciLy3/m5euyiexb3HtGhjQNqBmCnmJGwXf
         MUTgJu5AHfzQ8ShP60lUShV3R5HQAHQcXeXnv2LFkXe7fsBt5cb+gev18+KhxKGr+5kI
         0qXU+ShjEnxk5+V2OJLaQRiEdaCMpClzWMTB2XVgCtuA+SnMmfOOqMTcMe80vuJOW7MK
         SLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffbS/pv8mbkzwi7BuDuXxKBVWgm3Q+ZGzVMRzNeN5+Y=;
        b=gcl+tLuI+wUOstge6v/yiv9IXmoEfJKC7UeF1C6wrFKqGNvLwpjj3e7U2RoxRM598X
         JZapaOqzR19E1EXL8Bgpae19a0XTyiCssIkfJ9kGXtzU7DqoQaMrXo2JMGosw97HtC1f
         m70MmlKeJ3Zc31aT2Ex1ijIYGy4nVSf+5mQ5vOGJ2f+yrg4C2RsySGerOwAqWu4UG1G8
         OjpEDftk3xC1yC6x10uGA+foEn+fKqq+Chx9lWIgCYGkHqze1fONsqPfMeN3Vr2exhNf
         xQWf+Ls5h+8Gpzz6IFTlmwMd3687u5K4PKN1MCOrtlN55MqYVm2KM/gsXN6aHMLRN2v+
         gNcQ==
X-Gm-Message-State: ANoB5plEzAuKsmDCVa45IVFfWBDkROmPaXVlTuDXayQr8naJ6/IuiH8n
        4FaP2E4ol/H5+4u6pNoi2RXxbbGBMPiZqaw=
X-Google-Smtp-Source: AA0mqf6QFQzi7P5j2zCWig0dCG28/HaaTm4atHzN0jrf21gACRfqp7XweVAXGEEiRc1oG+wRFR/a6fqA6RDLewo=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a02:2a4c:0:b0:374:3cc9:2b37 with SMTP id
 w73-20020a022a4c000000b003743cc92b37mr44057930jaw.294.1671482793424; Mon, 19
 Dec 2022 12:46:33 -0800 (PST)
Date:   Mon, 19 Dec 2022 14:46:19 -0600
In-Reply-To: <20221219204619.2205248-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221219191855.2010466-1-allenwebb@google.com> <20221219204619.2205248-1-allenwebb@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221219204619.2205248-12-allenwebb@google.com>
Subject: [PATCH v9 10/10] Documentation: Include modules.builtin.alias
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Allen Webb <allenwebb@google.com>
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

Update the documentation to include the presense and use case of
modules.builtin.alias.

Signed-off-by: Allen Webb <allenwebb@google.com>
---
 Documentation/kbuild/kbuild.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
index 08f575e6236c..1c7c02040a54 100644
--- a/Documentation/kbuild/kbuild.rst
+++ b/Documentation/kbuild/kbuild.rst
@@ -17,6 +17,12 @@ modules.builtin
 This file lists all modules that are built into the kernel. This is used
 by modprobe to not fail when trying to load something builtin.
 
+modules.builtin.alias
+---------------------
+This file lists all match-id based aliases for modules built into the kernel.
+These are intended to enable userspace to make authorization decisions based
+on which modules are likely to be bound to a device after it is authorized.
+
 modules.builtin.modinfo
 -----------------------
 This file contains modinfo from all modules that are built into the kernel.
-- 
2.37.3

