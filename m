Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5770B622E3B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbiKIOpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiKIOpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:45:12 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB454186EB;
        Wed,  9 Nov 2022 06:45:10 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so2035504pjc.3;
        Wed, 09 Nov 2022 06:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EykLsHeIVHRO9PdnUtJ+KSnyFBk98kvT0QI6KNtiYAM=;
        b=KY2/9r6gj3wAKeO3IF1EWjaba52UxmHK7IyTetfWSTQ0g/GquJI1io9+dDzeqEX2d0
         /Jg91Hb9l6hMY5QwO1WrIYZ/0kB4p5v8NWfCk45jdGZ4xsLw9QGl5wkCL7KGhIygT6P5
         dJx5RDofgTF9Hs581wMo4Tdp4WorRLiOV0IPKb3YVJKnWKwRhXrZuAV6gOifD6+HyYzp
         E1d0bGFnr6rfZlGqH+rf3Oy6AhITS5cnOMN8Wrn4yujAvrhK/frV+M1t8FPhaqUKN9Ly
         DphomHbeFAenzmq2L8gwWEUpvJqSq8Tv4DCW1Aadj6dhOF0isLt1gBFBy5mhLhHLm8LZ
         f9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EykLsHeIVHRO9PdnUtJ+KSnyFBk98kvT0QI6KNtiYAM=;
        b=sF4wJweDvX126OiLs1pnIpJ622HSBAiwW71UMu7JQw3KSPt1SZMdwOeLbkWTe3m1kd
         07ZQkvakoZc4dfjJDvU2ui+Fow2TwYcl042GhlD/fTMQtG6wA5nMfxMj3GgW6MxFr3D7
         gNHJ/3vJT8Ohjb3Fs8SYE6VIw7iburEfl8eHP3Yg3i7uyS+uC5x4dNTUXVbI4fu2seaJ
         TAVUgQvcNq3rdrWZoTd++mESaEdwifUDFqCFnc4VvzIUsB0BDyT4lU7otFcrXIFVvt6v
         qCeGbYmEz4Y2g3dBHxChfR0xi3lwjlWyAkChrgUFvuTLxWpTTA+94LEXQB8Us5C6c54P
         n/1w==
X-Gm-Message-State: ACrzQf186FOPX8cYPP1rAX3dikw3MfdIWRp6A7ys1LHnxzEDSZ9xm/6R
        Z+4TvOoEjpBK211TqiEeEwA=
X-Google-Smtp-Source: AMsMyM6E7S+hpcuxPPqJZtWasCHQscNqdTaG7NTDnsR8LPQezPNjV+jphpzTTWJL8371/qdiPRIXvg==
X-Received: by 2002:a17:90a:d084:b0:213:8cf1:4d34 with SMTP id k4-20020a17090ad08400b002138cf14d34mr64036139pju.150.1668005110411;
        Wed, 09 Nov 2022 06:45:10 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id w15-20020a1709026f0f00b001870533c443sm9149511plk.236.2022.11.09.06.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 06:45:09 -0800 (PST)
Message-ID: <47514c0a-7d5b-5a0b-6bb5-d5c96d163838@gmail.com>
Date:   Wed, 9 Nov 2022 23:45:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] docs/driver-api/miscellaneous: Remove kernel-doc of
 serial_core.c
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <4e54c76a-138a-07e0-985a-dd83cb622208@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <4e54c76a-138a-07e0-985a-dd83cb622208@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

On Wed, 2 Nov 2022 20:48:01 +0900, Akira Yokosawa wrote:
> Since merge of tty-6.0-rc1, "make htmldocs" with Sphinx >=3.1 emits
> a bunch of warnings indicating duplicate kernel-doc comments from
> drivers/tty/serial/serial_core.c.
> 
> This is due to the kernel-doc directive for serial_core.c in
> serial/drivers.rst added in the merge. It conflicts with an existing
> kernel-doc directive in miscellaneous.rst.
> 
> Remove the latter directive and resolve the duplicates.
> 
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Fixes: 607ca0f742b7 ("Merge tag 'tty-6.0-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty")
> Cc: stable@vger.kernel.org # 6.0
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Hi Jiri,
> 
> I've seeing the increased warnings of duplicates from "make htmldocs"
> since the 6.0 merge window. They look like (partial):
> 
> /linux/Documentation/driver-api/serial/driver.rst:111: WARNING: Duplicate C declaration, also defined at driver-api/miscellaneous:111.
> Declaration is '.. c:function:: void uart_write_wakeup(struct uart_port *port)'.
> /linux/Documentation/driver-api/serial/driver.rst:111: WARNING: Duplicate C declaration, also defined at driver-api/miscellaneous:111.
> Declaration is '.. c:None:: struct uart_port *port'.
> /linux/Documentation/driver-api/serial/driver.rst:343: WARNING: Duplicate C declaration, also defined at driver-api/miscellaneous:343.
> Declaration is '.. c:function:: void uart_update_timeout(struct uart_port *port, unsigned int cflag, unsigned int baud)'.
> /linux/Documentation/driver-api/serial/driver.rst:343: WARNING: Duplicate C declaration, also defined at driver-api/miscellaneous:343.
> Declaration is '.. c:None:: struct uart_port *port'.
> /linux/Documentation/driver-api/serial/driver.rst:343: WARNING: Duplicate C declaration, also defined at driver-api/miscellaneous:343.
> Declaration is '.. c:None:: unsigned int cflag'.
> /linux/Documentation/driver-api/serial/driver.rst:343: WARNING: Duplicate C declaration, also defined at driver-api/miscellaneous:343.
> Declaration is '.. c:None:: unsigned int baud'.
> /linux/Documentation/driver-api/serial/driver.rst:376: WARNING: Duplicate C declaration, also defined at driver-api/miscellaneous:376.
> 
> These warning messages are not easy to track down, as there is an
> unresolved issue in Sphinx's C domain parser who can't handle a
> function and a struct of the same name and causes duplicates in a
> later stage of Sphinx processing.
> 
> But the warnings shown above turned out to be true duplicates.
> 
> There is a not-clearly-documented rule in including kernel-doc
> comments into .rst files. Any kernel-doc comment can be included
> at most once in the whole documentation tree. Otherwise, you can't
> be sure of which target a cross-reference points to.
> 
> As I don't have full context of these kernel-doc comments, this is
> meant as a band-aide patch, especially the reference to
> serial/driver.rst added at the bottom.
> 
> If I can get acks from you and/or Greg, I'd like Jon to take the
> fix, as this issue affects the -doc tree most.

Jon, Greg has added this to his tty tree and (hopefully) it will
soon land Linus' tree (v6.1-rcX).
I'll ask you a back-merge once it happens.

        Thanks, Akira

> 
> Thanks,
> Akira
> 
> --
>  Documentation/driver-api/miscellaneous.rst | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/driver-api/miscellaneous.rst b/Documentation/driver-api/miscellaneous.rst
> index 304ffb146cf9..4a5104a368ac 100644
> --- a/Documentation/driver-api/miscellaneous.rst
> +++ b/Documentation/driver-api/miscellaneous.rst
> @@ -16,12 +16,11 @@ Parallel Port Devices
>  16x50 UART Driver
>  =================
>  
> -.. kernel-doc:: drivers/tty/serial/serial_core.c
> -   :export:
> -
>  .. kernel-doc:: drivers/tty/serial/8250/8250_core.c
>     :export:
>  
> +See serial/driver.rst for related APIs.
> +
>  Pulse-Width Modulation (PWM)
>  ============================
>  
> 
> base-commit: 30a0b95b1335e12efef89dd78518ed3e4a71a763
