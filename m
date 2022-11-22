Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462356348B2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbiKVUsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbiKVUsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:48:30 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444ED1C9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:48:28 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 6so15051686pgm.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qQ4il4WCPkNns9UB7hYX0PSzg5JhITm8H9TsWBohCps=;
        b=1fnX0Z4rNDw3WqW7vxA09Nvzwl604ChRAQDY326MTPWvgOWsIg9zOYQXUVcDfRFQcG
         GMK2za3OoxZSU4iAbDaPm2HH/xuJUYw+xIAfsHc4Tg5QCr5CvenylZaIg8MP3H5F4q7c
         ByHy6lQP98I0X6BkktI1gt2TubmQmdioHQoqYsULG/DAkrxYa6RF8pm0YOxo7OvTx5j0
         EDQk+ZkyYNY59jtwVsGHRGlCxmeHciOt8Efxwa5lJVI1DHjM5PQQ++0XcNlkwwz6LEKk
         b7DKgD6oD99TIw+f+o7HSMe2KeRXVUu4XZuB/sXSzwsZA1G8BWMrS2oacO8E/aHIPjYl
         K/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQ4il4WCPkNns9UB7hYX0PSzg5JhITm8H9TsWBohCps=;
        b=5Wp+m7L8G2cKqLNe/qN1/ZD6s+5zmAJwcBJZ7E/y22uRZvvZc/1/HELucaXZ4nB2RP
         5PRlGB3HmUZ3zyihhaIWtajm5mkdxdxEUOnj0i29oMfKPKAuR+HngRX+3ihRYNvu919l
         H0k3Rm+hJfVTx9ZmSXBlQwExIIe9oeSxNwnnlfmSoE1Hk0oq6/ltD5pc5hoT9oIeFZFT
         Lc717UEEkHbOjrGEZmZ8DYmtQ4utTtmpV9mRfVtjpxtD6cCXedzrYoIfSdsn3U9xyao+
         GSgvamCxW8Hna6m43VZcS079Tvjn6rSvnIigv4Tnh0Aa8oLMHmXu8xptFAN+B6rlL5GM
         mObw==
X-Gm-Message-State: ANoB5pmfFHbFYr2FXQ7hShyWQPQyz4Nqi7gbWAtJoDYsL++2kycwG7Rs
        oLCwoyamWUn7nNxhcWCzhqGkTQ==
X-Google-Smtp-Source: AA0mqf4kN1U4OHLHbJ789kCmBZLZ4vW6PKsHiJnp5W2dY4sK+ojJihZwT+uTMhpuv+/LcZAoirBvZQ==
X-Received: by 2002:a05:6a00:16c6:b0:573:65d4:a104 with SMTP id l6-20020a056a0016c600b0057365d4a104mr16579849pfc.85.1669150107446;
        Tue, 22 Nov 2022 12:48:27 -0800 (PST)
Received: from localhost ([75.172.139.56])
        by smtp.gmail.com with ESMTPSA id a13-20020aa794ad000000b0056ba02feda1sm11442823pfl.94.2022.11.22.12.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 12:48:26 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Nishanth Menon <nm@ti.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, nfrayer@baylibre.com,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, glaroque@baylibre.com
Subject: Re: [PATCH v6 0/2] soc: ti: k3-socinfo: Add module build support to
 the k3 socinfo driver
In-Reply-To: <166906774215.20855.4956750581421635106.b4-ty@ti.com>
References: <20221117095419.171906-1-nfrayer@baylibre.com>
 <166906774215.20855.4956750581421635106.b4-ty@ti.com>
Date:   Tue, 22 Nov 2022 12:48:26 -0800
Message-ID: <7ha64iaf6t.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

Nishanth Menon <nm@ti.com> writes:

> Hi Nicolas Frayer,
>
> On Thu, 17 Nov 2022 10:54:17 +0100, Nicolas Frayer wrote:
>> In order for the TI K3 SoC info driver to be built as a module, the
>> following changes have been made:
>> - Converted memory allocations to devm and added the remove callback
>> - Added necessary code to build the driver as a module
>> 
>> v2->v3:
>> dropped module conversion part of this series while other driver
>> dependencies on socinfo are worked out.
>> A dependency issue is introduced by changing subsys_initcall()
>> to module_platform_driver(). Some drivers using the socinfo information
>> probe before the socinfo driver itself and it makes their probe fail.
>> 
>> [...]
>
> I have applied the following to branch ti-drivers-soc-next on [1].
> Thank you!

Sorry for the churn here, but I think these need to be reverted.

We've discoverd some more complexities/issues when socinfo is modular,
and I think the socinfo core code needs some work before this can
actually work reliably for all socinfo users.

Basically, I think we need to finish converting all the socinfo users to
modules before we can be sure of all the corner cases when socinfo
itself is a module.

Sorry about this churn, but I think it's better to be a bit conservative
here and revert before this lands in mainline.

Thanks,

Kevin
