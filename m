Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC62712673
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243330AbjEZMTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjEZMTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:19:45 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55B8A4
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 05:19:43 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-ba827a34ba8so1189898276.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 05:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1685103583; x=1687695583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHsdIxAYeMANZULb6GLWJmQC7c45qZjIT81elj1fddI=;
        b=lSJYGnqeQY7cNwiJUUTnU31YRBaYTiGEAM5UbYyrnHolLQt+Z9wiJH08UyUunhr38K
         1XO2+rS24yyFIv0efH1UnT+Ma8A5UB5ttQhwqoPodZEeLO9fJFq6AohUXp7/5HzvLnJq
         OIeuNMtgdyCng6SAjiFmDrOfKUu0Aq+FEF/VPys5BwuJoogGjgfl1WpVUl6OzwsEqEYw
         tdLi51TSe1RKUup5yvobDkGwWBrkP4Gb0tXRaYGLbXzEzFN96Q/p4CLl/yeZ7/ziSJnI
         5ZIIDLmg5NRzqAoO74SANVIhACpt34SUt9eEa08lJhxmisg0p3DfbesRIZE8TfEKL1Yq
         kmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685103583; x=1687695583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jHsdIxAYeMANZULb6GLWJmQC7c45qZjIT81elj1fddI=;
        b=T0rThizC3edZPB9jSjLV5OPOfyj45nmKD3OuXt4+RH5uc1DYlOnjjkVctUVOxn2g+S
         M35tqVuAxwq5jyMoP6+oZ6KwPaLdUcuIVd3k3SlrU1+7LJkVnkft6E6C8KiV9P2I8zfT
         ZFghAj6W2m7BFqDbxotPmeGan/gQvuwbZk19e3lvdPmhof4FlpBbKygQf3Xk59tonkS4
         bNw9r/sCDF/shNYbvzx/EmEQDIrcQDfVHR3UD/PQTyUKLp1+Xs48E2LpXR/MDOtnCPf4
         agurffZ9DMmkAk0f0D8cqAqcHWs566sx6ut+6AlUd/4220zwq1s+pbRnvThqDZmGWALr
         hdlQ==
X-Gm-Message-State: AC+VfDzxPXEHTlnR+aThXSIlX0KA3YskDhdMRAeC9VBajMXVieC4u8nT
        pJWyl/rKBA77vAwVMhH90bgn/d/fTsXVx//cE0DWsw==
X-Google-Smtp-Source: ACHHUZ6TR8aeEsFNfAjEOuHAuaWt7JWI/7ObSKbm04REWHMNhaCJaos0b7KfEN3AtBAAwszyMAqtvmTJQixwwbC2zu0=
X-Received: by 2002:a25:cbd3:0:b0:ba8:8162:2538 with SMTP id
 b202-20020a25cbd3000000b00ba881622538mr1640458ybg.42.1685103583132; Fri, 26
 May 2023 05:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1684887977.git.peilin.ye@bytedance.com> <429357af094297abbc45f47b8e606f11206df049.1684887977.git.peilin.ye@bytedance.com>
 <faaeb0b0-8538-9dfa-4c1e-8a225e3534f4@mojatatu.com> <CAM0EoM=T_p_-zRiPDPj2r9aX0BZ5Vtb5ugkNQ08Q+NrTWB+Kpg@mail.gmail.com>
 <c536fcd795f74016928469be16fe21df8079a129.camel@redhat.com>
In-Reply-To: <c536fcd795f74016928469be16fe21df8079a129.camel@redhat.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Fri, 26 May 2023 08:19:32 -0400
Message-ID: <CAM0EoMm5R1qmqz+Pn2_Mawur0_PK070p2zw4Y+EqDwYNF2A6=A@mail.gmail.com>
Subject: Re: [PATCH v5 net 6/6] net/sched: qdisc_destroy() old ingress and
 clsact Qdiscs before grafting
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Pedro Tammela <pctammela@mojatatu.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Peilin Ye <peilin.ye@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        Hillf Danton <hdanton@sina.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 5:25=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Wed, 2023-05-24 at 12:09 -0400, Jamal Hadi Salim wrote:
> > When you have a moment - could you run tc monitor in parallel to the
> > reproducer and double check it generates the correct events...
>
> FTR, I'll wait a bit to apply this series, to allow for the above
> tests. Unless someone will scream very loudly very soon, it's not going
> to enter today's PR. Since the addressed issue is an ancient one, it
> should not a problem, I hope.

Sorry I do not mean to hold this back - I think we should have applied
V1 then worried about making things better.  We can worry about events
after.
So Acking this.

cheers,
jamal

> Cheers,
>
> Paolo
>
