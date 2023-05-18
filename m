Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D21F707C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 10:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjERImp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 04:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjERImm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 04:42:42 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000DCE6A
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:42:40 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-969f90d71d4so270411966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684399359; x=1686991359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyiZQgT36LsZr8g4X4z/pK8Lc4mslR2lhG8l35ElJJs=;
        b=jX6ZMr1gj6JTheUW2U82Au/CqQ2LMduUavE0++1b0iZFUl+GxiQawna6AP/el6Bp/q
         8n1RP8rl6Woc1M4igGN7Uiir+TMJa2x8ldZiaMZxNceM4oED/iTznplNsPYXiMY6Md4l
         VgtQuYkytnxOUqRrkOB9GuZbHrdNvxeOH30Mz1w+pP8dpymVCe54gAW04ErXWnu11nUq
         OgoEevEPfauSZfKxFxB5AS93/g2OONXtDU28QvURhlee/OKt/fEGrF2TrMOnvxff5Czs
         Yf/PnDPMBKTsGX0BbhnNEx3Lla8HsC8SMZaXC5ohiXtaA9V4RWR0d9HPQF8kscTqsL7M
         8MyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684399359; x=1686991359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyiZQgT36LsZr8g4X4z/pK8Lc4mslR2lhG8l35ElJJs=;
        b=efYmB6qoTS/UVdzGny9Qv242dWwj9Hm5Qf4255VvlwCZ8WgWvOucL9JgznVtkzRHDK
         9b3xmJcCSVFAvhbgyRYYVuXoGnThJoQ60eYtrlD2ybq2SG/o1LYLk3QNse4Yb+93SoF3
         CZf3WT5e7qqdZ+ox1WR8muXPiODoqfd18yvYUD8UuTI0arftvItGHClAyVYT6DTHNoBH
         OGRK5Fy5yFyRBb53jxpgS4gFtZPxhh1ombqZt6421gZlxS+6qzqAZxLTC1OTTbyGMRVV
         FHvz0bUhN/t/7ou66f7Njb6XTDK1wpx2KS8/6m45iqqYPvOdosAX5abKEBbg1R4daTkN
         aIQg==
X-Gm-Message-State: AC+VfDxTTwODCQOG1xHLll0HayyHwbRmPtv14QgDgdqIuYWlgSb8urBs
        4Zqb8L/5W9n0u2sDFeX/QogjJUOG+96AXCbv4giuyA==
X-Google-Smtp-Source: ACHHUZ5lVM3rBQYMsSwl1ZV4Nb1nlmzzwn8SEosCeirRzNgYGUo1cUR9zwyGTnuxyAJUwIadfPrUyeHsbLc8/xIjXqw=
X-Received: by 2002:a17:907:168d:b0:969:f677:11b9 with SMTP id
 hc13-20020a170907168d00b00969f67711b9mr35672579ejc.54.1684399359308; Thu, 18
 May 2023 01:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230515121521.30569-1-lmb@isovalent.com> <a29c604e-5a68-eed2-b581-0ad4687fda10@linux.dev>
 <CAN+4W8hixyHYOwYRh-3WedS-a0KTQk8VQ4JxqM8y-DQY-yjsNA@mail.gmail.com> <a453c3d4-5615-f445-17a8-92a1dc4282e6@linux.dev>
In-Reply-To: <a453c3d4-5615-f445-17a8-92a1dc4282e6@linux.dev>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Thu, 18 May 2023 09:42:28 +0100
Message-ID: <CAN+4W8iDy8w=aVErrSKA1OqJ7Onv3eszYOKHLr+zucfHRuHsVg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: btf: restore resolve_mode when popping the
 resolve stack
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 2:42=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 5/17/23 2:01 AM, Lorenz Bauer wrote:
> > On Wed, May 17, 2023 at 7:26=E2=80=AFAM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
>
> I can see your point to refactor it to make it work for all different BTF=
_KIND.
>
> Other than BTF_KIND_DATASEC, env->resolve_mode stays the same for all oth=
er
> kinds once it is decided. It is why resolve_mode is in the "env" instead =
of "v".
> My concern is this will hide some bugs (existing or future) that accident=
ally
> changed the resolve_mode in the middle. If there is another legit case th=
at
> could be found other than BTF_KIND_DATASEC, that will be a better time to=
 do
> this refactoring with a proper test case considering most bpf progs need =
btf to
> load nowadays and probably need to veristat test also. If it came to that=
, might
> as well consider moving resolve_mode from "env" to "v".
>
> btf_datasec_resolve() is acting as a very top level resolver like btf_res=
olve(),
> so it reset env->resolve_mode before resolving its var member like how
> btf_resolve() does. imo, together with env->resolve_mode stays the same f=
or
> others, it is more straight forward to reason. I understand that it is pe=
rsonal
> preference and could argue either way.

 Okay, let's drop it then :)
