Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B085471999D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjFAKWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbjFAKWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:22:05 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DD01FD3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:18:40 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f6e4554453so6386815e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 03:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1685614691; x=1688206691;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6XkTQ3CoGch36kB7T1IroYG5r0BhmIO+8aTMljzxUEY=;
        b=URvuUPMduCrUKpW+Ol39ok793SYOg+PBYxgwDTW9AyapjAXj7Jb2F8lUTjkdEAexXJ
         u/DxrvJ6zz0EBt1+lSqHy/dfb1lRLWRop7968NKxMbXVdFykRANlQybHBIfH+gr7mIVJ
         bE1Gkwvlk3eSLxRXCfhXcj1Z1VIXdLl5l6r3pP1q+4KakcntNIv84FhHGSu35z3X46sD
         UKk9wuvex7cpvZ+0BP4P3Y0UU7ole6RvlWWeDzOVO2cPewbLoLdyWE0cDZ0jeKBQQphD
         kxuEDR/pbICZB+TQFBVsG3eFXCE4BU7438dfgC0LLlChW+pfjPrfUmNzSwU/7V8EoCX1
         8TnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685614691; x=1688206691;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6XkTQ3CoGch36kB7T1IroYG5r0BhmIO+8aTMljzxUEY=;
        b=Cey1p5Pb6b+RzFvSCreIpjlnWchZfm3HEVOi+1zkROuva3y+gNlVc7q7FyFSJzdh9I
         Sq84jdhyVEai1IpE0QCMAm1xfPjB2oPF0+ggqmNqDvzO+SOzekGwIUFTZ5nlPtUKcKiP
         5YRLgl3K3mdZDNixcCU/jzrcrl5VKFwzHikXXcsVUBM+f76l+HsoEVZioheDxqQL8kNE
         VKvGC/u+paImDYKRBnZnf0HLOQoXud7h+ONsfeYCbyywN6kz5WP4ZkSVcfy47glUFxl4
         OQKIQFvcqWvIfv+yXqmxTI5O1bh4Ri8LsrYhlEfBQKIJEIHagUqXJQqL7SOwT+4FRy9o
         kKnw==
X-Gm-Message-State: AC+VfDwnOI/q+vjCfRV/fqQl+dqN9vWqL69RbkjVGYjdT/bLFoOzxwMb
        mRSdEjZ7RA7DpkG8oqQPd/Vt0Q==
X-Google-Smtp-Source: ACHHUZ6zWD2AjaNcc66+tXB2tbV5HvOXZIVxwveIS7GawEtSHtUuAbiPap7EgwcP1KYkdHehyB3moA==
X-Received: by 2002:adf:ef8d:0:b0:2f4:6574:5a93 with SMTP id d13-20020adfef8d000000b002f465745a93mr1566253wro.4.1685614691384;
        Thu, 01 Jun 2023 03:18:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:a1c1:aac9:326c:88d7? ([2a01:e0a:b41:c160:a1c1:aac9:326c:88d7])
        by smtp.gmail.com with ESMTPSA id i14-20020adfe48e000000b0030ae499da59sm9735708wrm.111.2023.06.01.03.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 03:18:10 -0700 (PDT)
Message-ID: <1c464b6a-dd02-f846-5691-c29f567466c1@6wind.com>
Date:   Thu, 1 Jun 2023 12:18:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [RFC PATCH 0/8] vhost_tasks: Use CLONE_THREAD/SIGHAND
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Christian Brauner <brauner@kernel.org>,
        Mike Christie <michael.christie@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     oleg@redhat.com, axboe@kernel.dk, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        hch@infradead.org, konrad.wilk@oracle.com
References: <20230519-vormittag-dschungel-83607e9d2255@brauner>
 <ab8c9f95-c9e9-de04-4e28-78163a32da80@leemhuis.info>
Content-Language: en-US
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <ab8c9f95-c9e9-de04-4e28-78163a32da80@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
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

Le 01/06/2023 à 09:58, Thorsten Leemhuis a écrit :
[snip]
> 
> Meanwhile -rc5 is just a few days away and there are still a lot of
> discussions in the patch-set proposed to address the issues[1]. Which is
> kinda great (albeit also why I haven't given it a spin yet), but on the
> other hand makes we wonder:
> 
> Is it maybe time to revert the vhost parts for 6.4 and try again next cycle?
At least it's time to find a way to fix this issue :)


Thank you,
Nicolas
