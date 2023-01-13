Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4E3668EF4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240225AbjAMHS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbjAMHSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:18:06 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F6A372D11;
        Thu, 12 Jan 2023 23:02:40 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5132780FA;
        Fri, 13 Jan 2023 07:02:21 +0000 (UTC)
Date:   Fri, 13 Jan 2023 09:02:20 +0200
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
Message-ID: <Y8EB/KsqW2kikYIU@atomide.com>
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

Hi,

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

No need to resubmit if no more comments and the patches still apply
fine.

Did the issues pointed out by Krzysztof get fixed up? If so, I'll apply
these for v6.3 merge window.

Regards,

Tony
