Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADDF72E289
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238790AbjFMMME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbjFMMMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:12:02 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87978C7;
        Tue, 13 Jun 2023 05:12:00 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f8c5d0b216so6257805e9.1;
        Tue, 13 Jun 2023 05:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686658319; x=1689250319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JiZLKGxx/obOBwfx5ZXrNlXAMV40xGv31BFdtweV1Dw=;
        b=GKgafrdBUG7C7YWkzxxj0bfx+26A+gq8hhshr+iogR9KUA9fZIxbtol8Qll6nLXPrT
         y/zUPy/8ekuVc4Z5Aox2JGowpzPqZbf0HrjmytQ/2Y76/nbA25nxY2LIypA7utQNYI5e
         8hgRw/5NGZNLfo16K/+JKN9nDULJIagFQri0sNuFeLU3OE0xddVoeItOC9eqA6Kf+8Wy
         QuLzVpLUUnNy4/eSQR+pNHeg3RCI9QDJ3Ef/6btiZgX5uo2fFsqzZeq71O7W8F+mTX8B
         XLYUKXOnD3AdfNtihfs+J97y8CWF/+XJn5MX2pvFboZwBkE7lIb1tvTTjGhQOZYyIJya
         qwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686658319; x=1689250319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiZLKGxx/obOBwfx5ZXrNlXAMV40xGv31BFdtweV1Dw=;
        b=NI/4ixm2wRxAkA3cpzhxFb95ogEIzZVdp0r3uKAQZBx0OxPZLgl2NnHJs8hnpoqw2z
         YR3ilkh64OsdZqILjwzSkcyIwgvM9Eu2zzF0r8pyoTn3+tdofI0Ef+IWHWUtSM1h6Za3
         fwf5UtzqvnsFkkZHdQvvryvwEmwKxAQZEDKxzMKSIsJLjhSFJX8i05SjEivbO77kuH2h
         +PsvuZsV5v2uKkrfu6DRI9pnQVqIexK29Moz6JxmF2D8JyB0fNtFnAlGKV5irkK7QYHP
         ZFbae0vOODsk4W++fjt4hUViWD1CWHAzp6YhaUGJLsa8DN1U6vmu1Z5ZvDjquwVfkEVS
         08Mw==
X-Gm-Message-State: AC+VfDxBBSns4hfJ8yXlOxaBIWVRI1qqQ+KVzU3atkYefbbgr53Juaet
        RBX0DBephqoFl5DYi7Ya+avUIzERnq0=
X-Google-Smtp-Source: ACHHUZ7GJhRdshkb1048wUmGAGhogLKcFmKEWoBC5TuAQNknuGpMyneSA6A8ru3RRnMPYhRfxciyxw==
X-Received: by 2002:a05:6000:4e1:b0:30a:d459:8f72 with SMTP id cr1-20020a05600004e100b0030ad4598f72mr5783874wrb.60.1686658318731;
        Tue, 13 Jun 2023 05:11:58 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id e16-20020adffc50000000b0030fbb834074sm7486868wrs.15.2023.06.13.05.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 05:11:58 -0700 (PDT)
Date:   Tue, 13 Jun 2023 13:11:56 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de
Subject: Re: [PATCH 4.19 00/23] 4.19.286-rc1 review
Message-ID: <ZIhdDNHSoA232PLZ@debian>
References: <20230612101651.138592130@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612101651.138592130@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Jun 12, 2023 at 12:26:01PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.286 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Build test (gcc version 11.3.1 20230511):
mips: 63 configs -> no  failure
arm: 115 configs -> no failure
arm64: 2 configs -> no failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
powerpc allmodconfig -> no failure
riscv allmodconfig -> no failure
s390 allmodconfig -> no failure
xtensa allmodconfig -> no failure

Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]

[1]. https://openqa.qa.codethink.co.uk/tests/3909


Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
