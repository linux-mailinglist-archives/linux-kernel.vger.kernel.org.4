Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429115FE7BE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiJNDvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiJNDvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:51:17 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40238196B44
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:51:16 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id e129so3260632pgc.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aVCyBiCZDn5HkUxGUrbOX8V30hdrNq+pu/fmdZO+DQs=;
        b=HYlxMKmQBMJ9fQa4DX257S7pyPvD4niaVRVid6SVUtghjyhVqc8WffD4/S5xaeixP7
         xwHkyg/KF4sYlgaAl8BcdmuY0ZYKKkEOaPizXkgCZHsEhZFYqg8KwJjUXVMeqHpGCeGn
         qITgM9WLwMwaKCWxp+Fn9qj/NHW1gNB9COrXkTn5M4tPqI3a0ND+f+iUwA530eNfJSc9
         7nsOdQcD8oeimSZGP/PyHDJFVAokfMYb2noeuu5NWV/23LRhgGapuY7XRBK1LCZBitFr
         LiqRzWKeqdRUAcyzr99Mn0vMb9dnaZuK9PnUQOkPJ60FvM92tOqO8mC/Icibc+rSxTpP
         UaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVCyBiCZDn5HkUxGUrbOX8V30hdrNq+pu/fmdZO+DQs=;
        b=ZaxZw+BYmPM4XrymTnQrCJxq2BY+P27UGn8PI+7h1dj3kNiVvK55mwQJNREtRzy8R4
         dXAEvrNHqPD+9mC2WXHq9nM4yrdL6rUboezpzHfMFeUFOrhFSaYh/13Gwchh6ULVVEfj
         IKd4z/dtFpBjlvWDlXo+SHDItFpDR484aamm1G5IymhUZYyoZkdxVLZJdA75/LTIZiWR
         YXl2fKqb6E/ClnG6g8IZ9L9bF9a9mlvBXELMJg9l0QpO9qe/wnlH8CYGdQ9FXzX0QZnv
         lPMPJtqZnS3JkOfvIV/m7JdHhHScYGxE4xOkiVj3KGSTzcSs8dDjjP0VcgYOEHPkDOmW
         nBKg==
X-Gm-Message-State: ACrzQf04/IWikpZZqx9hQ/fx/Uq6X7uF3Mwha1MVEWHAUm335JPqRsv8
        8kPN9IJFZggmR7sKXlvh5FCdEg==
X-Google-Smtp-Source: AMsMyM6Y0+7i6TkCO2N10Y3MJBF+2t9Jcy2YiUF6UBoHedlFmXGOnANBBOw2nEyrpT+dnGwWj8Gm6w==
X-Received: by 2002:a05:6a00:b84:b0:565:caea:38bc with SMTP id g4-20020a056a000b8400b00565caea38bcmr2978288pfj.80.1665719475513;
        Thu, 13 Oct 2022 20:51:15 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id e63-20020a621e42000000b00565cbad9616sm492123pfe.6.2022.10.13.20.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 20:51:14 -0700 (PDT)
Date:   Thu, 13 Oct 2022 20:51:14 -0700 (PDT)
X-Google-Original-Date: Thu, 13 Oct 2022 20:05:01 PDT (-0700)
Subject:     Re: [PATCH] MAINTAINERS: git://github -> https://github.com for cschaufler
In-Reply-To: <CAHC9VhTPt40PFC5NASOjOK+fqJym5JOyb8UrwAL7DGDQWqVwqA@mail.gmail.com>
CC:     casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     paul@paul-moore.com
Message-ID: <mhng-3a781b98-6c44-4ae5-bf58-75cb4eeb2dd0@palmer-ri-x1c9a>
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

On Thu, 13 Oct 2022 14:54:00 PDT (-0700), paul@paul-moore.com wrote:
> On Thu, Oct 13, 2022 at 5:49 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
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
>
> Casey is the one who needs to ACK this (and he has an email delay at
> the moment), but the URL looks good to me.

No worries, I'm in no rush to merge this.  Conor just pointed out the 
RISC-V KVM URL having this issue so I scripted a patch for everyone.   
Feel free to just take it through your tree if you want, otherwise I'll 
keep it around locally and hopefully remember to send something once 
it's Ack'd.

Just note that "MAINTAINERS: git://github -> https://github.com for" was 
a scripting mistake, it should probably be "MAINTAINERS: 
git://github.com -> https://github.com".  If I have to re-spin this I'll 
fix it, but if someone else is taking it then it's probably best to 
fixup.

> Reviewed-by: Paul Moore <paul@paul-moore.com>
>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index daadd0de77a9..019cdb48e254 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -18723,7 +18723,7 @@ M:      Casey Schaufler <casey@schaufler-ca.com>
>>  L:     linux-security-module@vger.kernel.org
>>  S:     Maintained
>>  W:     http://schaufler-ca.com
>> -T:     git git://github.com/cschaufler/smack-next
>> +T:     git https://github.com/cschaufler/smack-next
>>  F:     Documentation/admin-guide/LSM/Smack.rst
>>  F:     security/smack/
>>
>> --
>> 2.38.0
