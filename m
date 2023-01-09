Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03BA661CA4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 04:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjAIDVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 22:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjAIDVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 22:21:30 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8B110FFC
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 19:21:27 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m7-20020a17090a730700b00225ebb9cd01so11407614pjk.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 19:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1jM4mtOjxzdkvFj3jCakSNJPcFUF5OXMS78TpTOkDW4=;
        b=cRp2Z8RUR4sfc1KLeo3L5gGC6ptTp4LAVkfMYeHbSm58AYuAy4sxKOFLXN/CLRCE5E
         LshWW/NefQvWJ8mNHInIl7KQ0ifdJygzsYI7rjHldbqnpK6bvJ+LWVg02P8qyfwLLSmP
         LlYLVUupKcv6tz8Sju4/sfM+AfrCR2mJO8mz3kOP3E96z8bUS6tm/pM7EYEDKOVaUAP1
         58EG0tVx3EEKqJBORmYqmh9q6RaQcxPymx3AWVLC7tl5XEeOzqFvjnzGQjsD7EuSUTkE
         C5o/pVkUvtCN8jkVmsElc198JdwVjphcErKfPKiZzupEfZVOvwCOreItJFOvhpPZZdtj
         syUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1jM4mtOjxzdkvFj3jCakSNJPcFUF5OXMS78TpTOkDW4=;
        b=uUVomy2bIN1Mwry/zXBL7sVW3HMmrzmQPJqh92FsiXg27oCvPO1FqLRuN80ipyjyCA
         iH0hTCxlt7kht3viOSRKR70mfs1EpeXyeGc3ZuXXreZvnz9jtCAupVE2CPJGK4T9SL3A
         lqiGz0fUj1o+GjxB6G2Y8S+1kLwHmLJaR3L98qEeXQxd8QXzm1vLop85ExhcsongSCaB
         L7vd7T84kZTln93pftAzxE68XgptuZFKmBV4tVbmoi9UObDazMdtUrfFfpMgtfaa26/x
         y+vSLugaSKGpEhJENT4ZSPakjorW5l1FYT0PiCdBx6HpyBTDbp7AWQ17jRJTURclqgxG
         +88w==
X-Gm-Message-State: AFqh2krOz6dxLq4cYxaKOcROGKDQSvy37bEcNiK4jet+uqZVHu84tTE3
        sv3hUw8dLvtjrlcKcpEiGn6qAtXnc5iSjaH7
X-Google-Smtp-Source: AMrXdXtVFt1i2MZWHS/tT/iGO3Y7mw0s3YQU8XLOXkuSEK8oesC6OzPZBoaF74YwPKmynJ8e1b9AgA==
X-Received: by 2002:a05:6a21:8cc4:b0:af:cc4e:f2d with SMTP id ta4-20020a056a218cc400b000afcc4e0f2dmr17033783pzb.0.1673234486613;
        Sun, 08 Jan 2023 19:21:26 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b5-20020a630c05000000b00477def759cbsm4200903pgl.58.2023.01.08.19.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 19:21:26 -0800 (PST)
Message-ID: <df7cb4c5-eae8-1aa4-2c1d-4cbf3c651c1a@kernel.dk>
Date:   Sun, 8 Jan 2023 20:21:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [syzbot] KASAN: wild-memory-access Read in io_wq_worker_running
To:     syzbot <syzbot+d56ec896af3637bdb7e4@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000e7f96f05f1cb9a84@google.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <000000000000e7f96f05f1cb9a84@google.com>
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

On 1/8/23 7:34 PM, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> INFO: rcu detected stall in corrupted
> 
> rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P5774 } 2664 jiffies s: 2777 root: 0x0/T
> rcu: blocking rcu_node structures (internal RCU debug):

Don't think that's related, probably because of the earlier base of
that branch. Let's try something that's merged to current master:

#syz test: git://git.kernel.dk/linux.git syztest

-- 
Jens Axboe


