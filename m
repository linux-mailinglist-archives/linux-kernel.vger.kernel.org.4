Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7499A5FB264
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 14:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiJKM0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 08:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiJKM01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 08:26:27 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE2B237D9;
        Tue, 11 Oct 2022 05:26:26 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id d7-20020a17090a2a4700b0020d268b1f02so6420905pjg.1;
        Tue, 11 Oct 2022 05:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X1TQOsxy3CXZu68a4jU7nD1cMoJlBD4fQULPrHpX//w=;
        b=KokdXzHYKxEaGdFUlkO998lAz1wbmBG6aB+gmd6GI2p2cI/GQb3dA7fZdT3fKlZBXw
         XhRYD19eE3YJ7+xuZJ/WC4dAtUFJXKzm1/2KtTqFOtBhnSvPG0YrQ8hPnaD32ReaIOa3
         UPzr99k9HBYWD7/Uy+lxsrb2M81k3oQEUporSX+Y1gTj9Ex/bd0M+Z987BabMvi1DnUA
         MBA5Dn8BgsUUX3CZiDVPB06CJtiaCnBGZHbSqhtSXFUwX1KPmoevQanteqKGbv2cz6Rb
         lK+yjRPYSY+9xkT2mMZO+sI4xTd97i5mwUGud5uqoazMTOjW1wQgKYfGghKLRkVu/ilF
         WXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X1TQOsxy3CXZu68a4jU7nD1cMoJlBD4fQULPrHpX//w=;
        b=tGixSOnLfNLclHqIaZNUiq6mP8I7ELsqySXQy7i3lSrvzFeQP2ihgCY/DvBp6CoTKB
         EZVJVtJFbAJ4laIi2xI7yuTN4BIIngt2Crdsdtpvm55Vdd3iEIRMWI7Zrxrss17vd1zK
         eF/CpkfxBzxqF/Wcin8VM2/gmc44ipPIkLYRhK8ykHBAH3Ukn4yRXa62SRas2nHRZ0xj
         xxxef3UkGfLTIuoOmzXBLlKtiSLU+Mwso4wn7m1Ru2/WvPz9ZYJvoKW6sFEkFo4f4pNG
         cAjZusgfDjX7OMqoTHgv3nef+xQ04msdOULT4jPoo+xebH92Tn/MZp0IHforlKqBZCoP
         1r3A==
X-Gm-Message-State: ACrzQf1xZQZWPCxV4pzwgeV6cD4qur0PVKgKQwOmssB0FEv4GRn70f0V
        cn9cFTsfNNdKxW7HUfrOC0ezH8s0ukX2xorp
X-Google-Smtp-Source: AMsMyM4ri/A8WpsiFDhctKFGVdBuvBlxBUBtt5BQ8j5/0Df4HN8/zqICGMtzN2++AvEOuZNt/huJIg==
X-Received: by 2002:a17:90b:4d0d:b0:1fb:a86d:e752 with SMTP id mw13-20020a17090b4d0d00b001fba86de752mr26705214pjb.120.1665491186204;
        Tue, 11 Oct 2022 05:26:26 -0700 (PDT)
Received: from debian.. (subs02-180-214-232-76.three.co.id. [180.214.232.76])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090264cf00b00178b06fea7asm8475827pli.148.2022.10.11.05.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 05:26:25 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] Documentation: ACPI: Prune DSDT override documentation from index
Date:   Tue, 11 Oct 2022 19:26:01 +0700
Message-Id: <20221011122600.620690-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1207; i=bagasdotme@gmail.com; h=from:subject; bh=QGQXGh5Zq2x/CbY8Jk1C22Gb+od/xX2PdajUV74tjQU=; b=owGbwMvMwCH2bWenZ2ig32LG02pJDMmuCce5BdUP3zafcumuuJpHvMeLR39V0jsmCAs/6mixSf78 axd/RykLgxgHg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACZitYOR4fuaWwc3egY7rYr2N3Up2n E08da2TMeEiTsT3ZUsfl3caM3I8EI7cIv4tIhzX83PPC0T54991lOsvPducbXQs6OfF0S+4gcA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d206cef03c4827 ("ACPI: docs: Drop useless DSDT override documentation")
removes useless DSDT override documentation. However, the commit forgets
to prune the documentation entry from table of contents of ACPI admin
guide documentation, hence triggers Sphinx warning:

Documentation/admin-guide/acpi/index.rst:8: WARNING: toctree contains reference to nonexisting document 'admin-guide/acpi/dsdt-override'

Prune the entry to fix the warning.

Fixes: d206cef03c4827 ("ACPI: docs: Drop useless DSDT override documentation")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/acpi/index.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/admin-guide/acpi/index.rst b/Documentation/admin-guide/acpi/index.rst
index 71277689ad97f4..b078fdb8f4c934 100644
--- a/Documentation/admin-guide/acpi/index.rst
+++ b/Documentation/admin-guide/acpi/index.rst
@@ -9,7 +9,6 @@ the Linux ACPI support.
    :maxdepth: 1
 
    initrd_table_override
-   dsdt-override
    ssdt-overlays
    cppc_sysfs
    fan_performance_states

base-commit: 27bc50fc90647bbf7b734c3fc306a5e61350da53
-- 
An old man doll... just what I always wanted! - Clara

