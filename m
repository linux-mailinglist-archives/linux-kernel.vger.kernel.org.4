Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6038616609
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiKBPZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKBPZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:25:40 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D2EF015;
        Wed,  2 Nov 2022 08:25:39 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 21so27021218edv.3;
        Wed, 02 Nov 2022 08:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hD7I2teCJc+7/W1eRwiXGEi3Z7l5CqlZVQDOMVcFO8A=;
        b=kT7qsjHDVUf9C7CJD1siF5mfXIb3FiBYOtqGgeQJ3I27JZEqXFr2byiHwySQU0onqu
         +DigtCuRydKlIDp4vg+yFtCRCoWRhaDSQrMXhW083Z+y9md6+Q+HVGpzt/F2MccEaA7n
         CKOla7ph4nA2C+KIA3PuuDu27/qcEjauwV5iNeMMXLgCwDmJ6ACgbvrD1pH/hQ909U40
         bGMII+eZ42v1ww0865llvLQwZSQ92iGlOFbl+fjiZr0oRo3f2VK9JieKgQBemE8+XKpu
         zdKk7nPoyay0I3Oe/x4uQnjf4L82qz1PDn6swxiyBb4FLEgcA1icSVUXM2Dkc3HXwDzL
         Pxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hD7I2teCJc+7/W1eRwiXGEi3Z7l5CqlZVQDOMVcFO8A=;
        b=gwcnQvf4/WmYHQiIVPXa8E6sKpaW4FoenJKBau7hqWL0Y9riGIPaWaPZsRUOb0sbkj
         d/yfVTCTcHS/iy3JboMjNfuSJYiMJbW3GqCdJvWl3UJZlhneyBITGLT+XHrZlaWydg4O
         viLYRXKCB5GJJdrDd02rcz8mXo7yVKOEklcDfutaamDvgit1lGV5i3l/7JymFz9ZpTxf
         R2j6C1GztUIad94Rux/HJdiZFo6eOaqGmm1tKllxpaOSSgTCDCEgM4EJ+77vhCbUOyNq
         aB0u9KT8cGHU8ztiUCtDPEol1OoADjdnGQMIdyTD0L/VVVDW3TzwCGd41u2min8aGkwg
         2KHQ==
X-Gm-Message-State: ACrzQf3xTheL8jcs5nbeB4kWjdA71EsQt10XnWWL5+meZIb/zVKDVuBq
        lOV5Bv275bkwb0nLUtAAzAs=
X-Google-Smtp-Source: AMsMyM6hmIxmUsvGLVAoH6dfEI0EEZsGhFcW2HJ9QxxT+O/10FO9Bt1nswkOJauSYQBaDYv3VFNQOQ==
X-Received: by 2002:a05:6402:27cf:b0:462:75b3:a277 with SMTP id c15-20020a05640227cf00b0046275b3a277mr26270160ede.175.1667402738262;
        Wed, 02 Nov 2022 08:25:38 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id e28-20020a170906845c00b00731803d4d04sm5467377ejy.82.2022.11.02.08.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 08:25:37 -0700 (PDT)
Message-ID: <20ea4d6a3cd2a01fe0c5a5a6db1b2ed05548cf8f.camel@gmail.com>
Subject: Re: [PATCH 0/8] Remove adis_initial_startup usage
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Ramona Bolboaca <ramona.bolboaca@analog.com>, jic23@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 02 Nov 2022 16:27:06 +0100
In-Reply-To: <20221102141843.122182-1-ramona.bolboaca@analog.com>
References: <20221102141843.122182-1-ramona.bolboaca@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-11-02 at 16:18 +0200, Ramona Bolboaca wrote:
> Remove adis_initial_startup usage due to the fact that it leads to a
> deadlock.
> The same mutex is acquired twice, without releasing it, once inside
> adis_initial_startup and once inside adis_enable_irq.
> Instead of adis_initial_startup, use __adis_initial_startup.
>=20

Auchhhh!!! Thanks for catching this... However, the Fixes tag is
pointing to the wrong place. I'm fairly sure I introduced this bug in=C2=A0

commit b600bd7eb3335 ("iio: adis: do not disabe IRQs in 'adis_init()'")

This was where the call to adis_enable_irq() was moved to
__adis_initial_startup() and effectively creating the deadlock for some
devices (adis->data->unmasked_drdy is not set)...


I guess I did not saw this when bringing in the change because I
probably tested the full series on some device supported by adis16475.c
where this won't trigger.

From a quick look I think it's safe to drop adis_initial_startup() as
it is always called during probe() before registering the IIO device.
We could also just create an unlocked version of adis_enable_irq()
(since we don't need to grab the lock in this path) but likely not
worth the trouble.

- Nuno S=C3=A1
