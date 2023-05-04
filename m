Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69D16F22BA
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 05:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjD2Dlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 23:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjD2Dlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 23:41:35 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FF526A2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 20:41:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Q7ZyR3r4nz4xDH;
        Sat, 29 Apr 2023 13:41:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1682739686;
        bh=ekrUI3+8BrR0nHkWhYZH1OoQichJoAnJM3+aShy0lg0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DMN6HrmakjqW9uKPK1tW24ZW4779qPY6K7IeQkEZiZaf0luHkL9dTZb5vzYNZaslY
         TIrDK1Vne+EcqG+R+zgVTIONZu92d9nHia9Ltneb/Rm2afD4ENPM/e3MlRXH9/Nrwf
         1/AE8Qu8OC30on7wWHOJK1kWsrRcCQCPfGB4pD788HlENoahSmfxajD6i+CgQlhsKV
         smCK/g9sgfKX7E1e2iRWPigaU9/UiZBeGYBAVFxLg7yWHYXTDUslhbDNQmspT4kYm3
         ttMdWip7Z2BTI2oZcIpTa9hrD3YOAo+PQWtpfHdlUtDqnFTleigO8lAdkFleftt12Q
         1Q2f2TOCC1pBA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     aik@ozlabs.ru, ajd@linux.ibm.com, alex.williamson@redhat.com,
        arkamar@atlas.cz, bgray@linux.ibm.com, christophe.leroy@csgroup.eu,
        ira.weiny@intel.com, joel@jms.id.au, kconsul@linux.vnet.ibm.com,
        kjain@linux.ibm.com, leoyang.li@nxp.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        liubo03@inspur.com, mcgrof@kernel.org, mikey@neuling.org,
        nathan@kernel.org, nathanl@linux.ibm.com, nicholas@linux.ibm.com,
        npiggin@gmail.com, nysal@linux.ibm.com, pali@kernel.org,
        paul.gortmaker@windriver.com, paulus@ozlabs.org,
        rdunlap@infradead.org, robh@kernel.org, seanjc@google.com,
        tpearson@raptorengineering.com, windhl@126.com
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.4-1 tag
In-Reply-To: <CAHk-=wgY8_-BvS5mFR+UtCwbLrOVikYfHi_m9OFxE2D43B+=8g@mail.gmail.com>
References: <87fs8k734t.fsf@mail.concordia>
 <CAHk-=wgY8_-BvS5mFR+UtCwbLrOVikYfHi_m9OFxE2D43B+=8g@mail.gmail.com>
Date:   Sat, 29 Apr 2023 13:41:18 +1000
Message-ID: <87wn1v2w4h.fsf@mail.concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Fri, Apr 28, 2023 at 2:44=E2=80=AFAM Michael Ellerman <mpe@ellerman.id=
.au> wrote:
>>
>>   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags=
/powerpc-6.4-1
>
> Odd. Your shortlog has this:
>
>> Michael Ellerman (46):
>>       powerpc/configs: Make pseries_defconfig an alias for ppc64le_guest
>
> that removed the 'pseries_defconfig' file, but then your diffstat
>
>>  arch/powerpc/configs/pq2fads_defconfig                                 =
              |  80 ----
>>  arch/powerpc/include/asm/atomic.h                                      =
              |  53 +-
>
> doesn't have it, resulting in the summary not matching what I get:
>
>> 278 files changed, 2672 insertions(+), 9188 deletions(-)
>
> versus my
>
>  279 files changed, 2690 insertions(+), 9528 deletions(-)
>
> and I see no obvious reason for it.
>
> I wonder if your test-merge just didn't remove the file (it did have a
> conflict due to the IXGB driver removal), and that's why.

Yeah my fault, looks like I edited the conflict in powernv_defconfig and
then did 'git add arch/powerpc/configs/*' which added back the pseries
one.

> Anyway, I'm not entirely sure about the mismatch of the end result,
> but it seems to be due to that one defconfig file, and I think my
> merge is fine. But please double-check.

Yep looks fine, thanks.

cheers
