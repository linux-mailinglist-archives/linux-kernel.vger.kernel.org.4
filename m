Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9B3739843
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjFVHj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFVHjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:39:24 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC771992
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 00:39:22 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-986d8332f50so803445666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 00:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687419561; x=1690011561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kyBZGQlE3g+2vxed0mGUpWgi1BkyuNRNZMTHS+0UClg=;
        b=jcZEYMmaTGfXSJNIG6AiYj8K3pqSThJfZs0FMuItw9Dv4JqW0WLJzUjqbRfygZ68/Z
         tpJ3T8yshvY07weAiyJFAEJTqIZerhK7aJ+snvJ6VDjfdnzxIM35Z+0cM0eO96rrcgy8
         91PGYUb2r6b57MtyDqFXg0vddX6HnEfFZYlpLfi199bag1Kswfd3gRV4HrQl3VRPxTkd
         xsr/EWr/nG967uc1vdraW+eXvkmjloQFHlZdUn4BvjQq8i8OuDmhTR5pq+Oy7NUPWY/q
         E/qtm3UaXGm4DeWKenb38y70CufRY712AzbNgK8/Sx7PguEsLjdrC2+/som1eWDnyDvh
         7mkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687419561; x=1690011561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kyBZGQlE3g+2vxed0mGUpWgi1BkyuNRNZMTHS+0UClg=;
        b=WbleQKtiR2Aim5YqLAnM+U5niIbQYieu4u0I6wBhzHgrXmkvLUJ0Jy/5fTDqWD8oTG
         2CFEm4WdedBW/42JOm87NyTwacNmBZwfEfPtnoGA7Mxd5D/i1cH/V6gj/gf/Q8560Zb2
         x5Wj5MigF1K4wTSlJYMp3CyP7y8NH3p7eAmfo5QbrALlgmiVyWLcb8lPsgkB7/KKfrt6
         UzH/oxooO784RrC6vky+wxiX74+fRJrhyL4QxY0kMgnlK+cqaU/edukrfTC0PKgMdxg3
         e4n4MD7C5ALieJtzf+42rrKTG0wFXT0EL1hwnt/zXc3txqvV3jd8tYA8INboYDJ/8Ix3
         0pGA==
X-Gm-Message-State: AC+VfDzLMYS7lGkkCZTyDWgFvdNzvXSoekoeY8EBVPK8vvlvD92vJcxl
        oat5Bqy70ssDvRhro85ROlI/KA==
X-Google-Smtp-Source: ACHHUZ5W1Hm5W+HPcY3dmYtKyH5Zrzts4JCIeqr67/DMIHwyqq+LW+oLBpq8rwfO7/YWEuBleGLAsg==
X-Received: by 2002:a17:907:3f87:b0:984:bd75:6a3 with SMTP id hr7-20020a1709073f8700b00984bd7506a3mr14238689ejc.58.1687419561108;
        Thu, 22 Jun 2023 00:39:21 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id kk10-20020a170907766a00b00988a6421831sm4223077ejc.93.2023.06.22.00.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 00:39:20 -0700 (PDT)
Message-ID: <68cf749a-4248-1250-6e6e-713649ec8578@baylibre.com>
Date:   Thu, 22 Jun 2023 09:39:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] erofs: Fix detection of atomic context
To:     Sandeep Dhavale <dhavale@google.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Will Shiu <Will.Shiu@mediatek.com>, kernel-team@android.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230621220848.3379029-1-dhavale@google.com>
Content-Language: en-US
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230621220848.3379029-1-dhavale@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2023 00:08, Sandeep Dhavale wrote:
> Current check for atomic context is not sufficient as
> z_erofs_decompressqueue_endio can be called under rcu lock
> from blk_mq_flush_plug_list(). See the stacktrace [1]
> 
> In such case we should hand off the decompression work for async
> processing rather than trying to do sync decompression in current
> context. Patch fixes the detection by checking for
> rcu_read_lock_any_held() and while at it use more appropriate
> !in_task() check than in_atomic().
> 
> Background: Historically erofs would always schedule a kworker for
> decompression which would incur the scheduling cost regardless of
> the context. But z_erofs_decompressqueue_endio() may not always
> be in atomic context and we could actually benefit from doing the
> decompression in z_erofs_decompressqueue_endio() if we are in
> thread context, for example when running with dm-verity.
> This optimization was later added in patch [2] which has shown
> improvement in performance benchmarks.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre
