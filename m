Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146756D5A18
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbjDDH4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbjDDH4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:56:38 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC58198C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 00:56:37 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id y19so19089139pgk.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 00:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680594997;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIg7JqA61i+WXDUK/4pZhrKUfJgqag33zxgFoayH0oI=;
        b=O4sJWsdnmKoxpoDEIhmhfTuRYG40K6JWMkijGlpnz6m3Ge2mPmyS7B6hzFO+k1Mkan
         C0Msc9gMJ+Wl/+LHe0pH/k3iTnrkLKfzR1TakeECezDM/QiYtOSfpfgeLwVh1O6oybUP
         u/Y+7S9I0laxBe4lrLYiXEPWjsdAdOB5f165PmAHIDuqZYuizMvke5MxVxqarQtN6I8h
         ZQ1dAyE5JjMnlcfcI0ZbesMUoZnveTYCav4mfIPF2u/IyQFAxqaGlibI6d9sD3IFST5H
         LTg+twLZQJKGxJsBQi0IgfXmoze/BDp7M8Ocp16RZJpkcg7RXMVWQA8MSrCs/S6ZjlPH
         Fx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680594997;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hIg7JqA61i+WXDUK/4pZhrKUfJgqag33zxgFoayH0oI=;
        b=5aQcFmWiX51p/VK/Fac4LgYfmJ5HpHJANyU/YD2+NwB5/SxYFVvBW5/NbXfsNGmhIP
         mxY5TaaMR2R9RHJxLtsiIJ+NtMbFBy6YXQkhjUW3C6/iFINe5bFnNPaijwukP7c1zLzV
         BX1CN/+HtLdajT/TFZDvBDXTlN7ZLrzkitSVi4fuh3HrE6Uc26mX9H38O4A9MW0dXZVe
         vHyy3yUgffSVxyb6XhDQurYLYC3JkcVK+dw/5SQkwD1pkgI9Swk/6Y7JKLdLMwpqP7Df
         dF8iucLO5gm5WbviY7HDcTAx/KUdoe+Ov/T5AYsPQ9TWGxtm4ZHjSf7grJc/XekHTZEU
         pkhw==
X-Gm-Message-State: AAQBX9f7n5ILJ/3+t3XPwPHEX6hVw13L/LlRkYmxjVqKtPl630N5C1Vm
        8Tfqs58vevjyNTzID8GUtgs5bA==
X-Google-Smtp-Source: AKy350ZlS4v1TCe9i4suVNVKKtFMFIpKzI3SIWFC61GDm8aoIuIaf/PVrO0bule4uPCUG7lKAUbE3w==
X-Received: by 2002:a62:1a05:0:b0:628:a3d:8aa7 with SMTP id a5-20020a621a05000000b006280a3d8aa7mr1204508pfa.31.1680594997115;
        Tue, 04 Apr 2023 00:56:37 -0700 (PDT)
Received: from [10.200.10.217] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id n6-20020a62e506000000b006227c3d5e29sm8483914pff.16.2023.04.04.00.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 00:56:36 -0700 (PDT)
Message-ID: <1b164b8b-952c-5786-4e96-df8eddc199e8@bytedance.com>
Date:   Tue, 4 Apr 2023 15:56:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH v2 0/3] Some fixes and cleanup for maple tree.
To:     Liam.Howlett@oracle.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230314124203.91572-1-zhangpeng.00@bytedance.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230314124203.91572-1-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kindly ping.

在 2023/3/14 20:42, Peng Zhang 写道:
> Some fixes and clean up for maple tree.
>
> The bug fixed by [PATCH v2 1/3] does not seem to be triggered due to some
> coincidences, because now the implementation of mtree_lookup_walk() scans
> pivots one by one and exits the loop early. The test cases for the bugs fixed by
> [PATCH v2 3/3] are difficult to write. If I think of how to write them later,
> I will send them out. So I send out the second edition first.
>
> Changes since v1:
>   - drop [PATCH 4/4]
>   - update the commit message of [PATCH 2/4]
>   - collect Reviewed-bys
>   - add fixes tags
>
> Peng Zhang (3):
>    maple_tree: Fix get wrong data_end in mtree_lookup_walk()
>    maple_tree: Simplify mas_wr_node_walk()
>    maple_tree: Fix a potential concurrency bug in RCU mode
>
>   lib/maple_tree.c | 52 ++++++++++--------------------------------------
>   1 file changed, 11 insertions(+), 41 deletions(-)
>
