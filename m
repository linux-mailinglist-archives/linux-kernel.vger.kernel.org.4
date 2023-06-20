Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA563736435
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjFTHOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjFTHOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:14:17 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED16119;
        Tue, 20 Jun 2023 00:13:47 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-988689a5f44so264018866b.1;
        Tue, 20 Jun 2023 00:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687245224; x=1689837224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHYZLznLEupvmNgdz85Wsrh9nTfIdkBiscUX255Az7M=;
        b=KS2MlNlXd3y1nTza3BQfUQefl0hUFRyaHJjF0aNqen8fNC0xrWWq2Wqj4BXSO/TymI
         7ZYHqb9Q0z2YI2jLz3j5V3n5Ti55PCYI2DNo0FHlYiLkbjgBrKE94yVJbYGGRKO2JNie
         swEfgr00n17CznG0qqtGxiT9LXeKUpAqB8fL9K0Wiz5Fv4c9DZuG7zH27UlHU+IpIXwj
         /74r3NxBxFV57roZ9AojpB2d+cobw2MJdSENRHLkn+1RSHeZreF8MTrO09njiqaaSNXW
         jaqzeslntv7BXyd++oVljfTIIA2Inss/uW3+u+Ol8tO7biaME1caakBq2wFMkXEmVjx/
         SE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687245224; x=1689837224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHYZLznLEupvmNgdz85Wsrh9nTfIdkBiscUX255Az7M=;
        b=Yk0oCVh5gZ2fJTX1aWMD+YoQKwivtwZRm0JUQ1S1gyAntqnSk3k7kLqRO+cz/ux6TK
         TlRqECa41/n0R1cVagxF/Kyj2HhzXBmIjnI93osR+98NQAaXeuso67XxAe93ErUU3TTz
         aags5qDR8hdh08653L80SHdaolHqpUP7zLnOtE07Lri4KxcTUV6smzXoPk/G9n6SvO6p
         8FCoXWq9ZYtN8OFSIRRiVi3moLKdq3iZEoVHGeeBuMELYb6H2WOO6NCatsKKSJQvP2Dr
         Gk6+YlXv+xHb5hZGvkdYuB6iPN4Jzn3NkhTnC0/YSXW1L/0j0UTP8ZHEsc4bfobJS/IH
         860g==
X-Gm-Message-State: AC+VfDwVFm/BSyFDEAhdpK+jZ2y5avUwmqCP3kN9RJYGD8H+8CfqLJ8f
        N3tkD1Mt0G6Z9gddZbJj03Eq2etPDKrYFCyPYiM=
X-Google-Smtp-Source: ACHHUZ6F96J1yKxnlaxPS5FMbR2w71s7opnQjEhCe3UpSiAY5D8Q7lBEBoaoOSJHfUY5/idqlvCgI9wkZMATl0p2xeQ=
X-Received: by 2002:a17:907:a412:b0:989:d9d:d911 with SMTP id
 sg18-20020a170907a41200b009890d9dd911mr1975412ejc.69.1687245224382; Tue, 20
 Jun 2023 00:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230620004217.4700-1-dakr@redhat.com> <2c92bae3-0003-3c53-8ef1-6e12e5413995@redhat.com>
 <CAPM=9tzMzfuMN_iGD-97_o=QQEDT6Mbb9_u=z_o49TeT7=XUFA@mail.gmail.com> <CAFCwf11OwnoxPWHuS_55OXKE7wfHH++1Bk_37DATeCiT07GtMQ@mail.gmail.com>
In-Reply-To: <CAFCwf11OwnoxPWHuS_55OXKE7wfHH++1Bk_37DATeCiT07GtMQ@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Tue, 20 Jun 2023 17:13:31 +1000
Message-ID: <CAPM=9tyv5Fje0iL0-2oJQBKEsg-nc-YV9q4BSg5SwnBvGvrzDw@mail.gmail.com>
Subject: Re: [PATCH drm-next v5 00/14] [RFC] DRM GPUVA Manager & Nouveau
 VM_BIND UAPI
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     Danilo Krummrich <dakr@redhat.com>,
        Donald Robson <Donald.Robson@imgtec.com>, daniel@ffwll.ch,
        tzimmermann@suse.de, mripard@kernel.org, corbet@lwn.net,
        christian.koenig@amd.com, bskeggs@redhat.com,
        Liam.Howlett@oracle.com, matthew.brost@intel.com,
        boris.brezillon@collabora.com, alexdeucher@gmail.com,
        bagasdotme@gmail.com, willy@infradead.org, jason@jlekstrand.net,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2023 at 17:06, Oded Gabbay <ogabbay@kernel.org> wrote:
>
> On Tue, Jun 20, 2023 at 7:05=E2=80=AFAM Dave Airlie <airlied@gmail.com> w=
rote:
> >
> > Since this is feature is nouveau only currently and doesn't disturb
> > the current nouveau code paths, I'd like to try and get this work in
> > tree so other drivers can work from it.
> >
> > If there are any major objections to this, I'm happy to pull it back
> > out again, but I'd like to get some acks/rb in the next couple of days
> > in order to land some of it.
> >
> > Dave.
> >
> >
> > >
> > > forgot to add your email address to the patch series - sorry about th=
at.
> > >
> > > This series (v5) contains the Documentation changes you requested.
> > >
> > > - Danilo
> > >
> > > On 6/20/23 02:42, Danilo Krummrich wrote:
> > > > This patch series provides a new UAPI for the Nouveau driver in ord=
er to
> > > > support Vulkan features, such as sparse bindings and sparse residen=
cy.
> > > >
> > > > Furthermore, with the DRM GPUVA manager it provides a new DRM core =
feature to
> > > > keep track of GPU virtual address (VA) mappings in a more generic w=
ay.
> > > >
> > > > The DRM GPUVA manager is indented to help drivers implement userspa=
ce-manageable
> > > > GPU VA spaces in reference to the Vulkan API. In order to achieve t=
his goal it
> > > > serves the following purposes in this context.
> > > >
> > > >      1) Provide infrastructure to track GPU VA allocations and mapp=
ings,
> > > >         making use of the maple_tree.
> > > >
> > > >      2) Generically connect GPU VA mappings to their backing buffer=
s, in
> > > >         particular DRM GEM objects.
> Will this manager be able to connect GPU VA mappings to host memory
> allocations (aka user pointers) ?
>
> I only skimmed over the uapi definitions, but from that quick glance I
> saw you can only pass a (gem) handle to the vm bind uapi.
>
> I think it is an important feature because you don't want to have two
> GPU VA managers running in your driver (if that's even possible).
> Maybe we should at least try to make sure the uapi is/will be
> compatible with such an extension.
>

I think that would have to be a new uAPI entry point anyways, since
managing user ptrs is extra, but the uAPI is nouveau specific and
nouveau has no hostptr support as of now.

The gpuva manager is kernel internal, I think adding host ptr tracking
is useful, but I don't think it's a blocker right now.

One of the reasons I'd like to get this in the tree is to add things
like that instead of overloading this initial patchset with feature
creep.

Dave.
