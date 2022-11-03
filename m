Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2E961759E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiKCEci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiKCEcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:32:09 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182CC1B78A;
        Wed,  2 Nov 2022 21:30:36 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-13c569e5ff5so944253fac.6;
        Wed, 02 Nov 2022 21:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=beWe+uN+ON3DnKB4aGPZ3xvAANzoMjyW6vf2PFY929c=;
        b=jacehTQdxGORVtrgfvg0hPn0N5GQ2IUEGiL/11ZLmE5QRgqMbF6clRydJ/bAvwS1O8
         8Z9UR6DiWWKEVePi87bU5voHcQV4UUftDtF/6e95DaD5ELfNE8JHWHhWwkraGlHT/ig8
         jVeu1W283oM+9PRjGW7YZCKVy6Y+RNb+STI4bXXVQI/4SK3STy0z5ozLwJ7779WSKKvP
         z84gR7ImXU45qb4g7G4KfA4XepQw63t0iJzOVlrVzotBWrSuaJOIJalsiBwyDhXJ4jTV
         aSlLd0jNwOjRv85WYRIR5emtjHLsA7hQuNulGRxDWHQkyM41tHOLr/kpaknE0i/eknpt
         Ok4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=beWe+uN+ON3DnKB4aGPZ3xvAANzoMjyW6vf2PFY929c=;
        b=bqEmPCVjQrPK3v+sR3q4UHv/hJR2FIk38nBo1gdcbRwhdpaDPMFgLjxJv3gNFYcw56
         7pmgJf7t3b8CRkGL3okCmRB7elEDHFL2wcqYh+1D52u0QasMNt5pQJwN/oSvSJM9W9aF
         RyP7DE3Xjc7tDb64UEwpMpGdEIwb5BEzKGXjTHDlfC0YzFTy8xDyah6ggHjVR6fMoMt6
         W5ssvjUP4ZOnQTHf3OLhkpbQ1SwJKsG1QphpgfCnSTcozJiCRHMag+oFW12yndHAEZBd
         emdpXs/xHwdisNeC7kp+h14RAi1JIWjQ+V4ZYKeh6bfia9F8qfJyvi1pQN2GLTxYYrDj
         6bag==
X-Gm-Message-State: ACrzQf1h1CZjIDXpv/HmDSf+X9v3vTMyXeAriAipf6wrS0ExNl5C3rNK
        48qpivtizkrfRM6cjcVKMXbtI0FnxPY=
X-Google-Smtp-Source: AMsMyM5/TXw3maOdtX+B4EYEcC9BeJj3uMEM0QxNLDKW/206hGsoRzr8X5YYyqpVqpk3jT6Tc3lf4w==
X-Received: by 2002:a05:6870:2487:b0:131:4fee:aec2 with SMTP id s7-20020a056870248700b001314feeaec2mr26066038oaq.69.1667449835919;
        Wed, 02 Nov 2022 21:30:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i3-20020a4addc3000000b0049201e2b8f4sm5150583oov.4.2022.11.02.21.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 21:30:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 2 Nov 2022 21:30:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        "garnermic@meta.com" <garnermic@meta.com>
Subject: Re: [v2 3/3] hwmon: Add Aspeed ast2600 TACH support
Message-ID: <20221103043034.GA2113834@roeck-us.net>
References: <20221101095156.30591-1-billy_tsai@aspeedtech.com>
 <20221101095156.30591-4-billy_tsai@aspeedtech.com>
 <20221101131456.GA1310110@roeck-us.net>
 <271C521D-8F20-4C86-B3DA-9C0AD74242D4@aspeedtech.com>
 <20221102170138.GA2913353@roeck-us.net>
 <F1166366-99CC-4A36-A0A2-4965C787E60B@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F1166366-99CC-4A36-A0A2-4965C787E60B@aspeedtech.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 03:52:59AM +0000, Billy Tsai wrote:
> 
> Can't I use a min/max RPM to let the driver know a reasonable timeout/polling period when
> the driver is trying to get RPM?
> Beacause that our tach controller have the falg to indicates the hardware detected the change
> in the input signal. I need the proper timout to rule out slow RPMs.
> 

If the chip measures the fan speed continuously, why would that ever be a
problem, and why wait in the first place instead of just taking the most
recent result ?

Pretty much every other driver is doing that, so I really don't understand
why that would not work here.

Guenter
