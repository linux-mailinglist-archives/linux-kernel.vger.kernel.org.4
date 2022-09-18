Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E5F5BC00E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 23:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiIRV1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 17:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiIRV1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 17:27:39 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C5B13E13
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 14:27:37 -0700 (PDT)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 31DA43F475
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 21:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1663536456;
        bh=VBMgryLG1fCHHFs6o9PjHyuHeF2daTdVHmXIfMnp98o=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=UwfoSjuO9SLOGrfLni+oudmzqj24NP5XNhqOrr+qvv6gzyvKyjTNDEMcnBbBiFV4F
         6CbpP5aWYVBNXl9QJ9RF3oecaFaeSuCwV4t3JUaEZ9WgyCNL//uM+6tk5F/jyt9uvX
         vzTB8SUHVy/guqmqLIbyhR7t/3LTiXZloobzpGpGCGgRacxjR+JDgRxhs5OED1pcG1
         kBds+I+Nmd87bNj24SU+Ss30RirzImH+61GXd0zncyEdMeAJT8Z//PgsQZHZkdkYLy
         w4Tn156UMYySmlmaI2MGRBGaQXZHjzvXA2RRHtzIa+MY3iTTxLjU7RQB4QpHawV/rY
         dDVnPBw7WhidQ==
Received: by mail-qt1-f198.google.com with SMTP id ay22-20020a05622a229600b0035bbb349e79so13673184qtb.13
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 14:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=VBMgryLG1fCHHFs6o9PjHyuHeF2daTdVHmXIfMnp98o=;
        b=gG1+oKpPixrdj8zlcW2NKmxTsdBZytZ9a809SgwZRookdlyAPq3IzTaUDoHmvh2uJ4
         f/duzT2NYnOfpEgUda5QjnmKk33Vx0gl0+bbX2p0eskWnIJRkdIdU9kpDgCFBrEu4hEW
         1ptfMz+JH6Oo19h53jUtpUnlcEUFXxALnv9LkzOGvQfpFnw5DavowsyOEYNYQvvl3ym8
         EErRzUP9dRmWr3xW/9lAq0zVBjb6XpyiPS12vdt0vhJOYPArA6iSw5A2zwm6gTE/kIF6
         Ohg0OhQhmizu84277QLV7R7ozW55LSJnF1GT6UPNiTnP6YL+zRXyQGmurZOJSwbi3Gf3
         cbMQ==
X-Gm-Message-State: ACrzQf2RJuw2VTUgxcBdu3Iwkkfutrq3NRuGREQDDWgS/Wx142MntaKB
        cqobTHFMhDRJX/Y+KjqU90yjiGddNIaOiXI7oTlJX1ECHgnpSUUYqMZfuwUNLGRdO2ZzfDqKNPi
        8TgGDUEDB4wdilpg7M9baX7Fi1UzvnTIEGjCrA0hr8w==
X-Received: by 2002:a05:622a:d4:b0:35c:e40c:7628 with SMTP id p20-20020a05622a00d400b0035ce40c7628mr3206082qtw.428.1663536454729;
        Sun, 18 Sep 2022 14:27:34 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7ZWP/HUcZxev2jAyOxgKhUOEApS0yeqyOB7P5V0WSpE41k3bRq3tXcjqskab12IAiiTuoYYQ==
X-Received: by 2002:a05:622a:d4:b0:35c:e40c:7628 with SMTP id p20-20020a05622a00d400b0035ce40c7628mr3206075qtw.428.1663536454507;
        Sun, 18 Sep 2022 14:27:34 -0700 (PDT)
Received: from [172.20.4.66] ([65.206.117.195])
        by smtp.gmail.com with ESMTPSA id de42-20020a05620a372a00b006b945519488sm11466016qkb.88.2022.09.18.14.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 14:27:34 -0700 (PDT)
Message-ID: <a9588d9e-56a1-666c-9542-35bd0c8f64af@canonical.com>
Date:   Sun, 18 Sep 2022 18:27:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] Fix race condition when exec'ing setuid files
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220910211215.140270-1-jorge.merlino@canonical.com>
 <202209131456.76A13BC5E4@keescook>
From:   Jorge Merlino <jorge.merlino@canonical.com>
In-Reply-To: <202209131456.76A13BC5E4@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


El 13/9/22 a las 19:03, Kees Cook escribió:
> Thanks for reporting this and for having a reproducer!
> 
> It looks like this is "failing safe", in the sense that the bug causes
> an exec of a setuid binary to not actually change the euid. Is that an
> accurate understanding here?

Yes, that is correct.

>> This patch sort of fixes this by setting a process flag to the parent
>> process during the time this race is possible. Thus, if a process is
>> forking, it counts an extra user fo the fs_struct as the counter might be
>> incremented before the thread is visible. But this is not great as this
>> could generate the opposite problem as there may be an external process
>> sharing the fs_struct that is masked by some thread that is being counted
>> twice. I submit this patch just as an idea but mainly I want to introduce
>> this issue and see if someone comes up with a better solution.
> 
> I'll want to spend some more time studying this race, but yes, it looks
> like it should get fixed. I'm curious, though, how did you find this
> problem? It seems quite unusual to have a high-load heavily threaded
> process decide to exec.

It was reported to Canonical by a customer. I don't know exactly the 
circumstances where they see this problem occur in production.

Thanks
	Jorge
