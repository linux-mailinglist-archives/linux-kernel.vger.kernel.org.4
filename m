Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986806C1272
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjCTM56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjCTM5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:57:36 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDFEE394
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:56:45 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id m22so5350882ioy.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1679317005; x=1681909005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4PBK1F4xmuxkhj1Bp/pC5zsVsfYN8MHoztwMr1Mlxt0=;
        b=hmCo894tBO47HrZGMgQ0TU1uLXbzv1E1p+aiRQ5KELmPk0Wz7DxvH5p81Xz4CL9ARs
         C+rqH33TiKjBLRwEeokcvbtUJM2/xZe1J4sUcbbjU10Y+d1eot4HzrNF4Cc9cs0QK7oK
         fWIUKt2zol35q3fEky3giQvmj8RBkOOgmHUyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679317005; x=1681909005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4PBK1F4xmuxkhj1Bp/pC5zsVsfYN8MHoztwMr1Mlxt0=;
        b=lZxTQn040B6jmmfpdyDkktBBWc9n1QJdf7UyNX5ALQs/BMJxtQ63iZj/DQErnu7RXb
         FIhZFvHRCmFmq5+EBK70X7Pb5NHRmv4aH+HFs6awR2b0kL55hL/vVFFMc06cUICXxGPe
         OysU8PCRQa2pzcNNakhC9PitG7+LN2qyqSSnFtYBcw4fuA6Pl8P36ZroqcSXsHv5lp7d
         WLW0Ks4KUzG3z7PuhajcmRsslgwxQWMqueOMBb/oxIiUpzasHA+hVsVtSyq3RYcHB8p9
         TE6DTR1YZkBjPX+2bXFESs3SHg1EjsgQb1KqZCCJ+RKC3TvdhthgopefkANXcK5p2fUd
         2aTQ==
X-Gm-Message-State: AO0yUKUIg68ddlBcpG93o25t3mEucyQ8VInsy8Z7ZxvQ+mqjGhXqQ57g
        89+Hz3O+cn53e3xTKc+Y9WxCVAxiOBPRCuZv2Rbg3w==
X-Google-Smtp-Source: AK7set+VbE6SOQTu7hY7IZOXpYFjyei0/tZDLmAEfqaPb+DBYjzbVCs+QSOKQiFlDt45F6XUxaO0+Q==
X-Received: by 2002:a5e:a50d:0:b0:74c:9cc4:647 with SMTP id 13-20020a5ea50d000000b0074c9cc40647mr8922048iog.1.1679317004868;
        Mon, 20 Mar 2023 05:56:44 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h24-20020a056602009800b00743fe29dd56sm2872679iob.4.2023.03.20.05.56.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 05:56:44 -0700 (PDT)
Message-ID: <8579dfaf-11bf-cefa-c3ed-eb9b2d9d1a22@linuxfoundation.org>
Date:   Mon, 20 Mar 2023 06:56:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] tracing/selftests: Ignore __pfx_ symbols in kprobe test
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230207135147.5ce618d6@gandalf.local.home>
 <20230213204643.39f86987@rorschach.local.home>
 <20230318144202.486c43d1@rorschach.local.home>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230318144202.486c43d1@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/23 12:42, Steven Rostedt wrote:
> On Mon, 13 Feb 2023 20:46:43 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> Shuah,
>>
>> Can you pick this patch up?
> 
> ping?
> 
> -- Steve

l I will queue this up. Sorry for the delay.

thanks,
-- Shuah
