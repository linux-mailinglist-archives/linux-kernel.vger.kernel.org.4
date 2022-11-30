Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C5B63E096
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 20:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiK3TTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 14:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiK3TTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 14:19:13 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345F18326D;
        Wed, 30 Nov 2022 11:19:07 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id q186so19826675oia.9;
        Wed, 30 Nov 2022 11:19:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYXjbxoFQehwcsI7KFidJyM7jz5FlBew6fgMc5btlwA=;
        b=Q/23+aDaqLUHDDBbaBonOfsF7i2K+MiBpMKiOhvTNMCvwiwln1wbyEtgJ+Tr5F3+HB
         MmPwQMvQj5wkQ6ZksJBF1NFbZ424DBs0axUw0VEeNsiPKmDT7FYfIXpXFYq7nNmTjNS7
         5hfK+9kf5uHMsPYykmTWdyhRMLvOiuQJEx2PmCleg08/9p46ajmQbWwA10zvPqlnKvFR
         deCXoIxJWjY/X73bdKLEnZjUEtWa6q1wsZ2ljaJWsom09s/W84wUiuj8r2dZWlE/Lh7D
         izQ7IOED6UoDt1S/aBEDwC6p5jlN2PbcXPhBjL6PLgZcgR9Cn1J4CsYVEhtncrydBCoF
         iGAw==
X-Gm-Message-State: ANoB5pktTc18M+TTSqgdtwbUF7yER+Uw0vhG4hlGNnFkN/Tpp3CQAPaH
        YkNfuf6S8njglDjsCs89iNqF7yv9fQ==
X-Google-Smtp-Source: AA0mqf4rKwspdtZ+SMaPu2KJBmHK8BHdPWeidUIEUapjacMCkerAKVk18+BhHcSlwZs26jDT527iUA==
X-Received: by 2002:aca:4486:0:b0:354:5bc5:17f2 with SMTP id r128-20020aca4486000000b003545bc517f2mr30378230oia.7.1669835946355;
        Wed, 30 Nov 2022 11:19:06 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x186-20020a4a41c3000000b00494ed04f500sm1031478ooa.27.2022.11.30.11.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 11:19:06 -0800 (PST)
Received: (nullmailer pid 2640013 invoked by uid 1000);
        Wed, 30 Nov 2022 19:19:05 -0000
Date:   Wed, 30 Nov 2022 13:19:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        kernel@dh-electronics.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: leds: Mark label property as deprecated
Message-ID: <20221130191905.GA2631320-robh@kernel.org>
References: <20221122111124.6828-1-cniedermaier@dh-electronics.com>
 <Y3y/S5COG7VPbsqL@duo.ucw.cz>
 <3f4c89a3-8955-ce41-ac2a-cee9b0ed5210@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f4c89a3-8955-ce41-ac2a-cee9b0ed5210@denx.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 10:26:30PM +0100, Marek Vasut wrote:
> On 11/22/22 13:23, Pavel Machek wrote:
> > Hi!
> 
> Hi,
> 
> > > Mark the label property as deprecated as it is mentioned
> > > in the description.
> > 
> > Lets do it the other way around. Functions (etc) don't really provide
> > good enough description of LED, and label is still needed.
> 
> Can you please provide a clear explanation which property or approach is the
> correct one for new DTs ?
> 
> So far, the documentation states that "label" is deprecated, and users
> should replace it with "function" and "color".

'function' is what activity/operation the LED is associated with. It is 
a fixed set of strings which s/w may use. It is a replacement for 
'linux,default-trigger'.

'label' is what is printed next to the LED for a human to read. 'label' 
can be anything and the OS shouldn't care what it is.


They serve 2 different purposes.

Rob
