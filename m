Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF41360A6F8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 14:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbiJXMmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 08:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbiJXMkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 08:40:21 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A977E33A;
        Mon, 24 Oct 2022 05:08:00 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id z5-20020a17090a8b8500b00210a3a2364fso8903279pjn.0;
        Mon, 24 Oct 2022 05:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lEXljrDw04wugCg/PDPyOEnwP1P5hItYMVo1gxAx7t8=;
        b=KMRXjpCyWsvVw+7XiYlbKGStvGACKJIS4oyWrAmKILhm2GcDQ8MGYA13JxjJLVBkhG
         yFqEG4/ZgccnRiskUH1azL2UQxddc5anpGQv69pmtNSjlONwOUMlf8tBsHMay6NFv6Pr
         Itre1SjmsDTbzJhHgupn6dKYf3LwE7oFWWe6Mqw3oXilHdoefjPBA2pRB+e2b0Bq22VY
         dXX75RKpmfe76/wYDqP5YC51ke54GaZkBuYKk6eoBW6MD9bI1CcEmTLIE8wTHvpwwxiJ
         qeHAxH0wdyMkqEAerX1RQN31IjK0fbCoEY4oMnjklSBGB0tvLhmcDKh7a1N52NQTj/oY
         09mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEXljrDw04wugCg/PDPyOEnwP1P5hItYMVo1gxAx7t8=;
        b=3Dyng98FY30UFq74O4ESnBvdRnirTIc1cjnup8sLyEHmzHwzI7SSNEPuqmM+6jEyLD
         tBal5R4kEZDKyBZdyZ3UpXHX2MPf5nToLDM3kcx0V3hVQ2IoJXXfbBi0e9x1DGw+vC8b
         DslJEfu2DtIf4npKNIeMWYTCnNvjsBUD9a0sNazBhI559eLhi5ogN0OU9gKQhr0lA5FJ
         7EbEbjGa7VXubAHwfDFtqv9dg9r1oQ3omWoPV7ZVeXp1jr3o+GXuDVY2lY3COGQGArv2
         E3H/MFElPCtJrqyPljT9+Eros8XaZIapGxotmLuLPEq5uxmgpfsquPErwYgkXuh1oNGq
         LcOw==
X-Gm-Message-State: ACrzQf3T9YBPp+5f3SaAm7bXuhTXdxo/QQVMMRoxZil9DoiUP3DTdwz5
        cOLArIibMmAZwNoqpRCqOoc=
X-Google-Smtp-Source: AMsMyM6a2jrPJQCXU523rN6IgJmxpifiRvb7NfqVI97VI/0q0mWvXUQTAZfjLfezYtusZLegzK0BTA==
X-Received: by 2002:a17:90a:5308:b0:20b:1eae:c94e with SMTP id x8-20020a17090a530800b0020b1eaec94emr73558027pjh.88.1666613054672;
        Mon, 24 Oct 2022 05:04:14 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:3698:60f8:9964:1fb4])
        by smtp.gmail.com with ESMTPSA id z22-20020a62d116000000b0055f209690c0sm19573031pfg.50.2022.10.24.05.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 05:04:14 -0700 (PDT)
Date:   Mon, 24 Oct 2022 05:04:11 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, linux-input@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ARM: dts: imx6qdl-sabre*: fix Egalax touchscreen
 properties
Message-ID: <Y1Z/O8vx6W/Z1Rg5@google.com>
References: <20220920042608.1865560-1-dmitry.torokhov@gmail.com>
 <20221023093016.GC125525@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221023093016.GC125525@dragon>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 05:30:16PM +0800, Shawn Guo wrote:
> On Mon, Sep 19, 2022 at 09:26:05PM -0700, Dmitry Torokhov wrote:
> > This patch fixes interrupt trigger (should be level low as that is what the
> > driver is always using), the GPIO that is the interrupt source that is also
> > used to wake up chip by driving the line low.
> > 
> > The proper polarity is be needed for converting the driver to gpiod API.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Looks good to me.  Let me know if you want me to pick it up.  Otherwise,
> 
> Acked-by: Shawn Guo <shawnguo@kernel.org>

Thank you, I merged it with the other 3 patches through my tree.

-- 
Dmitry
