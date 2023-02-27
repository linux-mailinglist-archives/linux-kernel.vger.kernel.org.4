Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CCD6A3A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 05:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjB0Ef7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 23:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0Ef5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 23:35:57 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1523716AF0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 20:35:56 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v16so2018950wrn.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 20:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jPDUgfWIJpqXibCa/CpfzA6vX/+eetr76UO3gYXulag=;
        b=Y2c2pMHOdmAWtt42WXGHxZoHXdY5+0HknEEl4m1pey2F2mtxesIX9SOYzYDaLOeWhL
         jb9MSlJ+U9vQRnnInMmuXKIZtanhroJ1RSITM/Txt7mZnPNHynjG528tgmkATXIPYlIt
         BiPO7RmKAm+DAqsNjcLd52ySPrJVkahzo6PF3pXHJTgpSN/L6aHpAM0FZMwvbZDz/SH9
         +A1wLlM8TgaJFC71etHyIN8Q/2JvS3g+5+I8SoBzB8tLuWCUgyTkQj7IaPIGl9tNjVSK
         q60vADlahLPKfbRV4qKSCz+Fnr7zJmIJgx3nDeUkWsguhUHHjS+bZXCb/vduaLtPgss0
         KVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jPDUgfWIJpqXibCa/CpfzA6vX/+eetr76UO3gYXulag=;
        b=0H9DTvxxpK4LNgkBNWZX4YP2f/6oQv9Cg9z3igCZAHQEyfihsTHuF9HveFDYwpS/zT
         XznEIcQTc4+VqOay8B1wlPi0PYNJaQ8Efob2AdkhlNY1fQgJn+BU6mo2326lalpyrL+x
         oDzt8JsePkrL/B1Zdh9PAWMhRctg8czAZ3i0w97viAQghd5EklJkAxvMoRilwtrvz6hM
         w/P7nK89MZ9q8D/19FLmLaHCNsrjVqBubtZhOsUJ7cKtBLV6QW77wKa33s+w8SsTKv7J
         +tvtGKC3LlFQHrEH1U5roBRUIs8nRB+HfmiGsuafU5MLuzkD7Pd6lFx5y7LXxEMM9si8
         dBAQ==
X-Gm-Message-State: AO0yUKUZOwsYmLQFpg1lt9oofIURyA80byrZ2j/QebV8mP0jV+BZAUmT
        k1lXeEsaq0UsXvT1wJGcFDg=
X-Google-Smtp-Source: AK7set8Qbgx8pnWq50BGUT5t8DZU+nfGoMdvWrb1ybtBTDMXnROu0Tshyv2lNkjH3G9h5ryYHM1q3A==
X-Received: by 2002:a5d:6c66:0:b0:2c7:d7c:7d7 with SMTP id r6-20020a5d6c66000000b002c70d7c07d7mr5308365wrz.22.1677472554501;
        Sun, 26 Feb 2023 20:35:54 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l3-20020a05600012c300b002c5694aef92sm5863340wrx.21.2023.02.26.20.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 20:35:54 -0800 (PST)
Date:   Mon, 27 Feb 2023 07:35:51 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Wenjing Liu <wenjing.liu@amd.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        George Shen <George.Shen@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_factory.c:365
 dc_link_construct_phy() warn: variable dereferenced before check
 'link->link_enc' (see line 362)
