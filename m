Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9593D5F6314
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiJFIvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbiJFIvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:51:12 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5366DAC2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:51:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n12so1585320wrp.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 01:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aIf8xFSpdZbA1GQzuqts7ymYscMRXeakvYyTWUDLadI=;
        b=G2GZPFQtAV+fYMiWZUUw9Ycw4NyH/47he9vDSPotO9NB+kd/J+ZTdp4QRwxs3nUmel
         HsE6XDKEW5sgrt/QH6ElbgDbCHmOcxh+iT0NqyFTt3vJCqNtDZ7xBXJUf2RQDiFIZTFO
         BVmPbl+qzzABOI+E2a3Ou4i+0l7AqwQhJlxrFI10eOvuLOOv39p2bgFOjVUq3IzTNgdm
         imCSquDjoB7r8VPw0135RDuR5doUnprvSetHHzy/LNFGfEJ/YtD0Ir9yiut3enBuyACk
         uQoH3GbZCQR93o/HCw39kkDnAKJWHAGH1wnBO/YrX9FY3UIYazs78CpMd5gNZhMYqaud
         BKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aIf8xFSpdZbA1GQzuqts7ymYscMRXeakvYyTWUDLadI=;
        b=ogE+tLoW4fdyyjLy4L+nEXPEQUNke4sDIBxJpWm1LUYyGAXjxtlOM3yzK5VHyJH+xt
         bTBgw8L76RHbcqfaHqu063nOMIUZkvcfs+fFuvMXMQiltkvHcMabtNnFariY5e19jqXD
         PZDVR9Pm5DTLhc7LEL3uKrhnsqovLhta6StmgK69xr7/nAqo2ZH4L7MmWZhwXs4PS71z
         EzXN5inc/oE8a+z0j7udTy3U0IMJoeFO6VDuJBe8GYTqQq89Ix3h3oXFFZDsgXgBKXe1
         Jf/5pC3eB2iua0DOhtXlDCtFXxQxLoYQczcCuFgtbghxj1G+vm/BA3ae8aSqeUvLIJPz
         6+eQ==
X-Gm-Message-State: ACrzQf2H+bZBEK/OxmC2PSBrx+fEr0Ju+J+ZIR/y1+f1YkQBNteKUBSo
        a0Kc/IhZX8lKcjamyBn/ONyoBmQyKAI=
X-Google-Smtp-Source: AMsMyM5MMGYHRauq4eVLkpLLZvw2RTDbvRrV8/jSalu4l28kT8hstXJuRFCaWh2Nh/nRrelPatgN7w==
X-Received: by 2002:adf:ef43:0:b0:22d:c507:dd48 with SMTP id c3-20020adfef43000000b0022dc507dd48mr2337256wrp.416.1665046268371;
        Thu, 06 Oct 2022 01:51:08 -0700 (PDT)
Received: from debian (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id m7-20020a05600c3b0700b003a1980d55c4sm4886918wms.47.2022.10.06.01.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 01:51:08 -0700 (PDT)
Date:   Thu, 6 Oct 2022 09:51:06 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: mainline build failure due to 5d8c3e836fc2 ("drm/amd/display: fix
 array-bounds error in dc_stream_remove_writeback()")
Message-ID: <Yz6W+j+l0cJbr5dX@debian>
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

Hi All,

The latest mainline kernel branch fails to build allmodconfig for every
ARCH with gcc-11 with the error:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c: In function 'dc_stream_remove_writeback':
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:527:83: error: array subscript [0, 0] is outside array bounds of 'struct dc_writeback_info[1]' [-Werror=array-bounds]
  527 |                                 stream->writeback_info[j] = stream->writeback_info[i];
      |                                                             ~~~~~~~~~~~~~~~~~~~~~~^~~
In file included from ./drivers/gpu/drm/amd/amdgpu/../display/dc/dc.h:1269,
                 from ./drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:29,
                 from ./drivers/gpu/drm/amd/amdgpu/../display/dc/basics/dc_common.h:29,
                 from drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:27:
./drivers/gpu/drm/amd/amdgpu/../display/dc/dc_stream.h:241:34: note: while referencing 'writeback_info'
  241 |         struct dc_writeback_info writeback_info[MAX_DWB_PIPES];
      |                                  ^~~~~~~~~~~~~~


git bisect pointed to 5d8c3e836fc2 ("drm/amd/display: fix array-bounds error in dc_stream_remove_writeback()")

I will be happy to test any patch or provide any extra log if needed.

Note:
This is only seen with gcc-11, gcc-12 builds are ok.


-- 
Regards
Sudip
