Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EE07231B6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 22:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjFEUsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 16:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjFEUsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 16:48:10 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CD0EC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 13:48:09 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-394c7ba4cb5so3683385b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 13:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1685998089; x=1688590089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xq0Z29Z9v8/HSNmJhVPOkRPbdlFtvw8P4NfsBjKIwMw=;
        b=SaFSxoMQ/rkujiKlOyPhZhi30DCr/bk27mjXT9rRuyVTZ+P0CUDWWD+M0jYy+L2Iwx
         GnPjs47eTXkdrHqSirBrjjFaG8tWgV6QDRDyAI80QUOtjVg9A+ARRjD2E9Dt/t2VzcNW
         IaMXooEevPNFvlUtPdv/RG3Xi68lA+HkKC4LA49iZXqP6r7+gn0XJIDxpW4eGw8mBKc0
         oP3fx8QK+H39B/aIqZOftgDrmQvh+W5xTqpUi0UmneEXFICpPb9FWW2Tn0NIDZj356iW
         dp2g1I4bhuSTPvv+WDGAnUxPfn3KZfk6ZmIq5hf6HZcV6pu4N2IUSQH+Ck7stZe397td
         msJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685998089; x=1688590089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xq0Z29Z9v8/HSNmJhVPOkRPbdlFtvw8P4NfsBjKIwMw=;
        b=i9sJPhwNir3y3wZc7miwAl1hx9quMJeVKNY0qpcfga2gfdkLZ5QbC/kvX8/e7p857j
         zZvUZ7zdMa0hX8svZfhrbaU+InvIHSn9AjUhMI5EmqVCJ679IWvWTrZIvr/sDn41vcl9
         BqTzk8hktuFadG2fibxBYN9oxIP1XP2djo0KrhdhG5Z8M0weUe6jgTWILe+9ClpXYmPL
         m+wZNds2/XcSywm1GCHzvnr5BOo4iNrfK4dXkyLZH0viP9kANa/9n2O+J/3rnMpUAiPy
         y8pWO4CL+lXHT2xrh/Bd77W2shox4q03ALoxzOzdISP7vpryhlXe81K61viR2VckUY+E
         u/rA==
X-Gm-Message-State: AC+VfDxf9zlYcgPl3u0LcpJv8rcNE0dDnE0OguuryYk4NoYN5SPjSR7t
        +aNgJkkcHr53vlItkxTPMJt9OTLqQICdY6HszlbRe+Roj9hpxzM=
X-Google-Smtp-Source: ACHHUZ4KRquTklGYJ+yGnfXpLFaSLvSszhN9j23ISvReW6UYnVuP35zxeaDwTA3kPqmxNXWzrllEIehQ4gm89lV5KTY=
X-Received: by 2002:a05:6808:911:b0:39a:ca93:53dc with SMTP id
 w17-20020a056808091100b0039aca9353dcmr2537982oih.24.1685998088905; Mon, 05
 Jun 2023 13:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230605105207.7d02fa3b@canb.auug.org.au>
In-Reply-To: <20230605105207.7d02fa3b@canb.auug.org.au>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 5 Jun 2023 16:47:58 -0400
Message-ID: <CAHC9VhSj1KbidMU4is6Y3dyvJbFCZ-woxKbPGAYmJYZFPnYxvA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the selinux tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 4, 2023 at 8:52=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the selinux tree got a conflict in:
>
>   security/selinux/Makefile
>
> between commit:
>
>   42c4e97e06a8 ("selinux: don't use make's grouped targets feature yet")
>
> from Linus' tree and commits:
>
>   6f933aa7dfd0 ("selinux: more Makefile tweaks")
>   ec4a491d180b ("selinux: fix Makefile for versions of make < v4.3")
>
> from the selinux tree.
>
> I fixed it up (I just used the latter version) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Hi Stephen,

I had to do pretty much the same thing, and yes, simply taking the
code in the last patch is the right thing to do.

--=20
paul-moore.com
