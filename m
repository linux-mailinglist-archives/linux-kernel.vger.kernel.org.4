Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C4174B202
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 15:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjGGNnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 09:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjGGNnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:43:15 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6A7211D
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 06:43:12 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-635e5b06aaeso12698186d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 06:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688737391; x=1691329391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dzZkPG7RI0wAetYk691Ba8KUKNWl6F1qo7jNyyUdK70=;
        b=p59HvEZUQAvjmAzFEUEIg3jouNj+3W3V4HWCRoTddqH1X5xky3rZjaSrMloOmkT1r5
         l2l85R/Q8A0VNuX2IhonifMxEhUGtlLiVP8MoaC1fm/XTiNxKU4aKZ+tnUNompGJcZys
         bkJ9tdbcBmNrWndDt5aTtrTcmNGWDrlKlHiqzfdhq1O8h57VDlpMqOHFytcSosFtmR9g
         Kcnmh5JZUtiGXtCBg4IlGzjm6dLzN0OnTlVbCdVn7C1j7mmozqdLyiO41szzrD/U+fcV
         4whLWWkMNZEt0WuF15IZjz9PRLtpp3Rsevg/WoQinG860O2X/BuAc21esYFGW030m0rq
         yXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688737391; x=1691329391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dzZkPG7RI0wAetYk691Ba8KUKNWl6F1qo7jNyyUdK70=;
        b=bdruNvGdvf1q1oN6xmQnCSX+rsKpw/rwIFtsO+psqt24PAOIettH2fT2VMzY9gykkN
         kDPlLIBMccaIVq4G3hebdVYQY8Gr9FmuxkdnKtU3lOUzBy51WWUMY1IA4WSFt4LCl+/X
         HFPGrBqCqWi0HXz0nTLoKADzLP4NWVrYKOUPs3wx8/1GR+knKQVhwM8scDJ/9riwEyuS
         xYNpUkVnMNBmUxRcAo9I+YQ/EIKwtgR8jovklMI93BF8cIydJsv0gCxFTkOmhToZJ1Ka
         V41zIom5NuO7Yw9bXA5dU6QVJeO3dDm6ZJBrHpW4jhrYUNWcOOMyu2V3Hm9tdnjBx+Ti
         5SmQ==
X-Gm-Message-State: ABy/qLZlwqFYfKBYZCDaAi4dhW2VNqY/Ko5xv+BZTeB/97ubE7RrmulR
        x3yPpb6p0Pa936htWFdJRQw7MnanAAvVX1wtjrH3ig==
X-Google-Smtp-Source: APBJJlFpy8jDyr+KlmdxqCpqIx3uqmKGuxqPWsdaP5UQPNw0Sk1yW0BVcwfYgifZv/9oQcKxx9JRXU8ymUO0lbn+u0c=
X-Received: by 2002:a0c:9e81:0:b0:635:e81d:e57d with SMTP id
 r1-20020a0c9e81000000b00635e81de57dmr4166916qvd.55.1688737391400; Fri, 07 Jul
 2023 06:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230531090424.3187-1-johan+linaro@kernel.org>
 <20230531090424.3187-3-johan+linaro@kernel.org> <CAMi1Hd3fe=wk02WG8J7K5Ud1GcWkuKKKrxFjkNguxDkzNz2WVQ@mail.gmail.com>
 <ZKfyH4jRGlVlcLeY@hovoldconsulting.com>
