Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DFE5FE7C1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiJNDvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiJNDvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:51:20 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132D919B647
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:51:19 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 70so3774105pjo.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xj6EA9Cf8G1V5kTfX084ZFL0HswwaRXsbxfz8fvUzdM=;
        b=EmENXU//I1HHcNUunkI3Nuy/Lst7i/3szR10j2QqD9QUaz/zaxjc6gMJPzkEvRVSXz
         RvEx64dqOngIB0pCZGpVsYdGLkNngiqc/dU6a+AuL5mseSoG8zQad2HS7ZLB3TJ5+v6K
         2pSOaNfvKHEI/b02Yiaj++xzqAJ3C/teg8I2g76lxRiTVjupi42/SBVYnPHlW80gtDIS
         yK4jKf7x9bY5aLFABs8AeC1mOqhcHA9qWCB3nF4irs+2HRsAGQmWQYu882I9IN6swonx
         qxhdWDU8P+9WlnGEBWMHWMNQEKLsNlJRT18Nl/QiYe9vnZ7tnvXiXVtr3pnhtshA3+Jx
         o5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xj6EA9Cf8G1V5kTfX084ZFL0HswwaRXsbxfz8fvUzdM=;
        b=iEQCJmQx94oW0wPGq3lRiKB19ylsXX+PShCvg7740PpQ0/lFu3Jg173Lbe4OwVnDQO
         mtC0B19hg0wM/J/brYiedc+9hO0ATNiHvfKQwmsmkMqD8x9TLmps7DBxzs5J5hEmIhgj
         iBw4aVVkiPNXnSYIIGCBd6K4mFa1/T8BAmFdQA950sU1moCsEH8iiVyL8R64TkjctDY0
         JYibixbzi70q5EVThzDz6Zd6tqXWN1hZEZDPr/CFg/g5Q0bI5HIVH5SfM6paPtYop4xF
         7ybBL7TfZ9Ckr5g2eLqx0FdEMMOI5jmaSNT9xOSAoeHCs+spBv4b5E+8wdxgJ4NNEEx8
         LzfA==
X-Gm-Message-State: ACrzQf0YcZ+PZZWdsztwG1uNTvwFn9J18qCKDVSyzLDjdcEI0EosNl2g
        aYPmHjFQdTHD7PReSKqVE9Ux4g==
X-Google-Smtp-Source: AMsMyM7s1sOslKip/dGdE56XK5d5Er1ShADXOLTKQTQv/dZlQDAoBr9sXyrrJYNVJzE2BSCrTkdTSQ==
X-Received: by 2002:a17:90a:86c6:b0:20b:dba4:758a with SMTP id y6-20020a17090a86c600b0020bdba4758amr3424553pjv.71.1665719478458;
        Thu, 13 Oct 2022 20:51:18 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id e24-20020a656798000000b00454f8a8cc24sm464642pgr.12.2022.10.13.20.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 20:51:17 -0700 (PDT)
Date:   Thu, 13 Oct 2022 20:51:17 -0700 (PDT)
X-Google-Original-Date: Thu, 13 Oct 2022 20:07:05 PDT (-0700)
Subject:     Re: [PATCH] MAINTAINERS: git://github -> https://github.com for konis
In-Reply-To: <CAKFNMonU3aVqwRdxyFefBJMg0-XC9j8bE-qYZ-9xx-4--NdkGg@mail.gmail.com>
CC:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     konishi.ryusuke@gmail.com
Message-ID: <mhng-1ec448c6-70ad-4964-9dd0-032892bfb2ef@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Oct 2022 16:06:43 PDT (-0700), konishi.ryusuke@gmail.com wrote:
> On Fri, Oct 14, 2022 at 6:49 AM Palmer Dabbelt wrote:
>>
>> Github deprecated the git:// links about a year ago, so let's move to
>> the https:// URLs instead.
>>
>> Reported-by: Conor Dooley <conor.dooley@microchip.com>
>> Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>> ---
>> I've split these up by github username so folks can take them
>> independently, as some of these repos have been renamed at github and
>> thus need more than just a sed to fix them.
>> ---
>>  MAINTAINERS | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d118acdce8b8..c9c396e2d8a0 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -14363,7 +14363,7 @@ L:      linux-nilfs@vger.kernel.org
>>  S:     Supported
>>  W:     https://nilfs.sourceforge.io/
>>  W:     https://nilfs.osdn.jp/
>> -T:     git git://github.com/konis/nilfs2.git
>> +T:     git https://github.com/konis/nilfs2.git
>>  F:     Documentation/filesystems/nilfs2.rst
>>  F:     fs/nilfs2/
>>  F:     include/trace/events/nilfs2.h
>> --
>> 2.38.0
>>
>
> Ah, that's right, it needs to be fixed.
>
> I'll pick this up unless it's decided to apply similar fixes all at once.
> Thank you.

It's easier on my end if you just pick it up.  Just note the 
"git://github -> https://github.com" typo.  I can send a v2 if you want, 
but IMO it's trival enough to just fix up.

Thanks!

>
> Ryusuke Konishi
