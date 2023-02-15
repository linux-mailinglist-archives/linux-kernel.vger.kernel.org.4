Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCA9698179
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjBOQ75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 11:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjBOQ7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:59:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3428113DA;
        Wed, 15 Feb 2023 08:59:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F3F5B8231D;
        Wed, 15 Feb 2023 16:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E4EC433EF;
        Wed, 15 Feb 2023 16:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676480388;
        bh=ggwchy4DM45wIgANx8zfmH+ySHvQBvq1Gcmp+ihiKSg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CwIVCPZZf2WGMAooB4pI+AMAutctrXzZ3pk7lDUrAUoZn5zlyi6x1RgtNCIW83Gm8
         GBdwl5A/yElGyjjneFWNNI9h7Wr3JKiV3pTi78dPeRQ2Bq8NWZCxhVuho63fLIu9Bm
         NP35QpsDp8A3uKuLez4SAlaae842urlgnOqChio8kCDghVVjimXqtO8MQFJnDln8nO
         pocUhmsO+boiEFj7G/vECF1Xk04TOgxQMAmSn0AREqhuV01Ze+JG+HGgPdktS0nPuX
         qT5qYXQkOLzkpyz8vBTRBC+A9Bl7rJef0k6LmQoZ3nh8OEWn3nueJkHiodYxosaZ5g
         qmN+xQR/kdSCw==
Received: by mail-lf1-f41.google.com with SMTP id y25so28367887lfa.9;
        Wed, 15 Feb 2023 08:59:48 -0800 (PST)
X-Gm-Message-State: AO0yUKXGVbK33QSR6SM9TYxtK8FLImuy779jgZMbV3/V1WCPjHwpNUu7
        D7qXjAxlnXu0A2MvRFiRKbOtTxXq1HHBtYSVB6g=
X-Google-Smtp-Source: AK7set+eA/Zi76Moio7beAlJ6RUCtjwR9ATwM8bHx4MGo9hbpM+d8TdMkO2QH+HeEP9pp0jMSGh9ujnh44hHB8w0PKU=
X-Received: by 2002:a19:7610:0:b0:4db:37ce:ae0 with SMTP id
 c16-20020a197610000000b004db37ce0ae0mr725175lff.7.1676480386958; Wed, 15 Feb
 2023 08:59:46 -0800 (PST)
MIME-Version: 1.0
References: <20230215100008.2565237-1-ardb@kernel.org> <20230215100008.2565237-2-ardb@kernel.org>
 <20230215165832.GB3786546@roeck-us.net>
In-Reply-To: <20230215165832.GB3786546@roeck-us.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 15 Feb 2023 17:59:35 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHpyBrSvRVk+SyOzxFuYEWiL1uOxtdya5gXW3nbO95K5g@mail.gmail.com>
Message-ID: <CAMj1kXHpyBrSvRVk+SyOzxFuYEWiL1uOxtdya5gXW3nbO95K5g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] arch: Remove Itanium (IA-64) architecture
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, Tony Luck <tony.luck@intel.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ia64@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2023 at 17:58, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, Feb 15, 2023 at 11:00:04AM +0100, Ard Biesheuvel wrote:
> > Itanium is the original architecture for which EFI was developed, and
> > the way Linux supports it deviates significantly from other
> > architectures.
> >
> > So it is anyone's guess whether the ongoing maintenance and developement
> > of the EFI subsystem has regressed Itanium or not - QEMU no longer
> > implements support for it, and so there is zero test coverage using
> > actual hardware.
> >
> > Note that the Intel firmware team themselves already removed all IA-64
> > support from the Tianocore/EDK2 reference implementation of EFI in 2018,
> > so let's follow suit, and drop IA-64 from Linux as well.
> >
> > Acked-by: Tony Luck <tony.luck@intel.com>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> Trying again since the previous message bounced with "message too long".
>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
>
> Sorry for the noise for anyone receiving this twice.
>

Thanks, and this is my fault really - I used the -D option to omit the
pre-images but the patch is still >100k :-(
