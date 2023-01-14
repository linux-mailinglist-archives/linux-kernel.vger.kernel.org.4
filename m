Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A9B66A7DA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 02:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjANBBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 20:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjANBBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 20:01:45 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55029B0C
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:01:44 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d15so25083498pls.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qgw535iASL0BBYGWskr0WZVg4MmmiV+z+GQaxRQiCBw=;
        b=nL2bwlAxMR5DLssfrywtpH9mfIMIdBZVUZFo1QjotAyi9MVV3kHFHA8m+S5SdIzrag
         UPyHUhzj35Ep6CrZM6NEvD7x0FY0DEo4BpJ4d3k+0fWdtQM2IOC56v5tBey48QgxfKj+
         UYuk1wVaGyoTLtrtQ2Qru/KkRsCFvTcodzcs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qgw535iASL0BBYGWskr0WZVg4MmmiV+z+GQaxRQiCBw=;
        b=ZTRD3vxN/el//aUIsiDdGT5a+F+B65drGTlQNA5X2QVl/M62/cxqx3HKYaF65J4Gbf
         cbwuCOo9EYIC+lAAtTjsZxvg28gq3H6LeppGwzWvmDOVSBHsrOK7tjk8UfOAak7GxJIt
         GAPkURY1M8/xIM9MqqT5IrSrct6rxlVpnMG0CnXnUrzBtoemy21WCn7hBc8n3DSYhxaZ
         0dEO8sOmGaS9GlGg+pgx1iXAKxR75WfZeVH2hpTLvqo6PFmKTQA8zBJB+z7dSdamIMMk
         R2jYMf06AOrvv1yGQRDVe4xVhxcFAlGbfF3EYvtqAnticHAHHfQ3pEmo85Mdz4K1CVOY
         4Mig==
X-Gm-Message-State: AFqh2kqAA3uhY+IpWW0+Sdgii0YKTCf1u/43C69DwuDjsgSCv22WZXky
        Adwu1uqyB8sEfbLBxTmDFuMATw==
X-Google-Smtp-Source: AMrXdXvAmuCy/ESZg37YKkGXzL80Uo2d4QTNznHYtWzp/C4BjDA9aRt4kKT1ef6YjB95OdmJTrhnlQ==
X-Received: by 2002:a17:903:1209:b0:193:2303:c9e5 with SMTP id l9-20020a170903120900b001932303c9e5mr32737268plh.20.1673658103840;
        Fri, 13 Jan 2023 17:01:43 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902714600b001769e6d4fafsm7131481plm.57.2023.01.13.17.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 17:01:43 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org, rdunlap@infradead.org
Cc:     Kees Cook <keescook@chromium.org>, luto@amacapital.net,
        wad@chromium.org
Subject: Re: [PATCH] seccomp: fix kernel-doc function name warning
Date:   Fri, 13 Jan 2023 17:01:39 -0800
Message-Id: <167365809737.2027566.12615330259104728324.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230108021228.15975-1-rdunlap@infradead.org>
References: <20230108021228.15975-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jan 2023 18:12:28 -0800, Randy Dunlap wrote:
> Move the ACTION_ONLY() macro so that it is not between the kernel-doc
> notation and the function definition for seccomp_run_filters(),
> eliminating a kernel-doc warning:
> 
> kernel/seccomp.c:400: warning: expecting prototype for seccomp_run_filters(). Prototype was for ACTION_ONLY() instead
> 
> 
> [...]

Applied to for-next/seccomp, thanks!

[1/1] seccomp: fix kernel-doc function name warning
      https://git.kernel.org/kees/c/0fb0624b15d2

-- 
Kees Cook

