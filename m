Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3153E73E512
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjFZQaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjFZQ3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:29:43 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97858E53
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:29:41 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98df69cacd1so169617166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1687796980; x=1690388980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9CHrRqR2fSQ0++NtikS97CS9zylaxWqTRq+BBNV6q+Y=;
        b=W8WrJGCEHXQnHtNsnm/hELx31f1i1QjnfVRY4u5Vf1FFj8+/sEyhRitqj48mUB8SZA
         4CE2x6GicrJ+2hQgMxVd5+H6eUGkKo4a69xEh7oWA8SzHydEqqyftVYhCKylZf7LX8kH
         NBFQDLuLfFkTEuOnTlbL5qVgMghQjlvWrz7/hrDMP4rvNFdcLU4um9Hr0BueEPVU12/V
         H+m6QgR0tu33YW5cnykWyu2mcebU7bS3cVigbMuBcEZcPDDZZ+ChnudSsozvljPi1gju
         KkIEwJoewwOYqKC4Rk1MYuYhR0y5z8tCkQIMR8fQomC3kIGJJmp7lf64OVdnSj7U/7EM
         8tfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796980; x=1690388980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CHrRqR2fSQ0++NtikS97CS9zylaxWqTRq+BBNV6q+Y=;
        b=Gkt6vc9XTdcnD7eCvTHph34crp+zpLxzW2TyrJg3iuiml9eSxcmTBaOg5g4Olh8+sg
         hPhpdQ6i6yHiskQI0sS3Xh4IuAwbwNVcO5BGRmvJ4ExhWKukhiFHkgZJOiJ7CL1dS0Vj
         xl1ubEmX22vGr36iYWz+1riyNRl6ADtiKK9N2ggJZ8YSLKfP8BGgLE067Xe8xMfAbUDG
         6S8Am2jl3Y14JbqXQBunlhFU4hSKQQIkJF5rpBsgSbmvA0hGRMYIlrGvRamt2aOnSikD
         iDff6zjMvmUnJPSJlRn/mkBT3SP3sgnA2XmKL1ThGOskCMtcB4Mys0qPtdUDMY7XUEyS
         naAw==
X-Gm-Message-State: AC+VfDwWBtkJHePPG85H81djf2ilkZzgWf5LBbFBQYEnv5dhE0GC026w
        vANOugYphOfCB6vJv+38cTwO0Q==
X-Google-Smtp-Source: ACHHUZ6/O3Wkr5wbKrnbncEmhxHSeWiEksIyWcweInJx7/EUTGKrdhwfj47TMDyD3lIq1lzA4J9Mbw==
X-Received: by 2002:a05:6402:4c9:b0:51a:327d:f065 with SMTP id n9-20020a05640204c900b0051a327df065mr20581604edw.13.1687796980030;
        Mon, 26 Jun 2023 09:29:40 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id u12-20020a05640207cc00b0051bf998b25fsm2984500edy.44.2023.06.26.09.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:29:39 -0700 (PDT)
Date:   Mon, 26 Jun 2023 18:29:38 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>, palmer@dabbelt.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Evan Green <evan@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/9] RISC-V: drop a needless check in print_isa_ext()
Message-ID: <20230626-285e425abaadb83dd37d97fd@orel>
References: <20230626-provable-angrily-81760e8c3cc6@wendy>
 <20230626-skydiver-frown-659b982a43ad@wendy>
 <20230626-67e571e6d9f02c28a09dab33@orel>
 <20230626-jitters-spiral-68e941d0ad3f@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626-jitters-spiral-68e941d0ad3f@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 05:08:28PM +0100, Conor Dooley wrote:
> On Mon, Jun 26, 2023 at 05:19:08PM +0200, Andrew Jones wrote:
> > On Mon, Jun 26, 2023 at 12:19:40PM +0100, Conor Dooley wrote:
> > > isa_ext_arr cannot be empty, as some of the extensions within it are
> > > always built into the kernel.
> > 
> > This is only true since commit 07edc32779e3 ("RISC-V: always report
> > presence of extensions formerly part of the base ISA"), right? If
> > so, it might be nice to call that commit out in this commit message.
> 
> Per my last mail, where I commented on the origins of some of this code,
> there were no multi-letter extensions when this code was first added.
> When the first multi-letter ones did get added, it was Sscofpmf - that
> doesn't have a Kconfig symbol to disable it, so I think this has been
> redundant for a long time.
> 
> Apart from the ones I recently added, there's a fair few others that
> are not gated & should always be present.
> It's probably not clear from the comment, but this check is for whether
> the kernel supports extensions, not whether the system it is running on
> does. I guess I should expand on that in my commit message.

That part I understood, but I was thinking it'd be nice to call out when
the first extension was added which cannot be disabled by a config to
provide extra evidence that it's safe to remove the check.

Thanks,
drew
