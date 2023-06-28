Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063A97412CB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjF1Nnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjF1Nnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:43:40 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F0D2690
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 06:43:39 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-4007b5bafceso241151cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 06:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687959818; x=1690551818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+iaMZwyBIh+11qrQSGLnV1Wu07chjDvH/4Aamfu59w=;
        b=HiMTruj17NQKh3aQ7JiBVNXSofLwSd76IwEZQnN9fPPiO0AR5W77NsPh8Xp1x/8WmJ
         X3jvWoRsB+ACfV3nd/3X/vxoF2kX4W46iMNnUjdCN6GLAPNcZ5Q/t/g9ds7XOI/QLI95
         i+FNnGNonBF+yaBMUPSFiNn9ec3Z59ujQhWG9iuHFSIZ3jn+/3y69xRMNtTFzkZeHDST
         PX5pgi9ER1J84aZ8NfvUV6uEEaU8JHRIuyPPsL9bxQnZBpD2kC9izUum41N3fwJNgAEa
         NL7PysDCTgPWOp5mgE/VOaRpiWsrKWJc6hP7c4QOnflz86dSOyjneePhQEFJYmCdi209
         PgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687959818; x=1690551818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+iaMZwyBIh+11qrQSGLnV1Wu07chjDvH/4Aamfu59w=;
        b=enFo+WD1E4kLX8WPkhJPaC5sHnuFI63GwyoJBerFJN7agHDf6ctAVTmm5MvHkDTx+y
         YDDNd6lj3x61JOmJeoQRgatJIEpd4Y3MzL4xHGqaBTHhflYqQL0+LlsaVWZyCSsmQXzY
         vnX3d+IFxMWq/bF+HYMNnE8LC6gQVlUBsYkTT1/Se6JmdJJi+cdc6fwQpDKOhv5wRhLp
         lyA29anJUiUfxPbkZlTnY3kUxiUVHFs1/0FAzAD2kL6pxuknD27M1K+P/Db3WEMqSXOS
         B+mU7XngRWTaoWvxCYqClQ+6ZbK74X8k8zcbJYp1+Y8WHhPL7Gplq0JoxqZ5fTpR65kJ
         JTWQ==
X-Gm-Message-State: AC+VfDwtLi68LIAWSjWuABxgMagtieehnihNODVRkiUj/O5b6eTp7Hc3
        X0OOXXyvZdEZBqhKrTgcfdzsHgTIjkmgUllg+4uDtw==
X-Google-Smtp-Source: ACHHUZ4WogTNREVg5u/95oFGa4sWXVU+6iCyc2kWX1TQbQZvq1XwK8rb+EFydSpQWW4vJUCNttfcK9GjATSMfRgTQDI=
X-Received: by 2002:a05:622a:1b9f:b0:3fa:3c8f:3435 with SMTP id
 bp31-20020a05622a1b9f00b003fa3c8f3435mr134285qtb.27.1687959818387; Wed, 28
 Jun 2023 06:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230621174006.42533-1-tony.luck@intel.com> <20230621174006.42533-8-tony.luck@intel.com>
 <CALPaoCi+A5TxoReh=HRMsRKYDWb4eQ-NOB75Lj9674L6aV0T=Q@mail.gmail.com> <SJ1PR11MB608334F6555F9CEF3F740DE8FC26A@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB608334F6555F9CEF3F740DE8FC26A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Peter Newman <peternewman@google.com>
Date:   Wed, 28 Jun 2023 15:43:27 +0200
Message-ID: <CALPaoChuVYpv2aEycaT85mf_2kyEpHcsKbaeZSEVP94i1QHTRw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] x86/resctrl: Determine if Sub-NUMA Cluster is
 enabled and initialize.
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Mon, Jun 26, 2023 at 5:52=E2=80=AFPM Luck, Tony <tony.luck@intel.com> wr=
ote:

> Thanks for testing and review. Did you also test on one of your systems
> with a memory-only node? I recall that was an issue with my very first
> patch series.

It turns out the people who reported the crash to me were running an
experiment, but they were able to find one machine they hadn't yanked
the AEP DIMMs out of yet.

It was a cascade lake, so I had to yank the CPU family match check to
ensure that your fix was actually exercised. I can confirm now that it
booted successfully.

-Peter
