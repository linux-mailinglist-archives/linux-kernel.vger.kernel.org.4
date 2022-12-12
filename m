Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A08649978
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 08:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiLLHVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 02:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiLLHVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 02:21:37 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A876B1C3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 23:21:36 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o7-20020a05600c510700b003cffc0b3374so4355542wms.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 23:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dlqQFJZsv0WrGLoh5IhfmrcZ4gs96nv45/eei3MHPpU=;
        b=gu2YmdPD+mrWtk7IRpY6Yp3ae/4fIHowbR1VEHIoeWbdSnZZETN7xLUmtNX2Sc/mjX
         yT2UAW+Td57sOk7+JZ+8T9skiOtVKp03u9SXegpvNax+xD/3uCtvQUtof0ChpGR+H11O
         VCFnMuRiwAKSOGEMhDAshMFlcy458n0rdaZ9gQtEGTwzKAi3MMGkOm2rA3TXuuc+9S4q
         gm3mszKFKuzWULzi4Y7wYhoyHR+T8EDoZ1nDx7tcW4sCIsw+sKkxgARkLlVnlAsWAJzj
         /iHtSLjgBtFknTNpe9nwijqYElif5ak2T/nuKrJR070QrWGcDGLIGVZZeYW7Jxbyd7nU
         BMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dlqQFJZsv0WrGLoh5IhfmrcZ4gs96nv45/eei3MHPpU=;
        b=45zhDR9YQvATCDYJNPQtRzdPJ6C7V7SnYThO+wB3WRe4ap0zfs9jYfwhpQmtr5uida
         +NnMnLL5hdzaJ8r9KZo5BoJvx7Tvo2n88fwwirW2nSVpGyUt0h214k7c9YmfJt+mjzKG
         J7g8YonbfK0Q64GSIwUKdkYyOLtIgnaI8iTnyiXB/95mPCFUhUSUfwQaS75gp7Y6B+4U
         luV1cFMuXkXY9edBCjVrvp5m3+xOZ9T0pH9p8ZrpgPyz73+MSEDLRZz8DiIWpKmPumjF
         a6PV0VCqGh3eCjBeCWr/AHnUMf7HpfF6eYBJZJ+9FPeP2ljL4j0wVBWWAUsfWFmKb8eJ
         LeFg==
X-Gm-Message-State: ANoB5plBqCeMCP6nBNA4uSUA9fAoweb3PaJw2vO9/lDxtdjS6zTXh5fW
        fDgZhhyjUJrCouIpos0LCvs=
X-Google-Smtp-Source: AA0mqf5rV0VAKHtApr50JFqi1s/UM0+La3343NMIGe8UXBiY/XA867Q/fWiDFXpJ/vdl+tig0GtxjQ==
X-Received: by 2002:a05:600c:3501:b0:3c6:e63d:b898 with SMTP id h1-20020a05600c350100b003c6e63db898mr11396566wmq.7.1670829694657;
        Sun, 11 Dec 2022 23:21:34 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m18-20020adff392000000b00242109cf587sm7980683wro.28.2022.12.11.23.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 23:21:34 -0800 (PST)
Date:   Mon, 12 Dec 2022 10:21:30 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Stafford Horne <shorne@gmail.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:1699
 amdgpu_dm_fini() error: we previously assumed 'adev->dm.dc' could be null
 (see line 1695)
Message-ID: <202212110728.v8ny7lxV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stafford,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   296a7b7eb79246912de31ee799cb85220931231a
commit: ded2ee36313c941f1a12b6f85cde295b575264ae openrisc: Add pci bus support
config: openrisc-randconfig-m031-20221210
compiler: or1k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

New smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:1699 amdgpu_dm_fini() error: we previously assumed 'adev->dm.dc' could be null (see line 1695)

Old smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:1726 amdgpu_dm_fini() warn: variable dereferenced before check 'adev->dm.dc' (see line 1699)
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:2707 dm_resume() error: we previously assumed 'aconnector->dc_link' could be null (see line 2694)
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:3995 amdgpu_dm_backlight_update_status() error: testing array offset 'i' after use.
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:4037 amdgpu_dm_backlight_get_brightness() error: testing array offset 'i' after use.
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:5409 fill_blending_from_plane_state() warn: variable dereferenced before check 'per_pixel_alpha' (see line 5384)
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:6504 create_stream_for_sink() error: we previously assumed 'aconnector->dc_sink' could be null (see line 6403)
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8891 handle_cursor_update() error: we previously assumed 'afb' could be null (see line 8850)

vim +1699 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c

