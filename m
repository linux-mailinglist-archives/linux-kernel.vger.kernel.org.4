Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD45671309
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 06:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjARFP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 00:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjARFPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 00:15:23 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB404FCC4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 21:15:20 -0800 (PST)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1725C41916
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1674018919;
        bh=8MfSKhncIOn0mec0lQ/lo6LWytB4g/GdplyejQ8Y7SI=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=GFixvmYtFKjs+fJfn/smDa8/QBLAFzSA88qgjfwqiRnmpNY1saYi138+Kfp5ZgAt/
         oMx+Qdfkmwq7bW5l0W6GDNYraDzWbGxGxxp+6xk5HnEeb7k9BtifM7mgivCxfjxDEF
         NiLRfV0P/Zm1iOFcAkc1FbwbEXEXzuTPcPSYL4ZM0vO8L0L3QVGINI7Dk6F4zRIeuO
         4TQYjMRM7OlE3hn1l8js6HGgDBJEW2TdycSy/GRonEaaP+eIwbZl3pFOAqj1o9zblW
         7CylN4iaclVzRE8+2vw3SBDJ2M//Infm4zC7NBv/Blc9WM7UaTbhNrwkQ68OuHOgpQ
         8i+/c8I1vTSrA==
Received: by mail-pl1-f198.google.com with SMTP id k5-20020a170902c40500b001947b539123so7724021plk.19
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 21:15:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8MfSKhncIOn0mec0lQ/lo6LWytB4g/GdplyejQ8Y7SI=;
        b=hb8ftyydR51pEOSBx3UqFxmdnNE5b3XaJo9iCUMfM2g93j4P2jJKlJJf7fWp23yPlw
         3QdxdrYOuaI6e35z8ovj+rFLT7QDjclydvlWXJ7tTD4nLoJX/X9O169MtW13dr8zQgbY
         Pe2M11wbRx9DH0sCV14zKmv/OSzfCJQPK0BTOg1UE8Gg93h7TdpkKGAfBEbJsRSMt98s
         WdXB0KONeVhOFen/1/X1sejRfWL7BrLbc8SmpXCKnwlI4IoIW9ZM219t+SN+gJhu3teh
         WF9icih9vtEB13DGiyTFaJanAtqiqrM26H8luURGU6kPqXxpuJ6GLMQBhZq77oV/0xg0
         t18g==
X-Gm-Message-State: AFqh2kqQZwcRi0gsHWEUvvRHRC24HDXMIt3sNmaPzD0HvxyNlHwGOWbr
        Eno7WYDp8I9lhUikZ3ej/cSrrKDIGdEDtHPGLPpzP7qV6YbWHgnkdX+kB9yc3uT8wpxRcagcYol
        wnVC96NxVDf93V/M7AaBNcKNeSsW1/wZBYKvNNAYMukmXOy4BqpzrZFXyQg==
X-Received: by 2002:a17:90a:4a03:b0:225:f003:cd15 with SMTP id e3-20020a17090a4a0300b00225f003cd15mr608526pjh.34.1674018917181;
        Tue, 17 Jan 2023 21:15:17 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt8eCWsEpyACulC9/5YXCaOg83dDn6UKGheWH7d5sMUjmWbebd0C77CvE81KvufHYMVilND247s7krQbJeT1sg=
X-Received: by 2002:a17:90a:4a03:b0:225:f003:cd15 with SMTP id
 e3-20020a17090a4a0300b00225f003cd15mr608519pjh.34.1674018916854; Tue, 17 Jan
 2023 21:15:16 -0800 (PST)
MIME-Version: 1.0
References: <20230117160951.282581-1-kai.heng.feng@canonical.com>
 <5c95d25b-ff26-053b-efc8-5f6fd979c7e2@redhat.com> <CAAd53p5DFUMjMNAyp6YVONwCpGs8rRVORj0=OSgj+Z0f3QpeCg@mail.gmail.com>
In-Reply-To: <CAAd53p5DFUMjMNAyp6YVONwCpGs8rRVORj0=OSgj+Z0f3QpeCg@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 18 Jan 2023 13:15:05 +0800
Message-ID: <CAAd53p5XXCniBN7x4uhp4XW=qr2U72_UntgAR0BV2viRtd+8EA@mail.gmail.com>
Subject: Re: [PATCH] iio: light: cm32181: Fix PM support on system with 2 I2C resources
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     ktsai@capellamicro.com, jic23@kernel.org, lars@metafoo.de,
        Wahaj <wahajaved@protonmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 11:29 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Hi Hans,
