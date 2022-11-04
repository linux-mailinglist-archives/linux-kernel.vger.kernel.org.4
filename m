Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CDE61A106
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiKDT3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKDT3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:29:37 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C48646E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 12:29:36 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id p12so290429plq.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 12:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=coppeWfhGCt8RrFh4xp+o6BaCFfthicfV88Hga7Ywrs=;
        b=bXaVfbdb3ZcahXxunt5x8dpa93cEIlg83ooOkQZ8Xca/qcP9mecyVfzC59GKM3ic7r
         C2LwHAjdc3W4bJoDaUB6364Dip+DxzhWZSlJqBjd2UnrA4UQnQyDx0wkV/IskMEJ89WD
         gJITpdGbc51rtgK3c7N/pLdDDrjrZqkC+BSvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=coppeWfhGCt8RrFh4xp+o6BaCFfthicfV88Hga7Ywrs=;
        b=1oyXEKB67dkJTUdACTmUqDyN4NV/JO/NHWAkTrv9d40J8R41m+WTosS7tLssFftx8Y
         16bbXi32pb9pr21BFFJOjVQuDfXYVTUx0x1C3Pmb8g5znVUtMuoGvuMOAyDFwcmk0GDr
         buPypQ2XhkTf++iirbzmDiZpTntTnfRwISqbrAfcG7m7OfD4esVdoeHjiJyEDxmP/rKq
         2Jr0umj2q39IG6anRASVgq5QnK/TWE0s1A5j9i8hsXPq4mLKoFVYM4Eb6NOt6tiEii/I
         PQriHshTufX7eJhhpiLA5fZMkIAXjAwg65MziockePy+hKAv5NRh2nW23hcWrIMBpDqE
         pv/w==
X-Gm-Message-State: ACrzQf0Xj33kvkx+etNrbH/2ddul/az6CoZ4+r3JUBQ3EuEpahsYSkb5
        le40+CplGZzVKWKdnQM2HXcr4Q==
X-Google-Smtp-Source: AMsMyM5GA4vWe+7Au3BfwULC3SI7otx4Z3kmU+RAsXyTVz1BP2dUWnjKFDmRuAy9Wg2mW/X84RWcaw==
X-Received: by 2002:a17:90a:f414:b0:212:cacf:42c3 with SMTP id ch20-20020a17090af41400b00212cacf42c3mr55439472pjb.198.1667590176353;
        Fri, 04 Nov 2022 12:29:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902e5c700b00174d9bbeda4sm117527plf.197.2022.11.04.12.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 12:29:36 -0700 (PDT)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Fri, 4 Nov 2022 12:29:35 -0700
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
        linux-renesas-soc@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: rswitch_gwca_queue_alloc_skb(): Control flow issues
Message-ID: <202211041229.F3B37C03@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20221104 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Wed Nov 2 12:38:53 2022 +0000
    3590918b5d07 ("net: ethernet: renesas: Add support for "Ethernet Switch"")

Coverity reported the following:

*** CID 1527147:  Control flow issues  (NO_EFFECT)
drivers/net/ethernet/renesas/rswitch.c:270 in rswitch_gwca_queue_alloc_skb()
264     			goto err;
265     	}
266
267     	return 0;
268
269     err:
vvv     CID 1527147:  Control flow issues  (NO_EFFECT)
vvv     This greater-than-or-equal-to-zero comparison of an unsigned value is always true. "i >= 0U".
270     	for (i--; i >= 0; i--) {
271     		index = (i + start_index) % gq->ring_size;
272     		dev_kfree_skb(gq->skbs[index]);
273     		gq->skbs[index] = NULL;
274     	}
275

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527147 ("Control flow issues")
Fixes: 3590918b5d07 ("net: ethernet: renesas: Add support for "Ethernet Switch"")

Thanks for your attention!

-- 
Coverity-bot
