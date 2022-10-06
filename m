Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEED15F5D9C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 02:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiJFATd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 20:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiJFAT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 20:19:28 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C437A768;
        Wed,  5 Oct 2022 17:19:26 -0700 (PDT)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 2960J5I8015309;
        Thu, 6 Oct 2022 09:19:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 2960J5I8015309
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1665015546;
        bh=itNOCR5gHtTQrdnJYXTJ9ngkBQvQLMn5fhd9zkw7mxE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EI3lpVwylC1M2wCxCFRUzbXfsMuANn43jr19db5l/53yqpzVUC6+6Z9pCw5edYSsy
         gv34wuXqw76s9fqJ3sQnWux4NSijZGnKjmjm0e6dBcbO3xNZaYHBfjcpEjxQ2sybrf
         gfFvEaaXZof+0TxlWHksSbjvOdYjtCh5qqdf0gy91tYCww7SghGngVtwueiTSt5vVf
         mXny5wVZaPXVDxrZmvBLlh7JE4etreJGeJe0Kfg7y2Trdmdg2Iy1sE737iicBZ9CmW
         KukSS074jpxrECiXl3XGPYe89wjpTYQTvDRR1MB2+zhpPnpdMHOMZT50tjDby0ohxn
         l4PxFTskQszlA==
X-Nifty-SrcIP: [209.85.160.50]
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1326637be6eso480526fac.13;
        Wed, 05 Oct 2022 17:19:06 -0700 (PDT)
X-Gm-Message-State: ACrzQf3DMgHDxuoNDEPc72UpuGRO9980cO6xEP2kAwsBrxSuAeQtod7K
        fFsxXiG/WAxyvKfZtYIQ4Ym8OJS0+/EOLrUkks8=
X-Google-Smtp-Source: AMsMyM4LZp9IHbDPVhKdcdqhFmwxHOwXb30w+ZDcwdrOF2TcxdbsSMat7DRkf5Zhi/Vp8IfqzcyQM7iEtVyJCnTdfLA=
X-Received: by 2002:a05:6870:8a09:b0:132:554d:2f3d with SMTP id
 p9-20020a0568708a0900b00132554d2f3dmr4011406oaq.194.1665015545341; Wed, 05
 Oct 2022 17:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221001202836.3110985-1-masahiroy@kernel.org> <CANiq72=GidTB23dH1kXu1jTMSH-7Qe-2NLaD5ChrzLEU3X=O7w@mail.gmail.com>
In-Reply-To: <CANiq72=GidTB23dH1kXu1jTMSH-7Qe-2NLaD5ChrzLEU3X=O7w@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 6 Oct 2022 09:18:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQaUh58ou=+ZtqXgkd8AGqXqnzryJXy0201ORrgezwPXw@mail.gmail.com>
Message-ID: <CAK7LNAQaUh58ou=+ZtqXgkd8AGqXqnzryJXy0201ORrgezwPXw@mail.gmail.com>
Subject: Re: [PATCH] docs: bump minimal GNU Make version to 3.82
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kbuild@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 3, 2022 at 4:22 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sat, Oct 1, 2022 at 10:30 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > The error message looks weird, but the reason is that the 'private'
> > keyword is only supported since GNU Make 3.82.
>
> Sorry about that. Indeed, it was added in 3.82 [1,2]. Given GCC 5.1
> (the current minimum) was released 5 years later, I guess it is OK to
> increase it.
>
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
>
> [1] https://git.savannah.gnu.org/cgit/make.git/commit/?id=5b4d419476e9fbda8ea26017f6ec15956d103ed9
> [2] https://git.savannah.gnu.org/cgit/make.git/tree/ChangeLog?h=3.82#n814
>
> Cheers,
> Miguel


Applied to linux-kbuild.



-- 
Best Regards
Masahiro Yamada
