Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328DA6997A9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjBPOlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjBPOlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:41:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98BA3B870
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:41:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90D6260ABC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 14:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30C0C433D2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 14:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676558468;
        bh=3T3iubz/OzIX0beQkVOfl0dMIVw8Iyg1LerT7YWobYA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bqQdIYUKwEG5ap8m+zzzPrf5h3r6C+0jf6sHYHwV190X0QtgalUXbdIi1Cy0aqc2N
         neV0HY0Zv5cIdOBDZXqVduO1QnfxoD3r/FgREYaZGYm91iUgBL++FTFFb1JPbb/0+S
         ypLbVoHZO8OwCCWzXp/vMD5UXLYPdjgKgdGAJjRALO+rMNbj7jmp0YVhUGCZz0HsFI
         /vnyh+V5LMoWqjqaQz+jk5TTtaDY2AEov4Q9fxoY7zVagneZ78U36boJMRgq1yoREB
         YLhiKa8SacNh2lQF3KRcTxx/BFfiSwxdvm71QEnDz1fAzg3EsezqCKchwOL7G6QsrB
         y2JQXCplly4hA==
Received: by mail-yb1-f176.google.com with SMTP id b1so2405350ybn.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:41:07 -0800 (PST)
X-Gm-Message-State: AO0yUKWIMo1mnenIjd/0s6DE33g14KV+Jj0BKJqZAm1qjFugdM+3nIci
        j0B5w9pqtEBFmJUBxqINFp/fRkpNrWx7m7LWeTs=
X-Google-Smtp-Source: AK7set9fg7j+rXsB4sX4MXRApXhhmd2yEefhAqabXERggxwLpuEIZ/pW61+utdeRTgwKZDUiZuJjs+WKbjmhss3iYCE=
X-Received: by 2002:a25:e906:0:b0:91f:507f:f261 with SMTP id
 n6-20020a25e906000000b0091f507ff261mr618556ybd.463.1676558467046; Thu, 16 Feb
 2023 06:41:07 -0800 (PST)
MIME-Version: 1.0
References: <20230208155450.1941608-1-trix@redhat.com> <20230213071241.GA2799422@linux.intel.com>
In-Reply-To: <20230213071241.GA2799422@linux.intel.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Thu, 16 Feb 2023 16:40:40 +0200
X-Gmail-Original-Message-ID: <CAFCwf132HuNbXjQfLe9QjotE6FnwOxUKi99bytp0BbL5GyL0-g@mail.gmail.com>
Message-ID: <CAFCwf132HuNbXjQfLe9QjotE6FnwOxUKi99bytp0BbL5GyL0-g@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: change unused extern decl of hdev to forward
 decl of hl_device
To:     Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc:     Tom Rix <trix@redhat.com>, nathan@kernel.org,
        ndesaulniers@google.com, kelbaz@habana.ai, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 9:12 AM Stanislaw Gruszka
<stanislaw.gruszka@linux.intel.com> wrote:
>
> On Wed, Feb 08, 2023 at 07:54:50AM -0800, Tom Rix wrote:
> > Building with clang W=3D2 has several similar warnings
> > drivers/accel/habanalabs/common/decoder.c:46:51: error: declaration sha=
dows a variable in the global scope [-Werror,-Wshadow]
> > static void dec_error_intr_work(struct hl_device *hdev, u32 base_addr, =
u32 core_id)
> >                                                   ^
> > drivers/accel/habanalabs/common/security.h:13:26: note: previous declar=
ation is here
> > extern struct hl_device *hdev;
> >                          ^
> >
> > There is no global definition of hdev, so the extern is not needed.
> > Searched with
> > grep -r '^struct' . | grep hl_dev
> >
> > Change to an forward decl to resolve these issues
> > drivers/accel/habanalabs/common/mmu/../security.h:133:40: error: =E2=80=
=98struct hl_device=E2=80=99 declared inside parameter list will not be vis=
ible outside of this definition or declaration [-Werror]
> >   133 |         bool (*skip_block_hook)(struct hl_device *hdev,
> >       |                                        ^~~~~~~~~
> >
> > Signed-off-by: Tom Rix <trix@redhat.com>
> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
>
> > ---
> >  drivers/accel/habanalabs/common/security.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/accel/habanalabs/common/security.h b/drivers/accel=
/habanalabs/common/security.h
> > index 234b4a6ed8bc..d7a3b3e82ea4 100644
> > --- a/drivers/accel/habanalabs/common/security.h
> > +++ b/drivers/accel/habanalabs/common/security.h
> > @@ -10,7 +10,7 @@
> >
> >  #include <linux/io-64-nonatomic-lo-hi.h>
> >
> > -extern struct hl_device *hdev;
> > +struct hl_device;
> >
> >  /* special blocks */
> >  #define HL_MAX_NUM_OF_GLBL_ERR_CAUSE         10
> > --
> > 2.26.3
> >
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Thanks, applied to -next.
Oded
