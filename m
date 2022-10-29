Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6073761261B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 00:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJ2WEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 18:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ2WEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 18:04:34 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB2B626C
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 15:04:31 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E55DB5C0045;
        Sat, 29 Oct 2022 18:04:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 29 Oct 2022 18:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667081067; x=1667167467; bh=vBsgGI+zBo
        JU4/g4LxQpun2wPekJiYWPOVX43gTP7YU=; b=GSR9RKCPlxyxlpbdN7qXw9Lt1G
        Rjltf5Ls9EhRkt2vVSsdb7clY1g7WNmu+sJ9vTuL/p/zdc/So8jUJZhvP6iwpfw+
        7w8ANT0A53qlPcl3i4CjpA63eu7rh1To/GBmwjVZTSpPxnX+gBbCZwyZsc2FSwla
        4pJ+bki/7q/cE8Np5OhrWmMEYGnyu8m43j6ZKwRs0ExCNysFCGMratIbL2vCYVxY
        ihPfMn5Vd4yzSACNW8OtsSIQT0YEJDGKvoUj7yqSf7BzC6eo8neHEeUcU/S+V+MN
        Glko+I2LqAHBcXxSvlM7Y8ScAZLPEIDYUjqXwLTFnrOwH9/ElpUPnOMAMvcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667081067; x=1667167467; bh=vBsgGI+zBoJU4/g4LxQpun2wPekJ
        iYWPOVX43gTP7YU=; b=Om0ILi8AJI1irP13pmGHTyaBy/7OcJfhzHvF1yHj6yL4
        Ln3zsxndqWTgtquYdU2dxqPr/UFMeWy4465/gc8l8/1vuOGjgDN1Kfj3wZL0ugE2
        v/PGolHwrjbBCwBZvprKUVqFI+pzlK0LyH2NjcWdHdHB9Sle7aV72NFfB7rYXXbs
        CO2aoVAUdfwb9cmXN/jqT6Z3XlnfVJSvuO7fPn7juTm7AARgfDnOlgnT28BlD2rJ
        tr8rZz5aweh7E7OWiCJlMIcR9mwNh7z+zgpuHQrkK2HGCjwg6cTdEXoXPVCMoK2x
        F9ufqBIaf5GpdA9EMIqHcn732j8OS9hMi0PxKuZpBw==
X-ME-Sender: <xms:a6NdY3NC4u_0HptJuHZl8zXOa_07Ie-KCRIYTdAn9yGYKAknU94WFg>
    <xme:a6NdYx-5A69Cgb0is5hjh35tSHdKwJKI7f9revnAKIC9gQV-pfwGgHMG64yji5ys2
    3chMLT7lmrQNpe_sA>
X-ME-Received: <xmr:a6NdY2QE3F4ju2iXKIi7EHHiKEl6aJXi_owgGpJOddOCdsA5rWoa1t0yVCxVAgvc9mOaenftCl5xnucWntuqWVGDYUr0Z4sm3BxQHQbYto4SpJRA7m63f26jDtV2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtdelgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomheptehnughrvghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghn
    rghrrgiivghlrdguvgeqnecuggftrfgrthhtvghrnhepueelhedvkeehvddvgeevleekte
    fhteefueefhefhteeigffgtdegkeekgeeigeeunecuffhomhgrihhnpehkvghrnhgvlhdr
    ohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grnhgurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:a6NdY7sisxiex9GxcPCGShh0CmmSahfBafZCrw7fhWoPnws16Ac-Pg>
    <xmx:a6NdY_ePIeCr_F42cCsTk4PfDo28Jn0m8T_XypBIei6iLQmaurlTEQ>
    <xmx:a6NdY33SPABroughuG42HIy3T_Nk8Jk9ZdqDHOAztlvg_Nxx5Rywuw>
    <xmx:a6NdYwoFPLG7JwOpesxU8f02-21baS7S1NsemIiR6cvv6ec6QVcJAA>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Oct 2022 18:04:27 -0400 (EDT)
Date:   Sat, 29 Oct 2022 15:04:25 -0700
From:   Andres Freund <andres@anarazel.de>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: progs/test_ksyms_btf.c:37:21: error: no member named 'cpu' in
 'struct rq'
Message-ID: <20221029220425.p6lcwx65e4aqqkiw@awork3.anarazel.de>
References: <202210270554.FMcABmOT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210270554.FMcABmOT-lkp@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022-10-27 05:02:14 +0800, kernel test robot wrote:
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   98555239e4c3aab1810d84073166eef6d54eeb3d
> commit: 600b7b26c07a070d0153daa76b3806c1e52c9e00 tools bpftool: Fix compilation error with new binutils
> date:   3 months ago
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce:
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=600b7b26c07a070d0153daa76b3806c1e52c9e00
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 600b7b26c07a070d0153daa76b3806c1e52c9e00
>         make O=/tmp/kselftest headers
>         make O=/tmp/kselftest -C tools/testing/selftests
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> progs/test_ksyms_btf.c:37:21: error: no member named 'cpu' in 'struct rq'
>                    out__rq_cpu = rq->cpu;
>                                  ~~  ^
>    progs/test_ksyms_btf.c:44:27: error: no member named 'cpu' in 'struct rq'
>                    out__cpu_0_rq_cpu = rq->cpu;
>                                        ~~  ^
>    progs/test_ksyms_btf.c:48:25: error: no member named 'cpu' in 'struct rq'
>            out__this_rq_cpu = rq->cpu;
>                               ~~  ^
>    3 errors generated.
> --
> >> progs/test_ksyms_btf_null_check.c:25:26: error: no member named 'cpu' in 'struct rq'
>                    *(volatile int *)(&rq->cpu);
>                                       ~~  ^
>    1 error generated.
> --
> >> progs/test_ksyms_weak.c:41:29: error: no member named 'cpu' in 'struct rq'
>                    out__existing_typed = rq->cpu;
>                                          ~~  ^
>    1 error generated.

I tried to reproduce this, without success. And it's not really clear to me
how it could be related to the change either...

Greetings,

Andres Freund
