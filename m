Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBBA62E7F5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbiKQWNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiKQWNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:13:42 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28B46376;
        Thu, 17 Nov 2022 14:13:41 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso3103130pjt.0;
        Thu, 17 Nov 2022 14:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f06cqSRJWJq7tzA4zFWcNI3yf20+OmliN5HlU3NPwBg=;
        b=kIDW4IG0NXahblHZ+J9OHofWLjPQX/rflmieQg9t0L3fpCknXE3kM/jf+yeTz1/ZtP
         59XjoEKvi8ZufmQrmDCps36RQY8RQ8LcSD4PQsjEBoDfo9Q9DEBldCMe2lcFAjc0Mi6M
         PwzZVo3x8EPmc0fXTpSo++I/CDL3vjGrpG5XYnTGLXZoAyHvodu+cQhuDtgL9r1nYtEa
         T2Fj68OP9mlxVwQZZnp/rqLnPt00y3LTdraBTdN2Nb0zIc7R2cncOPzPlwSguPvYYHQb
         ic3ywhdWmemRh9X5kPZRSQA3+dL4NXrQ4dXzB4rv8TRiq0UAliBSRHHgl04OlTTTP+rQ
         SSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f06cqSRJWJq7tzA4zFWcNI3yf20+OmliN5HlU3NPwBg=;
        b=yp0sYbYmwtiAxSmMvO6seJxnSwHkeYHPiY1DjmmngISk7tVg+O9a6G3qUC0BHwgmaJ
         YY93WLQ+JZWnqfAto2+9aKposmpTrkXaUW1mV2TMdeKsYCBMAgk/C7DsjfJ2Y8RulsJI
         E952NdcqeSzZKtJgb4ECSfXFiUYkKYf47u7lPUbHgAcDXgknVFugQtpclQFP+fo7IrOL
         vCBpT9YAGofLlVAD0ZrvYXH+f2ZoBMB68hCKDdHe2ik9LzFLuMBjWceI40rLsX/uRUb8
         1FIwIBPGsWf1CXGH9FmmxsVoLyIZEgjcjEZgLTA2prWz9EPosgQtMthqh54UerjWfTTC
         MG4A==
X-Gm-Message-State: ANoB5plmT2YQv4cGeJAys51JsMy6XHOvSbgeOf0q5kGW6K3UStB8p3k8
        eFiKfLNQHH8Q4igM2mL6HW4=
X-Google-Smtp-Source: AA0mqf43FrXDE+6wKKa2X5G/31I/6kOkI9kyNqrRRQw/mzu7UkBb7oxm5w9ytGlOr1K+rri6xGa1IA==
X-Received: by 2002:a17:902:a508:b0:17c:7aaa:c67d with SMTP id s8-20020a170902a50800b0017c7aaac67dmr4499159plq.171.1668723221142;
        Thu, 17 Nov 2022 14:13:41 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:e4c5:c31d:4c68:97a0])
        by smtp.gmail.com with ESMTPSA id j23-20020a63e757000000b0047063eb4098sm1527256pgk.37.2022.11.17.14.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:13:40 -0800 (PST)
Date:   Thu, 17 Nov 2022 14:13:37 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Johnny Chuang <johnny.chuang.emc@gmail.com>,
        Scott Liu <scott.liu@emc.com.tw>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: elants_i2c: Properly handle the reset GPIO when
 power is off
Message-ID: <Y3ayEc8sFCLahOT3@google.com>
References: <20221117123805.1.I9959ac561dd6e1e8e1ce7085e4de6167b27c574f@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117123805.1.I9959ac561dd6e1e8e1ce7085e4de6167b27c574f@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 12:38:23PM -0800, Douglas Anderson wrote:
> As can be seen in elants_i2c_power_off(), we want the reset GPIO
> asserted when power is off. The reset GPIO is active low so we need
> the reset line logic low when power is off to avoid leakage.
> 
> We have a problem, though, at probe time. At probe time we haven't
> powered the regulators on yet but we have:
>   devm_gpiod_get(&client->dev, "reset", GPIOD_OUT_LOW);
> 
> While that _looks_ right, it turns out that it's not. The
> GPIOD_OUT_LOW doesn't mean to init the GPIO to low. It means init the
> GPIO to "not asserted". Since this is an active low GPIO that inits it
> to be high.
> 
> Let's fix this to properly init the GPIO. Now after both probe and
> power off the state of the GPIO is consistent (it's "asserted" or
> level low).
> 
> Once we fix this, we can see that at power on time we no longer to
> assert the reset GPIO as the first thing. The reset GPIO is _always_
> asserted before powering on. Let's fix powering on to account for
> this.

I kind of like that elants_i2c_power_on() is self-contained and does the
full power sequence. Can we simply change devm_gpiod_get() to use
GPIOD_ASIS to avoid the momentary spike in reset line state (assuming
that the firmware initializes the reset line sanely because if it does
not we have much longer time where we are leaking into the controller)?

Thanks.

-- 
Dmitry
