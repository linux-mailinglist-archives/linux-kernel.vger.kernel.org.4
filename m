Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F266BFFDA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 08:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjCSHtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 03:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjCSHtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 03:49:13 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC2B17CE3;
        Sun, 19 Mar 2023 00:49:12 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id iw3so9495546plb.6;
        Sun, 19 Mar 2023 00:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679212152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIfSZlQdjq2QeN3yLevVi7u/sy87+Xfos8uz/fqGXZA=;
        b=pKFQJctjA+4whOxYFNLAtvyVmViSvNOyL7P4Z4SLBqjJEzoX8isS/dLNIFcmw8Falc
         QgD/hLCN7EaFzP/s2MvoTX6//4L7WodJ0WG8lOMJj9VeXXbFMobU/RE8SZoiQ8HKEl2E
         IhvZinW80pe8fUQzHjI+xtov8vpu7o4BuCMcwB+7hx/gx8SrpfxowktCDp1vZ8shCoI7
         NezVaPjgxBOD0M6tlumRMxpO7wIPxIFzKdgoP7q8dgiTW5lzyoJTxzZp+cROPyZJbDAa
         NPyI/fVywoR/QerXqwXoLQdbMmzXVqMLsv4IOSNwJaSyV46T5OZnuV4woiXiZkk4xa5+
         hbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679212152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIfSZlQdjq2QeN3yLevVi7u/sy87+Xfos8uz/fqGXZA=;
        b=b1Q2t2LTC4lSoWXOLgi0tC1CzbVzGS1amGOhcYjafZNf/+30CiVJvwjabcBWdPC772
         NXWqXYFE2iD1rDd0n6x/ed6DodNrlWfUMx4FHI3UKDVRyRTtF7plbH95EVpNBrMeX7KC
         sOUMHBI0dnPuY5nSQ1UcoYytIfU8V/xcZAQOqi03rTBqL1KGDTuhhcplMrGp/wzBHgfe
         iWa0k4zrR3GiO88/L+84asVkX5tH2ObrY5J1L4KTu6XwwyVzVWodQHMR88IOXVJl0QaL
         cFTLk78dwxOPA7T+hFxaO7v8ryAVBOSQFMFNh68kkcxrvrTfFeRtEu3j6ruWAXONNJS5
         YHgw==
X-Gm-Message-State: AO0yUKU0Q1Wzg67gMZUWjf9kz9gx0bttKo+7rjoMMkwSLhuJwjtvwn5q
        hfA93eiG56eU01DpcooIDvM=
X-Google-Smtp-Source: AK7set+FBdBMrsQlN6ykWOyiDVcSRVtlF5HFu+P+nP9uLj4Gw+J+D4Y6gqQrJ62tzxJkwQ8h3xkrFw==
X-Received: by 2002:a17:903:300c:b0:1a0:48c6:3b43 with SMTP id o12-20020a170903300c00b001a048c63b43mr11027083pla.37.1679212151985;
        Sun, 19 Mar 2023 00:49:11 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-29.three.co.id. [180.214.233.29])
        by smtp.gmail.com with ESMTPSA id c23-20020a170902849700b001933b4b1a49sm4296638plo.183.2023.03.19.00.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 00:49:10 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 501E110667C; Sun, 19 Mar 2023 14:49:06 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux MediaTek <linux-mediatek@lists.infradead.org>,
        Linux LEDs <linux-leds@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>, Lee Jones <lee@kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/3] Documentation: leds: Add MT6370 doc to the toctree
Date:   Sun, 19 Mar 2023 14:49:01 +0700
Message-Id: <20230319074903.13075-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230319074903.13075-1-bagasdotme@gmail.com>
References: <20230319074903.13075-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=928; i=bagasdotme@gmail.com; h=from:subject; bh=8TeEYL2x7M4VCHkGB1sE6AhLj3kr5Uc9pFr0FLcyZ0M=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCli+/L82pR+MjA/LufiYIwu0hA97ui/pEEg8NTpRp36N Z2zf33sKGVhEONikBVTZJmUyNd0epeRyIX2tY4wc1iZQIYwcHEKwET4zjD8d/GtatU8Ne2gXeWe 9maux9oOb+afc14mstxLVv/9C/+nTQx/+D/kre2M2HLe5ltbR5PL7H1BIqZuy108Ag6n1Sk8ufe fFQA=
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

Commit 4ba9df04b7ac66 ("docs: leds: Add MT6370 RGB LED pattern document")
adds documentation for Mediatek MT6370 RGB LED device, but forgets to
include it to leds toctree index.

Add the missing entry.

Link: https://lore.kernel.org/oe-kbuild-all/202303182310.tB1mUzU7-lkp@intel.com/
Fixes: 4ba9df04b7ac66 ("docs: leds: Add MT6370 RGB LED pattern document")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/leds/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/leds/index.rst b/Documentation/leds/index.rst
index b9ca081fac71f4..ce57254cb871f4 100644
--- a/Documentation/leds/index.rst
+++ b/Documentation/leds/index.rst
@@ -25,5 +25,6 @@ LEDs
    leds-lp5562
    leds-lp55xx
    leds-mlxcpld
+   leds-mt6370-rgb
    leds-sc27xx
    leds-qcom-lpg
-- 
An old man doll... just what I always wanted! - Clara

