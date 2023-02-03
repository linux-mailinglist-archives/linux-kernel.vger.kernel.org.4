Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22706894A5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 11:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbjBCKC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 05:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbjBCKCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 05:02:51 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204C599D7F;
        Fri,  3 Feb 2023 02:02:47 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id m13so4699641plx.13;
        Fri, 03 Feb 2023 02:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uI1M7MlCo9XnTZpJcBOEs5KyjjwQHQ4dPVV8UJc85M=;
        b=QnIGxN6Lwu4aUFzN5zi5SuwFMdtnPJzPMWMZ9vIadX4m92djFC+2E4YcRW3eNF4v1Z
         Mg+ZxOCTI2vhUDl00H4wghHXab/rBKeEOrfVkQ3smacWDfBbshqwz/xoC/CEz3dbvOnz
         zdxlcD/D7y5jj2cdyoBY36E7SmR0SET3MT06VrTFvpDcpve8cOcLCxvfld0k0i7AINqk
         oTs/z7xROlKl6OoqvnGQPnnbtWhdgqj1cAQi+oTVJxLhe6mlSrD4TYjIoNkrLrshcLKf
         VUE7BfCWF58nSlTSjkY7sKBLRYQ4Hi1Ds1fYtEjD/yM1JcHeeMaCUJEuTh7CJ+lQuzc8
         vRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8uI1M7MlCo9XnTZpJcBOEs5KyjjwQHQ4dPVV8UJc85M=;
        b=omMr1Uz9kW4/6Zw5qOIrOuRKh6YSx57xELAVWz4O/+lcynDD99tpRLWPne8k9y+o1T
         bLKERA9ytQtFEmfzs5Tke4pgoRrJcI6uyCCMfu3ye/MG1NdM93mQWK83gx6upm8Srttn
         LcWNdYG6dSdDfXwqpl/YToFmcuNj3dRC8Jc3OzMfdsTFh52noOk6pQKmCK2GF2lI8xD9
         wNoaZ52R2xQN0RzrpCJgYyp/eInzQWciB+GSmQOVS/+LDlvanRYKGI8B9kk+cEJqqcZL
         Ck5u5K4R18vHMNcO1pJSDALRJctBM4ye5ZX4a0xOckWFfpDhT+j1wztTHBq1kaO0sjfr
         lmXg==
X-Gm-Message-State: AO0yUKVFsRsTS2SH8P0dN4w4xrqLBcTWW/C/J+UNwvHIqQneme56vpX0
        +yWml74P4y6pP0qPBQhQKow=
X-Google-Smtp-Source: AK7set++bw9bsEbt2KDe2FpE3hso9t1lCk8CgQqRkD77rwyegzc0cHcYY7ckjMXVEQKuFQCurWx5pg==
X-Received: by 2002:a17:902:c60b:b0:196:6c71:ae6 with SMTP id r11-20020a170902c60b00b001966c710ae6mr7016429plr.47.1675418566581;
        Fri, 03 Feb 2023 02:02:46 -0800 (PST)
Received: from debian.me (subs09b-223-255-225-232.three.co.id. [223.255.225.232])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902c15100b00198e54b814bsm446379plj.119.2023.02.03.02.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 02:02:45 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 4FCE8103AAB; Fri,  3 Feb 2023 17:02:41 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Intel Graphics Development List <intel-gfx@lists.freedesktop.org>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matt Roper <matthew.d.roper@intel.com>,
        Gustavo Sousa <gustavo.sousa@intel.com>,
        Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>,
        Matt Atwood <matthew.s.atwood@intel.com>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Srinivasan Shanmugam <srinivasan.s@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 3/3] media: v4l2-core: Describe privacy_led field of v4l2_subdev
Date:   Fri,  3 Feb 2023 17:02:15 +0700
Message-Id: <20230203100215.31852-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230203100215.31852-1-bagasdotme@gmail.com>
References: <20230203100215.31852-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1302; i=bagasdotme@gmail.com; h=from:subject; bh=+06fGKU6Nu7LzM7YPNBQVCSnWE/UvPRGzGU+ENUc+Os=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMl3bi97x7Uk37XrbU3jvdw/VyfZPP6VUZN3yDyc0Zxbhjeu U6G5o5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABO5as7IMEN/6zU/CY4XCc47HsSFPN zLb/ji8fMw0acOyv+ZLu+ME2RkuOTSE70p0XbLRQVDkxSF2/eeee4ofKnqsO/d5c2c7T9fMQIA
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

Stephen Rothwell reported htmldocs warning:

include/media/v4l2-subdev.h:1088: warning: Function parameter or member 'privacy_led' not described in 'v4l2_subdev'

Describe privacy_led field to fix the warning.

Link: https://lore.kernel.org/linux-next/20230203135303.32da1fc6@canb.auug.org.au/
Fixes: 10d96e289fbd77 ("media: v4l2-core: Make the v4l2-core code enable/disable the privacy LED if present")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 include/media/v4l2-subdev.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index 1ef5bbbf9d38c8..3e7a97c0657e1c 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -1033,6 +1033,7 @@ struct v4l2_subdev_platform_data {
  * @active_state: Active state for the subdev (NULL for subdevs tracking the
  *		  state internally). Initialized by calling
  *		  v4l2_subdev_init_finalize().
+ * @privacy_led: Privacy LED associated with the sub-device.
  * @enabled_streams: Bitmask of enabled streams used by
  *		     v4l2_subdev_enable_streams() and
  *		     v4l2_subdev_disable_streams() helper functions for fallback
-- 
An old man doll... just what I always wanted! - Clara

