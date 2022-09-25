Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F8E5E9196
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 09:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiIYHzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 03:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiIYHzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 03:55:41 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434E61A071
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 00:55:21 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id n83so4898442oif.11
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 00:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=XJ0Z8vsVTn/Vd6LCihmKjoSXcpO91zfLe+joK/VV72c=;
        b=EOD228gFhDIRPpt3AjSXx6PMpOvthtcqHdDVzrIoS2qqrPcD2M2fziVKateT0eDPUG
         cE0k/JTvoDo/2Knw3Nv9xv6XGifQ6bbmFMVISNfkTe+Fj310R5dttIhOXqlJ0BOXpF6w
         oMfpBfYnRiGFIVZ9m+HAph8YiUYo9bjkaf+OIUQpIvlcrCYgpxiPktyJLlgIP5HrW4S5
         SIJc9Yf1IDN8eA2PPYgKsk91yIY9+DLmmdA2+eenHA6k/sTrPjETTcC1P/KcVkMoqDes
         rbyNuQz91VlWD2R+iNl7ZBwdCBj9RpNhjAzpO+Kg2fOSeNnKUU/QL/GNPlogM003KTbP
         U9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XJ0Z8vsVTn/Vd6LCihmKjoSXcpO91zfLe+joK/VV72c=;
        b=K7EA5M40JFmRpIOTfFEcPlUz/1f7LrgUz5hS1LbnOhvGgKXmSqd+KNY1JhM0vlfy0e
         AHNI018a4Gl3d67+SC+prBlq0WG9dnZXIuM6lq16g/rfJJVF85zulKMC5i76INfpBlP0
         0A3WcYXDmGS9Jvv8X1ppra/SLtulOMyreQko5WtEuxKdgA+eddGp9wfDRe9qSL2bSr0D
         Js6kS0Ny4tF3sh10TlYx1FYDbVTDBtQIdGq7UK8vVZnKod542NVFedeTHX1LSJPAW50y
         GmUNpKHZ6NsJaNi9slK+Dw1WpD+8SQicNQxIWJIrWz2NInIEQFSgN+Wm5K3yS0FoGVSI
         hvmw==
X-Gm-Message-State: ACrzQf12KJo6L25jwjwnxEeyLFGJ2LT4s7aR64Uir3sKtF2Hy7zh9ENb
        43YizVbjNyzKJDIcofL7e1/idOyKRBEFww+aj9F1zg==
X-Google-Smtp-Source: AMsMyM5dzzRrIpetjQtBq/tYvpPJN4WcKos+BmsvueHhRTEY/pwkFJOCAAumC3pAY7jtVOLCW7x943nsTQrL+MIQy4E=
X-Received: by 2002:a05:6808:2012:b0:34f:c816:cdf5 with SMTP id
 q18-20020a056808201200b0034fc816cdf5mr12421683oiw.45.1664092520381; Sun, 25
 Sep 2022 00:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220921114444.2247083-1-gregkh@linuxfoundation.org>
 <YyyH1oXMubeQ8KVu@shell.armlinux.org.uk> <CAPv3WKch2J4tteo68wOt_ETj_eYEKy8EC5sTwDvW6UZ-Gs_sCw@mail.gmail.com>
 <CAPv3WKcEa69vhrfE9h2XeuckDjvB=Y-HT7Y3fjV1W6gqYRmyjw@mail.gmail.com> <Yy/8FawjLnaE2Swj@shell.armlinux.org.uk>
In-Reply-To: <Yy/8FawjLnaE2Swj@shell.armlinux.org.uk>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Sun, 25 Sep 2022 09:55:10 +0200
Message-ID: <CAPv3WKcF-EXAbBoLLZWSJWzutSicx9aNLgU1Ah+MU3WXKEic1A@mail.gmail.com>
Subject: Re: [PATCH net] net: mvpp2: debugfs: fix problem with previous memory
 leak fix
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, stable <stable@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

