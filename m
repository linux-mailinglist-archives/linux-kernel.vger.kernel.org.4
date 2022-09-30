Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BC85F062D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 10:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiI3IDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 04:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiI3IDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:03:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE42A1F7EE2;
        Fri, 30 Sep 2022 01:03:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D74562271;
        Fri, 30 Sep 2022 08:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF25C433B5;
        Fri, 30 Sep 2022 08:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664525024;
        bh=gcOUTgiHQKpl/JYONfzkMXDJJbeBVkcS2bX8718fyrY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A2EVGkdJq6mLOEmq0BeaB+JjAEci9/bHEZtVrEK0Ri9a0n3JAdOoAawxzNTEt3MvO
         DJS+TocFCexLhpK+Kp/BM2A+mjNKWdw7fgLysSNC3BSVnuqjkQvx31uPITPmCFqq4G
         ecOkcKmMlsCcoz/FFNlYCO60cXt0twgJmSE+0wCP4hIdzX6QGnsqAMhT+fdUtP/Voc
         tRc/9x17oBk1WHPFO72O23li79G5EEhxwUvUuWQgFNYS7rEipfr+eS+xSYjS66420+
         UMCI9ZGWP4jwpY/y9vRQlAUbhUhJBRrWhbQBBiLnag+kC7Gu9Yak9XJljCKJf8Ncwb
         ftbdJYsEoEK0A==
Received: by mail-vs1-f46.google.com with SMTP id 63so4004603vse.2;
        Fri, 30 Sep 2022 01:03:44 -0700 (PDT)
X-Gm-Message-State: ACrzQf2reVOcT9nbc0mJBnliCMOGtWmrqV6gqix4nDTiGcbls6vgE69m
        mIHQWvKbuvtSAV2XRHyzxR2y27E7oU0A5ifcrOo=
X-Google-Smtp-Source: AMsMyM7ZR61+OWq80j7WRQOHCCqaTWXzrOM+2VEzOyslVf03Wcxq7Rav4q6FzLGvJ3FxAGYPHky3V4VEeCjnit4pJNc=
X-Received: by 2002:a05:6102:2755:b0:398:4f71:86e with SMTP id
 p21-20020a056102275500b003984f71086emr3804732vsu.84.1664525023562; Fri, 30
 Sep 2022 01:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220929101445.32124-1-lukas.bulwahn@gmail.com>
 <CAAhV-H6xe4o0upxcQTN=8BeDdcDipmoRp+QQNiakJJZ_eneTxg@mail.gmail.com>
 <CAKXUXMwhF4V1=oNq1XaTmQpk_Tt7ZXfZEmK_r_GT6wz7=vVx2g@mail.gmail.com>
 <CAAhV-H4dExTGW7=pSPmunFVBK6YYjj-wo0ZKgfi9A=yHf2qV9g@mail.gmail.com>
 <CAKXUXMw731xNrqUzrCE1jRd25vfWdYFf-donLosOYOTqcm9JiQ@mail.gmail.com> <c6f23ba9-b92f-a518-25ec-44f5f188b840@microchip.com>
In-Reply-To: <c6f23ba9-b92f-a518-25ec-44f5f188b840@microchip.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 30 Sep 2022 16:03:32 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4ivkPPU2eQBSv1M8q0gT6M3X0po_9-yYGML7WfCVYBZg@mail.gmail.com>
Message-ID: <CAAhV-H4ivkPPU2eQBSv1M8q0gT6M3X0po_9-yYGML7WfCVYBZg@mail.gmail.com>
Subject: Re: [PATCH] loongarch: update config files
To:     Conor.Dooley@microchip.com
Cc:     lukas.bulwahn@gmail.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@xen0n.name,
        loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 3:39 PM <Conor.Dooley@microchip.com> wrote:
>
> On 30/09/2022 08:22, Lukas Bulwahn wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > On Fri, Sep 30, 2022 at 4:46 AM Huacai Chen <chenhuacai@kernel.org> wrote:
> >>
> >> On Thu, Sep 29, 2022 at 6:44 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >>>
> >>> On Thu, Sep 29, 2022 at 12:42 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> >>>>
> >>>> Hi, Lukas,
> >>>>
> >>>> Thank you for your patch, it is queued for loongarch-next, and may be
> >>>> squashed to another patch with your S-o-B if you have no objections.
> >>>>
> >>>> Huacai
> >>>>
> >>>
> >>> Feel free to squash as you see fit. I cannot recall sending something
> >>> specific for loongarch-next, though.
> >> Emmm, my meaning is squash your patch to mine and keep a S-o-B in that
> >> patch [1]. :)
> >>
> >> [1] https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/commit/?h=loongarch-next
> >>
> >
> > Process-wise that seems a bit strange (i.e., just mixing S-o-B by
> > multiple people, how do you bisect which individual change broke
> > something [you would need a second manual step of investigation],
> > etc.), but sure go ahead.
>
> Looks like each of yourself, Youling and Tiezhu should also have
> Co-developed-by tags, no?
Yes, that is needed.

Huacai
>
