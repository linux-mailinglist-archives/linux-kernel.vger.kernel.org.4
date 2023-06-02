Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF52720243
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbjFBMjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235581AbjFBMi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:38:58 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB421B4
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 05:38:48 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3094910b150so2052875f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 05:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685709526; x=1688301526;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OU+KWjof0+InLZd2Z+zpgcjkLN1kNtQWyAbuvbyUrk=;
        b=THMTmlN5uce2BLQVfhctAcE/ElUX8NGBjHT7ZwaEEpk7TrJXwy8U846OoMakn3sogC
         bhn9ipKsssaW5c8qvXobEpWZ51lv89/EojxzjAUwtEcwfz6O15ss3k676AmfEE6dDKIY
         0ER3nmveAix1DnYC8oujXKVY1yYl66vs6rTOCw4OlFYBBpk11Li650O6j/JljHPi23kq
         +gunUqdF62aWlDOwOD9JA6JVPP+nqfKoiTkiL2ZG7zExPf0n74eN2O5JoDryVqvGx7yz
         TpYGm3Rm2k5/7vMBV3whTwPrzFMy/hmbF4foWat529V0ZqRhUBIdnyS1S0OGlMHLFZ/u
         EFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685709526; x=1688301526;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4OU+KWjof0+InLZd2Z+zpgcjkLN1kNtQWyAbuvbyUrk=;
        b=D55++v3PhdExQFfRL04hPjselqfroV6esbmj4zdXvIEKzuXbfXRR1ghQ89d4ZBkFPT
         s3czomGryC4EIewqc5mjqLTftVwd6POEJluFCtgE8Z6yXfpQFQVQ2J+kPXhHJRhy/cjW
         Zj/DwWeQdcYy/HVskxl7ZiTTraBvjKQgY7z55q9ut2MtA0cz2mR5lih1lDgQj16gaJDR
         2iigWE87wI8Ke4D72v55mCUjaXm8Oy+rrrMWvZ1/nE1sfWmRsU0V2tvpCR3PTnPDIcXG
         0pbzA6q0HVsLi2NBk4OltUGLz9cdjGkpK97pn2V2pbMQoiweywkIJkYVhZA15Vd5f6wz
         1/Vg==
X-Gm-Message-State: AC+VfDy7BuaiflylLCe2+ZtlKHCA8TzPuD989Ha/XRf8LiqGW/8iA0Ef
        Ya7jfyd1bWCRnorkB+5yDTY=
X-Google-Smtp-Source: ACHHUZ4xZY9bylI1zvi3HVMwx5NHNkkt41dgybkWAqZVFxyRKX5FmKOcc3Ob9+9UCsSjSt42Sy71kA==
X-Received: by 2002:a5d:49c4:0:b0:30a:dcba:2d81 with SMTP id t4-20020a5d49c4000000b0030adcba2d81mr3707936wrs.38.1685709526341;
        Fri, 02 Jun 2023 05:38:46 -0700 (PDT)
Received: from [192.168.0.210] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id x11-20020a5d650b000000b00307972e46fasm1567347wru.107.2023.06.02.05.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 05:38:45 -0700 (PDT)
Message-ID: <1cbc8768-7a94-530d-f3ba-923038e6ef12@gmail.com>
Date:   Fri, 2 Jun 2023 13:38:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: re: zswap: do not shrink if cgroup may not zswap
To:     Nhat Pham <nphamcs@gmail.com>, Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

static analysis with clang scan build has detected an issue in the 
following commit:

commit 6804144bf1cfa3978ad98e625d8a1d2a4b80cbee
Author: Nhat Pham <nphamcs@gmail.com>
Date:   Tue May 30 15:24:40 2023 -0700

     zswap: do not shrink if cgroup may not zswap


The issue is as follows in function zswap_frontswap_store in mm/zswap.c:

         /*
          * XXX: zswap reclaim does not work with cgroups yet. Without a
          * cgroup-aware entry LRU, we will push out entries system-wide 
based on
          * local cgroup limits.
          */
         objcg = get_obj_cgroup_from_page(page);
         if (objcg && !obj_cgroup_may_zswap(objcg))
                 goto reject;

mm/zswap.c:1210:6: warning: variable 'ret' is used uninitialized 
whenever 'if' condition is true [-Wsometimes-uninitialized]

The goto reject path ends up returning ret, however, ret at this point 
has not been initialized, so a garbage return value is being returned
by function zswap_frontswap_store

Colin
