Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AFB6BC0BB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjCOXTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjCOXTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:19:22 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E37397FF4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 16:19:21 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t83so1661046pgb.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 16:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678922360; x=1681514360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SFMCxULO8QKbro8N2aWnp3bJ+wkQuvOtMXFpr7qNWdc=;
        b=mydXcGTKsWbPvI2OhYKhwXF5JJk2ew/KcYd+p+uHl+N5QMnusBKd3mARgeAdyXaVgp
         bF1G2XcZOD6vLmlJFY/xy+9ygQBBCnxVQhBxDXOo6CoQT+PWfhCZgGxaxrMpQjbknb9n
         jNK04wI90GwP5qSOxwOyo7qZxCsZaz18BwkDhY2jRiHJyNPZEHGfcA9irA4TQtnn2d9j
         QtXR88OsuMGxXUp/Lz8Zt9hnN2iPzNPwN1g0fOXwomJgBU8fgv45jvYGOaUTJOeSMI5U
         IPsDaZEnT4EUvqgLxfM73HhipQX/6IweGbTFOZXNQCq5HD/fjoCnbIH4154d2k5NHjkI
         Yydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678922360; x=1681514360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFMCxULO8QKbro8N2aWnp3bJ+wkQuvOtMXFpr7qNWdc=;
        b=LlsK0DgTmvQChjncnRdzJ0tmy5OSgOWAYA/LsEbDujg7XUHct0KipVxm/c37lvNSjY
         xuRj/WK1Q4KWr207c6Upn4bHaha5hJNvVd7RcwySBrJTL3blZKDiwXQTtPuPPoww+6cw
         MzstGEkVAJ6qDamtKNNrJj13aEk4Fjl7PX5J7NOoG4nrIxeHq0scaOlY/eCHeUv/MuoF
         pycHcOpXrN6Yi8GWIima5sr8JERQVFFrD+5ZoPCZXc942o2Qo67aAWyM7kJwE4RcLYOJ
         sQ2zZr6fXDeWQljxnD7xrkcoOSFRhy3j0hKZwGg2Wz8UrxKcOKVGs2Ks2s3zHTE4hlKW
         WGNw==
X-Gm-Message-State: AO0yUKWDAVqnIBvBPp2qr6Uxt86qXul0+x1fr96m4cXXTJPtbinphgIs
        oNo3/7F/zfS2TiLrroCQFB2hyw==
X-Google-Smtp-Source: AK7set+Hma8u9TEs915EVIsLiAy+0Y4mWgPfUSUOJeHLd7V2gCzgFZGfk7KTj91OKQtGFxZt7CuRMw==
X-Received: by 2002:a05:6a00:3186:b0:5a9:cebd:7b79 with SMTP id bj6-20020a056a00318600b005a9cebd7b79mr1261763pfb.0.1678922360361;
        Wed, 15 Mar 2023 16:19:20 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z13-20020aa785cd000000b005a852875590sm4059408pfn.113.2023.03.15.16.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 16:19:19 -0700 (PDT)
Message-ID: <d404a6b6-4ff9-930a-1cdc-fd730270fbe7@kernel.dk>
Date:   Wed, 15 Mar 2023 17:19:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 04/13] tracing: Rename kvfree_rcu() to
 kvfree_rcu_mightsleep()
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230201150815.409582-5-urezki@gmail.com> <ZAni8Q1NW9cWrvHJ@pc636>
 <20230315183648.5164af0f@gandalf.local.home>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230315183648.5164af0f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/23 4:36 PM, Steven Rostedt wrote:
> On Thu, 9 Mar 2023 14:45:21 +0100
> Uladzislau Rezki <urezki@gmail.com> wrote:
> 
>>> The kvfree_rcu()'s single argument name is deprecated therefore
>>> rename it to kvfree_rcu_mightsleep() variant. The goal is explicitly
>>> underline that it is for sleepable contexts.
>>>
>>> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
>>> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>>>  
>> Could you please add you reviwed-by or Acked-by tags so we can bring
>> our series with renaming for the next merge window?
> 
> I don't know. Perhaps we should just apply this patch and not worry about
> sleeping and whatnot.

That's a cop out, just removing the one case you care about. Fact is
the naming is awful, and the 1/2 argument thing is making it worse.
If a big change is warranted, why not do it right and ACTUALLY
get it right?

-- 
Jens Axboe


