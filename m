Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AA469F5E9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 14:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjBVNu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 08:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjBVNu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 08:50:57 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC60311C1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 05:50:53 -0800 (PST)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CA5A33F4A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 13:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1677073851;
        bh=aBBPjXj3R0x04LVSzwbtWQea8aW4cQ9Kc9kRT/YpHbg=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Xodyl9Xa6IaogPmJZmUsXkFlewRMUeMUknorwqIoHTef4j3zilySPOOyRBSn//Ozn
         WH6ltcID0K6Ah3bRAoXf8YJ4H03Bft92anjXCLVdcTC9nB0i89NhqOKNDwQPNevyFn
         dBZoyiBaQawC4XklYe6NY629Nmd67GyvNsBo6CweqVt4BqIzKVU2LGA22tOC52j2cW
         lHisTAl0GMm9ejJs6BhEfql2x98SZ3+M093PRbM1kShG/ITVBH1bnSAsuAk6ttBdBX
         hBkWxWdiD2rjlEKW37rLzxyLR1IKcjRXKlKY4CTgpowsXa1SE9f3H2GmAxiaSUB6u6
         EPSD5JMMYtjaw==
Received: by mail-pj1-f69.google.com with SMTP id b23-20020a17090a8c9700b002371fc964f7so2339250pjo.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 05:50:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aBBPjXj3R0x04LVSzwbtWQea8aW4cQ9Kc9kRT/YpHbg=;
        b=sJ2pwcrNOHs5RQNLMoVx7Ei9HtFy4/bD5QpNG+5c7kXSt6y24qLZFFUS9ISAWQ2WH2
         xs5JjloEUD08lW6aw5MdbDhPlEsBsm4Klm00Xvr3d7jdHOk5al5kjwpx+230FW3xFmrp
         c1BmtyA3qEGLgBIB0hF0kSX77/zpzkBZzNz7Ti0ey+bd6P5g9+7OJzymwvZmVoSn/YaV
         nJ8fRkzWFyODMufGucCCnbO7K8TJdjR2FZpfVzt1LoSgInyfF5OqSWND8lOB24gru8LM
         9PKqGJMXVJ5GhZ6UsJF90DT8cFfZKZD9TSbQT4vtczZqGbL6o+r3MvdUqEfYpZ2ZgUG2
         laNg==
X-Gm-Message-State: AO0yUKUsGF6VRU8bteQ6WhTh2nN8AbdQ/ALYEZqoUd36GMZ2hwMAH+XF
        a/UjF61yqSsMAzWwfEilYoRWo4TpRqBxHlVypXRRsxqfvbh6rHZAjuKJZeQmOKXQqlrr/1+Orvc
        pxIyBC2A7ua5HkHwZO9xwcbIkL9X01BV1eKBe6o+xveis0gZF8mp5N8cwiA==
X-Received: by 2002:a17:90b:1f87:b0:237:1892:2548 with SMTP id so7-20020a17090b1f8700b0023718922548mr1340181pjb.44.1677073850285;
        Wed, 22 Feb 2023 05:50:50 -0800 (PST)
X-Google-Smtp-Source: AK7set+B3zDTZXstNxu3HjOIuVf5wfZ2H1F5t4UojQulon3L5InNWzIq/OjXiv/nRJvgbKp4tQAVRF4MEodaV/05Pds=
X-Received: by 2002:a17:90b:1f87:b0:237:1892:2548 with SMTP id
 so7-20020a17090b1f8700b0023718922548mr1340174pjb.44.1677073849964; Wed, 22
 Feb 2023 05:50:49 -0800 (PST)
MIME-Version: 1.0
References: <20230208072141.1103738-1-kai.heng.feng@canonical.com> <7685a109-99fd-8b41-6911-5eba8924c0d6@redhat.com>
In-Reply-To: <7685a109-99fd-8b41-6911-5eba8924c0d6@redhat.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 22 Feb 2023 21:50:38 +0800
Message-ID: <CAAd53p5w0mszO9NWmc6M3Ff_GSV8-D6RA375mNcDC_85zqaUuw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: light: cm32181: Unregister second I2C client if present
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     ktsai@capellamicro.com, jic23@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Mon, Feb 13, 2023 at 7:17 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> Thank you for working on this, some remarks inline.
>
> On 2/8/23 08:21, Kai-Heng Feng wrote:
> > If a second client that talks to the actual I2C address was created in
> > probe(), there should be a corresponding cleanup in remove() to avoid
> > leakage.
> >
> > So if the "client" is not the same one used by I2C core, unregister it
> > accordingly.
> >
> > Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2152281
> > Fixes: c1e62062ff54 ("iio: light: cm32181: Handle CM3218 ACPI devices with 2 I2C resources")
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v2:
> >  - Use devm_add_action_or_reset() instead of remove() callback to avoid
> >    race.
> >
> >  drivers/iio/light/cm32181.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> > index b1674a5bfa368..a3e5f56101c9f 100644
> > --- a/drivers/iio/light/cm32181.c
> > +++ b/drivers/iio/light/cm32181.c
> > @@ -429,6 +429,16 @@ static const struct iio_info cm32181_info = {
> >       .attrs                  = &cm32181_attribute_group,
> >  };
> >
> > +static void cm32181_disable(void *data)
> > +{
> > +     struct i2c_client *client = data;
> > +     struct cm32181_chip *cm32181 = iio_priv(i2c_get_clientdata(client));
> > +
> > +     /* Unregister the dummy client */
> > +     if (cm32181->client != client)
> > +             i2c_unregister_device(cm32181->client);
> > +}
> > +
> >  static int cm32181_probe(struct i2c_client *client)
> >  {
> >       struct device *dev = &client->dev;
> > @@ -479,6 +489,12 @@ static int cm32181_probe(struct i2c_client *client)
> >               return ret;
> >       }
> >
> > +     ret = devm_add_action_or_reset(dev, cm32181_disable, client);
> > +     if (ret) {
> > +             dev_err(dev, "%s: add devres action failed\n", __func__);
> > +             return ret;
> > +     }
> > +
>
> This is too late, we will still exit without unregistering the client if
> the cm32181_reg_init() call fails.
>
> It would be best to do this directly after the i2c_acpi_new_device()
> call, so inside the "if (ACPI_HANDLE(dev) && client->addr == SMBUS_ALERT_RESPONSE_ADDRESS) {"
> block.

You are right, not sure what I was thinking but this is much better.

>
> This way you can also remove the "if (cm32181->client != client)"
> check from cm32181_disable() since it now only runs when the client
> was registered in the first place.
>
> Also please rename cm32181_disable() to cm32181_unregister_dummy_client()
> so that the name actually matches what it does.

Sure, will change that in next version.

>
> Regards,
>
> Hans
>
>
>
>
>
> >       ret = devm_iio_device_register(dev, indio_dev);
> >       if (ret) {
> >               dev_err(dev, "%s: regist device failed\n", __func__);
>
