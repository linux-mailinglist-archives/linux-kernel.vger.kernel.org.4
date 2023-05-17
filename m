Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5874F7062CC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjEQI12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjEQI1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:27:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7215C49EF
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:27:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EBD8643A4
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36E6C433A4
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684312020;
        bh=/VFfL2QbJ6k3VJGcWXoGQEaNMxXHPIHmIVTKIHJFJBo=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=oSCxm6sh/98I8Ox04VmmDDnilXcPcRMYh6yJ9qIuyLsWjQETjKV/2tX8zdPFulsF5
         z6EKAZ07VqvTVeqRfpnqqL2CwOCvijrT5vbtqIpcIHv68QOlZnBHabPf9gEJACQESL
         WqCeMK2g+VBxzzXfgLmlVUqV+PA40aNTJ56sggpJJH4bXPRaMhRaIz3hOKVzMqwKTb
         AD4VJGmlepH1dlPqnjHV1hZP7SQb/GdHaGJDvvgy8jhHbGhKD/YVV2OrY6RXW30jLo
         wWEca4DOvypVXBpjpxM6LQhK716xuN19c0TLJpG1GTon2lIgeDxmwL+Wl0XNv86O3u
         Rg1yzYw8y0gWg==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-19a19778b09so93559fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:27:00 -0700 (PDT)
X-Gm-Message-State: AC+VfDxwvg/wuvr0j3450fKPpVM+aZ3nxtLS15WTJUXiV2T4fS1rTb+8
        U69PuAUl4ETuyy/v+3s5oDJLRCku7V5uaehLMsU=
X-Google-Smtp-Source: ACHHUZ7N9/reC7wmuhF51pRnT9mEKyzQMTd0GpRUzXVd1EUiUPAn5uqg7uY9TVh9SqyXXxv+pftvSsYwMAWxuN8bJHg=
X-Received: by 2002:a05:6871:395:b0:195:e56f:ced2 with SMTP id
 z21-20020a056871039500b00195e56fced2mr15848513oaf.38.1684312019977; Wed, 17
 May 2023 01:26:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:290:0:b0:4da:311c:525d with HTTP; Wed, 17 May 2023
 01:26:59 -0700 (PDT)
In-Reply-To: <4125c148-a4f4-edd2-3009-0283246f8a95@gmail.com>
References: <20230517070739.6505-1-linkinjeon@kernel.org> <4125c148-a4f4-edd2-3009-0283246f8a95@gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed, 17 May 2023 17:26:59 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_=kXjKnmfiSEuTLG0fd6Ezj+7_R_ZSWntbvUgQ9Hyx0w@mail.gmail.com>
Message-ID: <CAKYAXd_=kXjKnmfiSEuTLG0fd6Ezj+7_R_ZSWntbvUgQ9Hyx0w@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: Add myself as a reviewer
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     brauner@kernel.org, anton@tuxera.com,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-05-17 16:37 GMT+09:00, Bagas Sanjaya <bagasdotme@gmail.com>:
> On 5/17/23 14:07, Namjae Jeon wrote:
>> I'm volunteering to help review patches for current unmaintained
>> ntfs filesytem.
>>
>> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index e2fd64c2ebdc..c2cecb2059d7 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -14928,6 +14928,7 @@ F:	drivers/ntb/hw/intel/
>>
>>  NTFS FILESYSTEM
>>  M:	Anton Altaparmakov <anton@tuxera.com>
>> +R:	Namjae Jeon <linkinjeon@kernel.org>
>>  L:	linux-ntfs-dev@lists.sourceforge.net
>>  S:	Supported
>>  W:	http://www.tuxera.com/
>
> Acked-by: Bagas Sanjaya <bagasdotme@gmail.com>
Thanks for your ack!
>
> Anyway, what about also adding linux-mm list so that akpm can
> pick patches?
Hm.. I think that MM folks probably don't like to see fs patches on mm list...
And as far as I know, Christian is going to picks up the ntfs patches.
Christian, right?
>
> --
> An old man doll... just what I always wanted! - Clara
>
>