Message-ID: <202302261837.dKavRZA5-lkp@intel.com>
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
head:   2fcd07b7ccd5fd10b2120d298363e4e6c53ccf9c
commit: 54618888d1ea7a26f8bccfb89e3c2420350c8047 drm/amd/display: break down dc_link.c
config: m68k-randconfig-m031-20230226 (https://download.01.org/0day-ci/archive/20230226/202302261837.dKavRZA5-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202302261837.dKavRZA5-lkp@intel.com/

New smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_factory.c:365 dc_link_construct_phy() warn: variable dereferenced before check 'link->link_enc' (see line 362)
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dpms.c:2307 link_set_dpms_on() warn: if statement not indented

Old smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_factory.c:145 get_ddc_line() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_factory.c:201 dc_link_construct_phy() warn: inconsistent indenting

vim +365 drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_factory.c

54618888d1ea7a Wenjing Liu 2023-01-18  348  	enc_init_data.ctx = dc_ctx;
54618888d1ea7a Wenjing Liu 2023-01-18  349  	bp_funcs->get_src_obj(dc_ctx->dc_bios, link->link_id, 0,
54618888d1ea7a Wenjing Liu 2023-01-18  350  			      &enc_init_data.encoder);
54618888d1ea7a Wenjing Liu 2023-01-18  351  	enc_init_data.connector = link->link_id;
54618888d1ea7a Wenjing Liu 2023-01-18  352  	enc_init_data.channel = get_ddc_line(link);
54618888d1ea7a Wenjing Liu 2023-01-18  353  	enc_init_data.hpd_source = get_hpd_line(link);
54618888d1ea7a Wenjing Liu 2023-01-18  354  
54618888d1ea7a Wenjing Liu 2023-01-18  355  	link->hpd_src = enc_init_data.hpd_source;
54618888d1ea7a Wenjing Liu 2023-01-18  356  
54618888d1ea7a Wenjing Liu 2023-01-18  357  	enc_init_data.transmitter =
54618888d1ea7a Wenjing Liu 2023-01-18  358  		translate_encoder_to_transmitter(enc_init_data.encoder);
54618888d1ea7a Wenjing Liu 2023-01-18  359  	link->link_enc =
54618888d1ea7a Wenjing Liu 2023-01-18  360  		link->dc->res_pool->funcs->link_enc_create(dc_ctx, &enc_init_data);
54618888d1ea7a Wenjing Liu 2023-01-18  361  
54618888d1ea7a Wenjing Liu 2023-01-18 @362  	DC_LOG_DC("BIOS object table - DP_IS_USB_C: %d", link->link_enc->features.flags.bits.DP_IS_USB_C);
                                                                                                 ^^^^^^^^^^^^^^^^

54618888d1ea7a Wenjing Liu 2023-01-18  363  	DC_LOG_DC("BIOS object table - IS_DP2_CAPABLE: %d", link->link_enc->features.flags.bits.IS_DP2_CAPABLE);
                                                                                                    ^^^^^^^^^^^^^^^^

54618888d1ea7a Wenjing Liu 2023-01-18  364  
54618888d1ea7a Wenjing Liu 2023-01-18 @365  	if (!link->link_enc) {
                                                     ^^^^^^^^^^^^^^
Too late.

54618888d1ea7a Wenjing Liu 2023-01-18  366  		DC_ERROR("Failed to create link encoder!\n");
54618888d1ea7a Wenjing Liu 2023-01-18  367  		goto link_enc_create_fail;
54618888d1ea7a Wenjing Liu 2023-01-18  368  	}
54618888d1ea7a Wenjing Liu 2023-01-18  369  
54618888d1ea7a Wenjing Liu 2023-01-18  370  	/* Update link encoder tracking variables. These are used for the dynamic
54618888d1ea7a Wenjing Liu 2023-01-18  371  	 * assignment of link encoders to streams.
54618888d1ea7a Wenjing Liu 2023-01-18  372  	 */
54618888d1ea7a Wenjing Liu 2023-01-18  373  	link->eng_id = link->link_enc->preferred_engine;
54618888d1ea7a Wenjing Liu 2023-01-18  374  	link->dc->res_pool->link_encoders[link->eng_id - ENGINE_ID_DIGA] = link->link_enc;
54618888d1ea7a Wenjing Liu 2023-01-18  375  	link->dc->res_pool->dig_link_enc_count++;
54618888d1ea7a Wenjing Liu 2023-01-18  376  
54618888d1ea7a Wenjing Liu 2023-01-18  377  	link->link_enc_hw_inst = link->link_enc->transmitter;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

