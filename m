Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD333744882
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 12:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjGAKfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 06:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjGAKfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 06:35:19 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5DE3ABD
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 03:35:18 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-443512ad63cso875017137.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 03:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688207717; x=1690799717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8Eh2PL9vw+z9/shvLtMm4v72TX39RzomazCMgKz8Nk=;
        b=gk4OqIV5V//ZdAOJAaa5GPYAcNpTpuWFTFce8LSBa89KFGM/FmAS6z5QFS/XFlG38L
         CaJJGZp4IRjFS0HE/dFvsjJA9OXF4XWK0ViyYv3RwVgFzGO3uGhC4MsRej6wFtS279nM
         pUtQdHj9dNr4BiUB+sjzn8SywLstAHZDDWGH+FhRhiVHEIEriHnKgkLBhdlt9KbK2hzs
         gr0Y3fXiBDLBIlow/iHMUOFMvuL28V9RVabATiv2RFq12pvxS6R65/mDX+s+cgwKrjX5
         h13lHcSN3KrRvAnXU5xD7yji8lmqMxJNfUsOj8Ea4rI/AHevzcQoTbLfwSNVkQ8R/2f8
         7mSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688207717; x=1690799717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8Eh2PL9vw+z9/shvLtMm4v72TX39RzomazCMgKz8Nk=;
        b=icM7XNrQnVBg0GMOeP/AyQVsxFk3DX2lEzu7+wN7WkCBQ1NF/D1wk82bK1v6RBzmjf
         WziElDhuPY1n9eev9Ht59Gyz8/CQJKOYQk3ILZ2S2dyWxXfqgFwHMj2AeqGLxNMIoTq2
         YLNmd98Vrh3UZHSKCvoDR5ji9CaGZUG7hItuq4ORjL9UU4dfiDiuwPnYj2qkju+EdFNS
         i8DpIv8VJ7Fq+/6RLur/d5DnKsA7rKCsGU3Y9tea6efPPXVo1pWB7zzkMJIJMw/H3wyl
         PiJRbSknYJ2oBdWG/y+ANhmD0XrYBeGRYAWSqBq38BxmSH9hbM/dYAzuRRT326hLpB//
         PD0g==
X-Gm-Message-State: ABy/qLYraSDPvds4LPWoCdZjXDA1UYSQ5QeD6fCB1J+GPU6fUbiWkRD5
        7mcxI/dnq0jmWdN4jUkrgOAdiq7ize6fBlTztks=
X-Google-Smtp-Source: APBJJlFHfNfsyxvXH3BjwiArTpL3edc4FjGRmjy6V65bUFDmug1RXImkOe4JjRA1CeTKvBNGPTUXC5oKPmqVxHbl8lU=
X-Received: by 2002:a67:f885:0:b0:444:d85f:1f3f with SMTP id
 h5-20020a67f885000000b00444d85f1f3fmr706523vso.3.1688207717690; Sat, 01 Jul
 2023 03:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230625155632.32403-1-franziska.naepelt@gmail.com>
 <7caa96fb-4fb6-fb87-5d0c-fa6985fa127b@gmail.com> <CAAUT3iM7eAYH5AcN=Ko9jDstEUGqXxG7Q6qjp4O9qF_e2WkUVQ@mail.gmail.com>
 <69a90f88-634a-4126-8d33-e770fcc4b686@kadam.mountain>
In-Reply-To: <69a90f88-634a-4126-8d33-e770fcc4b686@kadam.mountain>
From:   =?UTF-8?Q?Franziska_N=C3=A4pelt?= 
        <franziska.naepelt@googlemail.com>
Date:   Sat, 1 Jul 2023 12:35:06 +0200
Message-ID: <CAAUT3iOOzV_pAKrA1+JhFuj2Mzt9Od-fRXxTEyvEbJicHLWBvw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Fix some checkpatch issues
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        eperi1024@gmail.com, hdegoede@redhat.com, quic_vjakkam@quicinc.com,
        johannes.berg@intel.com, tegongkang@gmail.com,
        gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Do., 29. Juni 2023 um 09:40 Uhr schrieb Dan Carpenter
<dan.carpenter@linaro.org>:
>
> On Wed, Jun 28, 2023 at 06:38:03PM +0200, Franziska N=C3=A4pelt wrote:
> >
> > Do you want me to submit v4 to fix the email address as well as the sub=
ject of
> > the cover letter or are you ok with me promising to make it properly th=
e next
> > time? ;)
>
> Philipp is not the person to ask, it's Greg.
>
> Yes, you are going to need to resend because of the email address thing.
>
> Probably the cover letter is not a reason to resend, but since you are
> resending then please fix that as well.
>
> The reason why we insist that you resend is a couple things:
> 1) This is a checkpatch change to staging so we assume that you're just
>    doing it to learn how patches are supposed to be sent.  So this is an
>    educational opportunity.  ;)
> 2) Greg maintains staging, usb, serial and -stable.  He's super busy.
>    It doesn't scale to hand edit patches.  Some maintainers are less
>    busy so they can fix trivial stuff like this but in staging you will
>    need to resend.  Also if it were a security fix maybe I would step
>    in and help you fix your patch but since it's just a checkpatch thing
>    no one is going to edit your patch.
>
> Right now the merge window is open so Greg isn't going to see your patch
> for a few weeks.  When he does he will press the button on his keyboard
> which sends an automatic reply about the email address thing and deletes
> the thread from his inbox.
>
> regards,
> dan carpenter

Thanks for your help and the comprehensive explanation Dan and Philipp :)
Just send v4:
https://lore.kernel.org/linux-staging/20230701102223.5308-1-franziska.naepe=
lt@googlemail.com/T/#t
