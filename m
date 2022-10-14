Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CB65FE7BF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJNDva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJNDvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:51:19 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09844196B5B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:51:18 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y8so3739417pfp.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gessz9Lw9WUV8icSRgAP1AqoQqTWoQ7XuEFzNjGtaYQ=;
        b=DITmBQLna2ECC4Ct3cSzAXZ8DN05u/+B2BjOtCLhuyT2RvRDB7qysIRQq2NoV2O7Dv
         +hWDqCa+Cu45Zel25N6jPCAAc1CJPfFRUM6tCDzHHYZy9H/J+9vc/VTkIhLmzjYCygxg
         BskNs05xQYtedY3yneY9vm5H7TiJ/siwAe9KaPqEDM1zlRGJQSWD1rYbwzqi6bae88Hm
         DxBCUDMjdmtZ9IBDtNuVihSg1//s1ZL9X1wxUBIVn1kxVXW3thM5X24yZOoQPaY9C/0K
         sZ4J3AMH4fJDRZQze0ORWBL2QjOYSRKlCkrjFQeN3yG+ZwooqP0SoqdDe1CD3WRnfCYU
         CbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gessz9Lw9WUV8icSRgAP1AqoQqTWoQ7XuEFzNjGtaYQ=;
        b=x2KPur6iW2+H7W1nAXYO0Wh9Rt8/t2XIeiDykgcGbzwelStHz4L4X3yckEyOeA6WGc
         NlCKIPwC6ZH3qDhDpRUSeS9X24DFSnsX4VkyXM4XRWTujLZYMiU1FH8yKGJnGLGwpxId
         yJkInVfj/KQtLT3NJUtUGu2inYaKwM261sbbO/r2Qz4AcnLqnoZ7qns+291Vf5T35KyS
         Z6HG55E5aA4Xfi8AMNIS0ydAtjd2JncGsDtM3hR2kMaACSesF+4qM8CuTs/2TRwtnBNT
         iTn5uAPp28EADvx5kDnX3tCFM6jeqzYu0hx9WfZydPw/eGMwmshG5Gj8aC6+YUEZaFCJ
         rHAA==
X-Gm-Message-State: ACrzQf3jiFJRupi1xxOKaQbOtuaEd+EDAbx0bkppwJrdi6dAVoLBWbf1
        XWn86saD3ryn65fPEZXAfNkubw==
X-Google-Smtp-Source: AMsMyM4blGhOMbMFQpTJIBO2cyrf91uwWLI0pvOkbWu+8zpbRpLyaFGjHI4728iuaLdBuy6MYwUDoQ==
X-Received: by 2002:a63:5144:0:b0:43b:ed4b:224 with SMTP id r4-20020a635144000000b0043bed4b0224mr2827934pgl.594.1665719477111;
        Thu, 13 Oct 2022 20:51:17 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id s16-20020a17090a1c1000b0020a81cf4a9asm3984850pjs.14.2022.10.13.20.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 20:51:16 -0700 (PDT)
Date:   Thu, 13 Oct 2022 20:51:16 -0700 (PDT)
X-Google-Original-Date: Thu, 13 Oct 2022 20:05:39 PDT (-0700)
Subject:     Re: [PATCH] MAINTAINERS: git://github -> https://github.com for czankel
In-Reply-To: <CAMo8BfLs7wJEyCAPW9FKyG=mFt+EGMiWMkof=QwPRYUSdonozw@mail.gmail.com>
CC:     chris@zankel.net, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     jcmvbkbc@gmail.com
Message-ID: <mhng-894b3900-e983-4278-b7ec-1c0512a25dbc@palmer-ri-x1c9a>
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

On Thu, 13 Oct 2022 15:29:46 PDT (-0700), jcmvbkbc@gmail.com wrote:
> Hello,
>
> On Thu, Oct 13, 2022 at 2:49 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
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
>> index 019cdb48e254..7c71b452a84d 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -20069,7 +20069,7 @@ M:      Chris Zankel <chris@zankel.net>
>>  M:     Max Filippov <jcmvbkbc@gmail.com>
>>  L:     linux-xtensa@linux-xtensa.org
>>  S:     Maintained
>> -T:     git git://github.com/czankel/xtensa-linux.git
>> +T:     git https://github.com/czankel/xtensa-linux.git
>
> This tree is outdated and hasn't been used for mainline pull requests
> for the last 6 years. I'll send a patch that replaces that address with the
> address of the git tree that I maintain.

Thanks, I'll toss this one.
