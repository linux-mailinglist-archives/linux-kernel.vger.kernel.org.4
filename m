Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279315F059D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 09:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiI3HWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 03:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiI3HWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 03:22:31 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A9112647E;
        Fri, 30 Sep 2022 00:22:29 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 126so4256382ybw.3;
        Fri, 30 Sep 2022 00:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=XGGLlua7GXMuc36QzLfRv6BdbYRPzApkiA3VNvmfEWQ=;
        b=I+9KmAvj3PdBEA50JYR+BLHn6puwGXK07eiZIFqlVSPPQyLOJqIZa5l5eaCGQQhQrT
         zTtCn7+n83Svcn8Wc8sghJNuqwciTIHfgN8fDmLjdWwahcXOjhaSVhg4u4vNSAc+kMjx
         HpGuvg7xVWGl1RaEdOeU9r4FLE8xDupjK3cnBsI+nM1QZmyGvhWUI+54plU+DfKFOaB3
         6yFwMR4m2K8MWWNx7mKmma8kgR7++t7bu0Bag032oKL57qWHVunhN68EDxGYdp9j0wAh
         c1b+GfjCadysQMS0dZLV2D2R5uj+9uTOH/3Dm2D3yzz1nvYxmA6z5H9/iFqnyvCX0bJR
         kGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=XGGLlua7GXMuc36QzLfRv6BdbYRPzApkiA3VNvmfEWQ=;
        b=SX1qT4krNLfAlv5HVjTFr+OqxOfq6tK9gk19R7k1+ZSp/zhqDBahWOCiLpLr89E30H
         McTgQct2qqyzNYKxZkTBvh94d/3bBWqWIppq0LbMRqgZ0YQFDU4604S5BvbVRl7XSaDq
         X6zFRS4pQVW8oqOUACwPXsXhIl0d8RXt5q1pjZgwmS69U32ffu1zZwBJahzARbkoD+JW
         zSQE20grZCYfNGVbs24MPbLbPh7dpV9tNcW90yofU6QGZ/MOV4a5nm3KjOXngZgHBKRm
         J2z1IfFyU+wO/Vjdm5oafihon17uCl2hrlT4G6cAPFpc3hLPv9erV90A4sG27PTcICPz
         tylA==
X-Gm-Message-State: ACrzQf3Wc/6Sn8y9/Zs/M/QJSexi0T7yUhr/NX+dFldmd/udM9StWVCd
        4tBjYJHEznSmuzyxv5cQwLXH1duvu0dfHaYN5kE=
X-Google-Smtp-Source: AMsMyM6xWjPtwK06Sz1UuC19YFA2WThQGHUIYDVfOu6dW3rkut9e/g3MtFcNOAglopyzlzz+n9OWctNEtOoCRd5YQwQ=
X-Received: by 2002:a25:d0a:0:b0:6bc:f7a4:b982 with SMTP id
 10-20020a250d0a000000b006bcf7a4b982mr1223442ybn.77.1664522548389; Fri, 30 Sep
 2022 00:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220929101445.32124-1-lukas.bulwahn@gmail.com>
 <CAAhV-H6xe4o0upxcQTN=8BeDdcDipmoRp+QQNiakJJZ_eneTxg@mail.gmail.com>
 <CAKXUXMwhF4V1=oNq1XaTmQpk_Tt7ZXfZEmK_r_GT6wz7=vVx2g@mail.gmail.com> <CAAhV-H4dExTGW7=pSPmunFVBK6YYjj-wo0ZKgfi9A=yHf2qV9g@mail.gmail.com>
In-Reply-To: <CAAhV-H4dExTGW7=pSPmunFVBK6YYjj-wo0ZKgfi9A=yHf2qV9g@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 30 Sep 2022 09:22:17 +0200
Message-ID: <CAKXUXMw731xNrqUzrCE1jRd25vfWdYFf-donLosOYOTqcm9JiQ@mail.gmail.com>
Subject: Re: [PATCH] loongarch: update config files
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
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

On Fri, Sep 30, 2022 at 4:46 AM Huacai Chen <chenhuacai@kernel.org> wrote:
>
> On Thu, Sep 29, 2022 at 6:44 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >
> > On Thu, Sep 29, 2022 at 12:42 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> > >
> > > Hi, Lukas,
> > >
> > > Thank you for your patch, it is queued for loongarch-next, and may be
> > > squashed to another patch with your S-o-B if you have no objections.
> > >
> > > Huacai
> > >
> >
> > Feel free to squash as you see fit. I cannot recall sending something
> > specific for loongarch-next, though.
> Emmm, my meaning is squash your patch to mine and keep a S-o-B in that
> patch [1]. :)
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/commit/?h=loongarch-next
>

Process-wise that seems a bit strange (i.e., just mixing S-o-B by
multiple people, how do you bisect which individual change broke
something [you would need a second manual step of investigation],
etc.), but sure go ahead.

No objections.

Lukas
