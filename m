Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAF4716476
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjE3Okb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjE3Ok0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:40:26 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3218F;
        Tue, 30 May 2023 07:40:25 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-96f50e26b8bso843929466b.2;
        Tue, 30 May 2023 07:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685457624; x=1688049624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HVONGtru1vqvpdwj35njbJ3xnsiF5SXH/XspKxAtbg=;
        b=q8fJ9qbk7Jl0YnHgeMW8pNsQXiwZIpXef54bS0SDVbrPKo8Bn+bhixJkmC1bpx6wfI
         Eu3rr8syVVzCLQhQwMckDJOLarruJVOglg/qQGCcUJDhxQ+fayWtAe4CIdG/OhqpO1gB
         3fVbPnshlKcTsfmOzE6zN8Ff8+sGDs/OcuT3+tDLBOzGuu/pPtkp+mIKNdlD7oBhoVvV
         Xq2IOTzr0ClJodPE5Xf1a6GpqkHSM9bjMoRSaxPqQ9u+24FXWUAiGIPS3TRrn22SmTfW
         7OBrUPrC493kTpeUqG9ut88Mq2f5xEchyn8+M2W4+n/qJesr6fpchXYmtv7Tfqc7tQRO
         zS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685457624; x=1688049624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1HVONGtru1vqvpdwj35njbJ3xnsiF5SXH/XspKxAtbg=;
        b=REvPbwgW1Oc8Kx1XGc7TZqBV1h4jvl7OE0D220HKSbDAearYnujGlsuDg5kZysQR3t
         DKITBjmWqtmzG2TWo/a9n4emNBXoH8wO9UZTbYU5FhK1vcijELpXN7roc9Tdf4tbnfpd
         WokG3iR3oy5pgP4tOU1QoFqZ94BQ1vlMkiR7Cj9gXvRHKqaBdhXX4BXINa7m87BF0jZA
         hDne9HsG2BTOgLTWBia+Q9JhpHVraPglv+VcMv4QeCcie/YhJWsRBLyf4cakfG1Rabat
         QUKJLl3XSwwu1KFiIjsqgQIiuQCqiF/osxN0nhDnn/NwBWnkp1UiVPJSeWjpmCNV99Wk
         FMgA==
X-Gm-Message-State: AC+VfDy8Q9diP4jQfASw6TPfu/cQlpV+TLXAOCUq7N6Bz3neld+IohEp
        GBQaDV77jd8njbIjl6jluxarhYjDGy6J1+i5LQ0G+Rtf5RI=
X-Google-Smtp-Source: ACHHUZ6MaLMf6pv8NDIqccGUAHJSY+NbmyhyMtDCDskXV7kiWQZ7e7M553OQKfSBWSHc6ESBpV2gSfwJ1rLyfFAvlTg=
X-Received: by 2002:a17:907:72d6:b0:96f:45cd:6c21 with SMTP id
 du22-20020a17090772d600b0096f45cd6c21mr2838871ejc.30.1685457624017; Tue, 30
 May 2023 07:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <f395a434756b7f35336b541cdbdb61ef5b6fe0b1.camel@hadess.net>
 <20230530141628.21290-1-stuart.a.hayhurst@gmail.com> <8d3ba2cf2bf09af9e15a1453212d68bfd41f9399.camel@hadess.net>
In-Reply-To: <8d3ba2cf2bf09af9e15a1453212d68bfd41f9399.camel@hadess.net>
From:   Stuart <stuart.a.hayhurst@gmail.com>
Date:   Tue, 30 May 2023 15:40:13 +0100
Message-ID: <CALTg27kYqXXWZr2vsUg5ofgTH5XVdKMOat3MAG3Dn+eRYJ5+Cg@mail.gmail.com>
Subject: Re: [PATCH 1/1] HID: logitech-hidpp: Add USB and Bluetooth IDs for
 the Logitech G915 TKL Keyboard
To:     Bastien Nocera <hadess@hadess.net>
Cc:     jikos@kernel.org, =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, didn't realise it needed a v2, sorry.

Thanks,
Stuart

On Tue, May 30, 2023 at 3:33=E2=80=AFPM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> On Tue, 2023-05-30 at 15:16 +0100, Stuart Hayhurst wrote:
> > Adds the USB and Bluetooth IDs for the Logitech G915 TKL keyboard,
> > for device detection
> > For this device, this provides battery reporting on top of hid-
> > generic
> >
> > Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
>
> You can add my:
>
> Reviewed-by: Bastien Nocera <hadess@hadess.net>
>
> to the v2 patch that you should send, otherwise the tree maintainers
> will get confused.
>
> Cheers
>
> > ---
> >  drivers/hid/hid-logitech-hidpp.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-
> > logitech-hidpp.c
> > index b2cd7527de19..28761272afe5 100644
> > --- a/drivers/hid/hid-logitech-hidpp.c
> > +++ b/drivers/hid/hid-logitech-hidpp.c
> > @@ -4403,6 +4403,8 @@ static const struct hid_device_id
> > hidpp_devices[] =3D {
> >           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC086) },
> >         { /* Logitech G903 Hero Gaming Mouse over USB */
> >           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC091) },
> > +       { /* Logitech G915 TKL Keyboard over USB */
> > +         HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC343) },
> >         { /* Logitech G920 Wheel over USB */
> >           HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> > USB_DEVICE_ID_LOGITECH_G920_WHEEL),
> >                 .driver_data =3D HIDPP_QUIRK_CLASS_G920 |
> > HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
> > @@ -4418,6 +4420,8 @@ static const struct hid_device_id
> > hidpp_devices[] =3D {
> >         { /* MX5500 keyboard over Bluetooth */
> >           HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb30b),
> >           .driver_data =3D HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS },
> > +       { /* Logitech G915 TKL keyboard over Bluetooth */
> > +         HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb35f) },
> >         { /* M-RCQ142 V470 Cordless Laser Mouse over Bluetooth */
> >           HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb008) },
> >         { /* MX Master mouse over Bluetooth */
>
