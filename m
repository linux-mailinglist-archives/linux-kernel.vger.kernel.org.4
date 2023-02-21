Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3966769E83E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjBUT1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBUT1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:27:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EE23ABA;
        Tue, 21 Feb 2023 11:27:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 182A7B810A1;
        Tue, 21 Feb 2023 19:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD5BC433EF;
        Tue, 21 Feb 2023 19:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677007666;
        bh=CW0TrnVYPmqzjtnakRU/aIYasnOG7MQ3x8BrFO+nk5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q7O14rMgHPWK3ZL38sH6QN80+YfXUDY2bDXIlMYF0KJDtmtgzZg8jBegZT0X1wjc2
         WPmb+F3Hn/55y/CyX/z+nSiTTXc+bjOjWjvGE422HatRrB1X93br7LSuJeGW7kGsqC
         z6DsevUunCbLnOIrR7W2jMDDz8w8Maex76wL2SKo=
Date:   Tue, 21 Feb 2023 20:27:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v1 09/10] staging: dsp: add support for Fortemedia FM34NE
 DSP
Message-ID: <Y/UbMH5tXDgsvSbD@kroah.com>
References: <20230221183211.21964-1-clamor95@gmail.com>
 <20230221183211.21964-10-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221183211.21964-10-clamor95@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 08:32:10PM +0200, Svyatoslav Ryhel wrote:
> FM34NE is digital sound processing chip used for active
> noise suppression mainly on ASUS Transformers.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/staging/Kconfig          |   2 +
>  drivers/staging/Makefile         |   1 +
>  drivers/staging/dsp/Kconfig      |   7 +
>  drivers/staging/dsp/Makefile     |   2 +
>  drivers/staging/dsp/dsp-fm34ne.c | 364 +++++++++++++
>  drivers/staging/dsp/dsp-fm34ne.h | 845 +++++++++++++++++++++++++++++++
>  6 files changed, 1221 insertions(+)
>  create mode 100644 drivers/staging/dsp/Kconfig
>  create mode 100644 drivers/staging/dsp/Makefile
>  create mode 100644 drivers/staging/dsp/dsp-fm34ne.c
>  create mode 100644 drivers/staging/dsp/dsp-fm34ne.h


Sorry, but why is this going into drivers/staging/ at all?  What is
needed to be done to get this out of staging?  Why not do that work
right now?  At the least, we need a TODO file in the directory that
lists what needs to be done and who is responsible for it.

But again, just do the work now, it's faster and simpler to do it before
you submit it instead of waiting until after it is merged.

Also, no need for a .h file when you only have one .c file.  Just put
them all together into one file please.

thanks,

greg k-h
