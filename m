Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19BC5EDBF7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbiI1Lmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbiI1Lmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:42:42 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204B82BB33
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 04:42:41 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id bu4so4559838uab.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 04:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CelnwlimKlesVklJEV0/j9/zSnBOSdBudbtX5vRbufs=;
        b=ZjX3sAmRSl+Mrq4GhjXP/i5HYnctFytTA1ZrZYhoj44GIFwxGcfNrtxAMvmhiENFr5
         c9CeRiAVr3WlC5QDSCbLvyOvD11hG5qIE3sbVjBPRnlVYGPV4aEE8/3Gya9kh1gICRHV
         qI2N68430ByprfVdStvaiB6BnCrKkEcZW8UP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CelnwlimKlesVklJEV0/j9/zSnBOSdBudbtX5vRbufs=;
        b=ugzBjsazN9kHBpgVbAzzcov6Tf9xfIPUVq+kH0hNTPAJRIDdhVPJskcb5r/taqG34Z
         4jaxE1YJsnSvSracmtTQDc783G+/2VKd7CfFtGMWmlj6biJDe7sCObiuvDsXyZXqDutt
         AQch8v4o4iHbp5uuMd8h5yIbkL9IINQQiDsuPaslpoLe1Mf7Ee61wpOykqX4Cbdbu0Qz
         +mlSD78ve4lDdPKvO6R/e/RgCttVTurK8Z3vABlCxKYR/aeIole/K1lZM7O5qrXd63jq
         FfujTCjcb245WBYRBXuhjGqe4bw9MO+GdCYzT90JYRUHbpBkKVW29oLMVR9OUpihOmYv
         zXQg==
X-Gm-Message-State: ACrzQf3pz6hZUWY9JCVpCAJ5iPFflPs5XyCiRoFYs/C3/6ukT+ePKSZF
        EJdTwhZAY+u1bD6R2mXjQ4ICpMkdwJ2YtzElLD8=
X-Google-Smtp-Source: AMsMyM5ty9TAxnjSRUNeFgHyJZ8o0EA16Z7l2Gls9yd4ZB41DTqyl7tnZ34L/FcmT5XqRkv2DINfD+XEUFY1FHjG3c0=
X-Received: by 2002:a05:6130:c13:b0:39f:58bb:d51c with SMTP id
 cg19-20020a0561300c1300b0039f58bbd51cmr14782506uab.104.1664365360155; Wed, 28
 Sep 2022 04:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <CACPK8Xf+F9JYQpbKHLPeey-DjQJBY-82KQ7XRyaOeMu_HhEBig@mail.gmail.com>
 <YzP3OtV4GerKDrYe@kroah.com>
In-Reply-To: <YzP3OtV4GerKDrYe@kroah.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 28 Sep 2022 11:42:27 +0000
Message-ID: <CACPK8Xe05Tnn8L4q3ppmwukE5PzMwOM-jH-4Rk4ihomo=U-0oQ@mail.gmail.com>
Subject: Re: [GIT PULL] fsi changes for v6.1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Eddie James <eajames@linux.ibm.com>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sept 2022 at 07:27, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Sep 28, 2022 at 02:54:58AM +0000, Joel Stanley wrote:
> > Hello Greg,
> >
> > Here are some FSI updates for v6.1. The hwmon changes have been acked
> > by the maintainer.
> >
> > The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:
> >
> >   Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi.git tags/fsi-for-v6.1
>
> One of the commits in here is wrong, I get the following error:
>
> Commit: bb70829cf3c3 ("hwmon (occ): Fix response length in checksum retry")
>         Fixes tag: Fixes: c27b98ca0edb ("hwmon (occ): Retry for checksum failure")
>         Has these problem(s):
>                 - Target SHA1 does not exist

Thanks for pointing that out. I'll send a new tag for you to pull.

Cheers,

Joel
