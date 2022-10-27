Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6B460F054
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbiJ0Gcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbiJ0Gcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:32:36 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B41B166984
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 23:31:50 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id f8so224105qkg.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 23:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=egO0y1RoX0VqsW2hz8lRzfuDL2LVRUGSLUN9El9Nax4=;
        b=VXBbUDSo4OwR3rlKuDxsXx+Y85pri5bcV+gDbh5Y1onvbhpGIvDoJfKn5Y7vS3GchV
         8gZP0OU5cB/Qdxlzqu3ATR4/mxON7QATa7KaIKATuoRAoiRMon1B7nwSHvL7mEaXhVSA
         BTRnlmA9TK74jXcEfqlFx2yZ3hNCoH3ialktsOatFg1C2pzZotaZG6NnN5xZVvs4hQtC
         6MmExybjk6dcZpbWJdbOGAuYdpli0PJFfyZk+j7fmOpSAzNuFWd3564nwBm9fpTVMdB/
         9yY+126vs0JIrIdyMDaoU+zDHiGKxz9tpX0rNE7+6KVyEzi21RRlJHCAipnsW5Pp7sbf
         8a8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=egO0y1RoX0VqsW2hz8lRzfuDL2LVRUGSLUN9El9Nax4=;
        b=LUjJJpY3K29Uw6m1c6TN3zuM3sEQKHvaMQDTdsPtRcULw4n3btXv9ajy88Hf6F0Op9
         HJV1PfgVws1od+OJjj3CHZcty7cqzdISURufxFaCwfHik1lYYfgxaq8BiHVSw2vq/LFA
         a/kb5yMqgS1f0RVT/nGEyX18M2ZkDC5R09UMrzFm+ddsAMMU5iNnbTEaWs7zcLSTFu18
         CbGtbMZPnyLJD6BzI8zsBJngEyt6qFsO6E3FqRVzcIaLwDrJkCv3GQnWhweAnpQeGxa1
         O0HnwZQKByzSuSdBycm1M+ZfK4vKMd2V+EG/tK/+HTfhIbmfEMdk0NdW7S3g0P6t3BjE
         geew==
X-Gm-Message-State: ACrzQf06PqTH8dj1knT/rshRmc9im34zY0964hppiG9bMKtkBywdSq/V
        cBWlexXM/fyHvGpUTzBYOXfjhp7nuEQ2tJT6ZFHrDca4Xd7k7A==
X-Google-Smtp-Source: AMsMyM47GaEt2QI5twmxv6Xcu6XVyDjTFR6pOMBMdafInBEYn8fwAgKO8hhw/mx6xb0wR1bxj/+/MmPFmfc2ycNIEj4=
X-Received: by 2002:ae9:e315:0:b0:6ee:761d:4b8b with SMTP id
 v21-20020ae9e315000000b006ee761d4b8bmr33092486qkf.748.1666852309623; Wed, 26
 Oct 2022 23:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <BYAPR06MB557347406F22FBA1E400A5BFD8319@BYAPR06MB5573.namprd06.prod.outlook.com>
 <CAHp75Vd4Vk0v-T3kfxApGHb-H26KTHgH59DGP3Wm4qBgunDt6A@mail.gmail.com>
 <Y1embP5sEp/NPxK0@smile.fi.intel.com> <BYAPR06MB557390C5F741300BDE2BAA8BD8319@BYAPR06MB5573.namprd06.prod.outlook.com>
 <CAHp75VeNwvAppVdn+wqAYkzDS115ZuJqm9=gu0hyVoz14qWQkA@mail.gmail.com> <d9c73675-1060-fd8b-958f-50793dca4db4@nathanm.com>
In-Reply-To: <d9c73675-1060-fd8b-958f-50793dca4db4@nathanm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Oct 2022 09:31:13 +0300
Message-ID: <CAHp75Vec=VOP=9+hNOqa_PCmHp7Qtjq8AykeJkHd0rdz-EKT1Q@mail.gmail.com>
Subject: Re: [PATCH] lib/string.c: Improve strcasecmp speed by not lowering if
 chars match
To:     Nathan Moinvaziri <nathan@nathanm.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 6:29 AM Nathan Moinvaziri <nathan@nathanm.com> wrote:
> On 10/25/2022 12:19 PM, Andy Shevchenko wrote:
> > Looks promising, but may I suggest a few things:
> > 1) have you considered the word-at-a-time use (like strscpy() does)?
>
> Only briefly at the beginning of the function to check for an identical
> comparison and the added check hurt performance for strings that were
> not identical.
>
> On 10/25/2022 12:19 PM, Andy Shevchenko wrote:
>
> > 2) instead of using tolower() on both sides,  have you considered
> > (with the above in mind) to use XOR over words and if they are not 0,
> > check if the result is one of possible combinations of 0x20 and then
> > by excluding the non-letters from the range you may find the
> > difference?
>
> I'm not sure what you mean about the possible combinations of the space
> character. I have not investigated this method.

'a' xor 'A' == 0x20 (same for all the letters.
That's why we have a specific _tolower() in vsprintf.c.

> According to my previous findings the check for c1 != c2 does perform
> better for strings that are at least 25% or more the same. I was able to
> get even more performance out of it by changing tolower() to use a
> different hash table than the one used for the is*() functions. By using
> a pre-generated hash table for both islower() and isupper() it is
> possible to remove the branch where ever those functions are used,
> including in strcasecmp. This method I've seen employed in the Android
> code base and also in cURL. Using it would add additional 2x256 bytes to
> the code size for the tables.

Rasmus raised a good question, where do we actually need the
performant strcasecmp()?

-- 
With Best Regards,
Andy Shevchenko