>
> On Wed, Jan 18, 2023 at 1:21 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > Hi,
> >
> > On 1/17/23 17:09, Kai-Heng Feng wrote:
> > > Commit c1e62062ff54 ("iio: light: cm32181: Handle CM3218 ACPI devices
> > > with 2 I2C resources") creates a second client for the actual I2C
> > > address, but the "struct device" passed to PM ops is the first client
> > > that can't talk to the sensor.
> > >
> > > That means the I2C transfers in both suspend and resume routines can
> > > fail and blocking the whole suspend process.
> > >
> > > Instead of using the first client for I2C transfer, store the cm32181
> > > private struct on both cases so the PM ops can get the correct I2C
> > > client to perfrom suspend and resume.
> > >
> > > Fixes: 68c1b3dd5c48 ("iio: light: cm32181: Add PM support")
> > > Tested-by: Wahaj <wahajaved@protonmail.com>
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >
> > Thank you for this fix. I had looking into this on my todo list,
> > since I have been seeing some bug reports about this too.
> >
> > One remark inline:
> >
> > > ---
> > >  drivers/iio/light/cm32181.c | 11 +++++++----
> > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> > > index 001055d097509..0f319c891353c 100644
> > > --- a/drivers/iio/light/cm32181.c
> > > +++ b/drivers/iio/light/cm32181.c
> > > @@ -440,6 +440,8 @@ static int cm32181_probe(struct i2c_client *client)
> > >       if (!indio_dev)
> > >               return -ENOMEM;
> > >
> > > +     i2c_set_clientdata(client, indio_dev);
> > > +
> >
> > Why move this up, the suspend/resume callbacks cannot run until
> > probe() completes, so no need for this change.
>
> The intention is to save indio_dev as drvdata in the first (i.e.
> original) i2c_client's dev.
>
> >
> > >       /*
> > >        * Some ACPI systems list 2 I2C resources for the CM3218 sensor, the
> > >        * SMBus Alert Response Address (ARA, 0x0c) and the actual I2C address.
> > > @@ -458,9 +460,9 @@ static int cm32181_probe(struct i2c_client *client)
> > >               client = i2c_acpi_new_device(dev, 1, &board_info);
> > >               if (IS_ERR(client))
> > >                       return PTR_ERR(client);
> > > -     }
> > >
> > > -     i2c_set_clientdata(client, indio_dev);
> > > +             i2c_set_clientdata(client, indio_dev);
> > > +     }
> >
> > And moving it inside the if block here (instead of just dropping it)
> > is also weird. I guess you meant to just delete it since you moved it up.
>
> Doesn't i2c_acpi_new_device() creates a new i2c_client (and its dev embedded)?
>
> So the intention is to save indio_dev for the second (ARA case) i2c_client too.
>
> >
> > >
> > >       cm32181 = iio_priv(indio_dev);
> > >       cm32181->client = client;
> >
> > Also note that the ->client used in suspend/resume now is not set until
> > here, so moving the i2c_set_clientdata() up really does not do anything.
> >
> > I beleive it would be best to just these 2 hunks from the patch and
> > only keep the changes to the suspend/resume callbacks.
>
> Yes, it seems like those 2 hunks are not necessary. Let me send a new patch.

        if (ACPI_HANDLE(dev) && client->addr == SMBUS_ALERT_RESPONSE_ADDRESS) {
                ...
                client = i2c_acpi_new_device(dev, 1, &board_info);
                ...
        }
        i2c_set_clientdata(client, indio_dev);

It means the indio_dev is only assigned to the new i2c_client->dev's
drvdata, the original dev's drvdata remains NULL.
So we need to assign it before the original client gets replaced by
the new one, otherwise we can't get cm32181 in PM ops.

Kai-Heng

>
> But I do wonder what happens for the removing case? Will the second
> i2c_client leak?
>
> Kai-Heng
>
> >
> > Regards,
> >
> > Hans
> >
> >
> > > @@ -490,7 +492,8 @@ static int cm32181_probe(struct i2c_client *client)
> > >
> > >  static int cm32181_suspend(struct device *dev)
> > >  {
> > > -     struct i2c_client *client = to_i2c_client(dev);
> > > +     struct cm32181_chip *cm32181 = iio_priv(dev_get_drvdata(dev));
> > > +     struct i2c_client *client = cm32181->client;
> > >
> > >       return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
> > >                                        CM32181_CMD_ALS_DISABLE);
> > > @@ -498,8 +501,8 @@ static int cm32181_suspend(struct device *dev)
> > >
> > >  static int cm32181_resume(struct device *dev)
> > >  {
> > > -     struct i2c_client *client = to_i2c_client(dev);
> > >       struct cm32181_chip *cm32181 = iio_priv(dev_get_drvdata(dev));
> > > +     struct i2c_client *client = cm32181->client;
> > >
> > >       return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
> > >                                        cm32181->conf_regs[CM32181_REG_ADDR_CMD]);
> >
