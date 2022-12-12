Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C85F64A41A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 16:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbiLLPZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 10:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbiLLPZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 10:25:02 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C1EDF57;
        Mon, 12 Dec 2022 07:25:01 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id u19so10429731ejm.8;
        Mon, 12 Dec 2022 07:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9AHrQ7N3nRBE+WOLy0Bq5g+V2hYQvIG1OHCO+pLERp0=;
        b=RmHTBIvkXbdmJ5ksl/eZVByvCarZ8CgvdstcoD39FvhfidCefGaPFxvPUURIX0sGhb
         TvWQyJXIDLwBVEg2XhH7AkMb/1q0XKQNBQoXxHHhSNobRK5sWwKSsAJrxiNBcoGEGVmP
         kwaPucHYXKh1m3LhUWSFcnFKh5oPJ1lKnlimVtpDllvumhNurl1O7rHgOWcz/4UplkcO
         HvwUPefHOi7uL2I0qfTLQs/Nq7B/kSZfUx42FvMhGirjlBue1fY6oJKHWTOp5lXv9YQC
         Cbcae0nlcsRV4cpAp+eNcunMAiVRD4Glih6kcuc8kcN3e+uKVy/QNz7tV7Zikfo21jAo
         7qNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9AHrQ7N3nRBE+WOLy0Bq5g+V2hYQvIG1OHCO+pLERp0=;
        b=PDLIcHre0YZWKIdwCpgkrPsnSxBRzShuFjei0ynh4uEhc/J87NLKqy6WQCDh5AU4T5
         3LIutxV3dpqRvkC5B9MJoUO1G+etjEmib5ou6k0NcUjIGbFxdnaLZ6fKPjB//2KSzufs
         1IbOz3Fb1B+9QJ4ihCS6QgwljmubcXSLFyDXOEV0LffnJ3HUtczFrHRtbuq+4MAhYAdL
         xh3GGmB1EOUztNu6RqRymsdyM/49j480WxXv9aqHEjZCryzkGp+T1bfTJ7CkNSyw0b2p
         Q6WwxQU4gPPylOs6NmByS/yXiBFZZRNAwnNJ8xCjI6sxaOqba4EQnwD0vSCdSveTD0ap
         ZmGg==
X-Gm-Message-State: ANoB5plnZLU0bRtwESxPp2yi6YP2Cf7aqP6hxFKctgrZi2f8OqIZdeTD
        do6yriIC3iCkKAdwAbNPtm28gCMvi7JrIeO5yk8=
X-Google-Smtp-Source: AA0mqf7/wKhq/6iI8G8EHKUiD1UUAqFrx/VfnmYqMJ7pXyvsjQVJtsH/1M1e5/xQ95l1TBFCuhhiNPDCgWk8nQ4YGo8=
X-Received: by 2002:a17:906:4bc4:b0:78d:6325:356 with SMTP id
 x4-20020a1709064bc400b0078d63250356mr79921777ejv.6.1670858699756; Mon, 12 Dec
 2022 07:24:59 -0800 (PST)
MIME-Version: 1.0
References: <20221205210354.11846-1-andrew.smirnov@gmail.com>
 <CADyDSO4uh6b+sSZTkZ2_DR923=bA=kXgK1LqUMkknCMzf_DSwQ@mail.gmail.com> <CAHQ1cqGaL5v4PARTZU6_0tfSCz3=9b1THz-D-Bg1G64hBV+_Wg@mail.gmail.com>
In-Reply-To: <CAHQ1cqGaL5v4PARTZU6_0tfSCz3=9b1THz-D-Bg1G64hBV+_Wg@mail.gmail.com>
From:   David Rheinsberg <david.rheinsberg@gmail.com>
Date:   Mon, 12 Dec 2022 16:24:48 +0100
Message-ID: <CADyDSO5wBWKoWCO668cgPrZrCo9SfsJ0XqfCEbgRU3WErReibQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Handling of non-numbered feature reports by hidraw
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Thu, 8 Dec 2022 at 21:59, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> On Thu, Dec 8, 2022 at 7:46 AM David Rheinsberg
> <david.rheinsberg@gmail.com> wrote:
> >
> > Hi
> >
> > On Mon, 5 Dec 2022 at 22:04, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> > > I'm working on a firmware of a device that exposes a HID interface via
> > > USB and/or BLE and uses, among other things, non-numbered feature
> > > reports. Included in this series are two paches I had to create in
> > > order for hidraw devices created for aforementioned subsystems to
> > > behave in the same way when exerciesd by the same test tool.
> > >
> > > I don't know if the patches are acceptable as-is WRT to not breaking
> > > existing userspace, hence the RFC tag.
> >
> > Can you elaborate why you remove the special handling from USBHID but
> > add it to UHID? They both operate logically on the same level, so
> > shouldn't we simply adjust uhid to include the report-id in buf[0]?
> >
> > Also, you override buf[0] in UHID, so I wonder what UHID currently
> > returns there?
> >
> > IOW, can you elaborate a bit what the current behavior of each of the
> > involved modules is, and what behavior you would expect? This would
> > allow to better understand what you are trying to achieve. The more
> > context you can give, the easier it is to understand what happens
> > there.
> >
>
> Sorry it's not very clear, so the difference between the cases is that
> in the case of UHID the report ID ends up being included as a part of
> "SET_FEATURE", so BlueZ checks UHID_DEV_NUMBERED_FEATURE_REPORTS,
> which is not set (correctly) and tries to send the whole payload. This
> ends up as a maxlen + 1 (extra byte) write to a property that is
> maxlen long, which gets rejected by device's BLE stack.
>
> In the case of USBHID the problem happens in "GET_FEATURE" path. When
> userspace reads the expected data back it gets an extra 0 prepended to
> the payload, so all of the actual payload has an offset of 1. This
> doesn't happen with UHID, which I think is the correct behavior here.
>
> Hopefully that explains the difference, let me know if something is unclear

Yes, thanks, I completely missed that. Lets continue discussion on the patches.

Thanks!
David
