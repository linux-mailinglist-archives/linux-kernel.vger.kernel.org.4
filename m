Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AA16B03FE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjCHKWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjCHKWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:22:40 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82F560AAF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:22:38 -0800 (PST)
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6561C41B65
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 10:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678270957;
        bh=IZX2P2PDAu+pnEbMonzs7jqoA1UArPkS2k3AE2jq/H0=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=H6eWTm6ABmMdXlaqCDTDsO+ahjH+irjxboX5I4mQuvNaopt0LHxOaEU0y1FegXS+L
         ePM6dY/cp16cXsHVkQ56gti9420DXfFo/dz9pyj03ZRRCuhXbTqV/Ym3ApPqh5ae86
         8xW45UrdRvGAU5Wb8XMX9n4aKT9NGUMWp+BCgHsNi4luolUdgqOt7+kEWNE0jB9e3S
         qyikCgc3W4HR+xPMzMkycKItMIPePZ2ZxNEN6Q93gwBIR7cbGxn7HY6hNtAKw0ING+
         XGbVwQHrs0I6g+bFoa+opip5TE7B2usNZTrP5OF9w3Xev0rVRui2bdEqMlADlQYEi+
         SQU6ysE6/3xnQ==
Received: by mail-oo1-f70.google.com with SMTP id r1-20020a4acb01000000b00525391d8aacso4874662ooq.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:22:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678270956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZX2P2PDAu+pnEbMonzs7jqoA1UArPkS2k3AE2jq/H0=;
        b=ZSaY7hjfqfpv1Aq6fXr0wERbKyPcUJI3CQBdWi/sllIy1by0z22Nka0uoRm8Fbqysy
         wXf08fY0JA6F1eTb6gfE6S3fGCYzNuV6oy9tMfIHUUol5bSf+hjzCmSdITJt46+GmU8a
         UKDKM4nYvoAZmPb6Lmo1SH1y/PdUAkA4ki5YGT0mRvZhSziNnngmRlSFuO/EptffgqXK
         oYj5GgJw+xSDlswTmb0fEbD9Z16k3iyUBiRGU0w8PAIutjQIlT6XLaPgyHd41cTleYZh
         vGIgMaa+MpSNj+FdVizOXCY8WWIVnOxtZyLlIr2Gi9HiTddor8rwFg2NG16yEUumpOyX
         H4bQ==
X-Gm-Message-State: AO0yUKWTNmOVKaAmqkA1Op8Zl4lh69p9dQomLnlbDNNpTfy50+buthvI
        Y6clWJQXLtx0d6svXfkM5vzUftenWaUlbjLrQeoTk6Jo+fKMRwG66fCK8caeF2Qe35EFw9ZabMJ
        9hehvhbdKJY5DqIzYXHbauo0fdardTmsujnKPUPAJIsWgQxLlP/cjFAlP
X-Received: by 2002:aca:1201:0:b0:37f:9a63:cdf8 with SMTP id 1-20020aca1201000000b0037f9a63cdf8mr5212715ois.2.1678270956408;
        Wed, 08 Mar 2023 02:22:36 -0800 (PST)
X-Google-Smtp-Source: AK7set/mQ1s0zMs/u5CTMfC7MW2q9oSbh3oy00o9tqBVeNEN8kN15z98gKBRMYYo4R06YleIK5Jp8ypDJ21XS+Ck1KQ=
X-Received: by 2002:aca:1201:0:b0:37f:9a63:cdf8 with SMTP id
 1-20020aca1201000000b0037f9a63cdf8mr5212703ois.2.1678270956191; Wed, 08 Mar
 2023 02:22:36 -0800 (PST)
MIME-Version: 1.0
References: <20230307150030.527726-1-po-hsu.lin@canonical.com> <ZAhV8nKuLVAQHQGl@nanopsycho>
In-Reply-To: <ZAhV8nKuLVAQHQGl@nanopsycho>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Wed, 8 Mar 2023 18:21:57 +0800
Message-ID: <CAMy_GT92sg4_JLPHvRpH542DPLbxOEYYoCMa2cnET1g8bz_R9Q@mail.gmail.com>
Subject: Re: [PATCHv2] selftests: net: devlink_port_split.py: skip test if no
 suitable device available
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, idosch@mellanox.com,
        danieller@mellanox.com, petrm@mellanox.com, shuah@kernel.org,
        pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
        davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 5:31=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Tue, Mar 07, 2023 at 04:00:30PM CET, po-hsu.lin@canonical.com wrote:
> >The `devlink -j port show` command output may not contain the "flavour"
> >key, an example from s390x LPAR with Ubuntu 22.10 (5.19.0-37-generic),
> >iproute2-5.15.0:
> >  {"port":{"pci/0001:00:00.0/1":{"type":"eth","netdev":"ens301"},
> >           "pci/0001:00:00.0/2":{"type":"eth","netdev":"ens301d1"},
> >           "pci/0002:00:00.0/1":{"type":"eth","netdev":"ens317"},
> >           "pci/0002:00:00.0/2":{"type":"eth","netdev":"ens317d1"}}}
>
> As Jakub wrote, this is odd. Could you debug if kernel sends the flavour
> attr and if not why? Also, could you try with most recent kernel?

I did a quick check on another s390x LPAR instance which is running
with Ubuntu 23.04 (6.1.0-16-generic) iproute2-6.1.0, there is still no
"flavour" attribute.
$ devlink port show
pci/0001:00:00.0/1: type eth netdev ens301
pci/0001:00:00.0/2: type eth netdev ens301d1
pci/0002:00:00.0/1: type eth netdev ens317
pci/0002:00:00.0/2: type eth netdev ens317d1

The behaviour didn't change with iproute2 built from source [1]

[1] https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/
