Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FE4745D2C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjGCN0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjGCN0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:26:37 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA39E41
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 06:26:36 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b8baa72c71so1296133a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 06:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688390796; x=1690982796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqn7IKTdo14CySBv00ohACcAfgAIiWSh1E9RKmDPgr4=;
        b=Ek1UGhRgVlcOvIL06WHpGzgjgyHpvklDmtxMOactMDjhcaI4gwwV65eiGbrFnTuYMp
         sx+StujcB87IZnmVr0obLNhPZ3QtF3Hnn6KRTiSfoUNG34iq6GMQjbrGeO8blA+j2tvf
         h/kwO/mSVsgqvnw7MmKImnD9Pydwuvvhl5dLCVmInI1GKbEVxBZ0/2klnE3A77D9x7bU
         WI8PiUsuUjVZhuHi476SolDhvelKrfeWzquDbo/oNuoRyDoPM28I7yNszphIDppKjqcD
         nIvToQ+4GW88bXvZB5zKvNYfZ/SizZVOiU893uOtzX5iYcLUjFStPOA9WE2E32m0Xk2o
         XXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688390796; x=1690982796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqn7IKTdo14CySBv00ohACcAfgAIiWSh1E9RKmDPgr4=;
        b=iProFr/nTg//J96JR03b81M3aPJPsA1J4tQzFaxK0N1fZ1WDHR8xqovMiqCsKxziJK
         IvmPis/CvVJUIgi93cZXnq01pG82TRH0KVXGVuRFQuHJP3eauKzf/MpmbC+BVI+UZ/pP
         6nA7qx0nIuUHFtNu8+caMV5I9zhyd0wygGRyfiv4VgWirLJwzKScQnlbj8lCj/1vHyE6
         gskyBBRS3tvz8/5o2AI/gjvpraXy9p2DOXxzW/mVw7C1TXPf51Jz8GCISSF//RlQ7L5b
         GpW85O4/8Rm9c3mpSjdS1wl0X7RWwVj4QzJbVrXEob42PAP8dFjCenfPk2rQGMdMKx6+
         TH4g==
X-Gm-Message-State: AC+VfDysT0EiqVO9s98hlb1CgvCeTqEAayV9kMwPr/hF0/IFhPxiytae
        i4flB/JVHWHobvL/VEkNNiUZFLKvsvHR77RRNm0=
X-Google-Smtp-Source: ACHHUZ6uqGeljNO+21cjgetYX14NexS83zR1TTJuyVJ+ZqhjCxOYbav6ccfXjzVMlVGI0t01i24YsOMut9poxjZGFYM=
X-Received: by 2002:a05:6808:199f:b0:3a1:e7ad:11a2 with SMTP id
 bj31-20020a056808199f00b003a1e7ad11a2mr9346884oib.18.1688390795816; Mon, 03
 Jul 2023 06:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com>
 <CGME20230627161055eucas1p18d097cbcc2215b292c65a5b3a0f0e6b5@eucas1p1.samsung.com>
 <ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com> <9b778d59-c8d5-b037-0eb7-34cee5f273cc@samsung.com>
 <CABfnBFoZ=gh2rkY_oYWzjkGcu8HPQ2FqnrnushH0DZFSi8cwOg@mail.gmail.com> <50723e0c-370b-7e4f-338c-401998739fba@samsung.com>
In-Reply-To: <50723e0c-370b-7e4f-338c-401998739fba@samsung.com>
From:   Clemens Springsguth <cspringsguth@gmail.com>
Date:   Mon, 3 Jul 2023 15:25:58 +0200
Message-ID: <CABfnBFpZJ=kToimneFgs87i=yL37Z8_MJ5nL6NUpW9w6mFSyjw@mail.gmail.com>
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Martin Belanger <martin.belanger@dell.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        John Meneghini <jmeneghi@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux NVMe <linux-nvme@lists.infradead.org>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Jinhwan Park <jh.i.park@samsung.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
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

On Fri, Jun 30, 2023 at 6:21=E2=80=AFPM Pankaj Raghav <p.raghav@samsung.com=
> wrote:
>
> On 2023-06-30 17:18, Clemens Springsguth wrote:
> > Hi Pankaj,
> >
> > i would be very very grateful if you would create and submit the quirk
> > as a proper patch.
> >
>
> No problem. I will send something soon, but could you test it and
> give me a tested-by tag when I send the patch? I don't have that
> model at my disposal.
>

Hi Pankaj,

I am available for testing with pleasure.

kind regards
Clemens
