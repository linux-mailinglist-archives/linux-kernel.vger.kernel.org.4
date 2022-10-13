Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C7D5FE53F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 00:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJMWaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 18:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiJMWaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 18:30:05 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D9E2FFC8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 15:29:58 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 207so3696611ybn.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 15:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PViaeHG596lsKhDFy2h2Fs7+Z+afjotSfgIlxk34Cto=;
        b=iTQXxMqd+oIwd+5xDY7F5jYfH+xueYx+J3COMphmr94LGYVB4C6Shwz6POocIkLWxi
         e1+tVh6n7TTsPKqFHq4r0+EJ8xs+b4gWVnciQIB+adWzN6HounyjpSCRyRfeq7RNWt9P
         /nTt58sLIzqSecVQCs2wlG2vdZAftTnCbUQNv786OnlMX8BlGxp0EBu6mFjGH5vAoFmL
         e/Y5b3zAKh7CsdWsGZj4GWrOAPERWymbY3qRC1f24sNbmJlqUokVXb+VGeKjD8Lr2UDo
         Z50sExvN89haQq4flFNbgXvrXZoYkjceA7AhKfI+pg4ocFPV10fzvs4HKDeUcyHP7nFS
         SZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PViaeHG596lsKhDFy2h2Fs7+Z+afjotSfgIlxk34Cto=;
        b=NkDB0xbnaOLrJTrcOqL9Dy/x5wQj5XVaBMOW2m8uGHNbd2UJ33SFezGZdDAi6Xw9Pc
         q9a8l5GFqL1DhKrMqFObOYrBkdlhZG6Ce6MN5/AZJb22y9k5+LKQ7H9yzPzFp+tX2UJ7
         J7HxK337mBa3s2zDFtEQAo86Zlyqh2r1dIEYIKgLD1T4bDU00SFvBd4eC3Rw3aGNXDLC
         kbrU5cbEeSxAdrfHPGhY5+1D7rEp8ByZZyTwTLzdxHtLVIVWNdDrPK7uGvbbRAwNxmMa
         eiZhAYXQ1m3ZM28ILzU/tAiy2Qj7NHaM0U07o6fef6yHgswWiK8xoghszFl4IE5tA23k
         Y/Hw==
X-Gm-Message-State: ACrzQf0UVYKF9ylqfus7ZJnRVGFKpMTj41irlmNEWZl4XR6zsjmttOkK
        lMLy+GdBM5dLSbhihUOkNU6G1/gb+ZfRYJgkeg0=
X-Google-Smtp-Source: AMsMyM6vsEHqYRZAB+iAeOoT0JjnVOU44zpgU8oAxHP0C/rSJD0owP/6AdGfpX6gIXmevnYCzNvuFXzjrWr77zp9KWU=
X-Received: by 2002:a5b:803:0:b0:691:8cba:55bd with SMTP id
 x3-20020a5b0803000000b006918cba55bdmr2074345ybp.539.1665700198048; Thu, 13
 Oct 2022 15:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20221013214637.30782-1-palmer@rivosinc.com>
In-Reply-To: <20221013214637.30782-1-palmer@rivosinc.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 13 Oct 2022 15:29:46 -0700
Message-ID: <CAMo8BfLs7wJEyCAPW9FKyG=mFt+EGMiWMkof=QwPRYUSdonozw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: git://github -> https://github.com for czankel
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     chris@zankel.net, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Oct 13, 2022 at 2:49 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> Github deprecated the git:// links about a year ago, so let's move to
> the https:// URLs instead.
>
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> I've split these up by github username so folks can take them
> independently, as some of these repos have been renamed at github and
> thus need more than just a sed to fix them.
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 019cdb48e254..7c71b452a84d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20069,7 +20069,7 @@ M:      Chris Zankel <chris@zankel.net>
>  M:     Max Filippov <jcmvbkbc@gmail.com>
>  L:     linux-xtensa@linux-xtensa.org
>  S:     Maintained
> -T:     git git://github.com/czankel/xtensa-linux.git
> +T:     git https://github.com/czankel/xtensa-linux.git

This tree is outdated and hasn't been used for mainline pull requests
for the last 6 years. I'll send a patch that replaces that address with the
address of the git tree that I maintain.

-- 
Thanks.
-- Max
