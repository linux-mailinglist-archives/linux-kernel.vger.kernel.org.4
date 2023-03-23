Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1476C685E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjCWMcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjCWMcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:32:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B1F24CA6;
        Thu, 23 Mar 2023 05:32:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49BBD625D3;
        Thu, 23 Mar 2023 12:32:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF62C433EF;
        Thu, 23 Mar 2023 12:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679574722;
        bh=EYf6786yE/sBEJ5kVxCWKnQjuC3+cnNr9QYBjueYbts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J++0vaReFWwPOwPXGP+Po4zvrxhwh5She2/Ec56VQSyU/fB7On301Z7qGfUhVnUyX
         SdO5C25BT+xlwKrVGf5EnOQLRMO0ivqJ2a1v86lLTJn0ok331QoJwer4z39XS8p4Tv
         UWf3+tr8QcyH2hsSvavwjncNpjTVFvkGGC9IXuf9140dHvo6FawidhHQRWGdMaF8wQ
         fcFQXvjQ/lzngUvaOsH6tJBNoNLxkfsvI7wRhhU9EUYNnrTZhsSc7mDc3J2u7PqPVf
         MF9uFDrtjjga7TBZG1HIgr2H3KboAaLcQttd83XsXeOrQUjR+94n4RpXrBUoAzQqYo
         rdLJcSSaPByGQ==
Date:   Thu, 23 Mar 2023 12:31:56 +0000
From:   Lee Jones <lee@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux MediaTek <linux-mediatek@lists.infradead.org>,
        Linux LEDs <linux-leds@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        ChiYuan Huang <cy_huang@richtek.com>
Subject: Re: [PATCH 0/3] Documentation fixes for MT6370 RGB
Message-ID: <20230323123156.GL2673958@google.com>
References: <20230319074903.13075-1-bagasdotme@gmail.com>
 <2b8667b5-ea54-2ef4-f069-a86acd28ecea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b8667b5-ea54-2ef4-f069-a86acd28ecea@gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023, Bagas Sanjaya wrote:

> On 3/19/23 14:49, Bagas Sanjaya wrote:
> > kernel test robot recently reported htmldocs warnings on documentation
> > for MT6370 RGB LED. So here are the fixes.
> >
> > Bagas Sanjaya (3):
> >   Documentation: leds: Add MT6370 doc to the toctree
> >   Documentation: leds: MT6370: Properly wrap hw_pattern chart
> >   Documentation: leds: MT6370: Use bullet lists for timing variables
> >
> >  Documentation/leds/index.rst           |  1 +
> >  Documentation/leds/leds-mt6370-rgb.rst | 42 +++++++++++++-------------
> >  2 files changed, 22 insertions(+), 21 deletions(-)
> >
> >
> > base-commit: 4ba9df04b7ac66d2d000ed7ae2d8136302d99a57
>
> ping

a) Don't do that!

b) Especually don't do that 4 days after submission!

The usual expectation is 2 full weeks before submitting a [RESEND].

Mark Brown says it best:

"
Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.
"

--
Lee Jones [李琼斯]
