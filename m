Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B9B70794B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 06:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjEREsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 00:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjEREsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 00:48:16 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36A9211D;
        Wed, 17 May 2023 21:48:15 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-30786c87cdaso1482231f8f.2;
        Wed, 17 May 2023 21:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684385294; x=1686977294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXzqCsmhWx6vLlLx9fa7LWO9eUQ6VRxv85e5IWG1dls=;
        b=TsZ3BX4j7UQPLV7QbH52+4JxNJrU1AiCMlW3fc0cWwqiPmCa+kp0O+LPuYeG2s9lMY
         HKridmd9zuHnSVd8mTe5rAjfnESPAynU+cAzSFQM3clbMQvQcGJV+S3eRig9W/IETr/v
         OL7v/vDmBbysHed2pIvKydi/772V98+kGxqsV+cL2XGF6S5hfXpY+ykoo8nfUnqvOq6X
         7mREjqJkQvsziTQNeKO3u861dcXk6T5sYVsusW1X3Bf5+bPsFX+acqTbOjIA9YATIMtk
         Bdcm9PH3F+Ms8eTZ7BSwXHReHRknHuj4RMA5wJ5dmzjDH43+8f/1qqc2vKyJU+BI4O2y
         0NRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684385294; x=1686977294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXzqCsmhWx6vLlLx9fa7LWO9eUQ6VRxv85e5IWG1dls=;
        b=dkyN7lEdlDVpAZjafanizvrhMvMnZkQastUayYJVf4wc1okwE87b4jgJDQha2Kf5p2
         Tiq+zlP+vXs+d3qd7gzk8+4ISBritftE5x2FVaxxBb3DTZhGBXhursdB4RagCHvEKFu6
         MBwM6oltO/YuRsIopqzJdxoRrfEyqfCK6ROtoaiA/DBed+Fs3YRcmA6UfjNhs7N3+Ckj
         D/BsXTZ+wHWqa6vsWBAKvqmrSxlLRfcMP49qcxt2k51NwD8gcf+izognunoT+skvq+Bx
         fjr5s+B6g1f70od5IdIPxyht1HWBMGYiPpFADb2WD8IKKZLMf0bt967ZcZUpOyhpug6x
         4xag==
X-Gm-Message-State: AC+VfDzxyqp6D5dZfbrQsABshT/RJJdI6b3dLZUwhlLdrFCVRrGwrh2g
        pfm9zRFsNW1zEM62o42fbnpc+g8XAYfmCwUBve8=
X-Google-Smtp-Source: ACHHUZ55fbbvFhO5eBFO0p+flbgDgNbsz9EVZyM7FR6aKss6mij2A3xni/ZvfjpjjPEqbEB1k8KjB8iYlQsee4sCNqw=
X-Received: by 2002:a5d:5963:0:b0:306:b3f8:690f with SMTP id
 e35-20020a5d5963000000b00306b3f8690fmr506638wri.36.1684385294081; Wed, 17 May
 2023 21:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230516025404.2843867-1-azeemshaikh38@gmail.com>
 <yq1cz2zu42r.fsf@ca-mkp.ca.oracle.com> <CADmuW3U+AMVf5xDVTri4Mtyk1GnHf+E_6kPJcsNUSPjF05u7qQ@mail.gmail.com>
In-Reply-To: <CADmuW3U+AMVf5xDVTri4Mtyk1GnHf+E_6kPJcsNUSPjF05u7qQ@mail.gmail.com>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Thu, 18 May 2023 00:48:02 -0400
Message-ID: <CADmuW3UvuHvVHnQx3AGZso2N6JwnJ_5--jHxJPa+q-FFFz6N7Q@mail.gmail.com>
Subject: Re: [PATCH] scsi: qla2xxx: Replace all non-returning strlcpy with strscpy
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 10:11=E2=80=AFAM Azeem Shaikh <azeemshaikh38@gmail.=
com> wrote:
>
> On Tue, May 16, 2023 at 9:42=E2=80=AFPM Martin K. Petersen
> <martin.petersen@oracle.com> wrote:
> >
> >
> > Azeem,
> >
> > > strlcpy() reads the entire source buffer first. This read may exceed
> > > the destination size limit. This is both inefficient and can lead to
> > > linear read overflows if a source string is not NUL-terminated [1]. I=
n
> > > an effort to remove strlcpy() completely [2], replace strlcpy() here
> > > with strscpy(). No return values were used, so direct replacement is
> > > safe.
> >
> > Applied to 6.5/scsi-staging, thanks!
> >
>
> Thanks a lot for the quick response Martin (on this and other patches
> too). Just for my understanding, do you mind pointing me to the
> 6.5/scsi-staging tree?

Found it: https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/log/=
?h=3D6.5/scsi-staging
