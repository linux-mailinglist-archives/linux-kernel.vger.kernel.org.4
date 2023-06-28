Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F73D7413B4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjF1OSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:18:32 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:49130 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjF1OSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:18:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FFF96134A;
        Wed, 28 Jun 2023 14:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76884C433C8;
        Wed, 28 Jun 2023 14:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687961881;
        bh=wfZGDODHCfz8gHxWBKGvxIoCdVveMakQPrUioFcJTLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NOAiI+/0jjNDrNBATfAbbRvTJeteoBu+38qLS4xpLFTC9gcHhT2RRIexFGaMo9GcD
         lwvWBLxC0YQSMnjzzQ4Zog1At8XNRPFm99n+ugLeis/RjiLRImjX+hbNeApDrL6rS/
         SQJl+CVx1vQ6KGSxlnYT3h4+t5+Plko2lxH8TKBEgpDRAcLYCJOW/WOBmm3skqDuJV
         fyeggo0sNQc1OXto38+zRLXNJgSJv8xZaUeaxkNGLWPefxKGGqfAWrkjlMGxydSEj+
         Nj0yYPRpfmPwjwmZBCkDBuSIR565XBsWV8B0hFzUAaO+bm4eQK3NuQZv84HYn8B8GO
         wEjq5Z9kstg1A==
Date:   Wed, 28 Jun 2023 15:17:54 +0100
From:   Lee Jones <lee@kernel.org>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Haibo Chen <haibo.chen@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 2/5] regulator: max77541: Add ADI MAX77541/MAX77540
 Regulator Support
Message-ID: <20230628141754.GJ10378@google.com>
References: <20230412111256.40013-1-okan.sahin@analog.com>
 <20230412111256.40013-3-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230412111256.40013-3-okan.sahin@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023, Okan Sahin wrote:

> Regulator driver for both MAX77541 and MAX77540.
> The MAX77541 is a high-efficiency step-down converter
> with two 3A switching phases for single-cell Li+ battery
> and 5VDC systems.
> 
> The MAX77540 is a high-efficiency step-down converter
> with two 3A switching phases.
> 
> Signed-off-by: Okan Sahin <okan.sahin@analog.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/regulator/Kconfig              |  11 ++
>  drivers/regulator/Makefile             |   1 +
>  drivers/regulator/max77541-regulator.c | 153 +++++++++++++++++++++++++
>  3 files changed, 165 insertions(+)
>  create mode 100644 drivers/regulator/max77541-regulator.c

Applied, thanks

-- 
Lee Jones [李琼斯]
