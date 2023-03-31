Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839296D2B5C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 00:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjCaWiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 18:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjCaWiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 18:38:10 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC8F20C1B;
        Fri, 31 Mar 2023 15:38:09 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l27so23908253wrb.2;
        Fri, 31 Mar 2023 15:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680302288;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5v7xvunvsYzy+j0hJpOC0u3uISSu7pltf/PiT/5Sg7Y=;
        b=lAWH/t8UWEC0Dbj/7E4iCzDWL65Pjl/KK4pGG+Flgo2FlpmvtGPO5bUBNNEpD3TwY5
         M82t7cOddg3svU6CiicWPJOolJTe08Mt2Y9MAMLGZEHSwzRTVTqxcWnhf3q0Jh+ZCvIU
         AcQ/nZLKLdJIbf5NYHqdlrlpHPHo0UtOiG1q7LNZ+V7cy4RAKS1wRgj2te9RZ/WqLNEO
         CBC4ldPMZnPWdbB5VtU7NcukguQQ63bqdW+LkhCZQAB1N2tOc9a5q4LbiRTCepyAXFEk
         CjDao7IUoeiu+bjSur2mfg7cv7q8JdOGzcppkqca4SwCUqfXU52C09xd+/8VGYjPPmdT
         8Y6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680302288;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5v7xvunvsYzy+j0hJpOC0u3uISSu7pltf/PiT/5Sg7Y=;
        b=Y8A0jaspsoQMG7+KHFiAoeG1A1bMfNi75hhayun1+jTrSTSSSXwHA1+vnTo1OPY4D+
         bw7y8Gb0V5LXR4IDlEcr8qo1L5l+GyQnegXnCoDYoYHAIXesLjaBT+kX3xpdR9K+94Xe
         GWRjvdS2v48PuA2jSCg18RUZz3/dcu47nAcl/2/zY4jlznP+2tLrkuzxXMC9tTEs6lIb
         JWVvkDZk0mksDJz2fFzNG61e77AQaiEPVR8CPUqZ8yKVCOnk57g4HxfPdU2GUUuqcmXC
         O1wwUlQdGvz6Rzo+Je0IAsRTVM3pSxwciaMtodGnnO6IGvH/XYDIDKVbM9KpWoxE6w1N
         1nlA==
X-Gm-Message-State: AAQBX9fsvLII4a09e0p+ScYgWepslU8hdv+dxBMmFfbh2+kQ0EdndmT0
        MRpGnL7Y0DI8XGbEG2uKJwV8Kw31KR0=
X-Google-Smtp-Source: AKy350a2mJOf0+8PkcWAKztd5VJjFp413ZWnOwlRgDf6WMzPU7qHVCqIdlVC+ETZ4yHt15B9a2vxNg==
X-Received: by 2002:a5d:4d11:0:b0:2d2:d324:e44f with SMTP id z17-20020a5d4d11000000b002d2d324e44fmr21024396wrt.16.1680302287918;
        Fri, 31 Mar 2023 15:38:07 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id l12-20020a5d560c000000b002cfe685bfd6sm3189226wrv.108.2023.03.31.15.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 15:38:07 -0700 (PDT)
Date:   Fri, 31 Mar 2023 23:38:06 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-media@vger.kernel.org
Subject: mainline build failure due to 02852c01f654 ("media: i2c: imx290:
 Initialize runtime PM before subdev")
Message-ID: <ZCdgzm2NOSQc5qAL@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The mainline kernel branch had been failing last few weeks for alpha,
csky and s390 allmodconfig with the error:

drivers/media/i2c/imx290.c:1093:12: error: 'imx290_runtime_suspend' defined but not used [-Werror=unused-function]
 1093 | static int imx290_runtime_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~
drivers/media/i2c/imx290.c:1085:12: error: 'imx290_runtime_resume' defined but not used [-Werror=unused-function]
 1085 | static int imx290_runtime_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~

git bisect pointed to 02852c01f654 ("media: i2c: imx290: Initialize runtime PM before subdev")

I will be happy to test any patch or provide any extra log if needed.


-- 
Regards
Sudip
