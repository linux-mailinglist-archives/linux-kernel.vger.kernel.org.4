Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3A86BB7FD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjCOPgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjCOPf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:35:59 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EC26782E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 08:35:42 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id ay18so11973480pfb.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 08:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678894541;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mH9snH5oMnk00V9V22sRI9X+SMiczhAu4ymIdyFHzvE=;
        b=pKIkOUEY5+QPtipzidTl6zflUjml+sBj2vU44BH68gsC5l+6sx4W9F02txa37IXK6o
         f20pvG32xxZx1xpfZyP00sZDlZjeN7CR2D0rlJigrJ9biYClE2zjWkxKvUvsfxktNpaK
         NaV/8pt6kja+DcehL77wJcdXAbyuCsTxkCuuTSGfHdpEOKkU0NjkB0DaZcejP8lXhPDE
         TyFjm+ZjMkDTcqmGWUdB5DtQsWuvx6vUxe03VLHyyogk6QsrcONjkZ9E/b9vE7K1iWqF
         HrrN1Bq4PelTAT4CTE0Ag5IOlQuM9jn51+2HW+L4gfI7cvIfEQ5nh6u/qwFRVmHH1XQd
         tyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678894541;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mH9snH5oMnk00V9V22sRI9X+SMiczhAu4ymIdyFHzvE=;
        b=QaVjzWy0Ax7JGIcXpd5W3+hbZZ6pEakRrI+/dFvrNgxKZyWHw5v4wx17tx3VNFJkM/
         tbxYMPGmXigk1Gw+Unw2z5Iw8ioMLtlWiAhsdzHSUEvQszcypWgYBQjd8XY/Q/5ha5Qt
         rWcWbm15cWGTvVe5YWzFRPgcek4qVXnShGZiY2qkn5AZL9JXeq/uk9lEP8A8upeC9W78
         wv2eV06gmapDXcU3d26jVGeJLHMVMm4Q/z7ZS5+fVant5zWMjZDuAp2OtLNs35rcKCOD
         R+zGN/Yyh3E+3mepCVduwhwFNEJLQV91ViszVpXdjz+PxkOdKkw31UJwAkRPWGf8077A
         423g==
X-Gm-Message-State: AO0yUKUPbevR2vCQaBMaRoEhQqnLyAFsoDpUAfGPgSZLqImcwP/xWlDf
        N8KhGtyVdMWC+oH/fAzMzopUHN5Ewn7O90hciCE=
X-Google-Smtp-Source: AK7set+xtfNe2lHmhXv2MbjVzVqbM1qWhNJYgvDoVDUVJpw7t+tLv5+w0IcwqHOHwpx/X23tCM8M8Q==
X-Received: by 2002:aa7:8f25:0:b0:624:2a11:760 with SMTP id y5-20020aa78f25000000b006242a110760mr10247348pfr.30.1678894541280;
        Wed, 15 Mar 2023 08:35:41 -0700 (PDT)
Received: from CloudiRingWorld ([60.188.201.163])
        by smtp.gmail.com with ESMTPSA id u19-20020a63df13000000b00502e48db9aesm3461395pgg.53.2023.03.15.08.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 08:35:40 -0700 (PDT)
Date:   Wed, 15 Mar 2023 23:35:37 +0800
From:   Kloudifold <cloudifold.3125@gmail.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750: Rename function to avoid CamelCase
Message-ID: <ZBHlycBoZ0JRwHZm@CloudiRingWorld>
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

Hi Alison,

Thanks a lot for your help, so if I send my v3 patch, should it be like
below? (Philipp said "please make the Subject more unique", but the
Subject could be only a few permutations of very few words, I can't see
how it could be any more unique.)

Subject: [PATCH v2] staging: sm750: Rename functions from CamelCase to snake case

sm750 driver has sm750_hw_cursor_* functions, which are named in
camelcase. Rename them to snake case to follow the function naming
convention.

Changes in v3:
- Add this changelog (Philipp)
- Move lkp tags and link to the correct location in commit log (Alison)
- Update the commit msg (Philip)
- Update the commit log (Bagas, Julia)

Changes in v2:
- Use new function names in call sites (LKP)

Signed-off-by: Kloudifold <cloudifold.3125@gmail.com>
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303110849.X24WnHnM-lkp@intel.com/
---
git diff message
---
