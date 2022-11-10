Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7592D6246EC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiKJQ3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiKJQ24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:28:56 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DA1F2F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:28:55 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so1963971pjl.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kYFwHEO1MQlzL5988RRWEhawb+X2ogNV7IVaKnMutAU=;
        b=Rm55ZdKNphJGqjoRbhXa5JBhBhiPEiMwlpKtjW361GKLVvfqEtEX7Y7clPYJfMgqWR
         kpkrS895JF1SRdfNduRLBrodr2uK3vPGtZkRoWxsm94syt6dYHOvxrM+H2ctwB/h8AAO
         7XhSInP9a3nufSN5jxqnRX2+Gk55ecO7ma2S0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kYFwHEO1MQlzL5988RRWEhawb+X2ogNV7IVaKnMutAU=;
        b=ZWnGdHd6F276MT2c9n05iQa2l4ONLbrFwxeTAJUIR0wsHEwN8BAwSwmK/gNX++7aK0
         BTcUupHKArqooGehW3/I8pn8T7WFtdu3Bj2Ed8/CuJ/3AsG3KUgmOo52YHO++QvfPdUI
         7HRyT805rRPV6auQiM0YNJZrfBL7yk2T57eZJAp8QG2lOMKzE6qf1tPvmyKc2bWj19G5
         PKGrShhWbZujIt9EzXudVb+xViNNG00nOl1KEiARQ4GQa5Pv/KvE0pnyL6hggTlfSibI
         fnyuF2uk4LmfeJyS0jNNsMseKEkFHphC6icUx9fGAcAh0LuyBM6SqYzvK7QmJ+YpKjeq
         GESg==
X-Gm-Message-State: ACrzQf07P2aoSLAaprqr0y1ky9tMzjy9qC0WdU3b9x2l/E1iIdmDz46v
        T9/6pQMymXhVuAlDjDSw7QcO/A==
X-Google-Smtp-Source: AMsMyM4emYZP3L1Fe5or/JUatDIpzgVdYnSmSA1gAw+IRUfMU2GbSXaLJGFz4dkzBNNwc1PTVrDwog==
X-Received: by 2002:a17:90a:dd95:b0:213:7d3d:a769 with SMTP id l21-20020a17090add9500b002137d3da769mr1418306pjv.22.1668097735017;
        Thu, 10 Nov 2022 08:28:55 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p1-20020a170902a40100b00177f4ef7970sm11463523plq.11.2022.11.10.08.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:28:54 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Thu, 10 Nov 2022 08:28:53 -0800
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        Shawn Tu <shawnx.tu@intel.com>, linux-media@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: tc358746_g_register(): Integer handling issues
Message-ID: <202211100828.AFD4E1799@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

  Thu Oct 27 14:48:40 2022 +0300
    80a21da36051 ("media: tc358746: add Toshiba TC358746 Parallel to CSI-2 bridge driver")

Coverity reported the following:

*** CID 1527256:  Integer handling issues  (INCOMPATIBLE_CAST)
drivers/media/i2c/tc358746.c:998 in tc358746_g_register()
992     	/* 32-bit registers starting from CLW_DPHYCONTTX */
993     	reg->size = reg->reg < CLW_DPHYCONTTX_REG ? 2 : 4;
994
995     	if (!pm_runtime_get_if_in_use(sd->dev))
996     		return 0;
997
vvv     CID 1527256:  Integer handling issues  (INCOMPATIBLE_CAST)
vvv     Pointer "&reg->val" points to an object whose effective type is "unsigned long long" (64 bits, unsigned) but is dereferenced as a narrower "unsigned int" (32 bits, unsigned). This may lead to unexpected results depending on machine endianness.
998     	tc358746_read(tc358746, reg->reg, (u32 *)&reg->val);
999
1000     	pm_runtime_mark_last_busy(sd->dev);
1001     	pm_runtime_put_sync_autosuspend(sd->dev);
1002
1003     	return 0;

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527256 ("Integer handling issues")
Fixes: 80a21da36051 ("media: tc358746: add Toshiba TC358746 Parallel to CSI-2 bridge driver")

Thanks for your attention!

-- 
Coverity-bot
