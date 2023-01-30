Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08788681FA2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjA3XaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjA3XaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:30:18 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882792A161
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:30:13 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id e2so2362785iot.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1nynTv2Ukmore8oJy9kp+YA0Zu6nVdeunqSuZlsLFu4=;
        b=IihrPV91c0txs5z5kc9WvcNMFOFdzExEY9PtT9Xawn3cICGDXVnqxwuQDoXJwSca51
         M6LRLiBn9Nwa9qTLeJyiyzZ4qiziMDXBH2mmxADPHG3XTJdjavj1QAcIy6HWvTIPB/eh
         paFeDxYdkHV28EcJiI70rcS3NxJY5NNW19dyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1nynTv2Ukmore8oJy9kp+YA0Zu6nVdeunqSuZlsLFu4=;
        b=J8IzWFSTPgQZPsOvGSEhR9wvVlgdBzS/Qz4B9KUI7BA3Q/glDEJJIzmNWREzXNArwJ
         qMp+TmPX4GSskJgZ4zTb9qiH4JLaV40Btqkei1BXZKixnTV1jEptgRvJXuTARNRlrCd2
         jzw6FypfuCtq/kBgIp+rdEJzpENXj9RgOBGoNjFmne2fvD2P34ArL43TiuHeGddyxKKL
         5p9qn6TJIdcHejpmAsyLwzUZuJjKT7WIpSP5Xaob3z0/zWnDztHMGIwe0BcZ1KqDVmvV
         zuDbhJrCWNI/dvK1w0oPRK/iLfFVSmNyi+PMewapxj03MTL26uzzst0fSex3QRS8PGJY
         QG9A==
X-Gm-Message-State: AO0yUKWb1283ts5W7r9mro/equ/3aoqzNYgkt/MTVY9lC4WAl90eunfA
        UVusDZt55IC2yvPaKvZF8oZuEw==
X-Google-Smtp-Source: AK7set+Ka7jWFMTaHswsuPRZzqYl8P0nsaklr15XgXcATVEP11vHn9J9rdDkVExRCdnRcbC/xyDn9g==
X-Received: by 2002:a05:6602:88f:b0:719:6a2:99d8 with SMTP id f15-20020a056602088f00b0071906a299d8mr1515994ioz.0.1675121412814;
        Mon, 30 Jan 2023 15:30:12 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id g1-20020a5ec741000000b0071dc7b4d0c7sm1098260iop.6.2023.01.30.15.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 15:30:12 -0800 (PST)
Message-ID: <021776e6-b37f-0a2e-41e0-5c09f9582c57@linuxfoundation.org>
Date:   Mon, 30 Jan 2023 16:30:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] docs: add workload-tracing document to admin-guide
Content-Language: en-US
To:     Thorsten Leemhuis <linux@leemhuis.info>, corbet@lwn.net
Cc:     sshefali021@gmail.com, kstewart@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230127234616.55137-1-skhan@linuxfoundation.org>
 <f48e8dab-2a68-88d2-7917-f8f34a39e322@leemhuis.info>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <f48e8dab-2a68-88d2-7917-f8f34a39e322@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/23 01:35, Thorsten Leemhuis wrote:
> Lo! One small quick question.
> 
> On 28.01.23 00:46, Shuah Khan wrote:
>> Add a new section to the admin-guide with information of interest to
>> application developers and system integrators doing analysis of the
>> Linux kernel for safety critical applications.
> 
> That intro made my mind go "neither 'application developers' or 'system
> integrators' are admins, so why is this added to the 'admin guide' then?"
> 

I see what you are saying.

> That made me look up the into for the admin guide, which is
> ```
> The Linux kernel user’s and administrator’s guide
> 
> The following is a collection of user-oriented documents that have been
> added to the kernel over time. There is, as yet, little overall order or
> organization here — this material was not written to be a single,
> coherent document! With luck things will improve quickly over time.
> ```
> 
> Adding another section that doesn't seem to a be a good fit feels a bit
> like "making things worse than better".  So wouldn't this maybe be a
> good opportunity to create a totally new top-level section for
> application developers and system integrators, even if it's tiny for
> now? The audience is likely big enough to justify that -- and the topics
> are likely different enough, too (of course sometimes there will be
> overlap, as always). Any maybe it will help to bring other stuff over
> from admin guide that is more targeted for application developers and
> system integrators, which will help to get more structure into the
> admin-guide.
> 

I like the idea of creating a new top-level section for application developers
and system integrators. I foresee this section growing and also we can look
at other documents that are a good fit under this category and move them over.

Jon, Thoughts on this.

thanks,
-- Shuah
