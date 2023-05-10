Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535E16FD7BD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbjEJHCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236051AbjEJHB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:01:58 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEB6420A;
        Wed, 10 May 2023 00:01:49 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50bc2feb320so10751398a12.3;
        Wed, 10 May 2023 00:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683702108; x=1686294108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaNhuuj9SzRd97H3I1Sr8X9T+oYWLfgD5Xe3bUYTMO8=;
        b=sSDqo9JPnWE1EKPFkQyHzQQJe6tJv0slWstu2T4SlYZwMIxY5aF9PJhkuRAfSMCoWv
         XtoBL2VVjCVsIwJUPS90z5NuR9eQ1RdEZmQH8F0l5nGL96PFznofxq/LABVbwoatN9HH
         mbtdetcR+WWbk+rsHpaNa6D7ABW6UurvsD/RB+HIec+ccrmz6jEZQIiJqRsqmuvhpPgW
         FHcz+x9hpNY2bYO+FTlQs+AVml1dGJjdncBDK7B2DJ9EjZ8NYLfSR2Iw1AZuHf1HS5yN
         FuRcAi0RiNqNpSEvhBLyjHKEBoG++/RiHNUufzSwENYV1ajNOiI0gVEYmRekVPL1RGhn
         9vhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683702108; x=1686294108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IaNhuuj9SzRd97H3I1Sr8X9T+oYWLfgD5Xe3bUYTMO8=;
        b=gOBufex04lmm77RPr2/VI71I29n8H/AuVhMzPPrQNnX8DrkAr1x0uhA1+gVP7D0i8C
         v0UQ9qKpVWcNWPST1pAHC+CTnyyqqUEqnhNPwS8qZMT9Gfr5zac6yk1lbLThxkz7zXSH
         CyEnYlcaIooutRJ35Q0JGbF77ukMGXssxjcmLpGYovm38Lv7uSRxnM3PhGzDmUhm5iuh
         THN2RPspr28gIOCW/f44zolrqsxhj2UbiVr6QjmvYh5X5raNdZivlY5zvy4C44OQ7Ul1
         avkwXL0XsFN6DenJiGMDv8cLdaq90ud8tT29RDkbpclMDf/wHhGlIsMUW0O8Fq6nL3IN
         N4Tw==
X-Gm-Message-State: AC+VfDzKiVjrmab0e6UoAlCmYRTUFbrH0zLnHRWvcUURHLWdHRYGSNdc
        ouzk91amNYNmNfXmtDSwCDFqRZYakS6ZShcLFdMGMFPh
X-Google-Smtp-Source: ACHHUZ4bFZvJnuwiUsHcIDBCVuRiTIxgQgl2YxGlDp0+Bdjwc5KF05uoxN1IBgrDxulGbTxVQJST3XkbseQLQMBbp48=
X-Received: by 2002:a17:906:dac1:b0:961:8fcd:53cc with SMTP id
 xi1-20020a170906dac100b009618fcd53ccmr13093467ejb.42.1683702107738; Wed, 10
 May 2023 00:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230509084007.24373-1-lukas.bulwahn@gmail.com>
 <7cbe80f0-dcc3-bfc3-3bd8-c9f96704618d@intel.com> <CAKXUXMxO4b-8wT-88fJ=++woH-p79_4R-vUr=aELNFYinGcEuw@mail.gmail.com>
 <ea00d762-b0df-ab72-988b-98c62ffc7949@intel.com> <20230509184135.GDZFqT3yC/j5bJA1l5@fat_crate.local>
 <c0dcbda3-e131-2460-4c61-e98d0be750ff@intel.com> <20230509190325.GEZFqY/SfuCnadUjcW@fat_crate.local>
In-Reply-To: <20230509190325.GEZFqY/SfuCnadUjcW@fat_crate.local>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 10 May 2023 09:01:36 +0200
Message-ID: <CAKXUXMxfVtXtBioGWNSqghKuhaBkWuXU+7w+xUthHZEOsFxvTA@mail.gmail.com>
Subject: Re: [PATCH] x86: make config X86_FEATURE_NAMES visible with EXPERT
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 9, 2023 at 9:03=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrote=
:
>
> On Tue, May 09, 2023 at 11:43:12AM -0700, Dave Hansen wrote:
> > Like remove the option entirely?  Or just remove the prompt so folks
> > have to hack the .config for it?
>
> I wanna do entirely as we have waaay too many config options but we
> probably could start with removing the prompt only and see who
> complains...
>

Dave, Boris, thanks for your review and feedback. I have now sent you
a new patch series to remove it from the prompt and remove it entirely
as two patches, so you can choose which option to take now. In the
end, all of this serves my overall goal of reducing the number of
configs and removing CONFIG_EMBEDDED very well.

Lukas
