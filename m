Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE4862EA9A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 01:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240703AbiKRAyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 19:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbiKRAyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 19:54:23 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B36F7EBED
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:54:23 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 140so3426017pfz.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eRHZ8HxlKkpc/rQw9TF/Vjc6A04s7AH3fGHGNV8IcdM=;
        b=EMdaRR5ywe+TV/FYyD9a2i+UB/WspihcuIixd5Dr21nxmE+kcbN8TtOmL46bnAWEJZ
         kOMiPHdykN4qZbMIGafcSieL2JCDwRT1Gn5eDVMjpDrz6ejrGhrSbXWcjDVzKmH4t0kI
         elpclmBAb7rzG6BXcOB8kac8xK+aTsSO/BR5vCsDUvAsEuE/cvxFv1w+4ff1loBLW96l
         0yyqyGGuegV0UUvNRmtSwuv2elmshJ+Uldj5RrMlnESTdSN+SpgwZSPmNoQlgf2HfRo7
         1pcksb6gWej+VA9v9FvtxqoTUtsJVb/9HwmI9H6HwxDLzZlotYwNIr+cOvTN/Ul7FA4r
         e5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRHZ8HxlKkpc/rQw9TF/Vjc6A04s7AH3fGHGNV8IcdM=;
        b=hmXxwMJE/sia2ep6r6/APRAk1EqcHh3edXkmwNoTvBENYSwLQBhoJubJHjR3/HsfMw
         zM4C8jFXgkAvAwqZVeJgb+1BeURenD1u73da4ZzJFm01LWeqXV6ATSz31x5Zau72Dgga
         YTCRT12eDHGV2r2Fkxu+ZmAlMiaLvBS6QNHqf467SQnyHG/ekLNwe6IWbGcNvG/Kcy/N
         tJwiSdQZUZ1/gyZRpPV5woED4XL2Ve4Tk4dvUznsgfIdGljA0FSbsDHqYIq8/JfmaaWx
         rdJjDyYyz4RhZQ8AYAUlxIWT1vKQHvAFD533S+qahvw417GGCs8s3Hn22owMyODd5nmQ
         /RMQ==
X-Gm-Message-State: ANoB5pljxpEfOPJQitMp0mxDAmuIhyMvLBg3si8FI6rTr+tHSiH4mIql
        Kcmhmdwx8g9jPHYO+ZOolojPVYuPNO/5uE+yU1S4gQ==
X-Google-Smtp-Source: AA0mqf577aAwYGvH4qpaYZECY2LNNaZytgtXT9uUrDcNBCNowZCpDJhrRK4S5gagrFXZqiA33J0kBMych14iLw5Etbc=
X-Received: by 2002:a05:6a00:4009:b0:563:2ada:30a3 with SMTP id
 by9-20020a056a00400900b005632ada30a3mr5481609pfb.27.1668732862572; Thu, 17
 Nov 2022 16:54:22 -0800 (PST)
MIME-Version: 1.0
References: <20221118001548.635752-1-tharvey@gateworks.com> <Y3bRX1N0Rp7EDJkS@lunn.ch>
In-Reply-To: <Y3bRX1N0Rp7EDJkS@lunn.ch>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Thu, 17 Nov 2022 16:54:11 -0800
Message-ID: <CAJ+vNU3P-t3Q1XZrNG=czvFBU7UsCOA_Ap47k9Ein_3VQy_tGw@mail.gmail.com>
Subject: Re: [PATCH 0/3] add dt configuration for dp83867 led modes
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 4:27 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Nov 17, 2022 at 04:15:45PM -0800, Tim Harvey wrote:
> > This series adds a dt-prop ti,led-modes to configure dp83867 PHY led
> > modes, adds the code to implement it, and updates some board dt files
> > to use the new property.
>
> Sorry, but NACK.
>
> We need PHY leds to be controlled via /sys/class/leds. Everybody keeps
> trying to add there own way to configure these things, rather than
> have just one uniform way which all PHYs share.
>
>      Andrew

Andrew,

I completely agree with you but I haven't seen how that can be done
yet. What support exists for a PHY driver to expose their LED
configuration to be used that way? Can you point me to an example?

Best Regards,

Tim
