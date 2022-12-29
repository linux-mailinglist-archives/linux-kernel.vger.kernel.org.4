Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76236588C8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 03:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbiL2C7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 21:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbiL2C65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 21:58:57 -0500
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E88912628;
        Wed, 28 Dec 2022 18:58:52 -0800 (PST)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 2BT2wNek016432;
        Thu, 29 Dec 2022 11:58:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 2BT2wNek016432
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1672282704;
        bh=t2N0dlzEW4+3qCZfvXvu3dBaEvbxlnxpDxzgWF+ARYI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tEhp9MX+AFM4wjZm1B6k/lKqB88Wl26UXQ/1x7VPN0MSYYlmjZNUlaMTMN/1maJQJ
         rRIPV2ynEN7fORHmOiuAC2tlz72iNwQuGq9R2wtamh7z7OWFL80YAVVfXv5VXAz8uy
         kpVkdYeqQtPhmN00BU0IPA7h7dp1pLccYp8gVjD2HTmxlHYA5GGZUolvfQLUHs4WzX
         MO0Awf/X7z5eKIf+ZJqw8/5A2Y/er1+y6WUjozcOEk5q6+f39tXFBiNKi07kh+fKpD
         VMnlMkdv/rB3B8H1avBWaVZp/rKfbbGAAkLhJY74yAjKa5sZEB2TWF+35o6L783FBy
         vtxuPDzPvvtZg==
X-Nifty-SrcIP: [209.85.160.47]
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1441d7d40c6so20487447fac.8;
        Wed, 28 Dec 2022 18:58:23 -0800 (PST)
X-Gm-Message-State: AFqh2kqbdTyq5TLxREO5euAbo6v1LigZ+CPxfYbi2wvNR6JjLcjWgjIS
        rH8tw81nIZ7jfncfr6T2+AFutgg//wdJIHaOeWg=
X-Google-Smtp-Source: AMrXdXvPhYMiPBg5OUtIxN2qc2z0biR0zjYli618rgIL73FyVk9epIgaCLalkH6TUlbo06SnLpqRePQXZovIHjMZ7K8=
X-Received: by 2002:a05:6870:4c0e:b0:144:a2de:1075 with SMTP id
 pk14-20020a0568704c0e00b00144a2de1075mr1326507oab.194.1672282702603; Wed, 28
 Dec 2022 18:58:22 -0800 (PST)
MIME-Version: 1.0
References: <20221217055148.28914-1-unixbhaskar@gmail.com> <Y6WWI87an9IRmVod@bergen.fjasle.eu>
In-Reply-To: <Y6WWI87an9IRmVod@bergen.fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 29 Dec 2022 11:57:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNATZ7CLiFOGbZJTKgqAAaNPwFse7AOTUsyqjmLZhLR2Hww@mail.gmail.com>
Message-ID: <CAK7LNATZ7CLiFOGbZJTKgqAAaNPwFse7AOTUsyqjmLZhLR2Hww@mail.gmail.com>
Subject: Re: [PATCH V3] scripts: kconfig: Added static text for search
 information in help menu
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 8:51 PM Nicolas Schier <nicolas@fjasle.eu> wrote:
>
> On Sat 17 Dec 2022 11:21:48 GMT, Bhaskar Chowdhury wrote:
> > Reconstructed the sentence for the better readability.
> >
> > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>
> I liked the commit message your v1 much better (minimally changed):
> > Add few static text to explain how one can bring up the search dialog box by
> > pressing the forward slash key anywhere on this interface.
>
> Would you mind updating it once again?
>
> Kind regards,
> Nicolas



I replaced the commit description with v1's one,
and applied.
Thanks.



-- 
Best Regards
Masahiro Yamada