7578ecda14d521 Alex Deucher        2017-10-10  1667  static void amdgpu_dm_fini(struct amdgpu_device *adev)
4562236b3bc0a2 Harry Wentland      2017-09-12  1668  {
f74367e492ba24 Alex Deucher        2020-07-10  1669  	int i;
f74367e492ba24 Alex Deucher        2020-07-10  1670  
09a5df6c444cf0 Nicholas Kazlauskas 2021-08-03  1671  	if (adev->dm.vblank_control_workqueue) {
09a5df6c444cf0 Nicholas Kazlauskas 2021-08-03  1672  		destroy_workqueue(adev->dm.vblank_control_workqueue);
09a5df6c444cf0 Nicholas Kazlauskas 2021-08-03  1673  		adev->dm.vblank_control_workqueue = NULL;
09a5df6c444cf0 Nicholas Kazlauskas 2021-08-03  1674  	}
09a5df6c444cf0 Nicholas Kazlauskas 2021-08-03  1675  
f74367e492ba24 Alex Deucher        2020-07-10  1676  	for (i = 0; i < adev->dm.display_indexes_num; i++) {
f74367e492ba24 Alex Deucher        2020-07-10  1677  		drm_encoder_cleanup(&adev->dm.mst_encoders[i].base);
f74367e492ba24 Alex Deucher        2020-07-10  1678  	}
f74367e492ba24 Alex Deucher        2020-07-10  1679  
4562236b3bc0a2 Harry Wentland      2017-09-12  1680  	amdgpu_dm_destroy_drm_device(&adev->dm);
c8bdf2b63e5b6b Emily Deng          2019-05-27  1681  
9a65df19310859 Wayne Lin           2021-03-02  1682  #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
9a65df19310859 Wayne Lin           2021-03-02  1683  	if (adev->dm.crc_rd_wrk) {
9a65df19310859 Wayne Lin           2021-03-02  1684  		flush_work(&adev->dm.crc_rd_wrk->notify_ta_work);
9a65df19310859 Wayne Lin           2021-03-02  1685  		kfree(adev->dm.crc_rd_wrk);
9a65df19310859 Wayne Lin           2021-03-02  1686  		adev->dm.crc_rd_wrk = NULL;
9a65df19310859 Wayne Lin           2021-03-02  1687  	}
9a65df19310859 Wayne Lin           2021-03-02  1688  #endif
52704fcaf74bc9 Bhawanpreet Lakha   2019-05-24  1689  #ifdef CONFIG_DRM_AMD_DC_HDCP
52704fcaf74bc9 Bhawanpreet Lakha   2019-05-24  1690  	if (adev->dm.hdcp_workqueue) {
e96b1b2974989c Nirmoy Das          2021-02-10  1691  		hdcp_destroy(&adev->dev->kobj, adev->dm.hdcp_workqueue);
52704fcaf74bc9 Bhawanpreet Lakha   2019-05-24  1692  		adev->dm.hdcp_workqueue = NULL;
52704fcaf74bc9 Bhawanpreet Lakha   2019-05-24  1693  	}
52704fcaf74bc9 Bhawanpreet Lakha   2019-05-24  1694  
52704fcaf74bc9 Bhawanpreet Lakha   2019-05-24 @1695  	if (adev->dm.dc)
                                                            ^^^^^^^^^^^
Checked for NULL

52704fcaf74bc9 Bhawanpreet Lakha   2019-05-24  1696  		dc_deinit_callbacks(adev->dm.dc);
52704fcaf74bc9 Bhawanpreet Lakha   2019-05-24  1697  #endif
51ba691206e354 Qingqing Zhuo       2021-03-09  1698  
9a71c7d31734f7 Nicholas Kazlauskas 2019-10-28 @1699  	dc_dmub_srv_destroy(&adev->dm.dc->ctx->dmub_srv);
                                                                             ^^^^^^^^^^^
and then dereferenced without checking.

9a71c7d31734f7 Nicholas Kazlauskas 2019-10-28  1700  
81927e2808be5a Jude Shih           2021-04-20  1701  	if (dc_enable_dmub_notifications(adev->dm.dc)) {
81927e2808be5a Jude Shih           2021-04-20  1702  		kfree(adev->dm.dmub_notify);
81927e2808be5a Jude Shih           2021-04-20  1703  		adev->dm.dmub_notify = NULL;
e27c41d5b0681c Jude Shih           2021-07-25  1704  		destroy_workqueue(adev->dm.delayed_hpd_wq);
e27c41d5b0681c Jude Shih           2021-07-25  1705  		adev->dm.delayed_hpd_wq = NULL;
81927e2808be5a Jude Shih           2021-04-20  1706  	}
81927e2808be5a Jude Shih           2021-04-20  1707  
743b9786b14ae0 Nicholas Kazlauskas 2019-10-24  1708  	if (adev->dm.dmub_bo)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

