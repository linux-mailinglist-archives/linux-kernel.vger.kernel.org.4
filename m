Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E916D688D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjDDQOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjDDQOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:14:39 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEE630ED
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 09:14:38 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-752fe6c6d5fso17380139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 09:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680624877;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=syF/smnUwAV4ZKcd539TdCxhvG4UIaARCIo/FYWxUSE=;
        b=NezZ/cChFX7X9N5vXRkKRhEoKwRKlZNnlxdsD2sRu8AoohuiILG5LBrAEGvIPl9G6s
         qsZU2GdPHExGSKifbeAiQYjRsI+ST4NIb4FOf2hbvPhLeE7BeDmyJspzSfVvkmaOJe3Z
         9PEmYVT9y1EliaMjx4A8aG5Z/W5Ca0Bv6AANKySUcTA6yO4H7X123UQXmFmcnufS/8r6
         wPfvtb/yoesL3hxI8vKaNqvf/Zmm7AdnhY0OiIUlgigHF6tngdtCejXk6eMBFdk0MHnx
         v9WYlWhPX81bWD9V1UUFK3UaV805MrKoC1ntg6zaSHu0HiJTm+7ijzxHjiyJMWj/0pR7
         QDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680624877;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=syF/smnUwAV4ZKcd539TdCxhvG4UIaARCIo/FYWxUSE=;
        b=Xvq/QdClgMyoGdK5BfaAWNqIEEzWnwRaY6ykObCMf1aNY3dEXeOOVXj7YSuL4RquPi
         R+krtpXFpKdeT+o+vhjiDo/XTUHDWeADKEoWEkitSZBmvCf/KXhsPNl758vmrXTOHCyJ
         zC8NHGXlljITerI0DcvRzpp9CU7971Oj6E4IE6caG8LHDJjx2sh7d89q0U8NP90Q/Y2s
         uYCAfQ3lNsbXZEkkFCFqXksi9bsdXBAGNxqGj5cjClFCqOiqi1RFnhHf7+cV6lNrs1sd
         +ysRq/GxNDvvb/nNZIU4J8jSvmE0UWHJENY1gyb8suW4CR/sNMN7kPVBromIusYK6LaB
         WBdw==
X-Gm-Message-State: AAQBX9e7YAnSwTmB3HKT2qeaX+pjrF2neBftM6KagUYXi3PE6zsp7L33
        WtFaHYHDBy4FShecoTO0e/Gu3me3GrbTjTVgtyk9Ow==
X-Google-Smtp-Source: AKy350aPT1Rhe5H3Gy/XEyPb8/cBI4XCRpQ+Hp40vZyjmt57SEEJjNt+Cq1ZO2GQ7u2tmwJZhhTK9g==
X-Received: by 2002:a92:c214:0:b0:325:e065:8bf8 with SMTP id j20-20020a92c214000000b00325e0658bf8mr172572ilo.0.1680624877615;
        Tue, 04 Apr 2023 09:14:37 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id n21-20020a056638211500b0040617a81e1asm3363598jaj.59.2023.04.04.09.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 09:14:37 -0700 (PDT)
Message-ID: <86c63b44-7832-6a03-11d9-d389fdaf3c16@kernel.dk>
Date:   Tue, 4 Apr 2023 10:14:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/2] bio iter improvements
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        willy@infradead.org
References: <20230327174402.1655365-1-kent.overstreet@linux.dev>
 <ZCIVLQ6Klrps6k1g@infradead.org> <ZCNN2GE3WBjMkLkH@moria.home.lan>
 <ZCrsbv+zKGf4jvUm@infradead.org> <ZCsAhDpsiNWpiAxS@moria.home.lan>
 <ZCxAIR8pxOfSE6OR@infradead.org> <ZCxGdj3JKl2RPUJW@moria.home.lan>
 <2bbdb38b-a3ac-5127-23c0-56badd113538@kernel.dk>
 <ZCxLGLdcN5wYnxfr@moria.home.lan>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZCxLGLdcN5wYnxfr@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/23 10:06?AM, Kent Overstreet wrote:
> On Tue, Apr 04, 2023 at 10:01:58AM -0600, Jens Axboe wrote:
>>>> Starting to get personal instead tends to not help to convince your
>>>> reviewers that it's really useful in general.
>>>
>>> I know you and others like to talk a lot about what you want as
>>> maintainers and reviewers - but I find that the people who are the
>>> loudest and the most authoritarian in that respect tend not to be the
>>> people who drive discussions forward in productive ways.
>>
>> One issue is certainly that nobody wants to engage with people that
>> instantly try and make this personal, or just uncomfortable in general.
> 
> Yeah, you like to respond to technical discussion with a *plonk*.
> 
> *eyeroll*
> 
> Christoph can handle himself, he doesn't need you defending him.

I'm not defending Christoph, I'm trying to help YOU understand why
your patchsets always turn sour. And I'm trying to get this toxicity off
the list, because it's frankly not productive at all and it's hurting
the developer environment for everybody else.

If everybody else seems like an asshole, maybe it's actually you? A
little introspection would be prudent. If you can't change your tone,
please just go somewhere else. I'm not interested.

-- 
Jens Axboe

