Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43D7706413
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjEQJ0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjEQJ0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:26:25 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF3FE67
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:26:24 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-4365240bee3so140770137.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684315584; x=1686907584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=463+jZc1SwwU5dLnkJuI6XEsKfsLcH9JXONEkR0chgc=;
        b=RTGq+QqJxYy7xeDFAit4vzaKELbLA36E0UzlE08wsYK6eLKFfbF2GkFnwLhz1m8eSQ
         VH8Ub22Ag9n5Z4MAdl2pmlAYpKCeZ2Y87GWNObQmYeAWwsZo/Ww2yljN54aRFCZR3jzh
         ManuXTZEbtdQH5i4shA/+zZZ6Fobi7suRF6XqWLFHnotR4ClCMIoD1CcybnDia3xqgKI
         ug4xMNdIYYKwR5CvQtLdK7QFw+HmMV+L3zh56RgjtfdbbEFsrddyx9aGaVfC8v9EdI1G
         6XdlCJOBA3YOXBngguDulzJ1HcRzO92hi7lU9+wXuSz5FGfFnxPidV40yb34KQO6Xa/r
         CyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684315584; x=1686907584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=463+jZc1SwwU5dLnkJuI6XEsKfsLcH9JXONEkR0chgc=;
        b=dUclYaQdtoc3vkcCMtPNvGLjf0cASpyY7CGFXkZdAkdEcKHfzEuC+0hszpgQ8fsq5h
         sX7P317v41AfAQHxj+U4isbl0qcIBtIst67nJ20dC8i5ZYyZU8pnIZvfqdWpc2CBAyv/
         MyefeF1fEc3lzWW5bHDmikUlAMywAEMl1o/an5MqLDMvTq4PbLkDhpIF3wVAmv//c1/4
         51XCHeZxXoso6F1Q1g1b2arfyLRGLoVwlXvDosv648NERGFpgx4xa09m2YsedKQEt+pp
         JgO+mfY3+b69DOCRNdaqfObmd739EQzaJZ/ZScACensSp+2Oi/jqckI7+fbeu/xQHCYi
         JWJg==
X-Gm-Message-State: AC+VfDzu6+z7EhR/XfeJKH46tEIaxeJO/oaOz7Pz3B1ahfw7u5sI4O7k
        ITbiy+LSZNSKiNyU9L7TKDQCPME9pjcDy9irT4OT6w==
X-Google-Smtp-Source: ACHHUZ7PlEf9sZpsVL8yIFKgry46KtQDWkG5cMNReUJNl/yajmdY8zfYgicaCu9oahkhryydSeLIJRfBwHvVgdFTVqg=
X-Received: by 2002:a67:e3c3:0:b0:436:367:4ac0 with SMTP id
 k3-20020a67e3c3000000b0043603674ac0mr13539923vsm.19.1684315584095; Wed, 17
 May 2023 02:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230517031856.19660-1-xiaoming.ding@mediatek.com>
 <ZGSDoVKKVqCkbaCB@infradead.org> <CAFA6WYO+AvnbuAdWyBAQ8HkLaOno7PXdsPb9SubxrGNvAm4UnQ@mail.gmail.com>
 <ZGSLiiK/JzD5KMd7@infradead.org>
In-Reply-To: <ZGSLiiK/JzD5KMd7@infradead.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 17 May 2023 14:56:13 +0530
Message-ID: <CAFA6WYPOMwmrA3J84AHzoD2eAtNkpMxr754qHpc-j6XRkgFFvQ@mail.gmail.com>
Subject: Re: [PATCH] tee: add FOLL_LONGTERM for CMA case when alloc shm
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Xiaoming Ding <xiaoming.ding@mediatek.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fei.xu@mediatek.com,
        srv_heupstream@mediatek.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 at 13:38, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, May 17, 2023 at 01:22:51PM +0530, Sumit Garg wrote:
> > > > +#if IS_ENABLED(CONFIG_CMA)
> > > > +     page_flag |= FOLL_LONGTERM;
> > > > +#endif
> > > >       if (flags & TEE_SHM_USER_MAPPED)
> > >
> > > If this mapping is long live it should always use FOLL_LONGTERM.
> >
> > It depends on the userspace application needs. However, I think it
> > should be safe to use FOLL_LONGTERM by default to serve cases like
> > secure media playback.
>
> long term is defined as won't automatically go away during the same
> syscall.

Do you mean a pinned user-space page can be paged out automatically?
The documentation [1] isn't very helpful here either since it talks
about "short term" vs "long term" in abstract terms.

Just FYI, the underlying use-case for TEE registered shared memory is
that the references to pinned pages are provided to TEE implementation
to operate upon. This can happen over multiple syscalls and we want
the pinned pages to be always in RAM as otherwise the physical
addresses may change if they are paged out in between. If this is only
supported reliably with a long term flag then this patch should be
tagged as a fix and requires stable backports.

[1] Documentation/core-api/pin_user_pages.rst

-Sumit
