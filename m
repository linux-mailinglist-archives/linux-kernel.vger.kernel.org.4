Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D965F6A6D6C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 14:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjCANwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 08:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjCANvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 08:51:50 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2569B39B98
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 05:51:48 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id eg37so53872541edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 05:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677678706;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FmROz+jjysGIdxG0OXVt9BXRI08zLySmgZ7Ui4RktGI=;
        b=NNYQAaK3PrurqTvbeuwsK1orRteglxjVU8oziYmo6cL232LDCQYE7HxaAy2HxTdYxU
         6772ktfC1iFKPuHSEnDwmLmI+pay57cmzklprEPmCYl4v2XTHEjrWrZI/PMYwZWyGted
         kEvokGEE73dPNTQMVy5ZafPZ9o9SZgPV+yoxoIZZNgnnjBhB2yg/ab2g0+Mxkv19m1/F
         nJXeQ0vw5pDdfS1jqEtIHWKKH5FC5C/vYcB4S5Ieejrfyrv7denKqgJMo84WWInl+gqs
         fuj1EO0uTmTwzZVdDfVz4pqmws4qUpoEfuOcaqICO0XSaNe7ik+DTql+sjA6FgFNHF+O
         LmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677678706;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FmROz+jjysGIdxG0OXVt9BXRI08zLySmgZ7Ui4RktGI=;
        b=wPpA+crvuoeUJiP7+L8ZIUFJe2RwGVXKusrKSUb35k0+WAlTXbCynA4xO0G0cUCNWj
         7JttBeg6iHn7SQv0+g6Zu00qCWtkt6md6HZMECg9CqytDDbDTtpQAnNVUwj7lLGiXQTL
         voRUqllegPQtyRtGvmI8af4cQhWdlFby2IMzl915ZVhmGWQeg2e+gWuuk0OTPdr3FzLf
         rXlMtDBMsZVwVjvLFLjPu7tAR8SVob7Y1x2Q7iZytWkdtRHdSjMpbDDXN/K5j6Y+LOIc
         G/krjbPRk6EANJwG53ugCiKc/RAj8QSi1uNqEUQ9W1XnnGq3rHSSPvp3hBkR0p8idoWV
         ynng==
X-Gm-Message-State: AO0yUKW/Z46xo9Me6GNu4T4tvqEZM7YNSG1BiqSiVp6CZydzpIkvBBGe
        N+YKtBM7qzm1wDiF44eDwF63iA==
X-Google-Smtp-Source: AK7set9k19CfomyRoAzS5IG1PaeH5snagnjiUJoHQOo664uyG5BxusdPc4ChxHb2cY9aq3IBrafPtQ==
X-Received: by 2002:a17:906:8390:b0:8b1:800b:9fbf with SMTP id p16-20020a170906839000b008b1800b9fbfmr6951381ejx.13.1677678706653;
        Wed, 01 Mar 2023 05:51:46 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.78])
        by smtp.gmail.com with ESMTPSA id w1-20020a17090652c100b008cc920469b5sm5899948ejn.18.2023.03.01.05.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 05:51:46 -0800 (PST)
Message-ID: <cbad45c9-07b1-4393-e20d-ab8d372e0a3c@linaro.org>
Date:   Wed, 1 Mar 2023 13:51:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [Android 5.10] kernel BUG in ext4_free_blocks (2)
Content-Language: en-US
To:     syzbot <syzbot+15cd994e273307bf5cfa@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, gregkh@linuxfoundation.org,
        joneslee@google.com, lczerner@redhat.com, lee@kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        nogikh@google.com, sashal@kernel.org, stable@vger.kernel.org,
        syzkaller-android-bugs@googlegroups.com, tadeusz.struk@linaro.org,
        tytso@mit.edu
References: <0000000000007e24fb05f5d61afb@google.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <0000000000007e24fb05f5d61afb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/1/23 12:46, syzbot wrote:
> This bug is marked as fixed by commit:
> ext4: block range must be validated before use in ext4_mb_clear_bb()
> 
> But I can't find it in the tested trees[1] for more than 90 days.

Indeed it seems this patch was never backported to the stable tree.
I'm handling it.

Cheers,
ta
