Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF20746C8E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjGDI7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjGDI7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:59:31 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3F2137
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 01:59:27 -0700 (PDT)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EFEA03F734
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688461165;
        bh=Iq6cKg1bVkNflRBjs/XMRCMTTeQAcRlxHohCnato/0M=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=rpuWdPYUpR8GPErV/UPnnQ3qBkv3X6fVpqnzov8nRCK+/WSXtdYfYyAiqzxyJ0Ij1
         xEeuoIaAItjAPynP+z0hIN8sjdgLLZFmjQTlXaz+y6CvWPPEgirBRr6jJ4LCOXIwzm
         b2tB+xluPQj3QUHj5E9WiqOme7h4b3lS3ScjPe6kOn0N4CXcpwmE4+hk2t9Znsyal1
         pSqRc1B8NNqJQkctTXIKtO5RttzEiH0Hd7kLWkR4KqDb0psqRDzOhnZ+QdD9pIfv42
         fuY9sGQnb7KJnGI28erY29oW2Js54wtEeUpTXc1SmKN16wXaERaKbD5xF7lG0z7KYi
         ENCNJvZ8X/AgA==
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-67106f598b1so4820557b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 01:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688461164; x=1691053164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iq6cKg1bVkNflRBjs/XMRCMTTeQAcRlxHohCnato/0M=;
        b=gIXrMD9RPBCN9oqM/AqJ1YUQl77ltIlqgwvMQc2VyCbgxLGNNjMPeUPk/WQENEExmF
         eYxhtm0u6fvzNApTUuVX1S84En36Fq6QPc8gJRTvTL9gijnpuSFA/Ce5H6UUBU1fxnmD
         Tkl5oY/nQVxCoGJZQPjoaBk8NfDJ2fi5AfHcieliz+7VX5OQHLFCBt3lBVxILdCSAE0t
         avedr2sawuWD4WBbFG3q+Ud58stiSWvOnKGCS/63OU8AQLKnxSexY0GW2DEzhEPLnRvo
         6/BpkAf1yyXmy7Hl4sS03lRbV4T7VYAXXKWNp7jD+wUb6NVYuu2BzI74BVOZeO9eV2QJ
         gE5w==
X-Gm-Message-State: ABy/qLblfJXn8PRvacIiSDS0Kjo6W0tFHyMJTG/Sh6zOn36fDCLdSQ4/
        B0ZfN9lbZyZZkjDxJkNoWh5kh9Djo11m86dlczmCjWFgVGm03/7gx8dtRr9YqWQMHrN+bbShwnl
        SX6zx4id4xr5e1D4nEbCGCABdvEsJZtZ9SN3zxDPayq6FHb8/pYr2akLgSg==
X-Received: by 2002:a05:6a00:c8c:b0:67d:ccbc:5e81 with SMTP id a12-20020a056a000c8c00b0067dccbc5e81mr13255045pfv.4.1688461164103;
        Tue, 04 Jul 2023 01:59:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEA4BMzE4N8gwue1FHSWScEaB/ukcJ0jLDn6CFHKEFH69V6wIcnboq78jkqkyl7LecvUNNmcVKK25UHVuk3664=
X-Received: by 2002:a05:6a00:c8c:b0:67d:ccbc:5e81 with SMTP id
 a12-20020a056a000c8c00b0067dccbc5e81mr13255036pfv.4.1688461163739; Tue, 04
 Jul 2023 01:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230703162509.77828-1-koba.ko@canonical.com> <4ec2b7d2-11a5-6ab6-087a-175ed31faca4@web.de>
 <SJ1PR11MB60839A0FC6B5E79E3E5A7997FC29A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAJB-X+X+09-m57JcZcb-_9dKUG3CtAbLXxGTEg7R0bB8pyJx9Q@mail.gmail.com>
 <CAJB-X+XVO29wVxVezjFrgCyXigqEJxAzb0K0wueXNto5K_x2tA@mail.gmail.com>
 <9c27530e-21f9-15ce-5116-5af5b0c25f53@web.de> <CAJB-X+VjjxLi60k-6VNcypMB8EomJ0uYpDdfwpJ1dHPWRG7Vxg@mail.gmail.com>
 <706f49e8-d536-651a-2f19-394518633b53@web.de>
In-Reply-To: <706f49e8-d536-651a-2f19-394518633b53@web.de>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Tue, 4 Jul 2023 16:59:12 +0800
Message-ID: <CAJB-X+Wv6yeJLhWogopd5HyJADwLqSdmhfrh_P+-P02SEOACQQ@mail.gmail.com>
Subject: Re: [v2/v3] EDAC/i10nm: shift exponent is negative
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-edac@vger.kernel.org, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Aristeu Rozanski <aris@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 4, 2023 at 4:50=E2=80=AFPM Markus Elfring <Markus.Elfring@web.d=
e> wrote:
>
> > @Markus and all,
> > please review it, thanks
> >
> > Subject: [PATCH][V3] EDAC/i10nm: Fix an inappropriate shift exponen
>
> * Combined prefixes would be nicer.
Do you mean, [PATCH V3]?
> * Please avoid a typo here.

=3D> exponent

>
> > when get rows, cols and ranks, A special value combination could not
> > be handled so far.
>
> It seems that you stumble still on wording difficulties.

remove the previous sentence,
A special value combination could not be handled so far.

>
> > Fixes: 4ec656bdf43a13 (EDAC, skx_edac: Add EDAC driver for Skylake)
>
> You overlooked somehow to use double quotes here.

must be
Fixes: 4ec656bdf43a13 ("EDAC, skx_edac: Add EDAC driver for Skylake")

> Please provide the next version of a proper patch.
>
> Regards,
> Markus
