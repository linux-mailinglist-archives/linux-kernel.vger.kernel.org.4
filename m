Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6580D63C66D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbiK2R3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236607AbiK2R3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:29:37 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12775E9C2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:29:36 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id u27so12119634lfc.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aD5oc0QwrG2TnqyLIJrzBbzVZiwFPElwGlGkyZCl8zk=;
        b=btDw6PMfvCRGORM4AhKei7iUsVQ+QolmBO309u3MjuJAZidvfrVTYH643w0UJXWKka
         VW4tFZKYSPEAs+1CE88cx3bZLa3jUwei+tbNL9+cmFAnq9pTF4T1P7pWRSgyfDZEKouH
         AFUiOWjzMZoFMAKmXVQHN8FHMHDOxRnvBU3EgSh90JsdTsbLHtJ98t2Bx6r9rgR3I761
         VmKKdqcnPYWbm3aN5NULKVgz9FvMAOQz2BhjCTtzozlBxImnQWvsYlGkNPcgjAfOczuJ
         dxCR+Gi0nDfdn42j1wDIayLeZiywTLosqc3ApBAn0cMr8xGtpMhxM1nxoIgqAO4WV2dq
         WhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aD5oc0QwrG2TnqyLIJrzBbzVZiwFPElwGlGkyZCl8zk=;
        b=1AgTIvgRXA9Y0doN7QXYErfEVta57O3M4PT/yqIWwwCMl6t+FmhW3nPHNKzjKst2RG
         CP/KTrFmjVYJYP1C3iAkZjtGmSDHVejOMdvzcLPGFmtPwLNRnf4B0HQ4wIsqTCaHSR2a
         pOI1/mpPZrpa+pxnbNLhjo8Xj9GyJRkcbaBW1cu5TRIIZ11W2mcc2U/5SC1Nx8MLwh80
         K/CxCIjgehw5dZkJHfABjq68Z2f1VZwh9oYOiShxn7cTphzoRK3WU6a9OFHpnitshv22
         cz7b3ylREKGJhY+mk5C7Im7yGJx8TYoNpWVCLugdOp0D1SdaRUmfNZ1ppUtqkO1qwvsE
         3O/Q==
X-Gm-Message-State: ANoB5pl0viIBSOUE2g387zkrDybN9oEweaykxQ1SDosmYs/9MT4Oqx2J
        3BN4L4sk2l7scMtWFQ9A7Z5kF5j3vnUw0xStb3ssu59yRUnB5A==
X-Google-Smtp-Source: AA0mqf7RDIA8+J1hOUmt5hXhtbmsqaYaDXTzey887mKw6bTyj1yX7R8GLUW5yoNZwVu4EWX+QCsWfp4NExWAIoHT+F8=
X-Received: by 2002:a05:6512:2285:b0:4b5:14bd:3d3c with SMTP id
 f5-20020a056512228500b004b514bd3d3cmr3949286lfu.186.1669742974651; Tue, 29
 Nov 2022 09:29:34 -0800 (PST)
MIME-Version: 1.0
References: <20221123191627.3442831-1-lixiaoyan@google.com>
 <20221123191627.3442831-2-lixiaoyan@google.com> <CACKFLin=H_j6Jy+1jZJiG5xuE=C41joZ_dPS_BZmBwcf7W1rHA@mail.gmail.com>
 <CACKFLin7Pzw5E+kZ8GyrMabcVyyOt3Mb96-J2fBE_=2E4xbS5A@mail.gmail.com>
In-Reply-To: <CACKFLin7Pzw5E+kZ8GyrMabcVyyOt3Mb96-J2fBE_=2E4xbS5A@mail.gmail.com>
From:   Coco Li <lixiaoyan@google.com>
Date:   Tue, 29 Nov 2022 09:29:22 -0800
Message-ID: <CADjXwjhii7fn5yxh78XXfzFinvoxkdBu7F8kwiWTdtOOMeuExw@mail.gmail.com>
Subject: Re: [RFC net-next v2 2/2] bnxt: Use generic HBH removal helper in tx path
To:     Michael Chan <michael.chan@broadcom.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Gospodarek <gospo@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-16.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Great, thanks Michael! Will send a new version of the patch.

Best,
Coco Li


On Tue, Nov 29, 2022 at 12:59 AM Michael Chan <michael.chan@broadcom.com> wrote:
>
> On Wed, Nov 23, 2022 at 11:42 AM Michael Chan <michael.chan@broadcom.com> wrote:
> >
> > On Wed, Nov 23, 2022 at 11:16 AM Coco Li <lixiaoyan@google.com> wrote:
> > >
> > > Eric Dumazet implemented Big TCP that allowed bigger TSO/GRO packet sizes
> > > for IPv6 traffic. See patch series:
> > > 'commit 89527be8d8d6 ("net: add IFLA_TSO_{MAX_SIZE|SEGS} attributes")'
> > >
> > > This reduces the number of packets traversing the networking stack and
> > > should usually improves performance. However, it also inserts a
> > > temporary Hop-by-hop IPv6 extension header.
> > >
> > > Using the HBH header removal method in the previous path, the extra header
> > > be removed in bnxt drivers to allow it to send big TCP packets (bigger
> > > TSO packets) as well.
> > >
> > > Tested:
> > > Compiled locally
> > >
> > > To further test functional correctness, update the GSO/GRO limit on the
> > > physical NIC:
> > >
> > > ip link set eth0 gso_max_size 181000
> > > ip link set eth0 gro_max_size 181000
> > >
> > > Note that if there are bonding or ipvan devices on top of the physical
> > > NIC, their GSO sizes need to be updated as well.
> > >
> > > Then, IPv6/TCP packets with sizes larger than 64k can be observed.
> > >
> > > Signed-off-by: Coco Li <lixiaoyan@google.com>
>
> I've confirmed with our hardware team that this is supported by our
> chips, and I've tested it up to gso_max_size of 524280.  Thanks.
>
> Tested-by: Michael Chan <michael.chan@broadcom.com>
> Reviewed-by: Michael Chan <michael.chan@broadcom.com>
