Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD476C76F9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 06:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjCXFWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 01:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCXFWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 01:22:34 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAD91A48D;
        Thu, 23 Mar 2023 22:22:33 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id le6so844910plb.12;
        Thu, 23 Mar 2023 22:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679635353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBa50m/i08i2+AVQzWe3vhh1DYK9aNeOUnlAXKEeiMk=;
        b=ow+/YWYP8cw471S8dIhMoQRLi5YE/7c3wMi6ulFl1RFEkfrzG9K8vuY3iIPnT9CbvL
         2yBNWQNXPY3vPOc+Z9VZrs5qU7xVxtsOKtAGV/K4YhkyMx7MnBp9RwcDLHUDsCoOHzKS
         nIs3WJ/adxlGblLzRE2ZWWVfdtbDY90uzLvrKZAY4Nx1t5SF0L3YbZ3H1+G/B3SfezKC
         /7MeVuGmQvYUUYpT7Be9FbzVGdqIpZWyxuSjcPuXVpAc3g994oaRHMci8T5aAnMHUX8G
         EvVng4ztjh4ryz2rwaWRkgu82DzLrlHlZjQ9+TvdvbU9oc+hKpPTkhj2zngDNJstnjsv
         TwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679635353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBa50m/i08i2+AVQzWe3vhh1DYK9aNeOUnlAXKEeiMk=;
        b=69ajj1uchF8RIW0EZXCMA0NaPQ+jk1OlcZJbSDAzosD62B9zmc4OlYl32ojAQEEgqG
         ylCkiYjncBw2/SPoROLqeOHE3NDhz9I5CYOCWR3cHZo6yQ/UgDr/mRW4IanewtumLaXZ
         9iuAJQVqwEXzRV5RaHL2aSlTtLjIPeHNRFMUVitT6wow6ihXvjA9e+KWH/cyxV+pLXf+
         n3InzuDkHYiELbWgjBTsFI68fTCBr3h3XxIcc2JrrkgVxDfuQqndsW/X0Rz8+vT1X6Vu
         8++HVux5rDmECXY2dAZXwrCcHQ82w4pmUn1Ajm4TKAqGLR6wNRUY+wfes1ohF5QtNebQ
         xtDQ==
X-Gm-Message-State: AAQBX9f9luWzbrlxKkSdrRs8j20WDMt/qq7uPPRN++XvJ2Hmr8H0nIh/
        fOg3Ryuuv2BRoW3NatHUIizdJ+KGol4r1KkCnn8=
X-Google-Smtp-Source: AKy350YX1SkealeekR91Rmq68XEMrMxNDCiz4zvq58D9Otfq1guD+BQW0T8pWpKdTVCSjDoEarZR35T3NFIumKOXKS8=
X-Received: by 2002:a17:902:7c81:b0:1a1:f44c:8b98 with SMTP id
 y1-20020a1709027c8100b001a1f44c8b98mr397249pll.12.1679635352986; Thu, 23 Mar
 2023 22:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230323095311.1266655-1-mx_xiang@hust.edu.cn>
 <ZBxy9LYz+JyNW6GY@kroah.com> <8271c37c-4995-445c-89b7-90848f7ef3cc@hust.edu.cn>
 <adcd6c67-cedf-4831-9a9d-53c3ee2ebb88@kili.mountain>
In-Reply-To: <adcd6c67-cedf-4831-9a9d-53c3ee2ebb88@kili.mountain>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Fri, 24 Mar 2023 13:19:29 +0800
Message-ID: <CAD-N9QX+MvO2e+36Eip37mxtiPjSJs2zfBhP+mjwk43SSYXsJw@mail.gmail.com>
Subject: Re: [PATCH v2] usb: dwc3: host: remove dead code in dwc3_host_get_irq()
To:     Dan Carpenter <error27@gmail.com>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mingxuan Xiang <mx_xiang@hust.edu.cn>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        hust-os-kernel-patches@googlegroups.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 1:17=E2=80=AFPM Dan Carpenter <error27@gmail.com> w=
rote:
>
> On Fri, Mar 24, 2023 at 09:46:40AM +0800, Dongliang Mu wrote:
> >
> > On 2023/3/23 23:40, Greg Kroah-Hartman wrote:
> > > On Thu, Mar 23, 2023 at 05:53:10PM +0800, Mingxuan Xiang wrote:
> > > > platform_get_irq() no longer returns 0, so there is no
> > > > need to check whether the return value is 0.
> > > How did you find this issue?
> > >
> > > How was it tested?
> >
> > Hi Greg,
> >
> > We found this issue by Smatch. Our team is trying fix some true bugs fo=
und
> > by Smatch, with the help of Dan.
>
> LOL.  What did I do to get thrown under the bus like this?

Oh, my apologies :). We are a team. We together would like to fix
kernel bugs and do some contribution.

>
> >
> > Since this is a dead code removal, we only do compilation testing.
> >
>
> Just v3 and mention in the commit message that the issue was found by
> Smatch and the warning message that Smatch prints.  Put under the ---
> cut off line that it has only been compile tested.
>
> Also we needed to send a v3 anyway to remove the {} curly braces.

Yes, I have asked Mingxuan to craft this v3 patch.

>
> regards,
> dan carpenter
>
> --
> You received this message because you are subscribed to the Google Groups=
 "HUST OS Kernel Contribution" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to hust-os-kernel-patches+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/hust-os-kernel-patches/adcd6c67-cedf-4831-9a9d-53c3ee2ebb88%40kili.mounta=
in.
