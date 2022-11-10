Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B50624792
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbiKJQun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbiKJQuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:50:12 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37686BE2C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:49:49 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id l6so2031688pjj.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wyrWfcByjJXJ5u7emZGohwKYRcoGGODByISYDFHgldU=;
        b=SkZKW3Yo1le1fuMFEG+mH3AW0pGZzhfl1jquZr26xXoWgcpGUgwx/9i59trYLnbyNp
         0fECbdTZThXTLRMivyi83uOwpVX+PQtcAkIY/lpHnBGqzgJ8HE/JGcY/yGpDr/tts6s8
         fEUAZIy98nqHcvqsGCP73UaA5HAyPfN1MhCsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wyrWfcByjJXJ5u7emZGohwKYRcoGGODByISYDFHgldU=;
        b=piQu0rlG7ntnw6dJGBrySdW8JPg6zAvm2IWVOwPNYiV1aSGJBWqxxavE2L5/DlpSk8
         rXTL/+YhLoHBZHNzq+TY7ciqg+aKhcRpkB6YuHgsOyVizIC8Eaffso5K8ye8hNOvpPEJ
         mw2BGakTGKlSVBrCs4KCRrp9eUXGNig8ueGJFJUQV+RX1lSCyHiinlH1iPcyutZgCic5
         pvhP2/mGUf0DcLD5oZTEMZ88lrNj0BelprrLG2C6uPzaeSHjhKZQmNCcHwM1XKiJQWFn
         kYBsFdWOIl82WZ3+u4wT4XtC8yy5EiBaFDmdFZp/gi9m9b2XDSM0w2oQw0xzEFia792J
         BSTw==
X-Gm-Message-State: ACrzQf0U3+BVNfOa6LJ8gfVYRqzZpZ/4Sso3jMmHXm9TA32p775BNce0
        Ypxc4HrBiEkdqfSx+l0nlL0qKg==
X-Google-Smtp-Source: AMsMyM4giYvP77sTPDWGk4iRexWkKdhko7Z9x8ZbVQ0+6fKkZQD8biAGSZtsNEYAUXSGiobU0OhdmQ==
X-Received: by 2002:a17:902:e803:b0:187:3a52:d262 with SMTP id u3-20020a170902e80300b001873a52d262mr47366180plg.85.1668098988693;
        Thu, 10 Nov 2022 08:49:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l14-20020a170903120e00b0016be834d54asm11586089plh.306.2022.11.10.08.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:49:48 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Thu, 10 Nov 2022 08:49:47 -0800
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Lyude Paul <lyude@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Dave Airlie <airlied@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: nvkm_dp_train(): Integer handling issues
Message-ID: <202211100849.DDBADD2A6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20221110 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Wed Nov 9 10:43:10 2022 +1000
    8bb30c882334 ("drm/nouveau/disp: add method to trigger DP link retrain")

Coverity reported the following:

*** CID 1527267:  Integer handling issues  (NEGATIVE_RETURNS)
drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c:458 in nvkm_dp_train()
452     	u8  pwr;
453
454     	/* Retraining link?  Skip source configuration, it can mess up the active modeset. */
455     	if (atomic_read(&outp->dp.lt.done)) {
456     		for (rate = 0; rate < outp->dp.rates; rate++) {
457     			if (outp->dp.rate[rate].rate == ior->dp.bw * 27000)
vvv     CID 1527267:  Integer handling issues  (NEGATIVE_RETURNS)
vvv     "ret" is passed to a parameter that cannot be negative.
458     				return nvkm_dp_train_link(outp, ret);
459     		}
460     		WARN_ON(1);
461     		return -EINVAL;
462     	}
463

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527267 ("Integer handling issues")
Fixes: 8bb30c882334 ("drm/nouveau/disp: add method to trigger DP link retrain")

Thanks for your attention!

-- 
Coverity-bot
