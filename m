Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC9C614672
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiKAJOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiKAJOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:14:33 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48314646C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 02:14:32 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 192so12935511pfx.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 02:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ipcpX1kbua7oatb0n4l1N5J+XozqPX/zfhKouT9X4LQ=;
        b=CHoTVH90o6acKk0jKiKLHuFHSToLSIbcNIi2PExg8h7B5+D3PnrfBGBFlwQ5bVxTAs
         gO5PU8y7uikwIbKcifQGP+B/MTyGjZAuCuEWU6WeAzTx1zMt6uP7NxDzR0YGnArS3Lat
         U5wCPvvSQmSTxnHc/nQiige6fNXaVUQv5cL5KtLo2VlGkV9iddrg3wBpHg7v7E1ZIvZS
         YXZwFr7Y8uQNncDpFTgYc1L1o81DA5M9PktwlrZnI+nmND7MHYE7m4DJa1fsasP5OCKz
         DeD/pS7Jd8unoEml+qpOuPKATk8nX5V4Kj/f1LiImCIKa+Xkz0amBtuExl5dywWNHbr0
         cppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ipcpX1kbua7oatb0n4l1N5J+XozqPX/zfhKouT9X4LQ=;
        b=Y7vU/Oib46ACQWbUXGCKGxRDG2Jh5fviyKWki6PU1Y0QMuB0aYNL3nq+bgcRz9b3fD
         wiIPcrK9tSHVpbssqfjhz4XbKFyTmvrBNi07RaqJz49kM2rgnW28bAlH88hzlf/aon2+
         Etwg4ZgpqEB/bPY0HuwZWFEQi6RjqBKltuk47fjqkCs+RPUONHiH4ohxYmwz4ggQezeO
         wKz5cemp0YDqai2Kk0Kd/x0Ys+IvW/VMGS0f1OcX1icBEB8f0YTP+LU8p4KdvX2BuW4b
         dIfj7vukbzz7NoP4d2Hlc+8+kEtG3GOSJKY+uZF37ZpmEpjYjx+jE2Qgi/b2cvJzXWcT
         E+Kg==
X-Gm-Message-State: ACrzQf3B5NJrI6t7UZmL5wLkbnol0Jmd+QY86yNUgxAVlUOaQGIhOPRZ
        tWsXPNdX5QdysTlRFfmSilOgcAAynX6rVA==
X-Google-Smtp-Source: AMsMyM61IhvNG5GGvzinNG/kzvz6uNY20Vql+6nBYPmeqQSzun/h9a6vt7a3hN3S2nouRyFmGKLIpQ==
X-Received: by 2002:a62:1e04:0:b0:56d:a2cf:e7fb with SMTP id e4-20020a621e04000000b0056da2cfe7fbmr5943315pfe.48.1667294071839;
        Tue, 01 Nov 2022 02:14:31 -0700 (PDT)
Received: from [10.255.25.30] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090a3fc100b0020dc318a43esm5551259pjm.25.2022.11.01.02.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 02:14:31 -0700 (PDT)
Message-ID: <e7a5e964-6113-f54d-1477-5eb561f843e3@bytedance.com>
Date:   Tue, 1 Nov 2022 17:14:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH] sched/fair: favor non-idle group in tick preemption
To:     Josh Don <joshdon@google.com>, Chuyi Zhou <zhouchuyi@bytedance.com>
Cc:     peterz@infradead.org, juri.lelli@redhat.com, mingo@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
References: <20221027081630.34081-1-zhouchuyi@bytedance.com>
 <CABk29NtDny9qKZbZZ_i8Brwjtqs5GA0G4_SffzK4HzG3RrXVhQ@mail.gmail.com>
 <64d963b6-2d9c-3f93-d427-a1ff705fb65a@bytedance.com>
 <CABk29NsbGuMPcA8NJagMfPyHij3864F3DVQ6wpCj3UAo8tbFNQ@mail.gmail.com>
 <5af26ac9-3bdb-32d2-77a7-6cd8feca97aa@bytedance.com>
 <CABk29Nt38d31LnazbcSVB036jUYemC1KRpR2Dn7YgLmXkp-QBQ@mail.gmail.com>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CABk29Nt38d31LnazbcSVB036jUYemC1KRpR2Dn7YgLmXkp-QBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

On 11/1/22 6:44 AM, Josh Don wrote:
> ...nit...
> Some weirdness about this change though, is that if there is a
> non-idle current entity, and the two next entities on the cfs_rq are
> idle and non-idle respectively, we'll now take longer to preempt the
> on-cpu non-idle entity, because the non-idle entity on the cfs_rq is
> 'hidden' by the idle 'first' entity. Wakeup preemption is different
> because we're always directly comparing the current entity with the
> newly woken entity.

Indeed. The hidden non-idle entity might run longer at the cost of
delayed preemption. This behavior is not compliant to the SCHED_NORMAL
semantics. But we also can't tell from here that the non-idle entity
contains SCHED_NORMAL tasks or not. As long as the entities do not
aware of the schedule policies, this ambiguity exists.

Best,
Abel
