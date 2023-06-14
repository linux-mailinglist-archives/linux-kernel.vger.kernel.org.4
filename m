Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203E372FED4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244628AbjFNMg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236094AbjFNMgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:36:21 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFD61FD0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:36:05 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6537d2a8c20so5259126b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686746165; x=1689338165;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4e+Pwp+021TOiqEOI55JQb3RjMEOtcdSeHsod/nYw0o=;
        b=V+SK9acdDTnYBrQKZHF8LeRsGMn16ZHTwKjr6/V6NkXCuBoLLzDUu2M0Nfa+OFigNK
         V4mQFdEHDLPFNGAHcke1u4x7oi0gwn+8sSer3mbHXMTPH4KzJ9EHm7s6O7S8YuK2HChJ
         /3Z/Ndb5PEZlD/1RlJPV63dLNOflrGTYfxFYmOhTgJ6/K7qwLvsbI1BmE0URxNHCVRXo
         9R2P0rV1z6rLJ6IfG7arZAz9VmdPMFRQ6xpVawkJQ1w+PTLcc2T9pMQa4lhz4V2yo/EW
         +EQhBPpZFjsn/mbRUj0tN2+wlhbExNE2qB0PJFzysg1AAEeDMpDC6NSsKLyfXZ0iDzEN
         VSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686746165; x=1689338165;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4e+Pwp+021TOiqEOI55JQb3RjMEOtcdSeHsod/nYw0o=;
        b=iwIRPccOd1bO2emSTAa89Ztv2tdyuWkndp+XF9DwqN1DWozq4okjOOuI1rUg3FkYeW
         LmYBy86qxue9JkExOxcjia/5zsQsWEE/J+bMHrvcMN+tmtZXd5fBfFi5IXibmJvOY0O1
         lPrhau9GqrThAHUhjAWAyo8ZBO8Dy/+hCxBgkeKii/tnWbcEkSbxTG9t8ssWbk1TYmqT
         r+YqxiXcRZZ53Dn69gInDR0aBRx+YMX7oFpHmCQBy1y8hPmFxYUiYrNdUcrfA5frQddo
         tKq0FlmxrnF8Gey1yoOWG+S7N7HNTiIvHbFgEulFuBT2YEduX7mr3aHLa0fHw8lXZWix
         kBRw==
X-Gm-Message-State: AC+VfDwtDQfSxPB1kGzdg4Sva5kkFjaizlaHAMe3FeNOMVztoZrv9D3I
        UNx8GCu25kh89WSYWdpJ5Ec=
X-Google-Smtp-Source: ACHHUZ4+dJFI8HJ6v4oIutm5MrkaLnh0wkcAaLETYhTmKqSAen1q8lTzmzcujbzgFoRsU+WyzbV+Tg==
X-Received: by 2002:a05:6a00:2352:b0:665:bd58:c948 with SMTP id j18-20020a056a00235200b00665bd58c948mr2301728pfj.8.1686746164598;
        Wed, 14 Jun 2023 05:36:04 -0700 (PDT)
Received: from sumitra.com ([117.245.169.18])
        by smtp.gmail.com with ESMTPSA id j1-20020aa78001000000b00634dde2992bsm10250199pfi.132.2023.06.14.05.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 05:36:04 -0700 (PDT)
Date:   Wed, 14 Jun 2023 05:35:56 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>, Fabio <fmdefrancesco@gmail.com>,
        Deepak R Varma <drv@mailo.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>
Subject: [PATCH] drm/i915: Call page_address() on page acquired with
 GFP_KERNEL flag
Message-ID: <20230614123556.GA381200@sumitra.com>
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

Pages allocated with GFP_KERNEL cannot come from Highmem.
That is why there is no need to call kmap() on them.

Therefore, don't call kmap() on the page coming from
vma_res->bi.pages using for_each_sgt_page() in
i915_vma_coredump_create().

Use a plain page_address() to get the kernel address instead.

Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---
 drivers/gpu/drm/i915/i915_gpu_error.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915/i915_gpu_error.c
index f020c0086fbc..6f51cb4fc55c 100644
--- a/drivers/gpu/drm/i915/i915_gpu_error.c
+++ b/drivers/gpu/drm/i915/i915_gpu_error.c
@@ -1164,9 +1164,8 @@ i915_vma_coredump_create(const struct intel_gt *gt,
 
 			drm_clflush_pages(&page, 1);
 
-			s = kmap(page);
+			s = page_address(page);
 			ret = compress_page(compress, s, dst, false);
-			kunmap(page);
 
 			drm_clflush_pages(&page, 1);
 
-- 
2.25.1

