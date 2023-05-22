Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3A170B57D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjEVGyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjEVGxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:53:53 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4349D118
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:51:13 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f607dc98cdso553135e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 23:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684738271; x=1687330271;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cks/I+E1RSxlLoqm9z0OX20VEKZhG/X4ISND5hJYIcM=;
        b=i8FZlLxUnehhu1rc2d8lXLOxSQlxca5J4bDzpNsAe0ey51HdZjI+n4su5YkIijtiah
         rqSVJEwmxAwoxNjUOiDq/GFPa0b/mgITSRDb9NR49XvM+oAH7v+NvmPAwwLAmhymjsOo
         2aXsLIYY/EsenrMtPLdry53aGpZHgqSqKoT2K8NDCYDjXNFJL44Xpg0rQgDoSEjTJjHa
         kB5PpI7xCRDS8jvVqH1II7q3UhK/at0Pd4kHgthaCVZkWgVEvxxZy3n8FpyUjyCTEFPB
         4igu6yxFY4J9WtXghy3ZkZwNBe37TtIspEmIsmIr38tFI2K0SnakpzydNDkIYV187VrG
         8V/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684738271; x=1687330271;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cks/I+E1RSxlLoqm9z0OX20VEKZhG/X4ISND5hJYIcM=;
        b=EbcFPHqCAvOm48GJOeLVSjVygOPhxan7hcBetuB3JBSfBG/PKeMJqVZRVtPgrWg7QD
         RQmz31Fsl0wbSPcChUzTpgmlB7nEq+L+OdmOeBvTp6J7zGhjYHR5gNEOSHMVesylaFV9
         wgn0N4hmJTGZX6eSSm8HjGgSkPS7RpsgfKLWBiqibBIzGAHg0774FCgw6t553OFcf7w8
         ZQ+iPI2To2CblzPXL8BVJo8bLAqOFEKv3Cz7kNpUR9P/LdcYl0/bVFiZy3ER+9lx3DWu
         aV8GGrLUIIlFmXXfMj6zoAvQtrex5OH4fmJ0T76e8LE6wzQx5vPb4gVg5OAATe9RpYya
         cb0w==
X-Gm-Message-State: AC+VfDx5TN3gFQsJ01ZQrXHAP3QW7ib+kIthf7WNi83MNFxgK2FJcL8Z
        qD5idhtYmVO+29qgYSJMvcnshw==
X-Google-Smtp-Source: ACHHUZ6AEyW+VSbffKx1wxnVJ3faV12vzE8Em+qeuI8U9Fgx6CGukMj4YwM2XVkZhJfXGq8FsBCOuw==
X-Received: by 2002:a5d:494b:0:b0:307:8b3e:2858 with SMTP id r11-20020a5d494b000000b003078b3e2858mr6375277wrs.45.1684738271569;
        Sun, 21 May 2023 23:51:11 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o5-20020a5d62c5000000b003068f5cca8csm6615030wrv.94.2023.05.21.23.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 23:51:10 -0700 (PDT)
Date:   Mon, 22 May 2023 09:50:53 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, David Tadokoro <davidbtadokoro@usp.br>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_plane.c:1263
 amdgpu_dm_plane_handle_cursor_update() error: we previously assumed 'afb'
 could be null (see line 1222)
Message-ID: <16bdc393-7f1d-4823-8982-8c47cc80400b@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d635f6cc934bcd467c5d67148ece74632fd96abf
commit: 8bf0d9cdf36b0bebf17b733e3f5158783d765df3 drm/amd/display: add prefix to amdgpu_dm_plane.h functions
config: ia64-randconfig-m041-20230514
compiler: ia64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202305210251.IqE6U5XP-lkp@intel.com/

smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_plane.c:1263 amdgpu_dm_plane_handle_cursor_update() error: we previously assumed 'afb' could be null (see line 1222)

vim +/afb +1263 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_plane.c

8bf0d9cdf36b0b David Tadokoro   2023-03-05  1214  void amdgpu_dm_plane_handle_cursor_update(struct drm_plane *plane,
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1215  				 struct drm_plane_state *old_plane_state)
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1216  {
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1217  	struct amdgpu_device *adev = drm_to_adev(plane->dev);
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1218  	struct amdgpu_framebuffer *afb = to_amdgpu_framebuffer(plane->state->fb);
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1219  	struct drm_crtc *crtc = afb ? plane->state->crtc : old_plane_state->crtc;
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1220  	struct dm_crtc_state *crtc_state = crtc ? to_dm_crtc_state(crtc->state) : NULL;
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1221  	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20 @1222  	uint64_t address = afb ? afb->address : 0;
                                                                           ^^^
Is this check required?

5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1223  	struct dc_cursor_position position = {0};
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1224  	struct dc_cursor_attributes attributes;
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1225  	int ret;
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1226  
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1227  	if (!plane->state->fb && !old_plane_state->fb)
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1228  		return;
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1229  
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1230  	DC_LOG_CURSOR("%s: crtc_id=%d with size %d to %d\n",
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1231  		      __func__,
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1232  		      amdgpu_crtc->crtc_id,
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1233  		      plane->state->crtc_w,
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1234  		      plane->state->crtc_h);
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1235  
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1236  	ret = get_cursor_position(plane, crtc, &position);
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1237  	if (ret)
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1238  		return;
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1239  
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1240  	if (!position.enable) {
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1241  		/* turn off cursor */
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1242  		if (crtc_state && crtc_state->stream) {
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1243  			mutex_lock(&adev->dm.dc_lock);
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1244  			dc_stream_set_cursor_position(crtc_state->stream,
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1245  						      &position);
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1246  			mutex_unlock(&adev->dm.dc_lock);
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1247  		}
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1248  		return;
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1249  	}
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1250  
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1251  	amdgpu_crtc->cursor_width = plane->state->crtc_w;
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1252  	amdgpu_crtc->cursor_height = plane->state->crtc_h;
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1253  
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1254  	memset(&attributes, 0, sizeof(attributes));
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1255  	attributes.address.high_part = upper_32_bits(address);
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1256  	attributes.address.low_part  = lower_32_bits(address);
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1257  	attributes.width             = plane->state->crtc_w;
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1258  	attributes.height            = plane->state->crtc_h;
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1259  	attributes.color_format      = CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA;
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1260  	attributes.rotation_angle    = 0;
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1261  	attributes.attribute_flags.value = 0;
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1262  
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20 @1263  	attributes.pitch = afb->base.pitches[0] / afb->base.format->cpp[0];
                                                                           ^^^^^                  ^^^^^
It's not checked here.

5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1264  
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1265  	if (crtc_state->stream) {
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1266  		mutex_lock(&adev->dm.dc_lock);
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1267  		if (!dc_stream_set_cursor_attributes(crtc_state->stream,
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1268  							 &attributes))
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1269  			DRM_ERROR("DC failed to set cursor attributes\n");
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1270  
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1271  		if (!dc_stream_set_cursor_position(crtc_state->stream,
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1272  						   &position))
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1273  			DRM_ERROR("DC failed to set cursor position\n");
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1274  		mutex_unlock(&adev->dm.dc_lock);
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1275  	}
5d945cbcd4b16a Rodrigo Siqueira 2022-07-20  1276  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

