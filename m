Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A1667B32A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 14:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbjAYNVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 08:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjAYNVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:21:41 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B43217CCE;
        Wed, 25 Jan 2023 05:21:40 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id vw16so47553897ejc.12;
        Wed, 25 Jan 2023 05:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z11HQjPD482wG6TQqbqQUkBWzfmDI9uIR3DR03/5mws=;
        b=SaY/5HA+NXWkAvzF746yaoiv142/ti9OjsIQOTJ+8G3SmmrDkNbf8OF+34ZoyYTZel
         MUJ73Z8vhlP51FEqYXeDck+gQB2e2ta7U+XnRMByb+d8s7iP4iCGWTkLihUn3UnyUNXU
         WMeDQJWD01i04uT6+mSbMMAbbXPycFV7PdtoT0XnNmiwZD7QjY3UdsaDMTxY1OA1Bv7r
         mlL2gEjFolPBNbhObl9Z1nMzTjOtJGkgvGCD0Td4owhpIVjvBf7IKonh7p8vzdPTv6pp
         kMYUjszwwL3ZqU34b7fUwvrR7nKZoG6Fomxz3y+pqo9e1eUldNnlvq5xVqVUxGZ4Y+He
         IzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z11HQjPD482wG6TQqbqQUkBWzfmDI9uIR3DR03/5mws=;
        b=gnswqa3wf+PhtMWsMPuhVRsCszbPXqOhHL7hxGPevkNnVzA8z2kQJIEp1FR3B9XLuB
         thyidaD8hfzLoJs7GNHerdpKNY1840A0mXMGbWaSy7x6kVDXEL3yxJ1fzF4c6vL+orB+
         QPs2nf61E9R9ibv+6GyOmCl3kdLSXam7vgjbdqEcUCh/tvVBjUOnGdQzLc/d2sa0FvrI
         Fk5wBnLumxLgMKcQaSGcbYpu3UM4N8V4UoQL1qzEywQqgq2aa5RdHP/X/qwcsaXt/3h3
         AydlwVY1s3GknngDfWtPp2GPLrS31yQupS3uBuhP8lczAUqc2+uXVyoLdWw3il2yvMoX
         Sswg==
X-Gm-Message-State: AFqh2koa9Jt4FV8Ugd7xBmquod0L70Y0jc3o9h3pKvn9gVZaHsBhUUb1
        XL/3BTMYYmH8tqI0v5OY7H8=
X-Google-Smtp-Source: AMrXdXvnFsQ5y9XBLsNVnApLK68mC1dOMwOKSCWKL+7FwFYjkukpqa1izK5KofCcHh6kfZtdL+nNjA==
X-Received: by 2002:a17:907:8c14:b0:84c:e9c4:5751 with SMTP id ta20-20020a1709078c1400b0084ce9c45751mr34847769ejc.74.1674652898698;
        Wed, 25 Jan 2023 05:21:38 -0800 (PST)
Received: from fedora (176-74-132-138.netdatacomm.cz. [176.74.132.138])
        by smtp.gmail.com with ESMTPSA id fq32-20020a1709069da000b0083f91a32131sm2352741ejc.0.2023.01.25.05.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 05:21:38 -0800 (PST)
Date:   Wed, 25 Jan 2023 14:21:35 +0100
From:   Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        hemantk@codeaurora.org, quic_jhugo@quicinc.com,
        Bjorn Andersson <andersson@kernel.org>, Michael.Srba@seznam.cz,
        dipenp@nvidia.com, Bart Van Assche <bvanassche@acm.org>,
        iwona.winiarska@intel.com, Oded Gabbay <ogabbay@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        fmdefrancesco@gmail.com, jason.m.bills@linux.intel.com,
        jae.hyun.yoo@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/3] bus: add Wiegand bus driver
Message-ID: <Y9Es35/ehMuB9q8g@fedora>
References: <20230104133414.39305-1-m.zatovic1@gmail.com>
 <20230104133414.39305-3-m.zatovic1@gmail.com>
 <Y7WHjD4psjgAAyPd@kroah.com>
 <Y9EpNfZJ5irXZqvR@fedora>
 <43964d94-1c76-4c4f-b093-92a611518a87@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43964d94-1c76-4c4f-b093-92a611518a87@app.fastmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can not think of any such case. I was trying to be safe
when including this functionality, as I have seen it in the
SPI driver. Thank you for the information, I will just
leave it out.
