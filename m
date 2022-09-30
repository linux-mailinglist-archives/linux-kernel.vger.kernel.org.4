Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAA55F034B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 05:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiI3DZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 23:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiI3DZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 23:25:09 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC03CC14B4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 20:24:02 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x15so4369013wrv.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 20:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=KwtIAg7HwJ1rqqT+DnWl1VJ0hVA7c6T9lqyTYBLhets=;
        b=dnYVUdyV/UOJ+rvdo9lF+LmpB88wHEkW45PqT3a3eaHJwMU8paQRnrD1/o/htiX04y
         YohPdITF9BknKL9HidQDvJze6bd3Y3WzCP6Hj1KOdO0ZpbhNbBDjpZp/Vo4IAozImaXy
         l6i7kVBf4JBtjUwdrB7GO+GSFqolxELWQYIIMSFL2QhHhiav80UEsZa6Xz55oGwvabfZ
         0wWE53Xi8MgBYnvAvxlWA71NUX6w4YUUTtn8GGe64yITUvPEoZ70WqR/G0DSEmfNh6Wf
         CPCoOv2IPVywyqMz5EfwwVm3gFUyX8yEkXPdjqKFoBQzQ3Rpri1tUGDGzKjg6cx8PuV2
         ommQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KwtIAg7HwJ1rqqT+DnWl1VJ0hVA7c6T9lqyTYBLhets=;
        b=mtgMR63Y9Msq7toAm32cfiPUlEoJDo/EhyR5GLnPnLFljThqDxasBZ0dIcxIi3FDQM
         1ZaHayNBCZKDY9Z1XBQ8flrjQZmVdOGkugrN52i81rqzGIazf6195oX3k0lqln6G0QS2
         DmLJI2KgfVrM3wm7SNk3Smn4SLq2o/NxSKBiwi9JNUm2U3w8WlA7qJcqCkGxan8Pmejv
         lXnDemmMa3dbmSQ0KGqbztk6uOlJ8YJmwjgg/bH+0rik0HG0cPK4PVN2v9gsoTeAJhTD
         Fj3p+KHm+FcXuTTS8C+b9CEtTMd/P4dHD/7x0kuTt+HIHfOl+S0FbcJZektIBYXMVFho
         6d8Q==
X-Gm-Message-State: ACrzQf1+jZ7M9pCJjNq55RfEZT7zNSPueUW+78gMiiEXuqS8kHu1kSKJ
        mFPtIIj2NFzMg+n661+Ci9xgrbaMCrlhTGXfaLNj2Q==
X-Google-Smtp-Source: AMsMyM7XEtx+FTqXF6CXEzSTaxkaOHy1r/Gq/4I5ZCTlj+nvpKG7RLXTzZSSUlvdKx3n4BuDfdhITiiozf4JgGkalao=
X-Received: by 2002:adf:dd8f:0:b0:22a:84ab:4be3 with SMTP id
 x15-20020adfdd8f000000b0022a84ab4be3mr4215261wrl.40.1664508237708; Thu, 29
 Sep 2022 20:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnrHErOK+w878izVauHUKaX3eD-HXgigq2Ogm3iSj-fHA@mail.gmail.com>
 <76CB17D0-5A66-4D49-A389-8F40EC830DC0@sladewatkins.net>
In-Reply-To: <76CB17D0-5A66-4D49-A389-8F40EC830DC0@sladewatkins.net>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 29 Sep 2022 20:23:45 -0700
Message-ID: <CAP-5=fXVgwMO_CpS-EHN6PFhLB-J5Ft7qHz7oQd-WOMnTj72Cw@mail.gmail.com>
Subject: Re: Invalid event (cycles:pp) in per-thread mode, enable system wide
 with '-a'.
To:     Slade Watkins <srw@sladewatkins.net>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-perf-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 3:10 PM Slade Watkins <srw@sladewatkins.net> wrote:
>
> Hey Nick,
>
> > On Sep 29, 2022, at 5:54 PM, Nick Desaulniers <ndesaulniers@google.com>=
 wrote:
> >
> > I remember hearing rumblings about issues with zen 2, LBR, vs zen 3.
> > Is this a known issue, or am I holding it wrong?
>
> Hm=E2=80=A6 I also remember this. I have a Zen 2 based system that I can =
do testing on, so I will do so when I=E2=80=99m able.
>
> If I discover something of note, I=E2=80=99ll get back to you.
>
> Cheers,
> -srw
>

LBR isn't yet supported for Zen but is coming:
https://lore.kernel.org/lkml/166155216401.401.5809694678609694438.tip-bot2@=
tip-bot2/
I'd recommend frame-pointers.

+Ravi who may be able to say if there are any issues with the precise
sampling on AMD.

Thanks,
Ian
