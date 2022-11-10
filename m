Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6517662470E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiKJQbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiKJQba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:31:30 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABB831F86
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:31:29 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso1957834pjc.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q//NfvfwbHlgG9kr+gM0PFB8sz8eUnyj+TzRNyjvOKw=;
        b=ZyS9R/MGUW1YGsyldhs8c3fxMyKBfTNmQJ1dEiwBVAZLzrhn3y+kyT1y4tJXACxZij
         nHexC39gvmUtCFWpVUKNQV011pe/GyYd9XPoAWYAzHv6qXMNgqU5ZFpCn7bwdhTeN3SA
         QJeNpFVjKoNY34iyr+5i6NiOJokMKja7B6Mm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q//NfvfwbHlgG9kr+gM0PFB8sz8eUnyj+TzRNyjvOKw=;
        b=A6Fqm6uhnvNaKFhUTIc3igf/5xBDHGbWRLScu427/86aEI4SE7Yb4zZ6iVf16vXmld
         BHgBxs8i5LHYtq/fwAvKPuXPzsMoQymVTjVsjThyqg75e/dDMOx340tqSz2RYzQuEnMF
         zSL1pCs+Uz9wbc9KcxCbg8BbawSPg3KJw0YGCrP/2tV0pV3ZHmErIWZd2oAWZ9sgHqKK
         ftg9osd+Eg4V6JQ6vz2tlVMBfKrF/AWR46OMvAr11IfyYwjeHRZ1yh6woiCQHQebLbqb
         2b+jbfZFW+w2mMoIBYJ49jhCkPazQ1NH0nBFsfsG4L74ar1fo9VKES24m/FPhMhnsB/D
         EM+w==
X-Gm-Message-State: ACrzQf2jlPIunm8RLmg1wpm8UIKeCw5xOf83t6Uc2+vF9aZ/j0ukKqwB
        jsQKem12LmdbGdUYuroW3U0tWQ==
X-Google-Smtp-Source: AMsMyM7bIHCw2g7OgpW74otDtZWYJB94LTrxnCHjqC3yaKzr5RoqEceOvIFYIh4hvDYJgJPw1nezZg==
X-Received: by 2002:a17:90a:2acd:b0:213:e2a8:39be with SMTP id i13-20020a17090a2acd00b00213e2a839bemr55581665pjg.205.1668097889272;
        Thu, 10 Nov 2022 08:31:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f143-20020a623895000000b0056b6d31ac8asm10708209pfa.178.2022.11.10.08.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:31:28 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Thu, 10 Nov 2022 08:31:28 -0800
To:     Benjamin Mugnier <benjamin.mugnier@foss.st.com>
Cc:     linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        Shawn Tu <shawnx.tu@intel.com>, linux-media@vger.kernel.org,
        Sylvain Petinot <sylvain.petinot@foss.st.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: vgxy61_apply_gpiox_strobe_mode(): Control flow issues
Message-ID: <202211100831.ABA2A931@keescook>
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

  Thu Oct 27 14:37:38 2022 +0300
    153e4ad44d60 ("media: i2c: Add driver for ST VGXY61 camera sensor")

Coverity reported the following:

*** CID 1527249:  Control flow issues  (NO_EFFECT)
drivers/media/i2c/st-vgxy61.c:891 in vgxy61_apply_gpiox_strobe_mode()
885     					  unsigned int idx)
886     {
887     	static const u8 index2val[] = {0x0, 0x1, 0x3};
888     	u16 reg;
889
890     	reg = vgxy61_read_reg(sensor, VGXY61_REG_SIGNALS_CTRL);
vvv     CID 1527249:  Control flow issues  (NO_EFFECT)
vvv     This less-than-zero comparison of an unsigned value is never true. "reg < 0".
891     	if (reg < 0)
892     		return reg;
893     	reg &= ~(0xf << (idx * VGXY61_SIGNALS_GPIO_ID_SHIFT));
894     	reg |= index2val[mode] << (idx * VGXY61_SIGNALS_GPIO_ID_SHIFT);
895
896     	return vgxy61_write_reg(sensor, VGXY61_REG_SIGNALS_CTRL, reg, NULL);

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527249 ("Control flow issues")
Fixes: 153e4ad44d60 ("media: i2c: Add driver for ST VGXY61 camera sensor")

Thanks for your attention!

-- 
Coverity-bot
