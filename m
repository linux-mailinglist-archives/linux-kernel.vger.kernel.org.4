Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BD7647541
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 19:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiLHSDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 13:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiLHSDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 13:03:11 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06D43D93F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 10:03:10 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id js9so1308570pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 10:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ljb95iV2S47yFqe7M/P8twoED+tVhYFBm2hBkjjyeIA=;
        b=a7zzH5IVhSlqUV1f3wxFN1w4gxYVvptThMs+6ClgGLMen6dx4HjWmNYpT6Na1cVdt8
         +G94ov1eGOViFGejZ9Ck6xLXODIXAGZ2oH5LiAUk3j2POI7WzfkgZrqv03GO7VvmBqtc
         vYYtc2MConieAtU21n+Ce0FhJIyw+MiITecxbankO3UNZIp+qekQnSrqNSyq6N+CwUO5
         YcXuub28iQZ+RKoGAFz7RYyi8kp3axpTixnhspQF2x35B9nTu1mvAkVbvKCUn6Eaxr+4
         SM6JZ2+BDIgDaL+UJkkcjhU+xQKFCXdv6xhqbUU9fxcWSRFXtuhhVyWpbTq76UCxcTwZ
         Oveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljb95iV2S47yFqe7M/P8twoED+tVhYFBm2hBkjjyeIA=;
        b=HrOKjaZ2h/bAeR06gjqoSsW0hBgP1MeT2ugYCz8BtJBT0WARqnyPnSKFBJwATiINkL
         cOE6Ll5Fmc+sdAhFaqKioWCBTR45gTFcifMepdLPtueN0fvUVG9Jqbh/cKyCwB8SReM/
         i7eXe5+vN32e1Evx12PpmsmtVVRoS/Dl5/xvWh6b4mSV69IEfwOjaJdg1+dohNTUPAcs
         rhfBPBAqGRvXBiGwfT3XF2dnR/hg2+VHDB+1kRrTNUTLRzsGRgWN0fKYGHjOcUNHU+NB
         DjL2b24PQDoCcGK4/y+Ohu/DL6+kvyy5j1nUw5KMhKVl/v8iQSxIh4I8DqPSBeutLPOp
         FPGQ==
X-Gm-Message-State: ANoB5pko8+6XNyLDKNkitriGEV1rqJpmazOgVuojCm2nqrpgrIwq+GBY
        4lIxiI4ObZIm5ks3x4brogc=
X-Google-Smtp-Source: AA0mqf6SSYH4e9jGauKo9F/kLuRDw93dqOivHJLactz+eb7+Sw1nCsMIeg8/Vyv9VX8JNRe/PtB3fQ==
X-Received: by 2002:a05:6a21:1690:b0:a7:99c4:80ec with SMTP id np16-20020a056a21169000b000a799c480ecmr3696639pzb.20.1670522590145;
        Thu, 08 Dec 2022 10:03:10 -0800 (PST)
Received: from localhost.localdomain ([198.13.51.166])
        by smtp.gmail.com with ESMTPSA id x23-20020a63db57000000b004785e505bcdsm13377909pgi.51.2022.12.08.10.03.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Dec 2022 10:03:09 -0800 (PST)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Kairui Song <kasong@tencent.com>
Subject: [PATCH 0/5] Clean up and fixes for swap
Date:   Fri,  9 Dec 2022 02:02:04 +0800
Message-Id: <20221208180209.50845-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
Reply-To: Kairui Song <kasong@tencent.com>
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

From: Kairui Song <kasong@tencent.com>

This series cleanup some code path, saves a few cycles and reduce the
object size by a bit, also fixes some rare race issue of statistics.

Kairui Song (5):
  swapfile: get rid of volatile and avoid redundant read
  swap: avoid a redundant pte map if ra window is 1
  swap: fold swap_ra_clamp_pfn into swap_ra_info
  swap: remove the swap lock in swap_cache_get_folio
  swap: avoid ra statistic lost when swapin races

 mm/shmem.c      |  8 +++++-
 mm/swap_state.c | 66 +++++++++++++++++++------------------------------
 mm/swapfile.c   |  7 +++---
 3 files changed, 36 insertions(+), 45 deletions(-)

-- 
2.35.2

