Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC61B5BCCD2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiISNTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiISNTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:19:08 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A1129818;
        Mon, 19 Sep 2022 06:19:06 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id q35-20020a17090a752600b002038d8a68fbso3132473pjk.0;
        Mon, 19 Sep 2022 06:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date;
        bh=6sojfB0EzarM+k/PZBtiMXpeN1oQ0x+sgKh5POxkET4=;
        b=pC9aUZj8uxvkyE0WOYKlTkPDbfsZME97W5me+CBvNLN5DoZ7d0OO6m8KZbAq5XQswC
         m20L97rAYXd0dUEotuALnX9fu6eMHwsu0MZIezud5fQxn2/nZMGNy6gZu7YijbGAJZ2p
         8ySqyYEtnfxeh+A38Kj2arg73xMIUZnPQ8KgcehtCkfzy4VN3SfRet6cxTrsfrMEp0Lm
         S3z0ZEg3NYP5taWsmyR7xuBIQv/ilisWSuuEfQFpPyTh+972V8WW+vIRK8dAwDEloz8l
         yd23IDQTnv3tL9+oCvLybm59w7PLpIieRwPIB2rNILHHnXrFuChPONRZHkOtGVo9phUH
         0sQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=6sojfB0EzarM+k/PZBtiMXpeN1oQ0x+sgKh5POxkET4=;
        b=lKtHLToyWALXTbHvHZ2RE2eotQOJLRASGQFJZOebfwO052kfOVL+ju5iV9FsYlzD0o
         pcn8tM5VSjDfLILHTLSF7E3S2Qg+CjHn1EtnErk2vvRIyXBtWkYNZsaXCO4cDf6HLoQH
         QYNa6lK8BjnjzrqSxn/YoAybPK6ehRSHczFXJ8mOZaiTUy8fBRKJRCxyBRn9jOIpWFlb
         Ln7Kdu738IEuDbtQXnU1KP153JfBbD7k5WIUijldHr4OnAlefVPvxHx4mFUWPjWWWWcr
         oO+O1Ozqb+a+36h7efzpdDlg0BRylNsaHOfexWuWgbsKYA6IO8Z8wQ0V8IyH/U4puXLq
         tVWQ==
X-Gm-Message-State: ACrzQf0KQH1rCZDIKiD+JpsXuw3gUf6nOfawRp/Ybg2P779gUiU4BC5H
        xzNecnPzxxsexM+TYGc+ujs=
X-Google-Smtp-Source: AMsMyM6JaSPlEVM4mfSkdT3DBrLxFCCWZoBo/g1FoEpLYVeyAGh7ayjz3yx9xdtULFqJd1HLIgMYuA==
X-Received: by 2002:a17:902:db0a:b0:178:2636:b6de with SMTP id m10-20020a170902db0a00b001782636b6demr13047042plx.58.1663593546222;
        Mon, 19 Sep 2022 06:19:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j15-20020a170903024f00b00176e8f85147sm20042216plh.83.2022.09.19.06.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 06:19:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 19 Sep 2022 06:19:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, p.zabel@pengutronix.de,
        rtanwar@maxlinear.com, andriy.shevchenko@intel.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hhhawa@amazon.com, jonnyc@amazon.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 17/21] hwmon: (mr75203) add support for series 6
 temperature equation
Message-ID: <20220919131904.GA3547146@roeck-us.net>
References: <20220908152449.35457-1-farbere@amazon.com>
 <20220908152449.35457-18-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220908152449.35457-18-farbere@amazon.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 03:24:45PM +0000, Eliav Farber wrote:
> The current equation used in code is aligned to series 5:
> T = G + H * (n / cal5 - 0.5) + J * F
> Where:
> G = 60, H = 200, cal5 = 4094, J = -0.1, F = frequency clock in MHz
> 
> Series 6 has a slightly different equation:
> T = G + H * (n / cal5 - 0.5)
> and a different set of coefficients:
> G = 57.4, H = 249.4, cal5 = 4096
> 
> This change supports equation and coefficients for both series.
> (for series 6, J is set to 0).
> 
> The series is determined according to “moortec,ts-series” property in
> the device tree.
> If absent, series 5 is assumed to be the default.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to hwmon-next.

Thanks,
Guenter
