Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EE36A02EA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 07:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbjBWGrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 01:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjBWGrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 01:47:18 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3991E1D6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 22:47:17 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id ee7so23835579edb.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 22:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bsmNc0LW7KgPfnQR1pgTAG9e2DXG8L7W1cjt0n+8dxo=;
        b=X80BSI6zDmDav3I62Y4AZ6scW7/BNN44H3/n8Vms8apOHaFSQjMa6Mwd8iJ/B/ftrK
         yt3qqRuIkWvlVdOSudFYCWCpLp9aHTRaEwFYJUbxTqO1+VzQagMPscUqhUSDbDp1xGYB
         YrNvIbwiBpa5iUv8DkHILYQAjsp8VRl1ptdGYsH/eBIBkfJzNxEAIPPEyB0ZIM5A+XPx
         6utu8vHe32XZFwxhR+1sZfvk9ucNxoG3yS9VfsrFp3FqtoqLAe8VGje6YYaemTA7Q4nC
         QbNqJdf31G4Rjv6as/iIFzt9j2BjsCupWfCUQLRLZ3QQQR5IRYJqm0NrtSUkvs8OSyFm
         FFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bsmNc0LW7KgPfnQR1pgTAG9e2DXG8L7W1cjt0n+8dxo=;
        b=S/KZnIqPUAgaSvEHUqMQWokXgH7BcqXswBcWj2c2Q7+1j0OcQhNwb3Bl+xHK/Up3R+
         AeX3YYhxhmYsoPXp6xvgjNOwwJY7cOXXr8kSi4xkaTRDjP4B+8G0CAejremPS2fMRlFm
         4SWOK6RYGDb7Rp7lmfZ5eR0WbmP7KoLHcJ0Ku71DTpkj2fiT20uuH9h4KmIOR/b2Q+Z+
         wGcEtKkJJ1Vb0jvd/D0lzJXWRQp/MI0lwF/Ld8yJ6P+1RFRo1p73jn4DnDn4N9GNS+9t
         v/VSgpXPDrXEb4rdn3Dupnddxlo1aEan5v/M7KgEZX2TT8G0IWgbc4BsX3wJrINNYmal
         326g==
X-Gm-Message-State: AO0yUKUl54/bOjLrs9lDHtsRahQOPDD9OLeMcBmfZGP0s2Vm48hYocuZ
        5TWxMfY+1PZtChqRquNosLE=
X-Google-Smtp-Source: AK7set9rLeQQkEXuu1lHTL35o5OMi3rhw2FbznJ9KMnfsDrHRz79J525D+1Ed4I7JjC8t5KnPiflLA==
X-Received: by 2002:a17:906:2cf:b0:878:5fa4:7443 with SMTP id 15-20020a17090602cf00b008785fa47443mr17928861ejk.3.1677134835553;
        Wed, 22 Feb 2023 22:47:15 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id a26-20020a170906685a00b008b1b86bf668sm8125522ejs.4.2023.02.22.22.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 22:47:14 -0800 (PST)
Date:   Thu, 23 Feb 2023 07:47:12 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] staging: rtl8192e: Remove struct rtl819x_ops that has no
 entries
Message-ID: <cover.1677133271.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macro RTL_PCI_DEVICE with PCI_DEVICE to get rid of struct
rtl819x_ops in this macro. Remove empty struct rtl819x_ops from
driver as it has no entries and is dead code.

Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e

This patch series requires the this patch series:
"[PATCH 0/7] staging: rtl8192e: Remove entries from struct rtl819x_ops start with .tx_enable"

Philipp Hortmann (2):
  staging: rtl8192e: Replace macro RTL_PCI_DEVICE with PCI_DEVICE
  staging: rtl8192e: Remove empty struct rtl819x_ops

 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 12 +++---------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h |  9 ---------
 2 files changed, 3 insertions(+), 18 deletions(-)

-- 
2.39.2

