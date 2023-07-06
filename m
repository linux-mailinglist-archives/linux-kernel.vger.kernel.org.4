Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12903749898
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 11:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjGFJe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 05:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjGFJeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 05:34:24 -0400
Received: from www.linux-watchdog.org (www.linux-watchdog.org [185.87.125.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9534A1725;
        Thu,  6 Jul 2023 02:34:23 -0700 (PDT)
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id DF9DC40204; Thu,  6 Jul 2023 11:34:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org DF9DC40204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1688636060;
        bh=7IUX/efmY5qu26AolpxRuBTswD3/yIZVYtuzPfuO3UI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vtwUn8Bx8RHgDP3qB1c2siMUYIwhsy8uslWWby8JljdGrYAWosC567SbHC5z8Xn5X
         BGiGL9kusKnZ0DGnNlsrMYXtO23Uv1tChK/Yd+293ykT3NB/meKdqmx1bt4vm5z2PP
         RUn2YxgM/hnFE0XT0VttiEkHVwPEAhMUHzrWFDEE=
Date:   Thu, 6 Jul 2023 11:34:20 +0200
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Yuechao Zhao <yuechao.zhao@advantech.com.cn>
Subject: Re: [GIT PULL REQUEST] watchdog - v6.5 release cycle.
Message-ID: <20230706093420.GA1442@www.linux-watchdog.org>
References: <20230705122357.GA14855@www.linux-watchdog.org>
 <CAHk-=wgu6wv3aMx-p-tapvZ4ui7SSzo3OX_tz7jA4rggCfsk-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgu6wv3aMx-p-tapvZ4ui7SSzo3OX_tz7jA4rggCfsk-Q@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

> On Wed, 5 Jul 2023 at 05:24, Wim Van Sebroeck <wim@linux-watchdog.org> wrote:
> >
> >   git://www.linux-watchdog.org/linux-watchdog.git linux-watchdog-6.5-rc1
> 
> I think that machine is feeling a bit sick. I just get "Connection refused".

Should be fixed.

Kind regards,
Wim.

