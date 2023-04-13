Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415196E1343
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 19:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjDMRNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 13:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjDMRNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 13:13:02 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3524EF6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 10:13:01 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v6so14913874wrv.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 10:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681405979; x=1683997979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C+FOcVtrauGavkqeapsQUvV5l07pjdAtC6oPi4RZzFQ=;
        b=j+VH1iNZWqjXmS3+7tDbVgP7esu3h0D3XU1Saiv5tHD3GyBEL6bC7b4Vd8TJhw0QOq
         vxqeFGmDVT0cxNiSksBRym6+FwYAx/WesPAfJ2s2jz8MKUDhoX+WpEqAZyMXmAaydjRw
         gQ2g46UH+N60ApsGFv8BY70yyg4XYVVZO1+A/SqshPGNuA24Ta56ZFklWVQX0HgYF5J2
         S9BXyXuybF93xBK+djOI9rpfpWTSpVud8k5mlMzKkwVR8iBP+doSh7/86dcvhF4mQJPE
         L51Xqw1UGbY3GlC3dZ457WZWuieCxZRG1aOTvgIuxv3o7FZMUzBY0IPt+++ZDHZ0uT3V
         /npg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681405979; x=1683997979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+FOcVtrauGavkqeapsQUvV5l07pjdAtC6oPi4RZzFQ=;
        b=RGOOSxmkw/uMVnNhGsbaKQImaHfHrW6cZiSS+Qgxl5lZsEyhA8eEMnX+xc5reG1UEQ
         ee/1M7w6H7tSHPsCe6QmVggoUWJGy61UdtF3Dv+QYeVZtCcGl/B0KL+KG77E85zIDBUc
         E7qtfGYa1C8COp9p08mus/sZo2xaj2978/kuMWRNkIePiWmBI+shEBkNFh6noHxGOQW7
         daAUnLLSBMmkWmD4Xt1VTb544B5tt8AW97iwMpuoiDoVnp8APfEzCl0C7uty0isgInO1
         kYW221KsfB05J6tqfZxYnqjAdTwipBUydT9AFO4e6S/Y05F4Tp7+To4Tp272q6Zy9zt+
         K1pQ==
X-Gm-Message-State: AAQBX9eI7P9s4J4WfoK3uZmWw1tSUWg34j6wkI8qDjVwBW9C+mXHnPbK
        iJ3i40dVAWmkBoezf1ZS9LgGHhF340tsesicUThTNMqpF16NXWAX45U=
X-Google-Smtp-Source: AKy350bTQbDoNKIbxE6adRwcuataNMOj/xqDkMYGf4f4RKRZ4x5eVnwYFxjdMKI9fwBPSmKo0RM78CmlM1i63DavlsA=
X-Received: by 2002:a5d:4b87:0:b0:2f1:c72f:fa43 with SMTP id
 b7-20020a5d4b87000000b002f1c72ffa43mr547318wrt.14.1681405979130; Thu, 13 Apr
 2023 10:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230407203456.27141-1-quic_johmoo@quicinc.com>
 <20230407203456.27141-2-quic_johmoo@quicinc.com> <CAK7LNAQQmoyUx+0Jk3c7iqY20KokrHEOPwHNb2doZOOA8RWBDA@mail.gmail.com>
 <2023041015-lunar-dandelion-1b4e@gregkh> <ae44540f-8947-8efb-fb8d-45a84bd3fef3@quicinc.com>
 <2023041136-donator-faceplate-5f91@gregkh> <bcdcee9b-f213-bc3c-d300-92a1e0138187@quicinc.com>
 <2023041209-armed-overlaid-3d3d@gregkh> <d34a6b09-8244-49e2-2d7a-eee5fd5ca5b7@quicinc.com>
 <718c102205750a00b86e8d33748e9bfb3c485ee1.camel@klomp.org>
In-Reply-To: <718c102205750a00b86e8d33748e9bfb3c485ee1.camel@klomp.org>
From:   Giuliano Procida <gprocida@google.com>
Date:   Thu, 13 Apr 2023 18:12:21 +0100
Message-ID: <CAGvU0HnepJwhUdMPDPY7q8nAnMNU=2_XaZHkPhFO0hmaseSPEQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] check-uapi: Introduce check-uapi.sh
To:     Mark Wielaard <mark@klomp.org>
Cc:     John Moon <quic_johmoo@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        kernel-team@android.com, libabigail@sourceware.org,
        Jordan Crouse <jorcrous@amazon.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

On Thu, 13 Apr 2023 at 15:37, Mark Wielaard <mark@klomp.org> wrote:
>
> Hi,
>
> On Wed, 2023-04-12 at 09:37 -0700, John Moon via Libabigail wrote:
> > On 4/11/2023 11:14 PM, Greg Kroah-Hartman wrote:
> > > > Would you find the tool more useful if it simply filtered out all instances
> > > > where the size of the type did not change? This would filter out the
> > > > following which the tool currently flags:
> > > >
> > > > - enum expansions
> > > > - reserved field expansions
> > > > - expansions of a struct with a flex array at the end
> > > > - type changes
> > > > - re-ordering of existing members
> > > > - ...others?
> > >
> > > Obviously not, as some of those are real breakages, and some are not at
> > > all.
> > >
> > > Please understand what is an abi breakage.  Adding new enums is not.
> > > Using a reserved field is not.  Reording existing members IS.
> > >
> >
> > Yes, understood that method would miss certain classes of breakages. I
> > was suggesting it as a way to improve the signal-to-noise ratio of the
> > tool since we don't currently have an algorithm for determining
> > breakages with 100% accuracy.
>
> Note that you can check the exit code of libabigail's abidiff to see
> whether something is an incompatible abi change or not, see:
> https://sourceware.org/libabigail/manual/abidiff.html#return-values
>
> You can also of course use suppressions to instruct abidiff to avoid
> reporting changes involving certain ABI artifacts:
> https://sourceware.org/libabigail/manual/libabigail-concepts.html#suppr-spec-label

libabigail's abidiff already hides certain differences by default.
You can turn this behaviour off with --harmless.

Note that abidiff without --harmless treats certain ABI differences
asymmetrically,
hiding them one way around but not the other.

The ABI diff tool I designed for Android always treats differences symmetrically
and will only suppress certain kinds of diff if specially requested
(which we don't
do any more in production). [Technically, we also ignore qualifier changes on
function parameter and return types, but we achieve that by stripping them out
unconditionally.]

Once we get around to UAPI monitoring, we'll do the same there. We can always
review the SNR later.

Regards,
Giuliano.

> Cheers,
>
> Mark
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
