Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06FC6772D1
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 22:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjAVViE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 16:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjAVViD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 16:38:03 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F9D18A8F
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 13:37:47 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id q9so7674453pgq.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 13:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oe89yTjGNmmMUneDO1NsmFMgS00g5APq0GaajvfZiZ0=;
        b=J+daCyhSYvDYWVjODQE6PTdfJoZ/ugHBfEw9RdNa4DoHyo1sz0xA0/EJfAq/MsCiGo
         0IHi2W3TAjZz+V/tJ8BsQ9GUDI6K0etRzWK0h+Uh67To7mLugsDzjEAMjIbWJVRr4+Pq
         QoUL0GUqHrLAEP10C+V1o8Hq6aU5MiD0AgcC2gsVsQHEh3CEedzvx0vIprp7buTYJR1l
         16gNNdO+aIiTjKlDFYHcZaSdzJ7RfjT7Fbokuzg884aZuKjBXyG2bK0PU0lmt+kbzub5
         dau2YmokqakH0ocDY17ExpfqvM/6rzhhKQlBbFVliIQz73ghY9GuIFYnqedcsZ4eA+x7
         Xi3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oe89yTjGNmmMUneDO1NsmFMgS00g5APq0GaajvfZiZ0=;
        b=Wgjc6JBM1rrcjls7qBKmyB/ITAJwcb9yZDIgDoRwcbGqfn5pMWarf9hRM3tUihD5W9
         ge/q0MTSkfar2oBBjbEOzUR6YDq49iZe49SmH0PxXnBJosHV2FFJcjr3D3yCe8WYdtWg
         +I+BAVnd2kpJj3Dmw9G1VfSE92YtYfbGSHKPMLSpnQZrfwKAwHmPbJIGt5XOvbnJKJ9Q
         pc5bGcexSlSsl4recWDPNRntRd/gsE6yvkOz3grjqP4C5lqVH+su0TFK0xUVF4Pi6LkF
         7gy+On326NLdEElGOp5xYsy1WuawPwHMhmGhkSwLbXnB5QJzmnBMoZgnX8iBqft/mFcI
         buHQ==
X-Gm-Message-State: AFqh2krdgp7rVkEVckrbAJYFMkzw79AjcnnPafrVuvotdYz1LbG07IiB
        9x8eIuDTRfS1awNHVqfIpWAYSQ==
X-Google-Smtp-Source: AMrXdXszoC3+w1Q2zpPGPMKmhkMrf+BkeuMJJxCc2NsQnWAXRpcEltY7WDe9CHNW06GZjFQWhmcpBw==
X-Received: by 2002:a62:87c9:0:b0:587:4621:9645 with SMTP id i192-20020a6287c9000000b0058746219645mr5490475pfe.1.1674423459230;
        Sun, 22 Jan 2023 13:37:39 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y24-20020aa79438000000b00574ebfdc721sm30736947pfo.16.2023.01.22.13.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 13:37:38 -0800 (PST)
Message-ID: <dd18f35d-6b16-9601-90b3-2efc2cbed173@kernel.dk>
Date:   Sun, 22 Jan 2023 14:37:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: linux-next: Signed-off-by missing for commit in the block tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230123080830.7d50fccd@canb.auug.org.au>
 <61a0120a-4cff-90c0-6f87-4957aaee7a0b@kernel.dk>
 <20230123083458.45f3641c@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230123083458.45f3641c@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/23 2:34 PM, Stephen Rothwell wrote:
> Hi Jens,
> 
> On Sun, 22 Jan 2023 14:30:15 -0700 Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 1/22/23 2:08 PM, Stephen Rothwell wrote:
>>>
>>> Commit
>>>
>>>   24337ddf1ff4 ("io_uring: Enable KASAN for request cache")
>>>
>>> is missing a Signed-off-by from its committer.  
>>
>> Fixed up, thanks.
> 
> Thanks.
> 
> Except you misspelled "Signed-off-by" :-)

Hah, damnit! I never type that by hand, except for here... Anyway,
fixed THAT one up too.

-- 
Jens Axboe


