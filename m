Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EC072E2A9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240655AbjFMMQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239161AbjFMMQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:16:56 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B4510CB;
        Tue, 13 Jun 2023 05:16:55 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f735259fa0so55717945e9.1;
        Tue, 13 Jun 2023 05:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686658613; x=1689250613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+FzLHkawDTmgf/nMvF5LHf5GXlbo6Jv406YOG07Vfck=;
        b=lvoTvQiicX7z+8+LT9Sf2J9hdSt+8BqjBCOSz/8McyOOtxsXoTuUdKMvUoOs+Cmv0n
         zm/onpH8krxOFB8XWQ3HqaJcdd3BdQ+SuDbZVja91hqObFerhNf4zizVkPIHFVU4X54o
         gsJ8hpoY2tvHlPnPJAhnsT+yLEI7tYLtDStEiMVcLoXDqDxw1ut8HkG6xIbUkoPHzcwN
         7L2VfCp9ABvhCjBLvlS186FRBsAzLZak+Wpuv+/2XEmisba+k29LhouhzyXbdwEjYYFY
         iH1txI19z1qnjySq+0QBWNHceO1MW5d43AsLHEfqorNGViDtujO7QxaYRyte4GYFOOtJ
         eVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686658613; x=1689250613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FzLHkawDTmgf/nMvF5LHf5GXlbo6Jv406YOG07Vfck=;
        b=ZwOwfRGrMsRaFAQ8YFh1sJWChTuE8PGxANB9WjwwyhOkitCaPLfPPBJCmy9wc/mylA
         BShjU/DlaMtdn0Kvseht0fihIWZLs/O6SI0npRrTMWpry3W0k+l3a2YHfGW+9R+szk1l
         oVnqJgc64nmXLB5C5BYb7pgOaJr5+MrJBsZVDlC5t1R7LyTBxgWfaHphurQb2fiy0LvH
         yfRnTEcy9Al1q+XqKpBQxkcCXiSgWcGHb+7d9HmFbUdp0Wdc+ilOyzVtMDQWzNI+7FYD
         JZ8SfhiqeKju+zbhlFr2U+reKydjFTBiA7UVrBaCESyVNy/KPpscZ5Cq3ejF/0xP9jG7
         SPEQ==
X-Gm-Message-State: AC+VfDwqUPPl6LzKBPiOwHmUJoSn7dN3gNG6hsO5rcnO/6IBcT+sFeP8
        rJgo3r3e+fXLEbSpXkO5A+w=
X-Google-Smtp-Source: ACHHUZ5OapvFYuTyAxuyCS9DWKf/UNbphhKlMU+zel3/Ljc1xgoTVB4XMMxeB/rqp0W01JWUGLvsRA==
X-Received: by 2002:a7b:cd19:0:b0:3f7:f90c:497f with SMTP id f25-20020a7bcd19000000b003f7f90c497fmr10066936wmj.25.1686658613371;
        Tue, 13 Jun 2023 05:16:53 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id x25-20020a05600c21d900b003f60faa4612sm14287529wmj.22.2023.06.13.05.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 05:16:53 -0700 (PDT)
Date:   Tue, 13 Jun 2023 13:16:51 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de
Subject: Re: [PATCH 6.3 000/160] 6.3.8-rc1 review
Message-ID: <ZIheMkhpQ+p9b4W3@debian>
References: <20230612101715.129581706@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
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

On Mon, Jun 12, 2023 at 12:25:32PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.8 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Build test (gcc version 12.2.1 20230511):
mips: 52 configs -> no failure
arm: 71 configs -> no failure
arm64: 3 configs -> no failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
csky allmodconfig -> no failure
powerpc allmodconfig -> no failure
riscv allmodconfig -> no failure
s390 allmodconfig -> no failure
xtensa allmodconfig -> no failure

Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]
arm64: Booted on rpi4b (4GB model). No regression. [2]
mips: Booted on ci20 board. No regression. [3]

[1]. https://openqa.qa.codethink.co.uk/tests/3923
[2]. https://openqa.qa.codethink.co.uk/tests/3925
[3]. https://openqa.qa.codethink.co.uk/tests/3924

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