niedz., 25 wrz 2022 o 08:58 Russell King (Oracle)
<linux@armlinux.org.uk> napisa=C5=82(a):
>
> On Sun, Sep 25, 2022 at 01:27:06AM +0200, Marcin Wojtas wrote:
> > Hi Russell,
> >
> > czw., 22 wrz 2022 o 19:08 Marcin Wojtas <mw@semihalf.com> napisa=C5=82(=
a):
> > >
> > > Hi,
> > >
> > > Thank you both for the patches.
> > >
> > >
> > > czw., 22 wrz 2022 o 18:05 Russell King (Oracle)
> > > <linux@armlinux.org.uk> napisa=C5=82(a):
> > > >
> > > > On Wed, Sep 21, 2022 at 01:44:44PM +0200, Greg Kroah-Hartman wrote:
> > > > > In commit fe2c9c61f668 ("net: mvpp2: debugfs: fix memory leak whe=
n using
> > > > > debugfs_lookup()"), if the module is unloaded, the directory will=
 still
> > > > > be present if the module is loaded again and creating the directo=
ry will
> > > > > fail, causing the creation of additional child debugfs entries fo=
r the
> > > > > individual devices to fail.
> > > > >
> > > > > As this module never cleaned up the root directory it created, ev=
en when
> > > > > loaded, and unloading/loading a module is not a normal operation,=
 none
> > > > > of would normally happen.
> > > > >
> > > > > To clean all of this up, use a tiny reference counted structure t=
o hold
> > > > > the root debugfs directory for the driver, and then clean it up w=
hen the
> > > > > last user of it is removed from the system.  This should resolve =
the
> > > > > previously reported problems, and the original memory leak that
> > > > > fe2c9c61f668 ("net: mvpp2: debugfs: fix memory leak when using
> > > > > debugfs_lookup()") was attempting to fix.
> > > >
> > > > For the record... I have a better fix for this, but I haven't been =
able
> > > > to get it into a state suitable for submission yet.
> > > >
> > > > http://www.home.armlinux.org.uk/~rmk/misc/mvpp2-debugfs.diff
> > > >
> > > > Not yet against the net tree. Might have time tomorrow to do that, =
not
> > > > sure at the moment. Medical stuff is getting in the way. :(
> > > >
> > >
> > > I'd lean towards this version - it is a bit more compact. I'll try to
> > > test that tomorrow or during the weekend.
> > >
> >
> > I improved the patch compile and work (tested on my CN913x board).
> > Feel free to submit (if you wish, I can do it too - please let me know
> > your preference):
> > https://github.com/semihalf-wojtas-marcin/Linux-Kernel/commit/0abb75115=
ffb2772f595bb3346573e27e650018b
>
> I don't see what the compile fixes were in that - it looks like my patch

I overlooked drivers/net/ethernet/marvell/mvpp2/mvpp2.h diff (I
applied patch manually), but I double-checked and it was there, so you
are right.

> ported onto current -net. Obvious changes:

Yes, it's applied on top of net/net-next.

>
> - moved mvpp2_dbgfs_exit() declaration from after mvpp2_dbgfs_cleanup()
>   to before.
> - moved definition of mvpp2_root to the top of the file (as no effect
>   on the code.)

These are irrelevant. The most important part was:

--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -7714,8 +7714,8 @@ module_init(mvpp2_driver_init);

 static void __exit mvpp2_driver_exit(void)
 {
-       mvpp2_dbgfs_exit();
        platform_driver_unregister(&mvpp2_driver);
+       mvpp2_dbgfs_exit();
 }
 module_exit(mvpp2_driver_exit);

Otherwise, I observed NULL-pointer dereference when
mvpp2_remove()->mvpp2_dbgfs_cleanup().

>
> and the change to port it:
>
> - dropped my mvpp2_dbgfs_init() hunk (because it's different in -net)
> - removed static declaration of mvpp2_root in mvpp2_dbgfs_init()
>
> I'm not seeing any other changes.
>
> Note that Sasha has submitted a revert of Greg's original patch for
> mainline, so my original patch should apply as-is if that revert
> happens - and I don't see any compile issues with it.
>

Sure. In order to avoid misunderstandings, I stop here and leave the
submission to you.

Thanks,
Marcin
