Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093FE6C4115
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 04:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjCVDfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 23:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCVDfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 23:35:09 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0795F580F7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 20:35:08 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id x37so9817318pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 20:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679456107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dx2oz/Ki5X7I0WTDnufq5DCTmmhHb9+OLy4uaVLBV+I=;
        b=Jho7N4CwWsCHlK+B1/ayWoikCtFvGp8L7k5Qn8uXX53s/S/E75b1YCALWDh/KVIXbp
         e++vdzDwtbvInuOgENQoFrW4ilm3M2GDec3HPWBfQ3M+7gc0uhMfRWRY8TENjib7Go71
         59qSdQRwSPNjYC1/BgQ9EZdgzzsu0N7CPuFDLfheEHzdwPHzGlyYPTJSz4kHo3UFC0Z2
         dSS7iXEmtoHP4rPGchUOa1O2PXIPukcajqruwM47+YLnC0opMqTJH87UUvMhfkN8xplu
         TJVqbhm168mf703ds2fu3zO3LR4kuhs2LYTUfRCGhkXK5BQRYmbzTEPRWAHWdf4sUL5o
         iSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679456107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dx2oz/Ki5X7I0WTDnufq5DCTmmhHb9+OLy4uaVLBV+I=;
        b=gYipkHJ+0RpmfFwjXyCxdkuOqgm0m4cE2Tb292jx7GF1rpPb5790Jc/qzn7C4rn1t0
         LWd2Rj/Bl5hL5yVE7DfK7XyWMHbylll1kKBG2ykNEe091LuD9uT5sTRbp/+iONitastv
         7b2xaQuHdw/5C88dR5GrdYmhWXP/s5J2sdM1I900sgM34bFb7cKf9qiuPuDMa2GKd4o6
         gFP0LQcauGS7ML8gWU1TOi7HKrmHTb4e8om43n3dRItrniDVtMwFuftpKeTBcWuguqY1
         dVGYtTOO7+gvitJqBCBcgWOV6wsNaF8VAZxYsJiskn0We1WTV5DnclWPlvucDwRQM1L0
         B8wg==
X-Gm-Message-State: AO0yUKWQLIJVpQ3ClKc8M9J8YQWs2X19rq21e37qwzDvgUeIKoOTXAYF
        eLK6dWP2II7KFI7h7/ZvdPXjMNS8EeTHVw==
X-Google-Smtp-Source: AK7set9h7/+c61OH6J9Nr6+261+D605Q0BFw+6BkYl0oGnG0qD1CbrD2Y4q1x7nT646tffnoFXhZnw==
X-Received: by 2002:a62:4e8b:0:b0:627:df78:3b22 with SMTP id c133-20020a624e8b000000b00627df783b22mr1868620pfb.0.1679456107203;
        Tue, 21 Mar 2023 20:35:07 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-30.three.co.id. [180.214.232.30])
        by smtp.gmail.com with ESMTPSA id d1-20020aa78141000000b0062608a7557fsm9005331pfn.75.2023.03.21.20.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 20:35:06 -0700 (PDT)
Message-ID: <1a2278c5-5398-2e7a-344d-fd5dd9703b10@gmail.com>
Date:   Wed, 22 Mar 2023 10:35:04 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] scripts/package: add back 'version' for builddeb
To:     David Wang <00107082@163.com>
Cc:     linux-kernel@vger.kernel.org, masahiroy@kernel.org
References: <20230320110819.23668-1-00107082@163.com>
 <a05cfc82-a9e9-ea96-aaca-612ff9c14219@gmail.com>
 <3ee67285.5853.18704c2158c.Coremail.00107082@163.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <3ee67285.5853.18704c2158c.Coremail.00107082@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/23 22:20, David Wang wrote:
> 
>>
>> Again, your patch looks like corrupted (tabs converted to spaces).
>> Please resubmit; this time; generate the patch via git-format-patch(1)
>> and then send the resulting patch with git-send-email(1).
>>
>> Thanks.
>>
> I did use `git format-patch` and `git send-email`, but I did not run scripts/checkpatch.pl.
> Now when I run scripts/checkpatch.pl against the file generated by `git format-patch`, it shows a warning about "Fixes:" tag, and
> I have resend a patch which pass the checks of scripts/checkpatch.pl, hope this time it could be ok.
> 
> ```
> $ scripts/checkpatch.pl 0001-scripts-package-add-back-version-for-builddeb.patch
> total: 0 errors, 0 warnings, 7 lines checked
> 
> 0001-scripts-package-add-back-version-for-builddeb.patch has no obvious style problems and is ready for submission.
> ```
> 
> 
> David

OK, but there is already the similar fix submitted at [1]. Please test it.

Thanks anyway.

[1]: https://lore.kernel.org/linux-kbuild/3351f907cfd0b5d8372e858a8ec9065cc2bd91df.1679434718.git.kevin@kevinlocke.name/

-- 
An old man doll... just what I always wanted! - Clara

