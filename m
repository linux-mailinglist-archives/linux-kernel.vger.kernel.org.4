Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F5660EF56
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 07:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbiJ0FMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 01:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbiJ0FMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 01:12:46 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463151581B6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 22:12:44 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id hh9so383401qtb.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 22:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmDiMYe/I0ri6Zj03hdpur3rJrgB7k+DhMOzSt5LxUI=;
        b=hM2tehQXR8rhpVF9g+WAkkYLHO2gza5eLp8A5C/rbyeAH+vIL+0k9xuLSF+aoysY0p
         IV1nDGd1W14gsvEe5BwPL4dUnIhQCffmmyoeMjIojAuiHXiHb+Ie5vwStIIBxDhNXewv
         /dltDWdPmrIJFQIVGWMHCocFEs0VnC/F9cURrfBBLE0LJlpgsCtACKSzUMBUYEZAI1sC
         6gwir6oqL+FXUXdWdrErNn2TE/QivqIgFJNw3nTSb/oyj/nkLCBNgtRKdyOawG3jRc7P
         3mpr8LC0Om5GHXwU7pticVUP/D2vnWd5uetBTwlf0SG8WY88g06v2iVV2BcZMezV/Ss5
         34mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmDiMYe/I0ri6Zj03hdpur3rJrgB7k+DhMOzSt5LxUI=;
        b=XdSIPXimKwlp7hS0IvLcVKIhhsihrX/56QjXfbBvhUqdhqgmP8bZeDnFav3jekedsS
         XFeAF+UnfI+XHmRL+j70Q/Sq2iXhRRmBA1fVuxM4n4rWOTlxV8VkPn0OvVlQkep9o1dV
         AYc4lKZgoDHmi1/PfhshO1SgwSyNSPWxye9M9VL+nb7e6BTzx6hydrwO0tRmXMRDNson
         H374ijrsozbUo58p1ghRVLotLfPKfFocPh5vG+7xrwrSWRPFs5DPnCg3HJnRSZ7VZhZq
         UwM9HJsf7yvGavQZH6KYW6lyNPskRixCd7qskXv1SMC7EPe46bLadGEw6dEHiXD+a6W0
         hyJw==
X-Gm-Message-State: ACrzQf3cs+z28jwzzvjuoSUrSv0cUJ6HAJiAycWzJ/AC67H4nKW2KR2H
        x0EYfn89CNeL9VDFwgkTwGPCNdN/UISSsi78rrY1hcUy
X-Google-Smtp-Source: AMsMyM6aQPkWUzrcH5QcYJv7YBwmqFe1zX9SZ+R2FvqFrLBshlWiO4t1EvfUkMpXDGj/dS+trwAoMo7XaSKAjTAviUE=
X-Received: by 2002:a05:622a:164f:b0:3a4:f141:92fa with SMTP id
 y15-20020a05622a164f00b003a4f14192famr4761116qtj.447.1666847563200; Wed, 26
 Oct 2022 22:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <Yz8rIxV7bVCcfZb0@kroah.com> <20221007013708.1946061-1-zyytlz.wz@163.com>
 <CAPM=9ty0+ouf+rQWhM=9XSKFOA2zxKfa00MsNBvwrQGPQm2uPQ@mail.gmail.com> <CAJedcCwxioxr+4TBTdrEjAZh97J3oroSHSgax+bxSNRXCBvkRg@mail.gmail.com>
In-Reply-To: <CAJedcCwxioxr+4TBTdrEjAZh97J3oroSHSgax+bxSNRXCBvkRg@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 27 Oct 2022 15:12:31 +1000
Message-ID: <CAPM=9twhAL+c8mOLmidY_tEhEKwCh-CTjfs5yryOk8oGjMxuug@mail.gmail.com>
Subject: Re: [PATCH v3] drm/i915/gvt: fix double free bug in split_2MB_gtt_entry
To:     Zheng Hacker <hackerzheng666@gmail.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, gregkh@linuxfoundation.org,
        alex000young@gmail.com, security@kernel.org, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, 1002992920@qq.com,
        intel-gvt-dev@lists.freedesktop.org, zhi.a.wang@intel.com,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
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

On Thu, 27 Oct 2022 at 13:26, Zheng Hacker <hackerzheng666@gmail.com> wrote=
:
>
> Dave Airlie <airlied@gmail.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=8827=E6=97=
=A5=E5=91=A8=E5=9B=9B 08:01=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Fri, 7 Oct 2022 at 11:38, Zheng Wang <zyytlz.wz@163.com> wrote:
> > >
> > > If intel_gvt_dma_map_guest_page failed, it will call
> > > ppgtt_invalidate_spt, which will finally free the spt.
> > > But the caller does not notice that, it will free spt again in error =
path.
> > >
> > > Fix this by spliting invalidate and free in ppgtt_invalidate_spt.
> > > Only free spt when in good case.
> > >
> > > Reported-by: Zheng Wang <hackerzheng666@gmail.com>
> > > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> >
> > Has this landed in a tree yet, since it's a possible CVE, might be
> > good to merge it somewhere.
> >
> > Dave.
> >
>
> Hi Dave,
>
> This patched hasn't been merged yet. Could you please help with this?

I'll add some more people who can probably look at it.

Dave.
