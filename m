Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA436313EE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 13:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiKTMn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 07:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiKTMn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 07:43:26 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD282CDC6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 04:43:25 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 136so8921304pga.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 04:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XCUwHwIiSQ/LKf+6sit/EW/crWt69lnxhSoo3m6IKe0=;
        b=Z9F6BOI6NYbVtbZlT0ka5RxdknmgtFjiMwzWL+ZmfRmjx9jITw8BRxBiqmus0hfXjA
         YySkmEPQnYB+OjmED7SJWycofpG7FqWMYeIi0Wfdb5ZMEEUxbEx8QU7Feyz+5grlg2U3
         jApNmFQ5ZwdicKRMdQhxEJA9/cw6kNFDr/OK1El5YeVf+c61hlpXJExGNSpAoMpOvQXb
         FqCagswl7pRmf1DjgxWT+VPaGyL9e4slOQdTWcLVPjhAgtneDrlIzxEisZfbI4f4jMgV
         Pgo9LnSA2RcZjL6xwRgqdsgBxRI9y/pdrdCGFg5/eWPIi0W2tEuNQqDYHcJ7PneRLhrq
         r76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XCUwHwIiSQ/LKf+6sit/EW/crWt69lnxhSoo3m6IKe0=;
        b=42myevt0G5aBM7Rg4OeaCeb18lpDSwZtenVdcJP4OH47t4dBOjWAftcYaA5hafcNTw
         x3fZ5MhDHBN4f/0PbmVmKDXVgCYd+S0yxPC0sSKvUXco8nD/P5F8sixilY1Da+bU8U9j
         rp2fcDHNUHolXwFIGbdS3L7Ngn8beNaj/dTHbyksUDKRWcIn8t+HrOrU3qP6UTjKWDgZ
         ETjmU5CvPgCcZhM6RJ2ZVZXFdSbqB6bP2n+4t1qibhVexrfzzEAXX8H08lbZjbY2Utn7
         Jotxndokx/YMSBNECq03Cv8jERC7Xy9PXGrkQ4lT4C1KVdGYqlUOkf3qZ1/WJybkNUKz
         9eTw==
X-Gm-Message-State: ANoB5pmo8/zi37yzUiG0rgWl5bU85qGybAbMNIuoUmvZolgsn+ZSkphS
        Pi2FGcT/r063IuuNGHCU9qbxL6rbDkQ=
X-Google-Smtp-Source: AA0mqf5RvoM4DpgOQgWgwWwbi1FQbyDwtHWyQu4XgT1YW3jELlhRg3ZiIO2feAZVmL6UUxrbvdG6Bw==
X-Received: by 2002:a63:e644:0:b0:45f:702a:aec2 with SMTP id p4-20020a63e644000000b0045f702aaec2mr3991898pgj.450.1668948205054;
        Sun, 20 Nov 2022 04:43:25 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-22.three.co.id. [180.214.232.22])
        by smtp.gmail.com with ESMTPSA id z24-20020aa79498000000b0056cea9530b6sm6544968pfk.202.2022.11.20.04.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 04:43:24 -0800 (PST)
Message-ID: <1cc02070-8833-911d-56c8-608b5ca7eff0@gmail.com>
Date:   Sun, 20 Nov 2022 19:42:49 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: Question re: building with cp -l (hard linked sources)
Content-Language: en-US
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <b6a5f822-f7a8-b0b4-233c-8915056dc656@alu.unizg.hr>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <b6a5f822-f7a8-b0b4-233c-8915056dc656@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/22 12:58, Mirsad Goran Todorovac wrote:
> Hi, Mr. Bagas,
> 
> I am in process of bisecting another bug. Right now I take about 1h30m to build both
> the good and bad version of a kernel in bisection.
> 
> It helped a great deal to do the following:
> 
> # time rm -rf linux_stable_build
> # time cp -rp -l linux_stable linux_stable_build
> # time diff -ur linux_stable linux_stable_build
> # cd linux_stable_build
> # rm .config
> # cp /boot/config-EXAMPLE .config
> # time nice make CC="ccache gcc" KBUILD_BUILD_TIMESTAMP="" -j20 bindeb-pkg |& tee ../error-${VER}.log
> 
> I've been doing the good and bad bisect build in the same directory, but is seems to me that
> ccache then doesn't realise it compiles the same source twice?
> 
> I am not certai of the reliability of a build in a directory with hard links to the original local git
> repo copy? How does it handle git checkouts and git bisect resets? Is it supported?
> 
> I am asking because I haven't found an answer in any available man pages, and the build and git checkout
> process is rather obscure.
> 
> It seems to me that build in directory with hard link instead of copying is much faster, and I could
> do simultaneous bad and good bisect build, for only one source file has to be fetched and loaded from
> the disk into the cache and memory.
> 
> However, I cannot test that while bisecting, for it might interfere with some other fault in the tested
> kernel.
> 
> Is it supported to bisection build in the same directory where the source is? And then do a make mrproper?
> 
> I don't know how git and ccache interoperate?
> 
> Any advice?
> 
> The current procedure works, but it is not time efficient (15 steps might take 30 hours).
> 

You may want to see ccache(1), especially "COMPILING IN DIFFERENT DIRECTORIES"
section.

-- 
An old man doll... just what I always wanted! - Clara

