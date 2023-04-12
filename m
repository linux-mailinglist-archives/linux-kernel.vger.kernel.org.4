Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346386DFBD0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjDLQvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjDLQut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:50:49 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731627DB3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:50:26 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id i20so16152223ybg.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681318171; x=1683910171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txytFHb+OHcln9Jf1NBW9iIGnvsknm0ej/9O1NbRSBA=;
        b=YCiMefLv7nAtRiyKLvPC/8BYbWdlg8KJHhZQHd0CxqSg7iV7nQAw5pqzArjCBGixm2
         zXot5iJgoLWZ/mK4MVGNMewp24ea/PJs4lj7gftpyJoxUQ5uEGx4IdZY/EQVLitmk5KT
         6ngATDCRYblqj+B0U1bzhFjQa5iLAHDqJvkXlS/ZDP2Eo7rR1w9yz58ujd5MViELpVAq
         OmpZ5GqBK8mjF7ukPZlsCKOxgN0nvkgd1x4pk/BKp8j5bhsOi2o4eX+1dg38ehnE6qhT
         Gtxmarv5LBiqSRfXB2Gg7aBXYEzNH25VP+nmYn/8974Pg14ZikPkZ6kjrUcFYDFyWjM2
         ddCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681318171; x=1683910171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txytFHb+OHcln9Jf1NBW9iIGnvsknm0ej/9O1NbRSBA=;
        b=AFfod8gkPTzeK3DRKHXtmIlfZQqB4oReMXqv+377SqXo0+zjWrc3mECRIZFnc59q24
         hKGMKH4BWtbS/YtwhSoemZhsYYOHSyTs8ZGI50h8rY1HXO6eVzgmBWdWHGyJGsfO296z
         +HUfRqlS6nkfNLXsZ+u6s+UMwm9YkYxlv2dX/LqdFLiUnBzlGVXXqVr1YxoPaAztEWD3
         b6FvvE/ISQoQ5vxj+2jUCWVcGNWIHKaBRpvJeAEFsd/ReI3M6Pi3TfKAuY4ybnjQqJO0
         h+IR2bSFa/IaRO2CpQt7KGQ96Gk477GFqTuwq2yO0LQDEKh7KgqBQ3sfkrcpZvpU84Cy
         hI2g==
X-Gm-Message-State: AAQBX9e04pCKfRjCpvnXJx208SzCRD1bX950n+Swz+dSyAuc6tpCz1er
        SiQw95btr21qf0po5xR8YSSvs5VLSF3185SmAUTqqg==
X-Google-Smtp-Source: AKy350YfkY17PxsGQIapL7gdy+Rji3Kd9I7ld/GOAZaRrOshkDZOZjSrKDCizss68KYy7UVaIQC9fVpZ1hGrDSiQdH4=
X-Received: by 2002:a25:d4d7:0:b0:b8f:37ae:b75b with SMTP id
 m206-20020a25d4d7000000b00b8f37aeb75bmr1737335ybf.11.1681318170406; Wed, 12
 Apr 2023 09:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <ZDZ4j7UdBt32j28J@dhcp22.suse.cz> <ZDZqYTSHBNGLq0zI@dhcp22.suse.cz>
 <20230410073228.23043-1-jaewon31.kim@samsung.com> <20230412085726epcms1p7d2bec2526e47bd10a3b6ea6a113c9cc3@epcms1p7>
 <20230412094440epcms1p445319579ead0d0576bb616ebb07501b4@epcms1p4>
 <CGME20230410073304epcas1p4cf3079b096994d69472b7801bd530bc7@epcms1p8>
 <ZDaP4/PYyb9tKGQi@dhcp22.suse.cz> <20230412113759epcms1p8cb15b54e3a96c7616419cb030d16f804@epcms1p8>
In-Reply-To: <20230412113759epcms1p8cb15b54e3a96c7616419cb030d16f804@epcms1p8>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Wed, 12 Apr 2023 09:49:19 -0700
Message-ID: <CABdmKX2fA2nXaSb8k+LE1yeso=ZnboDtxhzmjzrS35GSKv73hQ@mail.gmail.com>
Subject: Re: [PATCH v3] dma-buf/heaps: system_heap: avoid too much allocation
To:     jaewon31.kim@samsung.com
Cc:     Michal Hocko <mhocko@suse.com>,
        "jstultz@google.com" <jstultz@google.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 4:38=E2=80=AFAM Jaewon Kim <jaewon31.kim@samsung.co=
m> wrote:

> Yes I think you're right. As a allocator, dma-buf system heap looks to be=
 loose
> in memory allocation. Limiting dmabuf memory may be required. But I think=
 there
> is no nice and reasonable way so far. And the dma-buf system heap is bein=
g
> widely used in Android mobile system. AFAIK the camera consumes huge memo=
ry
> through this dma-buf system heap. I actually even looked a huge size requ=
est
> over 2GB in one dma-buf request.
>
Hey can you point me to where you saw a request that big? That's a
non-buggy request?!
