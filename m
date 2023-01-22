Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E05677301
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 23:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjAVW16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 17:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjAVW14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 17:27:56 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39211206F
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 14:27:55 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id s13-20020a17090a6e4d00b0022900843652so13750600pjm.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 14:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/dAZopDqbAo3QdY1k+KfmF5laZlZPUhPOvXWpz29n6Q=;
        b=Te1loueT5FFT0///54ss+EGi5NnqZVnF66p9MrcSE2rlWW1aIYLlCCmGTCSW0F6DSF
         zGy/XhMPjWNOg0DTMdyryIdeC6S94qekXqZk6buO+/Y1zMPfGEuPKe1HnPmE+ScrERWn
         xI0FN6LDwN/9ZhC6ZxOtaJRABzDIs/aJ7ag5KnguVVe25wjnO9VF6p7+lMwTFL65IFcD
         gYlMIM1RXLCrAEXfPrPZoDmNxd0gYLglpwxFXhBXpa316k2GQE2o2N4FFVpLefP8Lhf9
         Xcqt1FTx9L0iCGSIFzYdmU532nJrR280DdX4Ubcy0mcevXrzERjnxXMMVfUgJYIabw5P
         V7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/dAZopDqbAo3QdY1k+KfmF5laZlZPUhPOvXWpz29n6Q=;
        b=iFPpCrTmhHRzpY0EJpk8cemYi7txAynM/wn8TrGAVeTsbCaaPr0GcU6hQZlef0UP2f
         c0v0l1nEjrnHqbpkx/8XAcA1dgCt+zMd/S8Dnark1jRYYxzC3PBQaRI+tXrcB9xJ6S9k
         fyyfsFCIx4ThNZfUVbdC7qLYXT5J+L4ASp0Unbw7sQaAe+KNLl0rzxhoiKs9jNROZvN/
         rUvSpx9ieobCZzBfMAfQ4oC65gY8k5q0pH2CWmZRRfFTdd0rOFKdn046nSekIQYw5Rqk
         xpUb/cQjmDY5EFUzfny9M4Sf/4UzP1+3lCovJuvGoVcq/yXFgyNm0pEa8bcIVtUw+nQT
         8YYg==
X-Gm-Message-State: AFqh2kobH++ExEcMTAwc+FkGwACJTxwlMt/41JHhJ74YpavXtJNN5ljj
        XnD+OnWE8IMCIIj3YupBXZsBdA==
X-Google-Smtp-Source: AMrXdXvaxXC+r8949o3MWU3crnBc0kvErgg9rRt/S+eh5ENhV+3MuHcztG7rmUXpDJjEAnKh9bEC/A==
X-Received: by 2002:a17:902:9041:b0:193:3a44:c436 with SMTP id w1-20020a170902904100b001933a44c436mr5527342plz.6.1674426475215;
        Sun, 22 Jan 2023 14:27:55 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t16-20020a1709028c9000b001947ba0ac8fsm3706940plo.236.2023.01.22.14.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 14:27:54 -0800 (PST)
Message-ID: <1ce4f09a-f4c3-ccd5-556e-3eb3aaa143f1@kernel.dk>
Date:   Sun, 22 Jan 2023 15:27:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] paride/pcd: return earlier when an error happens in
 pcd_atapi()
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Tom Rix <trix@redhat.com>, tim@cyberelk.net, nathan@kernel.org,
        ndesaulniers@google.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20230122154901.505142-1-trix@redhat.com>
 <1a501bc9-7058-6c47-0ebf-44459bc0e730@kernel.dk> <Y820PCtcJv12fJpI@ZenIV>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y820PCtcJv12fJpI@ZenIV>
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

On 1/22/23 3:10 PM, Al Viro wrote:
> On Sun, Jan 22, 2023 at 01:49:00PM -0700, Jens Axboe wrote:
>> On 1/22/23 8:49 AM, Tom Rix wrote:
>>> clang static analysis reports
>>> drivers/block/paride/pcd.c:856:36: warning: The left operand of '&'
>>>   is a garbage value [core.UndefinedBinaryOperatorResult]
>>>   tocentry->cdte_ctrl = buffer[5] & 0xf;
>>>                         ~~~~~~~~~ ^
>>
>> Has this one been compiled? I'm guessing not tested...
>>
>> In any case, this code is going away hopefully shortly, so let's not
>> bother with changes like this.
> 
> 	Look at the callers - the value left in entry is discarded if
> ->audio_ioctl(..., CDROMREADTOCENTRY, &entry) returns non-zero.  Sure,
> it's a nasal daemon territory, but realistically it's not going to be
> caught by testing.

I don't expect anyone really to be able to test it, but v1 had a pretty
basic issue that would've surely triggered a compiler warning had it
been compiled.

-- 
Jens Axboe


