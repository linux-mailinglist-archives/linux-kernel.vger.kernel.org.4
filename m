Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AFA64691C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 07:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiLHG0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 01:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiLHGZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 01:25:50 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9297448767
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 22:25:43 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id co23so452874wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 22:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lVqoTumIUaV6+VL26HGJasZO+Tnb32mc0SB9GPC1yuQ=;
        b=Qk/bnMPF4Zx2om8o/r3fAs+iHH5XU8LaFS+8wcBhD8CboQQWYDcd5eXxdrf60kYJ2t
         vXGOiltf0rErkL1Rcec392oTIfOy00NRLC0D3dGj9GAFs0dROjiLZAL71wlxI8NxAycN
         4sD4s4m460bHbncyB1vZUkIsir+rrzi3U3xK0NIYHgxm+6u9yzbcTwCboawncvA7KbKg
         IWZCV+cG8hvqRPQz8yxPrT35JrHrocuutCeRZnuYikTsK0c+hxZSr+t0fjjt0qzxqo4U
         nvKGHij7vttFL3EJHdrK9Nsh4XYa96DtPF4Dumt8PdnGJDzcC7kKVx+OdRQCQE0gR0JI
         2a0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lVqoTumIUaV6+VL26HGJasZO+Tnb32mc0SB9GPC1yuQ=;
        b=DxZBBvygmCXrId98nY+8DrMRX3EWrSzmb10nmxVxek6Teh39XMqRtCEFaepMaWZ8Xp
         o2YgbbxXelNp9SAySxKca9nCKX0EMzqG9CJxmjDYbjHeB0YOdNFJuK7VyT5unYRwJ1pa
         rGYDA7syTQ8jVNuk3tJJ+9awPKs7yV5skJXTXEeNEIA5K8jZ8fqT0Zm9NhYK/Fobh24Y
         dQTFUePxux8d58E+XhxEwWGs53g5uv9tpDaEViFgv+4/0DGSjPiAlq1AIm8ekCnwRNfi
         QZ5v891GaiikHWs6qoDXXB+u7eK43kFsA8ysDCRGPZO03r9I3Ub4KkQpzWthSMeBNE+y
         vuWA==
X-Gm-Message-State: ANoB5pmJrjTfzAMmrEf9RgWLr1eG5/sqBMewy5xdMiFu5nOVFFNy3SJy
        4PsaQnq1Vw8KmId1j2HiUjfnKxoDlR+XuQ==
X-Google-Smtp-Source: AA0mqf53fbuKtM66WgMuJ9T69Lw5atQisaUmRXtDIOWDp6cFvaisbOwrlZ+cj6I56SwFhcfj+WrOTQ==
X-Received: by 2002:a5d:5702:0:b0:242:569:3028 with SMTP id a2-20020a5d5702000000b0024205693028mr14797222wrv.435.1670480742037;
        Wed, 07 Dec 2022 22:25:42 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t16-20020a5d6910000000b0024217e7aaa7sm20834339wru.50.2022.12.07.22.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 22:25:41 -0800 (PST)
Date:   Thu, 8 Dec 2022 09:25:38 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Xiaojian Du <Xiaojian.Du@amd.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Huang Rui <ray.huang@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c:928 gmc_v6_0_hw_init() warn:
 missing error code? 'r'
Message-ID: <202212080729.ChsUgoMZ-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8ed710da2873c2aeb3bb805864a699affaf1d03b
commit: 479e3b02b73a2de2b19df2950863149c59d57bfe drm/amdgpu: add vram check function for GMC
config: mips-randconfig-m031-20221207
compiler: mips-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c:928 gmc_v6_0_hw_init() warn: missing error code? 'r'

vim +/r +928 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c

df70502eef80be Ken Wang     2016-01-19  906  static int gmc_v6_0_hw_init(void *handle)
df70502eef80be Ken Wang     2016-01-19  907  {
df70502eef80be Ken Wang     2016-01-19  908  	int r;
df70502eef80be Ken Wang     2016-01-19  909  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
df70502eef80be Ken Wang     2016-01-19  910  
df70502eef80be Ken Wang     2016-01-19  911  	gmc_v6_0_mc_program(adev);
df70502eef80be Ken Wang     2016-01-19  912  
df70502eef80be Ken Wang     2016-01-19  913  	if (!(adev->flags & AMD_IS_APU)) {
df70502eef80be Ken Wang     2016-01-19  914  		r = gmc_v6_0_mc_load_microcode(adev);
df70502eef80be Ken Wang     2016-01-19  915  		if (r) {
075719c3cb79f3 Tom St Denis 2016-09-06  916  			dev_err(adev->dev, "Failed to load MC firmware!\n");
df70502eef80be Ken Wang     2016-01-19  917  			return r;
df70502eef80be Ken Wang     2016-01-19  918  		}
df70502eef80be Ken Wang     2016-01-19  919  	}
df70502eef80be Ken Wang     2016-01-19  920  
df70502eef80be Ken Wang     2016-01-19  921  	r = gmc_v6_0_gart_enable(adev);
df70502eef80be Ken Wang     2016-01-19  922  	if (r)
df70502eef80be Ken Wang     2016-01-19  923  		return r;
df70502eef80be Ken Wang     2016-01-19  924  
479e3b02b73a2d Xiaojian Du  2022-01-17  925  	if (amdgpu_emu_mode == 1)
479e3b02b73a2d Xiaojian Du  2022-01-17  926  		return amdgpu_gmc_vram_checking(adev);
479e3b02b73a2d Xiaojian Du  2022-01-17  927  	else
df70502eef80be Ken Wang     2016-01-19 @928  		return r;

This seems like a false positive, but it would be more readable as
"return 0;" instead of "return r;"

df70502eef80be Ken Wang     2016-01-19  929  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

