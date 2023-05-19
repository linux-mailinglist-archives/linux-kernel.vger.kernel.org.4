Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30D5709AC0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 16:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjESO6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 10:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjESO6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 10:58:44 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A92101
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 07:58:42 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-561bcd35117so42753967b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 07:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684508322; x=1687100322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AajyqWszb0uY6qD9cS3VXYrfDU988bXtZCs1rPMruhw=;
        b=CVjYLnK8pZSm+0s+2JgmOpL6fd7Fh3xe0DrvRV47kW58O8GUdqascT+ihAWb+4/PB5
         57l1fSbdpzDrjebhCKxmt8dH+h8nzNnzfGUC6O47kcvj+/tq7D0PSJjuIJJayEMDuPTp
         RZmYcbvGlGStIcUkuVCBO7399/guNv++G9I5Asoz5DROlHagoZjpYdqO7T9i1NOAzJ1w
         Du4lToaIIcFchOrn0Nn//43a6dCasI0vQfLXRVHExkpStSbCh+g9ayLmw5x0ghVHqblw
         Dsm6QLKodk9RMwxd+A5A9Ln0JG71pTOJEq/9kFiLF97zE4pLcdM5N8FRzbB5GfM0mP18
         P5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684508322; x=1687100322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AajyqWszb0uY6qD9cS3VXYrfDU988bXtZCs1rPMruhw=;
        b=mIRNsieDvYF8AKLrLUQUH47KIM6yhhpfx8WOd3pGUhVhrm9nOlig8P4Iiw8uUopmfJ
         KjWIKYCztHhdmeubqVIu5Ehrqg8X3Sw13Yjegf2ALlKU3tRoKbGl8Onc66KU65j0RJBs
         Kt2jUXdRxcbP5AfsG1Nd+Z123wscbZ0kSUilez732Fu8IvqmJ46jwTiq7I79eJWeP8j2
         mrs6GTcGpOoLrWXJG6w6RTBwAhe1MfSPUGGZkHIKeGILLVAZ75RuLKCrL9O8S7FsQD/E
         /IlaxML8MzWe10OPTN6Ab8JP15WigJnfWLnJzi8wlj3oYx364eihLr9tCVIRwkHez4Bq
         Gaeg==
X-Gm-Message-State: AC+VfDwMebcBRSjLK+4lujkL+Z/MdRIzx8ynfM5O3HPeu9vg+bCgSYkK
        ii9q/POtX/du3ES4V9MLttDiFD13EXzGAp4xFwk5
X-Google-Smtp-Source: ACHHUZ4wVQ8Htbed+cTytEWUQf0lb6NRULZiiMX8VBBzsWBICc5rj9+tiqRxdZAlDEbFGOiNVwJSMMDulwZ/apnybkg=
X-Received: by 2002:a81:4e92:0:b0:561:d6dd:bc84 with SMTP id
 c140-20020a814e92000000b00561d6ddbc84mr2216527ywb.48.1684508321812; Fri, 19
 May 2023 07:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
 <90a25725b4b3c96e84faefdb827b261901022606.camel@kernel.org>
 <cbffa3dee65ecc0884dd16eb3af95c09a28f4297.camel@linux.ibm.com>
 <CAHC9VhSeBn-4UN48NcQWhJqLvQuydt4OvdyUsk9AXcviJ9Cqyw@mail.gmail.com> <49a31515666cb0ecf78909f09d40d29eb5528e0f.camel@linux.ibm.com>
In-Reply-To: <49a31515666cb0ecf78909f09d40d29eb5528e0f.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 19 May 2023 10:58:30 -0400
Message-ID: <CAHC9VhS7uMMgvwRRDzpZPUQDAeibdkLi0OCdp=j_Q-EcMHm0cw@mail.gmail.com>
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM after writes
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-integrity@vger.kernel.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 4:56=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Thu, 2023-05-18 at 16:46 -0400, Paul Moore wrote:
> > On Fri, Apr 21, 2023 at 10:44=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.co=
m> wrote:
> > > On Fri, 2023-04-07 at 09:29 -0400, Jeff Layton wrote:

...

> > I'm going through my review queue to make sure I haven't missed
> > anything and this thread popped up ... Stefan, Mimi, did you get a fix
> > into an upstream tree somewhere?  If not, is it because you are
> > waiting on a review/merge from me into the LSM tree?
>
> Sorry for the delay.  Between vacation and LSS, I just started testing
> Jeff Layton's patch.

No worries, I'm a bit behind too, I just wanted to make sure I wasn't
blocking this thread :)

--=20
paul-moore.com
