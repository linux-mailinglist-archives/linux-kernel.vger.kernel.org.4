Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAE86B1D29
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 08:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjCIH41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 02:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjCIHzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 02:55:24 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C21DB4BA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 23:54:59 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id y19so537251pgk.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 23:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678348499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1iXK5+ePsDKhEgIlUU5m0Syo0it8X6rean5oSrzb73E=;
        b=nsqZJ98umHe3ivTzOlso1UTWbtWFniYXYY9kIPJbg7QYQMlnfT+QWhhfneUDxytL82
         aRetbVQmZ/+8D9C6oHEmp5R+cFBKXIM2iW69TfpopiEP87a3UChXBBB0AL7xxE4t17VV
         wr7J5qXckA38AY/PT/6Iu5rCWgo+4v6eJAOa2cJMJjZp9Bjla7YmbI8ls9A3yonOTA/+
         jbbK7ILw4fBc/JjYdM+pbQcYI2xliT8lwGJglst9mO7T2VVYBtCif09KgFfFIJ67WJNu
         KLyX7WFfUR11St8Hy5TxbAM4m6txZR9VBgdsy/hU4Lmqb68Dnu0/5DVpn97SSVLusBJZ
         Y68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678348499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1iXK5+ePsDKhEgIlUU5m0Syo0it8X6rean5oSrzb73E=;
        b=PWFCyrPoCNsGUmJsVSsTczNNvrQb7WPEHiKNXbCFog0YTS8VOQEZLYXCQbfWYXQsqa
         HViPjM8/TSMOdIb+cci8SrcxYIz49H8T2wCg28GHV0qJbdT0cL3B6BNOTC2w42MGR3B1
         5X+a1Vrjs4v8jV2ULvh3qpyujEEOY1kStxzYdBxsfOr1VOxTlRf0w178kVRI3zt8nkxF
         xi5PSfYvmgdqIgexQRWEPvxx7RprlV2xgwfI7DE705vx4qW91Dd5Jwj11OALbHNkSol7
         crjqA/oXPXqaTdyfxfbdSBLVVySD2DJeyvayLf+SsQ1Ub/PmRFfZ8t1BiaZp1yjXlQ18
         FM0Q==
X-Gm-Message-State: AO0yUKUYRvntqJqP8i2zR4AW+V0isl3/iQPAgQw4alX11zyNPEEPAu20
        pODAJlVXuFkRItUaT5RvdhmDDwH2Fsk200G69+k=
X-Google-Smtp-Source: AK7set+z8uYhKvn2trBTZHFaSFsTPKYfwQiKWK/f+lSI7Ys5OQEyPdZF2IKqnsT/hcOVyXjzJRcucryrW9plIeUCDIs=
X-Received: by 2002:a63:7f1a:0:b0:4d9:8f44:e1d7 with SMTP id
 a26-20020a637f1a000000b004d98f44e1d7mr7493710pgd.4.1678348498939; Wed, 08 Mar
 2023 23:54:58 -0800 (PST)
MIME-Version: 1.0
References: <20230308064734.512457-1-suagrfillet@gmail.com> <20230308113510.fb6y2xhylavkrgtl@bogus>
In-Reply-To: <20230308113510.fb6y2xhylavkrgtl@bogus>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Thu, 9 Mar 2023 07:54:45 +0000
Message-ID: <CAAYs2=jFe_ejN9O26AMCZqDtnVkt1bpyMUw2nx1Q9t=SBWj79A@mail.gmail.com>
Subject: Re: [PATCH] Revert "riscv: Set more data to cacheinfo"
To:     Sudeep Holla <sudeep.holla@arm.com>, conor.dooley@microchip.com
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, pierre.gondois@arm.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Conor & Sudeep :

Sudeep Holla <sudeep.holla@arm.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=888=E6=97=
=A5=E5=91=A8=E4=B8=89 11:35=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Mar 08, 2023 at 02:47:34PM +0800, Song Shuai wrote:
> > This reverts commit baf7cbd94b5688f167443a2cc3dcea3300132099.
> >
> > There are some duplicate cache attributes populations executed
> > in both ci_leaf_init() and later cache_setup_properties().
> >
> > Revert the commit baf7cbd94b56 ("riscv: Set more data to cacheinfo")
> > to setup only the level and type attributes at this early place.
> >
>
> I had noticed the same and had something similar when we did some rework
> around for v6.1 merge window. But there were lot of other issues to be
> addressed at the moment and hence deferred this.
>
> So for the change in general, but as Conor responded, it would be good
> to do some checking to ensure nothing breaks and all the requirements
> this patch(baf7cbd94b56) addressed are already handled in the core.

As you suggested, commit (da29dbcda49d "riscv: Add cache information
in AUX vector")
in the "Get cache information from userland" series should be checked.

The commit da29dbcda49d adds the cacheinfo (read from
ci_cacheinfo(cpu)) in ELF auxiliary vectors,
so process can fetch the cacheinfo through glibc sysconf() after ELF loadin=
g.
At the same time, the glibc related support was enabled by its commit
(15b38ffc10 "riscv: Get cache information through sysconf")

With this reverting patch applied, the output of `getconf -a` looks good
in Qemu sifive_u machine and rootfs image with glibc-2.35.

```
LEVEL1_ICACHE_SIZE 32768
LEVEL1_ICACHE_ASSOC 8
LEVEL1_ICACHE_LINESIZE 64
LEVEL1_DCACHE_SIZE 32768
LEVEL1_DCACHE_ASSOC 8
LEVEL1_DCACHE_LINESIZE 64
LEVEL2_CACHE_SIZE 2097152
LEVEL2_CACHE_ASSOC 32
LEVEL2_CACHE_LINESIZE 64
```

>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>
> --
> Regards,
> Sudeep



--=20
Thanks,
Song
