Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B49B6B342E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 03:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjCJCV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 21:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCJCVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 21:21:55 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E6913D45;
        Thu,  9 Mar 2023 18:21:54 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id p20so4089875plw.13;
        Thu, 09 Mar 2023 18:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678414914;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=05gZSDBihA8hY3NIKPPbp0jecYVWtqAocZDIZnj0zCw=;
        b=R2VTB/sZyva/wlLXoN0020STY3aEF6R56aGlkmL+Cy364O/x2ou8wVwodOcE/OzJyt
         JZjk7dzZumYRQoflGySJvxkleGR9BNsXN7NVH8RcDpBb3gMOJUJKsODnWzIHaYrgLHk/
         blbd/hiAotDcOeiNIFJqa733llmzguoA12fO36KL4SE6WJCA5RbjbhNoptVUKTwyjSJ1
         2YLjroxHd2aVBy67QL25UCrwK3m+hzfGy+BMj1KR+uGvKmqeBQB5CN63qhT4m1rMuh08
         +Wfu9ULzbZ+qXV7vrf9W+gJ1OJUcFj67m+yQ5DayQMdhRx/l7Ybm/1q4ki+vrXdVisZz
         BTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678414914;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=05gZSDBihA8hY3NIKPPbp0jecYVWtqAocZDIZnj0zCw=;
        b=sbSlsUQSupH9C/TK7fTWQ1GgGJ8smlu6i4a6G0nizmcKYJGvMXGIlTneNgAr4Zy+mR
         WOW+r03CkjYK9kACbjpSrt8Hk8ktvV1l4k4AQQx1P233eBLFDh7Cz1FWuTuIP9QgIaY6
         UdWnSwtQ7VhBau2TjcfJn28sxw/csJSWKSyUxm20GvIg6NipwYHSfzlwQzFujuKXAGWj
         43IMUF+WmwtIbkKUrgdja1zQUzoHC5bxvRhgSmRt/faLE51x2cYJPrdEqDrstyS35QoQ
         2Bqqr641cXKBrAHrZtR5hz9BNGfeau+EUYElqKcQY2f2Nldoak3wasHcrqXl+PJ0h8/M
         5KuA==
X-Gm-Message-State: AO0yUKXBYw0jnrXxv17vceVAuFDe5GRfdB1+tn8uWUoNqnZq5qOv661V
        MC8D+DUz/bwW/OosHiwvDKk=
X-Google-Smtp-Source: AK7set/UtbH3NsorWBySmQUYnfVeU95znEDwX4XpDcSLdyopgAHV+E3goOA2yDJfunCHe9+na7u0yQ==
X-Received: by 2002:a17:90b:1645:b0:236:a4bc:222 with SMTP id il5-20020a17090b164500b00236a4bc0222mr24642864pjb.38.1678414913924;
        Thu, 09 Mar 2023 18:21:53 -0800 (PST)
Received: from [192.168.43.80] (subs03-180-214-233-23.three.co.id. [180.214.233.23])
        by smtp.gmail.com with ESMTPSA id ga14-20020a17090b038e00b00233d6547000sm221639pjb.54.2023.03.09.18.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 18:21:53 -0800 (PST)
Message-ID: <9ae992fe-a3a9-8c1a-200b-3fe683d658a2@gmail.com>
Date:   Fri, 10 Mar 2023 09:21:12 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: A question about compiling Linux kernel
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <315b5e4a-43e7-f7af-f320-a5a3564127c6@alu.unizg.hr>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <315b5e4a-43e7-f7af-f320-a5a3564127c6@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/23 04:22, Mirsad Goran Todorovac wrote:
> Hi Mr. Bagas,
> 
> If you can recall, you instructed me to use ccache, however with frequent rebuilds
> and especially bisects it would be better to recompile just the objects that have
> changed between the versions, rather than doing "make clean; make CC='ccache gcc'"
> 
> Is it safe to just do make CC='ccache gcc' and let make decide what to recompile?
> 

I have tried building a userspace application, for which the source code is
obtained by git. I do the initial build first, then git pull-ing without cleaning
the build directory, then incremental rebuild (usually `make` or `ninja`).
The incremental build only rebuild what is changed. However, when the version
identifier (mostly via build config) is changed, all previous build artifacts
are invalidated, essentially rebuild from scratch.

IMO, above can also be applied to Linux kernel (but I haven't tried to build
that way).

Cc: linux-kbuild list since I'm unsure on this.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

