Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B33743542
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 08:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjF3GrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 02:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjF3GrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 02:47:05 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FA4171E;
        Thu, 29 Jun 2023 23:47:02 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b69923a715so22507931fa.0;
        Thu, 29 Jun 2023 23:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688107621; x=1690699621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcNkK7QhtQRZoNjiKnln1uOwjiN81JdIADWFEln4Gqs=;
        b=aSmIw/mI1MAA63imaZEWs1aayzhdfF/qzHVXPMXxDj2sfQL3hJb/GsXaOq6HzncTO0
         YLISEBjling3H8gOJhbIJrAqiach3LgoGVTVK8WGoR2Po4cdRHTKLet614EZhJsJ3XCy
         sjzdMj+Oa+YDPxfXmyNghnc+5OvNYpB7Gq50QFnM/bavLpkb59dIEibUHLLzheEW3EAk
         zGzt77/vsjlFbmGZDs7SU/DnyClwDMElrmbq2WJ50/p/sIVj31524qz3IViiNw0/zLTA
         57S6d7TYsDYmBKsBppOKaI7OCAbGzOrS3NFleI38h59CvQyi271RW+TzYzgbKjUXNgWq
         No5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688107621; x=1690699621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcNkK7QhtQRZoNjiKnln1uOwjiN81JdIADWFEln4Gqs=;
        b=SvJ4hlyfHLDOobYnSygGdWpbVQrqqTWVFyh6+Iag4oOMRJ53jxC95uZFp6jm3rd/pi
         mmmAG1/EXgpn/5lbdFi6R1o8tnLLHtSiGlS40lz8TZDjqzad+U6Ipx9UdpBJk2J7USP1
         Ra4fjb1IExnAnRKqqAj6zDmB+oUlyvtJ9hsT5knVQIm7d1lJswD4RURRXbc/jwZ9P5f0
         PZKvagnjhFemRQIgLS7BDPUf7/nLB82++kwsm6uBaNGAmHFObqKVhlJHbJ5DhIqZbgBa
         l1J6GSUtICGF4nxvVo5PUZNNySnZI/7DTgxU3NyIFSa6iplnPxKAZl/RMbZxEFMy2HQA
         SZoQ==
X-Gm-Message-State: ABy/qLain6d3OszCyDL6AkQGpPWfhe2sV9wiH7ididyh5RwTpIb3bMoy
        98EXtcgyVPvEEBqp8DeYQ5+BA9bjw1BCDgh2aWM=
X-Google-Smtp-Source: APBJJlEjsjhPjVs6yMnJWIlPta/rIeJe08ueSRiHjjIaWip/gjvY6o7yVIEmCRW4mUDfDV6SakPEv/CuiHCT6o2DgkA=
X-Received: by 2002:a2e:870f:0:b0:2b6:a682:9aaf with SMTP id
 m15-20020a2e870f000000b002b6a6829aafmr1741685lji.43.1688107620423; Thu, 29
 Jun 2023 23:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230609115806.2625564-1-saikrishnag@marvell.com>
 <880d628e-18bf-44a1-a55f-ffbe1777dd2b@kadam.mountain> <BY3PR18MB470788B4096D586DEB9A3B22A023A@BY3PR18MB4707.namprd18.prod.outlook.com>
 <3894dd38-377b-4691-907b-ec3d47fddffd@kadam.mountain> <SA1PR18MB4709E390AC13A1EF5F652165A02AA@SA1PR18MB4709.namprd18.prod.outlook.com>
 <5e222335-5baa-4ce8-a90b-69a865f29b1a@kadam.mountain>
In-Reply-To: <5e222335-5baa-4ce8-a90b-69a865f29b1a@kadam.mountain>
From:   Sunil Kovvuri <sunil.kovvuri@gmail.com>
Date:   Fri, 30 Jun 2023 12:16:49 +0530
Message-ID: <CA+sq2Cd0qXL+Cgi2EXJHXPYrCouPJQMJ+rCs22_2PJUfJXMK2A@mail.gmail.com>
Subject: Re: [net PATCH v2] octeontx2-af: Move validation of ptp pointer
 before its usage
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Sai Krishna Gajula <saikrishnag@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "maciej.fijalkowski@intel.com" <maciej.fijalkowski@intel.com>,
        Naveen Mamindlapalli <naveenm@marvell.com>
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

On Fri, Jun 30, 2023 at 11:16=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> On Fri, Jun 30, 2023 at 05:19:27AM +0000, Sai Krishna Gajula wrote:
> >
> > > -----Original Message-----

> >
> > As suggested, we will return error in ptp_probe in case of any
> > failure conditions. In this case AF driver continues without PTP suppor=
t.
>
> I'm concerned about the "AF driver continues without PTP support".
>

Yes, it doesn't make sense to proceed with AF driver if PTP driver
probe has failed.
PTP driver probe will fail upon memory alloc or ioremap failures, such fail=
ures
will most likely be encountered by AF driver as well. So better not
continue with AF driver probe.

> > When the AF driver is probed before PTP driver , we will defer the AF
> > probe. Hope these changes are inline with your view.
> > I will send a v3 patch with these changes.
> >
>
> I don't really understand the situation.  You have two drivers.
> Normally, the relationship is very simple where you have to load one
> before you can load the other.  But here it sounds like the relationships
> are very complicated and you are loading one in a degraded state for
> some reason...
>

No, the relationship is simple. Idea is to defer AF driver probe until
PTP driver is loaded.
Once the above is fixed there won't be any degraded state.

Thanks,
Sunil.
