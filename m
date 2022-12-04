Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39314641AB1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 05:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiLDEi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 23:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiLDEiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 23:38:22 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8071707B;
        Sat,  3 Dec 2022 20:38:21 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so11878723pjc.3;
        Sat, 03 Dec 2022 20:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ql7eeabIEDFl5mJRnEM5jNb8uyqkgLCXuNSUvQMj8Hw=;
        b=g5uA1YVYXTC0hlJX7lqKIMn3LSbLY1wBmlspTGs4/qdc2Nmbe7Ll/0NgpiqA4WNryB
         ZNBVFzSO/kZmidZjdb7mnnT5AtaZh9eMonqJ/6kFFp1nQ4ZYrQT6I82sYtWlx0ykGe7+
         MBra2KizAR3pTXZhLqWgPtWVYLjdGu3DBobAgcHvbQgbqwkbuKm3hNnLEYumLP6SLc0C
         FIMn1GMGZy0uBkkLgbtsMW/n2bPvfLY39JSal1cynxWo+XXaf4EblxCLTJn+ZVTnIjuR
         jcdesMPVwWdGi8WOXde47cR8DDVFYt7SDeSVMwL72ZYPjpA64n17JQ0CV4YuS2wqPR8O
         2uvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ql7eeabIEDFl5mJRnEM5jNb8uyqkgLCXuNSUvQMj8Hw=;
        b=NpCkRx9LpDv0LHVbSUpmtI2YhKt3O7QL2EAAu3A+w3Mn+5JWPqbHJzO+Fbu/xdHf8Z
         ViEkPkK6dwza1yjXK9NAbxdCyggXtQGdWwuB/uPTPowMhLAr9STmGGDwA+QZ7TproXf6
         VZEehzj0FEeA2BBQanu2pLA3JsVjAkGSYA1m83VmiXzuYKsXDphFVjMBFzid09ygIHCG
         WxsBsv6L2BDNgYLhFOIXb2pgcjf1oOxa4YjEm2CmqAd7tqKG+w7r/228fQ7Q3017L3cf
         ew977Ibe8900oyx2LMoNu9J8IsH7WuFj++y9BFMcdKyeELOkU3ijMLTmlLtJ6o654GZA
         jT+g==
X-Gm-Message-State: ANoB5pnAQy1nGps8mCaDu9rA1dzsrU1a4b0NSDL/w9x4P3mlVgRu/M5G
        X+E0dM8n+Fk/cmTKwHBAVTU0g6zibn4=
X-Google-Smtp-Source: AA0mqf4zTJ2LzXQ/YZY51al7HMp/hCXFTOn33d2VcCsQ6nCZFOz5ibkxR3asHfKU4sZvPyGHwuvBDw==
X-Received: by 2002:a17:90a:6582:b0:219:2638:42d0 with SMTP id k2-20020a17090a658200b00219263842d0mr9910696pjj.186.1670128700177;
        Sat, 03 Dec 2022 20:38:20 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:50bf:ab09:e932:bfd2])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902e2cc00b00176a6ba5969sm2318645plc.98.2022.12.03.20.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 20:38:19 -0800 (PST)
Date:   Sat, 3 Dec 2022 20:38:16 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v6.1-rc7
Message-ID: <Y4wkOCD1YCcchwv+@google.com>
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

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.1-rc7

to receive updates for the input subsystem. You will get:

- a fix to Raydium touchscreen driver to stop leaking memory when
  sending commands to the chip.

Changelog:
---------

Zhang Xiaoxu (1):
      Input: raydium_ts_i2c - fix memory leak in raydium_i2c_send()

Diffstat:
--------

 drivers/input/touchscreen/raydium_i2c_ts.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Thanks.

-- 
Dmitry
