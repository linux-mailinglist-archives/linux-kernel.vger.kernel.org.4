Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE2470EA86
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 03:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238876AbjEXBEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 21:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjEXBEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 21:04:39 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E584690;
        Tue, 23 May 2023 18:04:38 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ae763f9a94so2411055ad.3;
        Tue, 23 May 2023 18:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684890278; x=1687482278;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OzZVabn94Qo+JPdAJzezydyiyAk6ZjBVePuUSxCh+Zs=;
        b=GdsvgV+y0XaDqL6AoD1lBikuoMv3nGdeRs/AmYvF9MUYzGwsdaEOGtMLYQ9dAOhfSG
         cFkYHt2gHxGj7YwsegCe5hCW1+0ur5ljdwufbd8mPfDFgJJ9FUAa4ffxZ27eRKLvpcs1
         yuD8SwtJ1glRDS8XM3oIpIjToq847oDAjpn3fQTA7Ofgltbyn1+LRsQTJunqw8ct4IK9
         eKdQBJXuZU9koLJIjQxLzCz+nigWuniY+QuWAaL9tC8R/QDsG0uevSFNIgli04WcRQjD
         BQyjvUTPL0ra3DZMyVXdoELfhmTmeFIelpR5yL8jmMmbUA9p15c3DQmJDgkNHrOMpJt1
         9aug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684890278; x=1687482278;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OzZVabn94Qo+JPdAJzezydyiyAk6ZjBVePuUSxCh+Zs=;
        b=dg9fN5dPHiNq7y2EQuz8mHWdC70rqwWi+z62mSRAImWwEjcl8Vl0AJp2bAhqn/0fLZ
         fCzQn4uFjPqCKhc7x966EzCtR861GPD1m/cVEULOSZw7+1Wfr3nxKuTtAahslgGRLQfU
         GUkvtMsoLws8hse9Ij1l0igo3d8INn+eFvFeRrL4G88792oy75xk3xbWSR41x29Fy4yc
         pyrXyJCu/ADawsU9oD0M8ivD+ovD735hhIB6lg/rOijgNqxZyrqHA6/z3YRtTbqr9H8q
         Zro8+363sndelPUPxIgyXCI5sv1OF7gf8wpDipCBQEdbl07Mfg0lTnABoYc+JXqiKh1l
         knPQ==
X-Gm-Message-State: AC+VfDx2PoYCUj+2vp0xrMMSE3MHyfDo9BgZm9Y7P5OKvQVwg9d37etm
        tlFO/Z11PuS7tdMPBGHusPg=
X-Google-Smtp-Source: ACHHUZ7b+XEFH0hw6KI8jiMOFwjJFYyS3Kl9WWlso2xpOg9wIRguC7Dy0eeDyhlGMlKWFPuJEg0AnA==
X-Received: by 2002:a17:902:b618:b0:1ad:e633:ee96 with SMTP id b24-20020a170902b61800b001ade633ee96mr12537155pls.55.1684890278289;
        Tue, 23 May 2023 18:04:38 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-87.three.co.id. [180.214.233.87])
        by smtp.gmail.com with ESMTPSA id iw10-20020a170903044a00b001ac2f98e953sm7352757plb.216.2023.05.23.18.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 18:04:37 -0700 (PDT)
Message-ID: <5ae1485d-4006-8b0a-7081-efadd96aa752@gmail.com>
Date:   Wed, 24 May 2023 08:04:32 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/2] fs: udf: udftime: Replace LGPL boilerplate with
 SPDX identifier
Content-Language: en-US
To:     J Lovejoy <opensource@jilayne.com>,
        Linux SPDX Licenses <linux-spdx@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Actions <linux-actions@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Cc:     Jan Kara <jack@suse.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Diederik de Haas <didi.debian@cknow.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Eggert <eggert@twinsun.com>,
        Richard Fontana <rfontana@redhat.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
References: <20230522005434.22133-1-bagasdotme@gmail.com>
 <20230522005434.22133-3-bagasdotme@gmail.com>
 <6f2e13c1-6d99-f9a5-057c-e127efc69457@jilayne.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <6f2e13c1-6d99-f9a5-057c-e127efc69457@jilayne.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/23 00:56, J Lovejoy wrote:
> 
> 
> On 5/21/23 6:54 PM, Bagas Sanjaya wrote:
>> Replace license boilerplate in udftime.c with SPDX identifier for
>> LGPL-2.0.
>>
>> Cc: Paul Eggert <eggert@twinsun.com>
>> Cc: Richard Fontana <rfontana@redhat.com>
>> Cc: Pali Rohár <pali@kernel.org>
>> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>> ---
>>   fs/udf/udftime.c | 18 ++----------------
>>   1 file changed, 2 insertions(+), 16 deletions(-)
>>
>> diff --git a/fs/udf/udftime.c b/fs/udf/udftime.c
>> index fce4ad976c8c29..758163af39c262 100644
>> --- a/fs/udf/udftime.c
>> +++ b/fs/udf/udftime.c
>> @@ -1,21 +1,7 @@
>> +// SPDX-License-Identifier: LGPL-2.0+
>>   /* Copyright (C) 1993, 1994, 1995, 1996, 1997 Free Software Foundation, Inc.
>>      This file is part of the GNU C Library.
>> -   Contributed by Paul Eggert (eggert@twinsun.com).
>> -
>> -   The GNU C Library is free software; you can redistribute it and/or
>> -   modify it under the terms of the GNU Library General Public License as
>> -   published by the Free Software Foundation; either version 2 of the
>> -   License, or (at your option) any later version.
>> -
>> -   The GNU C Library is distributed in the hope that it will be useful,
>> -   but WITHOUT ANY WARRANTY; without even the implied warranty of
>> -   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> -   Library General Public License for more details.
>> -
>> -   You should have received a copy of the GNU Library General Public
>> -   License along with the GNU C Library; see the file COPYING.LIB.  If not,
>> -   write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
>> -   Boston, MA 02111-1307, USA.  */
>> +   Contributed by Paul Eggert (eggert@twinsun.com). */
>>     /*
>>    * dgb 10/02/98: ripped this from glibc source to help convert timestamps
> Reviewed-by: Jilayne Lovejoy opensource@jilayne.com

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara

