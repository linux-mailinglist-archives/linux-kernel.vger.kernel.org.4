Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1264A5ED336
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 05:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiI1DEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 23:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiI1DD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 23:03:57 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907811D66EC
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 20:03:55 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id y2so7252347qtv.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 20:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=k5xwhL1ewkrmE9xgwNsvpHkNtWeZQJzzFqqUm+SfmO8=;
        b=pBxFwuvsfKUPTAnIKMt6pUsdhxehGFDDbcpsYWSIY/IRasIQVLIgtfGoH6Q42azjFl
         YYf8WHy/1pR5Ue1Z1/9vHYfI6QxnGedTBN/Ik90rzHuTcyAL68Gc0OTYMhqhDw8xfRQ9
         5FnIPrFBgTWq0EhUY4q730tI4wxLHMiKvkAPGdOiA5nlZa/n/VehDBJ6DJd6tCVwm/me
         p2rKMR7pOwNCP5/YQgkpImz5qY6pKISV+2f0vh8xcXw5lh4+drloKtIuELfncyWoBZX3
         Q93KGVFDJS+5ZEI/pZo8wUYjwckS9iTAFbkvgHxqH6Cy5blUWsAP2IUOtaPQgzRwDSkD
         LJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=k5xwhL1ewkrmE9xgwNsvpHkNtWeZQJzzFqqUm+SfmO8=;
        b=hjW0JJWtfVwy+St9rjy/bb5Pu/X5M2So9Av5egv/8Aq4vKlq/D2kmvsgR8HwYJnDhE
         gXgikw9XSQaSrPxu/NnM6QxZvRkpf0iTsAwDtA7wn9CV5P1hi+em3Wns7VTSd6Ovcwpj
         TSBJOOmhZ7EWzGATXHJTWIpx64TQlboQlpkGMp0AVS6Ef1zN/Z+MnMr25KIsM5MmWJfL
         O5EYcx5lTnht4FVVkbku829bbh+6XMjNtR4DXj1kLhr1GxAXLEjlro2rWBq7D/LXhkiw
         fFqcqkpVNk7cZoBtVLDfeqStuTj3h4DlOEMfuaosjqo+g39g+Huqn0DMSMkMygOC4PR7
         WNCA==
X-Gm-Message-State: ACrzQf2M1hJNZK5sNfBZybsEMyp/Q3SxYR3uSADMttbhNY/eU4pOpuxN
        fNyhfyHcIj7iDwwT1Cz1p9oDmXEzRoGDmZlEqYI=
X-Google-Smtp-Source: AMsMyM5PIZq7H6ggNUwmQs6YipoN41yZLVOr3eBawHhEvDGnpQqQJ0ATpweGNjCtjWcyn1Gz50BOL55j49/u2XJ4qPs=
X-Received: by 2002:a05:622a:493:b0:35d:52a6:2689 with SMTP id
 p19-20020a05622a049300b0035d52a62689mr3000983qtx.595.1664334234665; Tue, 27
 Sep 2022 20:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220926043618.566326-1-zyytlz.wz@163.com> <YzFkpRfkdnwgDDw6@kroah.com>
 <CAJedcCxGkz6i2LeCGWcHgU7P2n1TeB9gKVZCzmjPPJK=hhsfLA@mail.gmail.com> <YzMmp9llFUN1yUDH@kroah.com>
In-Reply-To: <YzMmp9llFUN1yUDH@kroah.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Wed, 28 Sep 2022 11:03:42 +0800
Message-ID: <CAJedcCxjjNFsHibTO3-M6a8vay3-2LcSN=0dNkqCicLakG4wOw@mail.gmail.com>
Subject: Re: [PATCH] misc: sgi-gru: fix use-after-free error in
 gru_set_context_option, gru_fault and gru_handle_user_call_os
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Zheng Wang <zyytlz.wz@163.com>, dimitri.sivanich@hpe.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        alex000young@gmail.com, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2022=E5=B9=B49=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=B8=89 00:36=E5=86=99=E9=81=93=EF=BC=9A
>
> Please do not top-post.
>
Got it :)
> I do not see any new submission, please provide the lore.kernel.org link
> of it.
>
Here is the link of new
patch(https://lore.kernel.org/all/20220928025957.1050698-1-zyytlz.wz@163.co=
m/T/#u),
I added the Fixes line to tell which commit introduced the bug.

Thanks,
Zheng Wang
