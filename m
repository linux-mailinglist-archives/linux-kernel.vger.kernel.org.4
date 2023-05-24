Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E3C70F8C3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 16:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbjEXOcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 10:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjEXOcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 10:32:06 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E04912E
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 07:32:04 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-19a347d69c8so276627fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 07:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1684938723; x=1687530723;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDyGaU5vY520HnRjaMujkkWoZrPH9Gy1gshhTzYah3M=;
        b=FfTgFnJkkoNOzvnk6oEE9OPOuc8tf6bsjZ9BjuQ6mCdPMyGsAzpYo7OE4+isfzgzY1
         pEfY++1lTgtDnpl5xPZ2qdf9djm0iwGAMzLTIvITVu7pAQpyE0xh2aPkuLSRoowRXeLx
         L7R165r7QeGBPbhuwFBrr6ThCdviuhTQ9bXCxn6O0ypDoDF2YkQdx2bHveTHpHpv8x1O
         NeUCVyJEnXyZKEYnTXPjelAbnpeETChz5KzihEjpnpGZONEPf/BGAUS5blax2LQdJc7h
         7QPjUWVn7wVz+WxqzYt1OOFIkZH1Fh7lvcGnb5UcdwvKI0JAFB9gxH5p5gx2Td8N5fG2
         fsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684938723; x=1687530723;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IDyGaU5vY520HnRjaMujkkWoZrPH9Gy1gshhTzYah3M=;
        b=YVCJ6BWrU9Ri8xAkGtHUzFPzvlqWL53rfNmn0gl2vM/Xs46Mh1iX1CjW1r2/SphS8O
         SbM3wk3b7xXFjnbUB2Gn4I+BChIGzq08cN0UBTS+yYWVPsk3glj13+g3My9UfWMUKy95
         RHCY1rgPKd6JdoX5ufBgs+LRHaDrH6iD+aEQmsn9wWZEYHcXJjCfsYMk30CJQ8huskVl
         A81Y5CNN7SgTfkPfDLqDxlHCaqevyh7lQ2paRWjdycazABhBsvK5FspiPiWqv5vhHDvc
         UE5NzLzIrlREvubhg8zWQ6r2wCfHLxJyoNsmluwoJFvaEwLwXG0fyYt51yMomBzi9J4M
         z1lw==
X-Gm-Message-State: AC+VfDytseQImTZQ/4m6TcWIVvWvEumKsebN0qvziMQhInZmPwuM4xw2
        j2JOiLVMklj3VCgtDp8TjPyttQX574QRPIdKBBo=
X-Google-Smtp-Source: ACHHUZ5FsadYXL4czxLL/bHmeVCASD9xFCcwU6J9Jb8HfL+5NU91k63PTMY1pBl3/JZ1F7qDeLMBdg==
X-Received: by 2002:a05:6870:e493:b0:199:a8cc:13dc with SMTP id v19-20020a056870e49300b00199a8cc13dcmr20766oag.9.1684938723334;
        Wed, 24 May 2023 07:32:03 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:522c:f73f:493b:2b5? ([2804:14d:5c5e:44fb:522c:f73f:493b:2b5])
        by smtp.gmail.com with ESMTPSA id dt40-20020a0568705aa800b001968dd2e1fesm2814oab.3.2023.05.24.07.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 07:32:02 -0700 (PDT)
Message-ID: <f309f841-3997-93cf-3f30-fa2b06560fc0@mojatatu.com>
Date:   Wed, 24 May 2023 11:31:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
To:     syzbot+b53a9c0d1ea4ad62da8b@syzkaller.appspotmail.com
Cc:     davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com,
        jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
References: <0000000000006cf87705f79acf1a@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in
 mini_qdisc_pair_swap
Content-Language: en-US
From:   Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <0000000000006cf87705f79acf1a@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: git://gitlab.com/tammela/net.git peilin-patches

Double checking with syzbot
