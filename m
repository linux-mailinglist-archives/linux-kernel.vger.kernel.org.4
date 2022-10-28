Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3776561133B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiJ1NnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiJ1Nmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:42:44 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D89127409;
        Fri, 28 Oct 2022 06:42:13 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id h2so4874993pgp.4;
        Fri, 28 Oct 2022 06:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7TzN8u9qaXkNZI85rkj+YULdYiSU+6znD3acTZbi9bk=;
        b=PgzFaoyFnP79dB2M15z+16QqS9kVHYPCuK2FGUaXIoAbDF71LzJpyYzs42SBLjQaDk
         wXNHii2lhxZSoyjfHSo6QcspyGL2eww1xBxB+08HZEeS/23JAJIGq78RXQbByJ4BzJhN
         wlKeVIrZQAJLZ3ERQSW9spGskea5nN+iKC0FMp4bD67oWnYJ9lUgKHTmg21fprl5HJgR
         BOD7Hq6ok1ya0hlmJfFyRfHSeI7Ej/ZjwtGmlkbbD2akm7A4uMAxkDisilVKiB3unvVS
         PWIBQUVlXWTFuTOrtD58uYbqdHFSjtgGIVMzKSqBVyty7Nqo6VbcTRsE+sWnonXNlIo6
         fOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7TzN8u9qaXkNZI85rkj+YULdYiSU+6znD3acTZbi9bk=;
        b=YLi3M44P+1OofmJpp3PjhpwYKcKBN3jSG3Y7sum9jLEBMsli9sLWdHjw/q6mShfyaV
         ODT8yXZajWLCW5VU4Sr0JuP5YrsQhdbNP3pUlrKc3l5x0x7kmPVMlDGWmOQ8vaUdnCWl
         L8KJ3EI+HOqXHPf0yO01HMhQ1SIlZgnh6251wh5QiGzYrYreHMZtBcBrqzgef5OYc/bS
         WEyYOFpD2YIfjPzHQm988KHP7wbadh1j/JJuyvN3sm79BYrsIqZWiWFn4R1kAp8y3MyF
         OQ2l1EJEC4vzcQHZP+1BanLXohxVjW7/kP4ndHCeZWHNJi03irp7fF4rJXlE1a+iT/Nf
         Q1Hw==
X-Gm-Message-State: ACrzQf1KIR1L/7m7izD96WcsB5ScKcXVfE64H89lbAsZMcq2QsSdNXhK
        RYK4x4/D0xuKaTFWp4ObTuU=
X-Google-Smtp-Source: AMsMyM61E7h+FsczP3WkOaBGojiLbuZ4mwmo4kMQzQSLNDcLC522YO7hh4OND8lkc7pttapi6mzRQA==
X-Received: by 2002:aa7:9ece:0:b0:56c:5afe:67f7 with SMTP id r14-20020aa79ece000000b0056c5afe67f7mr14538295pfq.55.1666964533093;
        Fri, 28 Oct 2022 06:42:13 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-72.three.co.id. [180.214.233.72])
        by smtp.gmail.com with ESMTPSA id w11-20020a170902e88b00b00186b5c1a715sm3112265plg.182.2022.10.28.06.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 06:42:12 -0700 (PDT)
Message-ID: <43169c1c-0745-989d-0ec8-f0ff0152f683@gmail.com>
Date:   Fri, 28 Oct 2022 20:42:08 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 08/15] MIPS: IP27: remove KV_MAGIC
Content-Language: en-US
To:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-mips@vger.kernel.org
References: <9a453437b5c3b4b1887c1bd84455b0cc3d1c40b2.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
 <ebf854f94d7a33c744202efb31cbb61087a33e44.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <ebf854f94d7a33c744202efb31cbb61087a33e44.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 05:43, наб wrote:
> It appeared in the original import of SGI code in 2.4.0-test3pre8
> and has never been used anywhere
> 

LGTM, thanks.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara

