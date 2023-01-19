Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39176733B6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 09:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjASIcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 03:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjASIcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 03:32:06 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D83DAC;
        Thu, 19 Jan 2023 00:32:03 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id AB80D80F1;
        Thu, 19 Jan 2023 08:32:02 +0000 (UTC)
Date:   Thu, 19 Jan 2023 10:32:01 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Mark Jackson <mpfj@newflow.co.uk>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND 0/5] ARM: dts: nanobone: Fix missing/incorrect
 features
Message-ID: <Y8kAAZ7cXrAYFo7B@atomide.com>
References: <20221130140547.295859-1-mpfj@newflow.co.uk>
 <CAAbcLfgUmiM=6eTQRRdkgLSEQZEcZwnzq0=Ov58S_osru-_V2Q@mail.gmail.com>
 <c7cb3be5-150b-a912-8801-670db63bd4ca@linaro.org>
 <CAAbcLfikQtFrVAsQgs9dYrXGx5-tFv4Mv-GZonNkbBQyNmFQ3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAbcLfikQtFrVAsQgs9dYrXGx5-tFv4Mv-GZonNkbBQyNmFQ3A@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mark Jackson <mpfj@newflow.co.uk> [221215 15:44]:
> On Wed, 14 Dec 2022 at 16:54, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 14/12/2022 14:35, Mark Jackson wrote:
> > > On Wed, 30 Nov 2022 at 14:06, Mark Jackson <mpfj@newflow.co.uk> wrote:
> > >>
> > >> This patch series updates the NanoBone DTS file to address various missing or
> > >> incorrect features.
> > >>
> 
> <snip>
> 
> > >
> > > Any update on this patch ?
> > > Did it ever get through ?
> > > Do I need to re-submit for some reason ?
> >
> > It's a merge window and you sent it just before it started.
> 
> Ah, okay.
> So will it be picked up automatically next time round or do I need to
> re-submit ?

Applying these into omap-for-v6.3/dt thanks.

Tony
