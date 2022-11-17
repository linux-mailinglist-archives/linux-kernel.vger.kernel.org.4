Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F250A62D557
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239675AbiKQIpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239616AbiKQIpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:45:05 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E32156D4C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:44:56 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id z192so1116611yba.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lf7Fu2NU8oOVwm5w942CLH9CTk4VOKP7yQpZtog5J8=;
        b=enc9KLtHOv7mlk0BIjzKF+9MkJexMliX0ErGiNqfxFD1U9IRWtNVwHXPn0IiCGgRYE
         btML7hIgVmIuICxV4/sfY/MAK9U7VXJJSM3thvKGiDC89jcrFFyry1KavBa7BGJLKfRd
         n/aEWOWe5QafFrcXLI4dDQTewspMPtG+Fki8PILPbHneNu9s0BHUsZ7+76hNAMw53Yby
         jljDecOqoF0fr/tQqVLo9ACIu9x/Io5zQlHOrmSk0nNEZ4/eNqSC1KhyHz78/Db//t5k
         ee0b5ospcdBqGEZAF4kAVnUG2FcI5g4Krb/YJ+hSlKizoS5ZmNJsJP9W1Vs1Mm9sa1c6
         uuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lf7Fu2NU8oOVwm5w942CLH9CTk4VOKP7yQpZtog5J8=;
        b=G1ctsIz1wKx5jQQdxfm5i8TvF0BUv82in+W/OeZDgsFSEjepLmXtWonfvP8OSbNRP3
         XEw9na+HjEJEdAnJbJVylqVXoI7Vdw6TJEJWEDGvAwDFgFPQdH8vEPZhRBeBHjUA54Fv
         IAYz6dtAz0zDvtxjnO87dZSdsSxDvzQgZwTga6TiqIcvVuANEruwc9lg0QFpF4bOz45N
         mH9lFRUS1He/b/jlQWZ8YJ1x9P/A/lzSDfLLX2qpBOqoZ4G52gm2MhvHJDf+KLpY/OfF
         38F2VfOClzxmlgIZoltU8J0OBt4iEL0bRfrv200wGfna5e25BUsyw52MQQbN1F68vn/Z
         p7+g==
X-Gm-Message-State: ANoB5pljqGKXfxkD/6B0M4S3LQZyjvlYfOAHXG08dd7IKmE5TeWSMt3K
        5DM1Xz/pYT1okwQ3Yz4M/oIv1gtGYFAEZ/ihgaL5qLP6uEdZoQ==
X-Google-Smtp-Source: AA0mqf7WJJv9XRooqQLl7dJ+OY3dIecNy6LLHCnYzTkHja5wGtFJOIEUIq4zDJ5tJvJD8m+jqxrClKYIEvC8NLPT7Bo=
X-Received: by 2002:a25:cc15:0:b0:6dd:e342:ca39 with SMTP id
 l21-20020a25cc15000000b006dde342ca39mr1193125ybf.648.1668674695925; Thu, 17
 Nov 2022 00:44:55 -0800 (PST)
MIME-Version: 1.0
References: <CAKdx3izLgNJO+5ye4twe0+CFMcUBrFUa+-NdLN6VKKWQ76YiLA@mail.gmail.com>
 <CAADfD8yoBvzs77f6gVO8J9FSZxOkEnkqgAaSCjcfG2YhEZBvcw@mail.gmail.com>
In-Reply-To: <CAADfD8yoBvzs77f6gVO8J9FSZxOkEnkqgAaSCjcfG2YhEZBvcw@mail.gmail.com>
From:   Hang An <anhang610@gmail.com>
Date:   Thu, 17 Nov 2022 16:44:45 +0800
Message-ID: <CAKdx3izuNmQgyKo0gny1FVESabobbnFVBRNOGVMwgjVSPVcz_A@mail.gmail.com>
Subject: Re: Can Not Send Netlink Messages with Unshare(CLONE_NEWNET)
To:     Ozgur <ozgurk@ieee.org>
Cc:     linux-kernel@vger.kernel.org
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

Thanks for your information.

Ozgur <ozgurk@ieee.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=8817=E6=97=A5=E5=91=
=A8=E5=9B=9B 16:35=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Nov 17, 2022 at 11:55 AM Hang An <anhang610@gmail.com> wrote:
> >
> > Hi,
> > A process can not send netlink messages(errno is ECONNREFUSED) after
> > running unshare(CLONE_NEWNET).
> >
> > Part of the call stack when process failed:
> > netlink_sendmsg
> > netlink_unicast
> > netlink_getsockbyportid
> > netlink_lookup(return NULL)
> >
> > The corresponding pseudocode is shown below:
> > unshare(CLONE_NEWNET) ;
> > res_socket =3D syscall(__NR_socket, 0x10ul, 3ul, 8);
> > syscall(__NR_sendmsg, res_socket, msghdr, 0ul);
> >
> > I can't understand this situation. Is this a bug or special design?
>
> Hello,
>
> you have emailed a public linux-kernel list, so this list mainly focus
> for development. maybe you should use bugzilla(1) to get answers to
> your questions or you should ask question mentioned own kernel
> subsystem (2).
>
> 1. https://bugzilla.kernel.org/
> 2. Network Subsystem | netdev@vger.kernel.org
>
> Regards
>
> >
> > Thanks.
