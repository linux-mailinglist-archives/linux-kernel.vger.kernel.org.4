Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF6F73384D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 20:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344193AbjFPSrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 14:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbjFPSrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:47:13 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0084A35AD
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 11:47:09 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-3409d944009so23015ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 11:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686941229; x=1689533229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p89jIZgCzbOnwHuA7sfuLhrqdvGB8exXX7N1OGRHHc8=;
        b=kVCCF5WNPluWzu8HBD+SS0ENvanutUA7LAgB0DDKZis0as6cvzPNG21eq4joxcMPOH
         p1uRVS10uMxxXuR14hePkC5wbtx72B5ayjFOU6jni+rZYmq8ZLOFw/spfV8zSQTmHfI2
         TFSzWi5ng88b2ne0OSNYQRRdWsng0PA2yNrfzBVucYuDMzAdOivAqYajj0IACLZGpgQT
         0hrFXJersIszLuhLo9l1poqSpyEozusaikRQU6eiXK+kif8E6FUh8+xfcdBlLRDqaicF
         UDrdH5RkS5BSSW4Um2SfkTe0s4Otg/lrSIUFLhQinrZk08pCeFKfW7wTNQKrWuuo0EQR
         oisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686941229; x=1689533229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p89jIZgCzbOnwHuA7sfuLhrqdvGB8exXX7N1OGRHHc8=;
        b=O0meS6gB0EUCYS26c+X+jrfAhh/zBJI+jt/pC2WH0yxW1rVRGOrNQV9DtqqMA9X2bK
         PvhWNgTEwPn3OfvoTskB0H2TlqFM+9+zYXMS6OMcomftqY1A6AWapEdNrvb1YWgJcF8R
         h3rHABOE332y1rnT3MZRf2rh33qVE26ev1N2+7RCQ+A5wRDd7yxdZ3nFQUpUe3BRP6aN
         YSrY/5WiVGtdl8I5txFIHk1KhoiliMImY5R3CzRtljv0U32LWKHimurAX8fXkO8uRAOz
         UBpIxItP2o73dX0vELxRVyzjU0D0FE3UEGRRDGhgbu0D1JyyoRY5P1Y7Wrq/yygqwSNH
         3zUg==
X-Gm-Message-State: AC+VfDwe5BvuIR6tDFaEmKL9BsfS1OSgc+8dfQseeeRvXjpKlwC+40iC
        uZHWELclnxMgNNplfsbP/VW57PxZspT3pEvySkXyAQ==
X-Google-Smtp-Source: ACHHUZ7sLu99m2m3o0HYgC6yYuSCh+NZktjsyUozVgqTM3QiVParr/gnxeNExLcHeRocM6Suy4WOZ/VBp3OUmDBZTj0=
X-Received: by 2002:a05:6e02:152b:b0:33d:79ea:9556 with SMTP id
 i11-20020a056e02152b00b0033d79ea9556mr77317ilu.18.1686941229293; Fri, 16 Jun
 2023 11:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230616133735.351479-1-jordyzomer@google.com>
 <20230616133735.351479-2-jordyzomer@google.com> <ZIykXq2U5XVZ4aB+@casper.infradead.org>
In-Reply-To: <ZIykXq2U5XVZ4aB+@casper.infradead.org>
From:   Jordy Zomer <jordyzomer@google.com>
Date:   Fri, 16 Jun 2023 20:46:58 +0200
Message-ID: <CABjM8Zc8H22YVJcHvPS0rROowYC_fhAikJ_dcevA6pr1G7=mDA@mail.gmail.com>
Subject: Re: [PATCH 1/1] nospec: Add documentation for array_index_nospec
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, dave.hansen@linux.intel.com, daniel@iogearbox.net,
        tglx@linutronix.de, rdunlap@infradead.org,
        pawan.kumar.gupta@linux.intel.com
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

Thanks both, I was planning on doing some plumbing next week to fix the
already affected calls and then add a BUILD_BUG_ON() in combination with
__builtin_constant_p() to prevent misuse from happening in the future. In
addition I'll send a V2 next week to fix the spelling/wording issue.

Cheers,

Jordy

On Fri, Jun 16, 2023 at 8:05=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Jun 16, 2023 at 01:37:35PM +0000, Jordy Zomer wrote:
> > +Please note that this function should only be used if the upper
> > +boundary is a built-time constant, otherwise this could be
> > +speculated on as well. If this is not the case please refer to
> > +barrier_nospec().
>
> "build time", not "built time".  Also, "Please note that" doesn't
> really add any value.  You can just write:
>
> This function should only be used if the upper boundary is a build-time
> constant, otherwise this could be speculated on as well.  If it is not
> a constant, use barrier_nospec() instead.
>
