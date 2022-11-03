Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608E861785C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 09:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiKCIHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 04:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiKCIHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 04:07:39 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2644632F;
        Thu,  3 Nov 2022 01:07:36 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id y16so1402013wrt.12;
        Thu, 03 Nov 2022 01:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GcIGqPOa10v06aLIXgn+5GXP6MAwOJhEwURiBI3VGnM=;
        b=QPuERkKHwBbrFrAJq9SOw+GtvmExxWW/S/DbqIRKSJiUjOmyab9PWipwkHkBBHU7Se
         lPO/gKd01DLySmnCRhgi2ACwnHyX2D0p/lTEHoav69m5YT7qSifdh40xppCRcWJLRgw2
         E1ouJ70qBcqsjitcTkDVEcfIMKDDB5N/Ftk7UfDqtT8sjmlylMvmy0nJeljSyWtTP/8Z
         kSRVSgmpj2OIDRvOHaeQ3lsG1SxOYGH+nqdA6u+CWMkzzQ2KmMaBG7OrC4YRhzVqxorQ
         LWT0xd6hBAZSbxJtF8xEFW8F0Jt3Y+4wdTFPtLKkyrbea9QeFlVscHsh9zkWdSJRfll0
         uCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GcIGqPOa10v06aLIXgn+5GXP6MAwOJhEwURiBI3VGnM=;
        b=bwAAmOKycakYr+nSN/S2hjrNfBp8XSqL2uyRD9DEtifuM+FCAZpDZjdZaEIa6Bu9ab
         At7DSoXR2qELSy15l6BxbwLXHo5z7Uj1QnpiOZuBSD4U8C1Xo5W0ljvI2bVOBr2fhjCt
         aBNSA6oFdJBNKw4txRtHG3noF6l/8bGyvN2d+neTQruTVLYU6efw8eRhOirv5GyHMsy2
         Ur5smolL+6twGbUqxLiFMfxb4SjF4hbhGbuLTFH3tQA3jO8m83GxlUmJIbQQ7cmHZ6mI
         cpMCz0AY4N2r/L8eClklE8L5v/grKdM6pkYmI5gnMFt83iYztYUqHGVM65lsMw+hMFeb
         2Y7g==
X-Gm-Message-State: ACrzQf1qQ3LVIRj9zHEm0RmbmVtGSw78mAwXNzNtw3fPTHqchdhabPYO
        1Y9hJMpRguTNXZMkIGEapahHmucX56KMEy1qyCg=
X-Google-Smtp-Source: AMsMyM4vRVojAzjb5nlKKs2EweGb7JPSREdWAE6agvoLhzzPpFXRgKfeZwCizsL21dTRBo3UWVgB7EGttUO7k3/BU+0=
X-Received: by 2002:a05:6000:186e:b0:22e:5dd3:e32a with SMTP id
 d14-20020a056000186e00b0022e5dd3e32amr17685846wri.167.1667462855253; Thu, 03
 Nov 2022 01:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221103040321.56233-1-dolinux.peng@gmail.com> <ea7fba87-6132-5f05-6c1c-7afc8d576b89@intel.com>
In-Reply-To: <ea7fba87-6132-5f05-6c1c-7afc8d576b89@intel.com>
From:   Donglin Peng <dolinux.peng@gmail.com>
Date:   Thu, 3 Nov 2022 16:07:23 +0800
Message-ID: <CAErzpmsxu_SLRQWX8DhizF27bupxf-=+wq7av03vLsOHJVaxDg@mail.gmail.com>
Subject: Re: [PATCH] perf tools: exclude the include/perf/ directory
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 3, 2022 at 3:08 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 3/11/22 06:03, Donglin Peng wrote:
> > Commit 3af1dfdd51e0 ("perf build: Move perf_dlfilters.h in the
> > source tree") moved perf_dlfilters.h to the include/perf/ directory
> > without updating the .gitignore file, causing new files in the
> > include/perf/ directory will be ignored.
>
> Note:
>
> include/perf is ignored because it has 'perf' in the name
>
Right.
> Can check:
>
>  Before:
>  $ touch tools/perf/include/perf/junk
>  $ git status | grep junk
>  $ git check-ignore -v tools/perf/include/perf/junk
>  tools/perf/.gitignore:6:perf    tools/perf/include/perf/junk
>
>  After:
>  $ git status | grep junk
>          tools/perf/include/perf/junk
>  $ git check-ignore -v tools/perf/include/perf/junk
>
Thanks,I will modify the commit log and send a v2.
> >
> > Add !include/perf/ to perf's .gitignore file.
> >
> > Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
> > ---
> >  tools/perf/.gitignore | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
> > index a653311d9693..fd7a6ff9e7aa 100644
> > --- a/tools/perf/.gitignore
> > +++ b/tools/perf/.gitignore
> > @@ -4,6 +4,7 @@ PERF-GUI-VARS
> >  PERF-VERSION-FILE
> >  FEATURE-DUMP
> >  perf
> > +!include/perf/
> >  perf-read-vdso32
> >  perf-read-vdsox32
> >  perf-help
>
