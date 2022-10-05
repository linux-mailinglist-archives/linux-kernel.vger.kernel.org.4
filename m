Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973F45F5807
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 18:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiJEQKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 12:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiJEQJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 12:09:56 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4D69FDD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 09:09:53 -0700 (PDT)
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 469A54146E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 16:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1664986191;
        bh=PhK3UR0JyIjrSTsOR0Bx6DOtf6gXMKKOB8Sonx5tiz4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=KchP5C3B/bSKyJExP3sQY/+S3VLkVw11Iy1MS1l0s9C/0A19/gyUC5XDRyYTROTAz
         qQ4oIcF0B3SBc3vQIl1u/VFtYIsXEq+zD57UEsyJXNDXQgMPrQQvHE+yjO1Ji/5/v/
         m0ucjs9B5g0xbf25vIx/SEsPOdHEFnPaOcawh2oX9wh+c/lKcf7Danr+Jl0Uvy7ZIM
         eaiI7clqrjE2MCgeJDRmAA2thNtubCmAcu7ryMUAzr02ecvDbMkIskQ4as4/vBW40N
         FVDwj16GupFiFCUfgtxNj2GoIyBkZsTgbgiSv68IsfoxKvNShMZfln1tGwCoF4nOGC
         CYjS4fJ2Y/8yg==
Received: by mail-oi1-f197.google.com with SMTP id v3-20020a544483000000b0035131ade230so7262463oiv.23
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 09:09:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=PhK3UR0JyIjrSTsOR0Bx6DOtf6gXMKKOB8Sonx5tiz4=;
        b=4cf+8UapAVXJVpj6458M4uNH+KykRSG+tLSz0kTs9RsTJh94Ede4nJg4nxqvfgmhJT
         nL/5ckBc9jsY+jIjThAuZDEMUfrusd+4rMRWD+szug7Ughkm+2jBAD8si4SGNZ0JCh7m
         lu/FVHmSgOfff/lqwlzGXAugCpFsigrppiVBlcok0+qf7BqFbwXgkdtHC8RS3KBW/92M
         Oe6W/8XPnQc4LzaWJu80Q5ecCBvqQn8z42PeYYY1G77fblA7IAS0xQfQaxSZO4sP8rWm
         wDzEWFhL7x79NelmulUpIdA9QYKajAS0qid88KkUxqNDZW5hU22QzjMUX82FfkEGoKI9
         sD4Q==
X-Gm-Message-State: ACrzQf0YjdInKtmjf6y8uMQjdAh/qZ2+TIJJYV1jS1AQUXVtirexZGFR
        Xa/e8YvHjRZTqw6zl+SHgj9wA/qIisOo1RroVpg5Xjkgpo71hfnmL5+VN4cX1QGSf08118i7HjG
        R/DHWNGAJETPl8HUZtVnsCLnjvv/WNyDw3EHf374fBA==
X-Received: by 2002:a05:6808:1294:b0:350:cdc5:894d with SMTP id a20-20020a056808129400b00350cdc5894dmr253453oiw.276.1664986188327;
        Wed, 05 Oct 2022 09:09:48 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5MMtPrl9VEi5ZyUWupTz5cDWAGQ1Rk91r1Y7Dr1gY3o6ldI48HygppwdflsAJr2bj7WCgsPA==
X-Received: by 2002:a05:6808:1294:b0:350:cdc5:894d with SMTP id a20-20020a056808129400b00350cdc5894dmr253430oiw.276.1664986188087;
        Wed, 05 Oct 2022 09:09:48 -0700 (PDT)
Received: from ?IPV6:2001:67c:1562:8007::aac:4084? ([2001:67c:1562:8007::aac:4084])
        by smtp.gmail.com with ESMTPSA id p6-20020a544606000000b00342ece494ffsm4421468oip.46.2022.10.05.09.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 09:09:47 -0700 (PDT)
Message-ID: <c9ca551b-070b-dcee-b4b4-b7fbfc33ab5d@canonical.com>
Date:   Wed, 5 Oct 2022 13:09:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] Fix race condition when exec'ing setuid files
Content-Language: es-UY, en-US
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
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/9/22 19:03, Kees Cook wrote:
> I'll want to spend some more time studying this race, but yes, it looks
> like it should get fixed. I'm curious, though, how did you find this
> problem? It seems quite unusual to have a high-load heavily threaded
> process decide to exec.

I just got a response from our customer regarding the situation where 
this race condition occurs:


Our application is a Rust-based CLI tool that acts as a frontend to 
cloud-based testing infrastructure. In one mode of operation it uploads 
a large number of test artifacts to cloud storage, spawns compute 
instances, and then starts a VPN connection to those instances. The 
application creates the VPN connection by executing another setuid-root 
tool as a subprocess. We see that this subprocess sometimes fails to 
setuid. The "high-load heavily threaded" aspect comes from the fact that 
we're using the Tokio runtime. Each upload to cloud storage is a 
separate Tokio task (i.e. "green thread") and these are scheduled onto 
"N" OS-level threads, where N = nproc. In a large run we may upload a 
couple thousand artifacts but limit to 50 concurrent uploads. Once these 
artifact uploads complete, we typically spawn the setuid subprocess 
within 1-2 seconds.

Have you been able to look at this issue?

Thanks
	Jorge
