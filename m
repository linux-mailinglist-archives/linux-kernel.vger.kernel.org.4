Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7C067BF61
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 22:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjAYV4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 16:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjAYVzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:55:11 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A50C2696;
        Wed, 25 Jan 2023 13:55:10 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id d10so80342ilc.12;
        Wed, 25 Jan 2023 13:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neYEi0cw4EDxVYjfQLR6pAXtwhYG53KqKTVTIsfdX4k=;
        b=D8kM3+XfkUVIQZCl0fXu4VUjpGIbecF4+xekcyktbQwE5SmYPqX6iIoh0lvosgKhI3
         T+6MdQmw2SGrFsQKEg39zajkJc57jZXd0WnaGUc/P7LlfInKTthVR3hLo506eqNAjxCb
         sQ+XIm7ppRULHxGcOB050jml5TzGiDn4Wl+psJk/SKeAZSrtXhTm/1G/ik+vD3bhJvmp
         eWl7cjG5KpBxXCUPe8kA2WjLtNJwI01RXlIEVgxpOPKR95uq1vZpZ+goi7mfbG3pYbSv
         1sic8U6OFeUj8RfZwA4VryvKcjn899kQAQhrpGobdWxJpubMEJ/4DeGkJBJ/GFUedyFM
         q+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=neYEi0cw4EDxVYjfQLR6pAXtwhYG53KqKTVTIsfdX4k=;
        b=Qekhj47MLC/XXweRnMjxOvwi0CgJGYeNkwLDQzXZ9ETSXwTypRNY3iL13LJyiFmh8p
         7uuSx3ea4/dVQnunTF0Ff5fIu0/1No2lNrcz01kwjcfj7kGTbX8n/Ntiu7mKXO6h/bj6
         JO3vcFU/ikteFofDRhf7m0x1MstBplqIUJl9Zs1/9Yp65vZ/RbOGQS70YuLrhyPxBr3c
         km7MBP9sZ/Bgl+G7t7ltosUYXDXGwPtg+xGO1MFR4DEvZVggJmoi/TpFDJAfpKajYTDm
         im9PhoGoQ6xzuVNYqGSs/ISjM0eWNGr9Kge1SavRyQLgO3Y3a4R+TBWv9Xg90Rs9OazM
         wcKQ==
X-Gm-Message-State: AFqh2kruuSdhw3nqQ/EmNAxY4A64tMlQXVaMkF1few9Lj7RtpTN/N47Z
        /ONbWDftfyWDyOnwUsYJ8y2r3ITT6m/yFMlmO5W5FnaBzG0=
X-Google-Smtp-Source: AMrXdXvhV5JG7qD7XXjwA72/JoOIluBtsCYvQQMzrPWbWd7PNpDARPbsll/2FI3hJwy/YTaFzMI19nmpFsD0ZA8Li4s=
X-Received: by 2002:a05:6e02:c0d:b0:30f:5797:2c71 with SMTP id
 d13-20020a056e020c0d00b0030f57972c71mr2157310ile.51.1674683709367; Wed, 25
 Jan 2023 13:55:09 -0800 (PST)
MIME-Version: 1.0
References: <20230125143425.85268-1-andriy.shevchenko@linux.intel.com>
 <CAMUOyH2Kc6hL4564sYDZdGRjiJJYmDA5WXEsF92p_xN8iZGMsg@mail.gmail.com> <Y9GKje/7t79cxecC@smile.fi.intel.com>
In-Reply-To: <Y9GKje/7t79cxecC@smile.fi.intel.com>
From:   =?UTF-8?B?SsOzIMOBZ2lsYSBCaXRzY2g=?= <jgilab@gmail.com>
Date:   Wed, 25 Jan 2023 22:54:58 +0100
Message-ID: <CAMUOyH163WY3Csbs8QOy6VssrR9TXZRi6ChnqPn=PO7z12rZOQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] usb: gadget: Use correct APIs and data types for
 UUID handling
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 9:01 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jan 25, 2023 at 06:31:36PM +0100, J=C3=B3 =C3=81gila Bitsch wrote=
:
> > On Wed, Jan 25, 2023 at 3:34 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > We have two types for UUIDs depending on the byte ordering.
> > > Instead of explaining how bytes should go over the wire,
> > > use dedicated APIs and data types. This removes a confusion
> > > over the byte ordering.
> >
> > Thanks for pointing this out. I was unaware of the exact UUID
> > functions, as I'm still quite a newbie here.
> >
> > I compiled and tested your patch in my test setup and it works perfectl=
y.
>
> Thanks for the testing. According to Submitting Patches documentation
> you can provide a formal Tested-by tag.

Thanks for pointing this out to me.

I'm not really sure how to do that though.
On https://docs.kernel.org/process/submitting-patches.html#reviewer-s-state=
ment-of-oversight,
it says:
> Both Tested-by and Reviewed-by tags, once received on mailing list from t=
ester or reviewer, should be added by author to the applicable patches when=
 sending next versions.

So I guess you could do that at your convenience on any next version.
Or is it already ok, if I just add the following line in my comment?

Tested-By: J=C3=B3 =C3=81gila Bitsch <jgilab@gmail.com>

I'm still quite a newbie in the kernel development community, so
thanks for bearing with my ignorance :-)

Best regards and thanks a lot,
J=C3=B3


>
> --
> With Best Regards,
> Andy Shevchenko
>
>
