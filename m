Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2F46D78E9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 11:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237439AbjDEJxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 05:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237354AbjDEJxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 05:53:51 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39961701
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 02:53:50 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id r7-20020a17090b050700b002404be7920aso34939070pjz.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 02:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680688429;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oy2BUyKU9CIKLi1foQ67EW9MQk9XYp7SRMcmahMZwkQ=;
        b=LXYcpEe+0yHYS4ZGeCbJiWd6kiQqbRWoASiO+X5Q3/XVNgY8uyTbKewb0xT4sMxt1m
         kImY4IX82RF9YIEXSsyyAOHn6ged3qZ7vVdYzKyGFYc/NgpuK1Co0NXbSOttKI8M4DDO
         FlJcTb/tbn0Lq9tlDUbHd+/Cf7vHAiC1WwQ95lWUHNclRb7TShClo722Z9h39hTCTMkz
         Opv3eIsjsRb8NVcm2qoOqztMRkF3tEvXyLzhihSkMot1QW0nOTAmxkd9ghDMquREgOUH
         ScYeDZVkbM2BHZ23CYgm1GApTu4ANReP+CN21DTxzO5HCh5uBwuZqX9U9fNQw8ri7AcD
         uEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680688430;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oy2BUyKU9CIKLi1foQ67EW9MQk9XYp7SRMcmahMZwkQ=;
        b=5xQ1u+qfhdzOjPY+z2DvZCOqEcnf2wfD6BB+hkpB6N2RnKkpc6LbqGANnfEbE1i25h
         3dO3g8Y154sT8cl7iLL9QLLrcnHFjO5Rv76IrDz1FQDQ+xovtMbof1yqrp1bJpTuVKoX
         fYp0tGqmc5Z9LOjXNg1PzwZ4cpTMyclrKY2L1fjqoTIEK1KiUqVGa91CCf1OPZhpiHk3
         e099E7xNCMiUjI55FNbqFmVsz8wj5wui7zGWHHBwyUuvwP5zDnjTLrJd1w+5zg7M5b8o
         IrcEze59r/fFL5zfdEFnmIUnLuTihc+1K59/oCbRnh4fZiH81ELayR14GmiIp62c3bQB
         6uoQ==
X-Gm-Message-State: AAQBX9foAgiXpZPT+V4glfvK4G79OZTufY258RtJghhhzz0Hjpde90hE
        la7hFFsR0OM4E70xDturXb8yvw==
X-Google-Smtp-Source: AKy350Zf8+5GytyTlr5OtZiGKrk+DQQGEEFknlCrX0tF0d4j+ZkQ2GlVotnK/coXWtacwGkKg44WCw==
X-Received: by 2002:a17:902:ced2:b0:1a1:aa28:e67a with SMTP id d18-20020a170902ced200b001a1aa28e67amr6792822plg.48.1680688429703;
        Wed, 05 Apr 2023 02:53:49 -0700 (PDT)
Received: from [10.200.10.217] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id p4-20020a1709026b8400b001a053b7e892sm9714095plk.195.2023.04.05.02.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 02:53:49 -0700 (PDT)
Message-ID: <1d3b071f-ead7-4431-c9f8-c712e7c8bdc6@bytedance.com>
Date:   Wed, 5 Apr 2023 17:53:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH v2 0/3] Some fixes and cleanup for maple tree.
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Liam.Howlett@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
References: <20230314124203.91572-1-zhangpeng.00@bytedance.com>
 <20230404132702.9240f3a77d0c00fca4b9bf55@linux-foundation.org>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230404132702.9240f3a77d0c00fca4b9bf55@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/4/5 04:27, Andrew Morton 写道:

> On Tue, 14 Mar 2023 20:42:00 +0800 Peng Zhang <zhangpeng.00@bytedance.com> wrote:
>
>> Some fixes and clean up for maple tree.
>>
>> The bug fixed by [PATCH v2 1/3] does not seem to be triggered due to some
>> coincidences, because now the implementation of mtree_lookup_walk() scans
>> pivots one by one and exits the loop early. The test cases for the bugs fixed by
>> [PATCH v2 3/3] are difficult to write. If I think of how to write them later,
>> I will send them out. So I send out the second edition first.
> Do we feel that any of these should be backported into -stable kernels?
> [3/3] looks to be a candidate for this?

Both [1/3] and [3/3] can be sent to the stable kernel, do I need to do anything?

