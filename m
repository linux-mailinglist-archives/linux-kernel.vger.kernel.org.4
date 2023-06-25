Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35DF73CE60
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 06:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjFYEEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 00:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjFYEEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 00:04:42 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF70BE54
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 21:04:40 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b7e66ff65fso6655505ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 21:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687665880; x=1690257880;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLYEE95h8dfs8ybeBu3uzI6jcL58MXhesvKSmBarnZc=;
        b=XCFH2esEI44BmGIvxFS9RZBf6xAFLp++eoTJOz+383WetmcWQdA8L+ABRvpbCxxoFG
         rh0Pz45cOMGW6bOiCCWdR7Rrn43oGmS+qITFZUzfB3ouORvyjagC+7oj1RjahlWN7zF4
         ROAdDX4TvwprD/Eblsks4vcL/6dF8ZCSEwbKARKi2e+LLR9OnCZwUfrki3irQNckUWyj
         VZqwbU2khR6MivWz/BmLTAjuUn6lUaYBfWN0GfdaZqGrBjUItuFGNLL8x29BhvgjA7jS
         CO4tMwRlgwg/EZz0L9hMmt6cnJ0SwwFP5oXHBDEim9TQoNTI0ORcU1Aa6f4LHlO4oXeW
         Hmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687665880; x=1690257880;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KLYEE95h8dfs8ybeBu3uzI6jcL58MXhesvKSmBarnZc=;
        b=ip23HMNIDQ52tJxcDnrwAhBkl+EVXqNNvAJlk8QKsmpv8Fg3TScaHOrvDieFueah+F
         w61cVvO0+6EOqoOLjF5mFEg7TeoDh1jr8IwxlwltNz7xngStKCOcgkzmCnuG2FPWIG9E
         QIgVdOUgf8KwXGtoqkomwOTxdy6b2O6Dg0np20LqU9ZeHnMSt7GMkQi17inxYVjV2TXe
         R+4mbI0VMlDZd7yR6A56MCIYfOAgiJ96qTTHF0ANMHkioToxnyd7CizmN4Mwn/jWSrJA
         9PmlECzAi1BczhZmV2eNlwhXbCGVfczhD4jygVbaKTUD0R7Dujr1bogLC4OFh1gQCjc2
         hE7w==
X-Gm-Message-State: AC+VfDxToa1C8J0/XslxtwrlXut/sTWoeLISLtWyMNkbKLle/oQUM4Vr
        eaG3K34WSxUDHfih1XBgM6antg==
X-Google-Smtp-Source: ACHHUZ7/AQXQTv0DowtVUwuM8z36C5q7DKfIwWqjl7D2Vin04YsC7Zfb8EsdqfJWteI+OtIsID3KHA==
X-Received: by 2002:a17:903:22d0:b0:1b0:5c0a:3f80 with SMTP id y16-20020a17090322d000b001b05c0a3f80mr4326175plg.44.1687665880307;
        Sat, 24 Jun 2023 21:04:40 -0700 (PDT)
Received: from [10.255.209.141] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902760900b001b54a88e6adsm1788065pll.309.2023.06.24.21.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 21:04:39 -0700 (PDT)
Message-ID: <1c0c3915-99d2-f75c-027a-70a1321b4662@bytedance.com>
Date:   Sun, 25 Jun 2023 12:04:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v3 0/4] Optimize the fast path of mas_store()
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org, Liam.Howlett@oracle.com
References: <20230615084301.97701-1-zhangpeng.00@bytedance.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230615084301.97701-1-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/15 16:42, Peng Zhang 写道:
> Add fast paths for mas_wr_append() and mas_wr_slot_store() respectively.
> The newly added fast path of mas_wr_append() is used in fork() and how
> much it benefits fork() depends on how many VMAs are duplicated.
> 
> Changes since v2:
>   - Add test for expanding range in RCU mode. [2/4]
> 
> v1: https://lore.kernel.org/lkml/20230602075353.5917-1-zhangpeng.00@bytedance.com/
> v2: https://lore.kernel.org/lkml/20230609120347.63936-1-zhangpeng.00@bytedance.com/
> 
> Peng Zhang (4):
>    maple_tree: add test for mas_wr_modify() fast path
>    maple_tree: add test for expanding range in RCU mode
>    maple_tree: optimize mas_wr_append(), also improve duplicating VMAs
>    maple_tree: add a fast path case in mas_wr_slot_store()
> 
>   lib/maple_tree.c                 | 69 +++++++++++++++++++----------
>   lib/test_maple_tree.c            | 65 +++++++++++++++++++++++++++
>   tools/testing/radix-tree/maple.c | 75 ++++++++++++++++++++++++++++++++
>   3 files changed, 186 insertions(+), 23 deletions(-)
> 
Hi Andrew,

I think this patchset can be queued for testing.
Both v2 and v3 just update the test code.
