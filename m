Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942DB5FEE00
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 14:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJNM2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 08:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiJNM2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 08:28:37 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C171C493F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 05:28:36 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id o21so2178979ple.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 05:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SCyhsNYwhZVTbMa7VcoLVc7/h3ERhFyOfIUt/jdRyKg=;
        b=bWVQ7gDq+JxyL7dr6GZ/FM89h2P+CITEYl6LoxMGfyp1ucFtrOp/eikUNt3+WHB8tU
         i597u6KnmRQCBN1QZlwlC0MBbJXxH7hfTh44uAlih9/fQft24D+zgWyiVlrh61UHJAe0
         YKkxLeTGc3t+yIy7/HFeGtvGkaUu6Wmv0FzzZXz2U7npB5Pf2qOr2VsuCXu4ux2Zi9Ip
         048owIhVsdKk/+Rfcb7dsfKPCRs6m9Al5Ra6eaEhwubbjwB7lg0vHWMcWE361SvBWwrx
         1KvtNWmXFo9uflZMuuTZlBRBKp0o9QVrzmMsENtze7hGI8fXzyHTBjkfjy+y8B6HehIl
         YGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SCyhsNYwhZVTbMa7VcoLVc7/h3ERhFyOfIUt/jdRyKg=;
        b=j9kugY39xPt19J36oxA7EwOR7xfGxgVYs0zYQRAluU7cAZk9mNoBw9cXb/nfFgkeQr
         RJMJFTnxcscKrWrcqJP1n8qDK7TbPExsI8xICyCnnatFWnSYfUntMBQhdaA8BXFuFUHN
         BuQX73A+CKjyEkWfFQ5Ah9uD9hkxTZjm7CrDpAbTheCeFjQ98g/7uOTZfn11LCTFhbNH
         JAZqg9z3yQqZQQ49uYUgb1uGS7voHBuiFyO5L5ZSELlBBVuyWP48dv4IzKcZc8sk59gg
         sWPnHdKConOats4TXDrK0VnDYxbruGEwMnGWpYj4KjVcTJlaGfn4FVDqI3Uo9V/NtEiX
         uJiA==
X-Gm-Message-State: ACrzQf2gpTwtvB4Z6k2vQamjCuWcYAOJrzOR9mPIfw3Qo8Imjh2yGOdi
        qmy4I3IXLk9/8gYi2YUQNsE=
X-Google-Smtp-Source: AMsMyM5alJd+48iN707KEK7AsJ/H4QRn2RPFJRfmvwTpeM3BlWBdCVfYD/6tpPU5oGhsHACmIZ3q2A==
X-Received: by 2002:a17:902:c40f:b0:17f:6737:9527 with SMTP id k15-20020a170902c40f00b0017f67379527mr5059333plk.19.1665750516177;
        Fri, 14 Oct 2022 05:28:36 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-8.three.co.id. [180.214.232.8])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c10600b001728ac8af94sm1586498pli.248.2022.10.14.05.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 05:28:35 -0700 (PDT)
Message-ID: <7e0b733d-db73-f9a7-0965-4744e63f1a33@gmail.com>
Date:   Fri, 14 Oct 2022 19:28:31 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: 6.0.0-RC kernels trigger Firefox snap bug with 6.0.0-rc3 through
 6.0.0-rc7
Content-Language: en-US
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-kernel@vger.kernel.org, Slade Watkins <srw@sladewatkins.net>,
        Marc Miltenberger <marcmiltenberger@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <b0c258c3-6dcf-aade-efc4-d62a8b3a1ce2@alu.unizg.hr>
 <Y0Zw2eHEb1aZ9f4y@debian.me>
 <29362d2e-eec6-5a23-4354-cf8868d50b2c@alu.unizg.hr>
 <6375f31f-316a-bebc-6aec-c6241049e401@alu.unizg.hr>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <6375f31f-316a-bebc-6aec-c6241049e401@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,URI_DOTEDU
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/22 17:32, Mirsad Todorovac wrote:
> I tried the "make localmodconfig" and provided the default answers ([ENTER]) to all questions
> the script asked as advised here: https://www.stolaf.edu/people/rab/os/linux-compile.html .
> 
> However, though it built much faster, the stripped version did not trigger the bug.
> 
> I am now trying to reproduce the bug with v6.0-rc[123] with config-{051913,060000}.
> This brings a lot of combinations, and though I am a newbie, I noticed that build scripts
> start with "make clean" for both deb-pkg and rpm-pkg.
> 
> Is there a way to rebuild only the stuff that changed between the versions?
> 

You can try building kernel with ccache enabled. However, you'll need
to unset build timestamp, since it will make builds non-deterministic:

	make CC="ccache gcc" KBUILD_BUILD_TIMESTAMP=""

The first ccache build will be slower than normal build, because the
object files needs to be written twice (to the output directory and
to the cache), though.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