In-Reply-To: <ZKfyH4jRGlVlcLeY@hovoldconsulting.com>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Fri, 7 Jul 2023 19:12:35 +0530
Message-ID: <CAMi1Hd2CGQKbMPm6GXfSHgrdHsyngBQ_DBseF08=oEvGdizVcw@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/2] Bluetooth: fix use-bdaddr-property quirk
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2023 at 16:37, Johan Hovold <johan@kernel.org> wrote:
>
> On Fri, Jul 07, 2023 at 03:11:11PM +0530, Amit Pundir wrote:
>
> > On Wed, 31 May 2023 at 14:35, Johan Hovold <johan+linaro@kernel.org> wrote:
> > >
> > > Devices that lack persistent storage for the device address can indicate
> > > this by setting the HCI_QUIRK_INVALID_BDADDR which causes the controller
> > > to be marked as unconfigured until user space has set a valid address.
> > >
> > > The related HCI_QUIRK_USE_BDADDR_PROPERTY was later added to similarly
> > > indicate that the device lacks a valid address but that one may be
> > > specified in the devicetree.
> > >
> > > As is clear from commit 7a0e5b15ca45 ("Bluetooth: Add quirk for reading
> > > BD_ADDR from fwnode property") that added and documented this quirk and
> > > commits like de79a9df1692 ("Bluetooth: btqcomsmd: use
> > > HCI_QUIRK_USE_BDADDR_PROPERTY"), the device address of controllers with
> > > this flag should be treated as invalid until user space has had a chance
> > > to configure the controller in case the devicetree property is missing.
> > >
> > > As it does not make sense to allow controllers with invalid addresses,
> > > restore the original semantics, which also makes sure that the
> > > implementation is consistent (e.g. get_missing_options() indicates that
> > > the address must be set) and matches the documentation (including
> > > comments in the code, such as, "In case any of them is set, the
> > > controller has to start up as unconfigured.").
>
> > This patch broke Bluetooth on Dragonboard 845c (SDM845) devboard.
> > Reverting this patch fixes the BT breakage and I see the following
> > messages in dmesg:
> >
> > Bluetooth: hci0: setting up wcn399x
> > Bluetooth: hci0: QCA Product ID   :0x0000000a
> > Bluetooth: hci0: QCA SOC Version  :0x40010214
> > Bluetooth: hci0: QCA ROM Version  :0x00000201
> > Bluetooth: hci0: QCA Patch Version:0x00000001
> > Bluetooth: hci0: QCA controller version 0x02140201
> > Bluetooth: hci0: QCA Downloading qca/crbtfw21.tlv
> > Bluetooth: hci0: QCA Downloading qca/crnv21.bin
> > Bluetooth: hci0: QCA setup on UART is completed
>
> That's odd. You should still see the above messages also with this patch
> applied, but you may now need to provide a valid device address before
> being able to use device in case the bootloader has not provided one
> (e.g. using btmgmt).

Sorry for the confusion, I missed the part where I do see these
messages when the kernel module is loaded but the direct firmware
loading fails.

Bluetooth: hci0: setting up wcn399x
Bluetooth: hci0: QCA Product ID   :0x0000000a
Bluetooth: hci0: QCA SOC Version  :0x40010214
Bluetooth: hci0: QCA ROM Version  :0x00000201
Bluetooth: hci0: QCA Patch Version:0x00000001
Bluetooth: hci0: QCA controller version 0x02140201
Bluetooth: hci0: QCA Downloading qca/crbtfw21.tlv
bluetooth hci0: Direct firmware load for qca/crbtfw21.tlv failed with error -2
Bluetooth: hci0: QCA Failed to request file: qca/crbtfw21.tlv (-2)
Bluetooth: hci0: QCA Failed to download patch (-2)
Bluetooth: hci0: QCA preshutdown_cmd failed (-56)

This happens in all the cases (working and non-working BT) because
filesystem is not mounted by that time. I'm running AOSP and all the
kernel modules get loaded from a ramdisk. But in the working case, the
firmware loading kicks in again later in the boot process and BT gets
initiazed..

With this patch, after the first attempt to load the firmware fails,
the firmware loading doesn't kick-in again. Also even if I keep the
firmware in ramdisk then the direct firmware loading from ramdisk
happens but BT still doesn't work
https://bugs.linaro.org/attachment.cgi?id=1148.

>
> Are there any error messages in the log when running with this patch?

I don't see any relevant error message in dmesg. I'll check if I can
find a command line BT debug tool which I can use on AOSP for
debugging. There used to be a few hci command line tools, when I
looked into it a few years ago. Not sure if they are still around and
useful.

Regards,
Amit Pundir

>
> Does
>
>         btmgmt --index 0 public-addr <bdaddr>
>
> work?
>
> Johan
