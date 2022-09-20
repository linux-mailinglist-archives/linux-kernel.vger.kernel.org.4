Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522EA5BE4E7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 13:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiITLr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 07:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiITLrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 07:47:55 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD93A167E3;
        Tue, 20 Sep 2022 04:47:53 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n35-20020a05600c502300b003b4924c6868so739236wmr.1;
        Tue, 20 Sep 2022 04:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=Uzqu4x3ReJl2swGfEJj67Pd2unDJ3Dv2X7PfUeAMFlU=;
        b=CmXkA8qIbaFNouX5UDIP2EtzvEpNmgRhb/8rznaJhGMNUuwBOFHghs3gJQS4uomnZr
         YDcqkjuEvJ4vCka5cONnCHVRV6iQInH+8o7Zq6VeC/3C8HUmiQ31Tc1D7RqHoZMY0+gl
         DpJVgqTY9VSsYXVMFHySjCx4npqW7qGsRD7k6vyHOfIxIklfFsHo9utUqClMbHOH7nzv
         xKq4OLNK7WWtv23lHrNAz+KZYWDVjodkcEtoVo4NkPp0a/0giowcL+JsMfRSnh9PfBq2
         GPBjK8DY/TfnAMRV+kChdRhMBeamsBENpwI9RfDCDpHENBnE3x1TJgyEn6gEeFu9Vrxg
         wbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Uzqu4x3ReJl2swGfEJj67Pd2unDJ3Dv2X7PfUeAMFlU=;
        b=b0t0o0tnomuG0WVnkPaW8/gsv2uImBvvGHdop01M56YS+66H9VL0DidCooeadI5CL3
         54gFqZQaCfylODjIJ3RfWfHN2eoLgs34+yvLSwRm+rns1d/Rxfh4tHut51cotIOT+VmP
         6xf9u4HVOkcY85M8X806RY/IW/Dq7C3UgG+cjV91lNabinKrn7fMJY1KJBIiP3Nw7gIP
         yL//6okjn/joSNTNCycG1YhkeulPHtQ1q1zjDVdrJf1miGtM8oElfd40YuvLor/PKaIt
         VI1I7GnUb+2IgaOxSI/8UZfjCi1RDSKIvm83BPLRUnFnxgmBh8S8mKjJZGsxX8I0H8wR
         VAQg==
X-Gm-Message-State: ACrzQf3e8Igm5QFbppmKNEZeH3vPrTkeLogQ1lrwh80cOrMEkIaqFf/u
        JNlqI/AjE9num05p5fAwl756H/IvOz7wqg==
X-Google-Smtp-Source: AMsMyM4aBYcaHzJkBzdvhpxsTIJL1CmLJ4dHjh82nS5T2kmR/xQCQfB8ki9IGbZoXjIWTpnN0yGzMA==
X-Received: by 2002:a1c:f009:0:b0:3b4:9398:49c9 with SMTP id a9-20020a1cf009000000b003b4939849c9mr2085385wmb.174.1663674472131;
        Tue, 20 Sep 2022 04:47:52 -0700 (PDT)
Received: from debian (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id b20-20020a05600c4e1400b003b33de17577sm2254667wmq.13.2022.09.20.04.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 04:47:51 -0700 (PDT)
Date:   Tue, 20 Sep 2022 12:47:49 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Philip Yang <Philip.Yang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-next@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev
Subject: build failure of next-20220920 due to c2b08e7a6d27 ("drm/amdgpu:
 move entity selection and job init earlier during CS")
Message-ID: <YymoZR0jHR7seGyU@debian>
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

The builds of arm64 allmodconfig with clang failed to build next-20220920
with the error:

drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:1190:3: error: variable 'r' is uninitialized when used here [-Werror,-Wuninitialized]
                r |= !amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
                ^
drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:1171:7: note: initialize the variable 'r' to silence this warning
        int r;
             ^
              = 0
1 error generated.


git bisect pointed to c2b08e7a6d27 ("drm/amdgpu: move entity selection and job init earlier during CS")

I will be happy to test any patch or provide any extra log if needed.


-- 
Regards
Sudip
