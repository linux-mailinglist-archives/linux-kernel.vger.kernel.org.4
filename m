Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463B56519B6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 04:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbiLTDl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 22:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbiLTDl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 22:41:26 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9FB62CD;
        Mon, 19 Dec 2022 19:41:24 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so10820897pjd.5;
        Mon, 19 Dec 2022 19:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xVh7BhiLAFK1y5fgqjdCBQvyDDgKeEj33/rk76TBR5s=;
        b=eIyMUGuhIXBj94VjBrAUhYLj+94tayhIXD10HOZKzIQ6CrgTN/phMZCweKAwIaCB8k
         oamV0qlLPDCgbgw7XnOEvPb4i4TP9cIkGd0h5jj5uofBKK52E7+6LLxTAhvXfkmkIBip
         VSX/P9iBKBhYtqZnVypFSj6sPW0lssLLdT4W0nQg2vMyQGXiWd6B4I7Fkx++aZ6uiZoA
         BgE3YZdcwBbhaAOm9F0Z/X++ekd/r+gI3p14y42+3M4stYmaJu2zuHihydMPYqQgxlf0
         a1c64nfggXO5y7B/yo7l9SuIvOrI0XMmDhcsfXkxUUYYMdTrJFeMwIoeTzYLQlXDqANx
         oUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xVh7BhiLAFK1y5fgqjdCBQvyDDgKeEj33/rk76TBR5s=;
        b=dj1LLc5XS+nfrRMoqRmnLZBiMEdg8tUbW1CgRkMmBP14GB4BMMSJuuBNRg39Mp9TQd
         ZkNyHnlqNkr966msnzzFnOS+shh/ydJtHdt+ny7pjlOX8br/czulFPGaD7kFZQ0epl36
         MwbKQDcwBcekWYKfJZXkR++m88Fy8Sx2A0abFqEECl1O3SBv1IfLf2AXIt/EvbWw79N8
         WSChIINvHCSwqMiG1jgnBrYUUb/raya//1rh6xEmc7TQH5+vdjIh/W1rQyn17HFsTCem
         tXr9wz6AvVBNXLT1WZZFKWeG4kjnCg8Q2WwdV/NGcE4nDFLoM43SEd/jyqzt3W/W1WND
         kNDQ==
X-Gm-Message-State: ANoB5pnh+DzrEG9osdZGSACzKzT4VtLZNLY6YelT2fEqYBijfPTWgPAG
        /I1iN8fAf2dATDt/MKE+XVM=
X-Google-Smtp-Source: AA0mqf6scQ9/TUdhQyckyTVN2l+rTWw5xP6+kf2svgdOWFmDqEGeGWPdfv/YMte1IhWDSljq4EL8Fg==
X-Received: by 2002:a17:902:6b08:b0:186:639f:6338 with SMTP id o8-20020a1709026b0800b00186639f6338mr11003150plk.6.1671507684172;
        Mon, 19 Dec 2022 19:41:24 -0800 (PST)
Received: from mail.google.com (125-237-37-88-fibre.sparkbb.co.nz. [125.237.37.88])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090322d000b001896af10ca7sm7974566plg.134.2022.12.19.19.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 19:41:23 -0800 (PST)
Date:   Tue, 20 Dec 2022 16:41:15 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        paulo.miguel.almeida.rodenas@gmail.com
Subject: [PATCH] [next] i915/gvt: Replace one-element array with
 flexible-array member
Message-ID: <Y6Eu2604cqtryP4g@mail.google.com>
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

One-element arrays are deprecated, and we are replacing them with
flexible array members instead. So, replace one-element array with
flexible-array member in struct gvt_firmware_header and refactor the
rest of the code accordingly.

Additionally, previous implementation was allocating 8 bytes more than
required to represent firmware_header + cfg_space data + mmio data.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

Link: https://github.com/KSPP/linux/issues/79
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]
Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
To make reviewing this patch easier, I'm pasting before/after struct
sizes.

pahole -C gvt_firmware_header before/drivers/gpu/drm/i915/gvt/firmware.o 
struct gvt_firmware_header {
	u64                        magic;                /*     0     8 */
	u32                        crc32;                /*     8     4 */
	u32                        version;              /*    12     4 */
	u64                        cfg_space_size;       /*    16     8 */
	u64                        cfg_space_offset;     /*    24     8 */
	u64                        mmio_size;            /*    32     8 */
	u64                        mmio_offset;          /*    40     8 */
	unsigned char              data[1];              /*    48     1 */

	/* size: 56, cachelines: 1, members: 8 */
	/* padding: 7 */
	/* last cacheline: 56 bytes */
};

pahole -C gvt_firmware_header after/drivers/gpu/drm/i915/gvt/firmware.o 
struct gvt_firmware_header {
	u64                        magic;                /*     0     8 */
	u32                        crc32;                /*     8     4 */
	u32                        version;              /*    12     4 */
	u64                        cfg_space_size;       /*    16     8 */
	u64                        cfg_space_offset;     /*    24     8 */
	u64                        mmio_size;            /*    32     8 */
	u64                        mmio_offset;          /*    40     8 */
	unsigned char              data[];               /*    48     0 */

	/* size: 48, cachelines: 1, members: 8 */
	/* last cacheline: 48 bytes */
};

As you can see the additional byte of the fake-flexible array (data[1])
forced the compiler to pad the struct but those bytes aren't actually used
as first & last bytes (of both cfg_space and mmio) are controlled by the
<>_size and <>_offset members present in the gvt_firmware_header struct.
---
 drivers/gpu/drm/i915/gvt/firmware.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/firmware.c b/drivers/gpu/drm/i915/gvt/firmware.c
index a683c22d5b64..dce93738e98a 100644
--- a/drivers/gpu/drm/i915/gvt/firmware.c
+++ b/drivers/gpu/drm/i915/gvt/firmware.c
@@ -45,7 +45,7 @@ struct gvt_firmware_header {
 	u64 cfg_space_offset;	/* offset in the file */
 	u64 mmio_size;
 	u64 mmio_offset;	/* offset in the file */
-	unsigned char data[1];
+	unsigned char data[];
 };
 
 #define dev_to_drm_minor(d) dev_get_drvdata((d))
@@ -77,7 +77,7 @@ static int expose_firmware_sysfs(struct intel_gvt *gvt)
 	unsigned long size, crc32_start;
 	int ret;
 
-	size = sizeof(*h) + info->mmio_size + info->cfg_space_size;
+	size = offsetof(struct gvt_firmware_header, data) + info->mmio_size + info->cfg_space_size;
 	firmware = vzalloc(size);
 	if (!firmware)
 		return -ENOMEM;
-- 
2.38.1

