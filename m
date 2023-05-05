Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75ED6F7CDD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 08:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjEEGSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 02:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEEGR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 02:17:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7AFAD38
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 23:17:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 502C463B52
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 06:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EC9C433A7
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 06:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683267476;
        bh=s0Q8w+nZ3D0tRHQQ0NfVXIwOgzbtcIUS0LMXlLCVPlE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=o1qf7cQdVwokJTmvHOUCzh1Ufx8A7z0mfp+Syr2QumpBf+BULm85uYhxTrHFDWbUw
         VHQp29hxAkwn8iiQW296pvqPyqZbuNcBhcpfPaAxZb7yDHKs+ndks4eB8+cP4gCaAM
         MFShDD/D/Xj9dPRMCmJjGvxSDq6K13LipD8RWK6/cXu0pb568dq+wMNmKChbW9yX3r
         vyIlzRvG3drFvnfcqMPFXawsh9RprNsAXAd2E7i9RPfuiEl15oWMA/QEMk3LUqwgrx
         Wymj7LusMUXonXZaeJowV759+ZK2g9f9r1QO9iTi/oLalolYF5XP0NFYppPRbx/5hk
         6cejNlJw0FSbQ==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-192cfb46e75so606908fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 23:17:56 -0700 (PDT)
X-Gm-Message-State: AC+VfDwh68avzxed065GHzJHya5vkjXvktB4MUgQ4SGqe+Hi8pIw5iog
        3qydyAC8VO9WhWf4bj5Pw6DBaUpDlwa/C/RempY=
X-Google-Smtp-Source: ACHHUZ59xiLH2jDPQ4tx28+0BYl225DfqBgHqfgxYWhngZ+AuyTuVMNt1mq8TJ8mpHQ1QQBrGJ2S0bdPvmhDKfVC170=
X-Received: by 2002:a05:6870:5141:b0:176:4c90:a172 with SMTP id
 z1-20020a056870514100b001764c90a172mr295547oak.56.1683267475770; Thu, 04 May
 2023 23:17:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:7858:0:b0:4d3:d9bf:b562 with HTTP; Thu, 4 May 2023
 23:17:55 -0700 (PDT)
In-Reply-To: <20230503140609.e65bdc2b0e55ba6f49bbb620@linux-foundation.org>
References: <20230407194433.25659-1-listdansp@mail.ru> <ZFHgAhisxjKQxhLx@debian.me>
 <20230503140609.e65bdc2b0e55ba6f49bbb620@linux-foundation.org>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 5 May 2023 15:17:55 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9R4g2MZGKw5ugUcjf-3OXkngNjNgZcHsysR659YCUBDw@mail.gmail.com>
Message-ID: <CAKYAXd9R4g2MZGKw5ugUcjf-3OXkngNjNgZcHsysR659YCUBDw@mail.gmail.com>
Subject: Re: ntfs orphan? (was Re: [PATCH] ntfs: do not dereference a null ctx
 on error)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Danila Chernetsov <listdansp@mail.ru>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org,
        Linux Memory Management <linux-mm@kvack.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-05-04 6:06 GMT+09:00, Andrew Morton <akpm@linux-foundation.org>:
> On Wed, 3 May 2023 11:16:02 +0700 Bagas Sanjaya <bagasdotme@gmail.com>
> wrote:
>
>> On Fri, Apr 07, 2023 at 07:44:33PM +0000, Danila Chernetsov wrote:
>> > In ntfs_mft_data_extend_allocation_nolock(), if an error condition
>> > occurs
>> > prior to 'ctx' being set to a non-NULL value, avoid dereferencing the
>> > NULL
>> > 'ctx' pointer in error handling.
>> >
>> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Duplicate of 10-years-old outstanding patch at [1].
>
> Well, the patches are actually quite different.  Is Danila's longer one
> better?
Danila's patch is better than old one. old patch doesn't free
allocated cluster in error handling. And Christian will apply this to
his queue if you drop this patch.
>
>> I'm not speaking of the patch itself but rather on unfortunate state
>> of ntfs subsystem. It seems like the maintainer is MIA (has not
>> responding to patch submissions for a long time). Some trivial
>> patches, however, are merged through mm tree.
>>
>> Konstantin (from newer ntfs3 subsystem), Andrew, would you like to take a
>> look on this orphaned subsystem (and help reviewing)? I'd like to send
>> MAINTAINERS update if it turns out to be the case.
>>
>
> Sure, I can join linux-ntfs-dev@lists.sourceforge.net and hendle things
> which come along.
>
> Or Christian may want to do that?
>
>>
>> [1]:
>> https://lore.kernel.org/all/1358389709-20561-1-git-send-email-nickolai@csail.mit.edu/
>
>
>
