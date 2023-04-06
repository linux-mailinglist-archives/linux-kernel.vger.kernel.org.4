Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2F46D90F2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 10:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbjDFIAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 04:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbjDFIAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:00:17 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210CD93;
        Thu,  6 Apr 2023 01:00:16 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso25065375wms.1;
        Thu, 06 Apr 2023 01:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680768014;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OB0Z9ftfjGj3fDiQkJtgA8r7X/5pTTPmtfxBUbgHqTE=;
        b=Hnd+H3qZmFgzuViNGsgJH6fZJb+ftNXrR74ZYfuGE/GkslNjLXEUTOgtWkrrCcWrt4
         dg49PIKJdvm8uPqrJ8nkrAf4WjW7XIewhKP6a3zZCfd0VzS6p1CTr1uRQkHXJao0JyUO
         wqMyy+QrlKk9Yyvhr7K7NJ4exAEZy1Fv3+Q9Lodz3R4s891ln6bqIfOKGJqSTqlohU+3
         0KSazpD10mPjVFgI4yap++M9LTsclQlQz1cDbBfbc13zA8lNlDQXUpqMmJrRPq2UKkVr
         QP7lGhjI2oARp4uSItrYnFoHY08WrwWuqoxAxt1CJBrnhcuhj0AnL08r6LCpw79a58Sc
         eR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680768014;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OB0Z9ftfjGj3fDiQkJtgA8r7X/5pTTPmtfxBUbgHqTE=;
        b=sn+p1mooL1+vO+uWYDkcfHB0zh+LXErrRJhdYt6sCg/jobeyyANF8haZVdOCZC1SlQ
         yec4L/FlR7kc5nx1s/9mqeKEzSA7uXGK0rpcxnEzxi1oUhZEY+dN0cgFSPO1j/jhvNjr
         QrjNrNmwBLxIO4ZUrJJ4HUrDkaA+UhQrBOdRqDP1GRi0LKxXkzZWGYJU0Ej2dId8vZ7P
         xE2JArVXoVzslT5z8v43EzEsc4uHIp6Pyc2Ka1xbrxAWdpknMGacNsG1+Hw0gicJlXVK
         CF2W802vu4tm6UHD+X+W7hWpXkD1FV3pNbFK+ZfWje5mUKYUvQGXGCeBmPZ+NEM+EX4m
         5frA==
X-Gm-Message-State: AAQBX9c1f3sWHbA8tgJgq5bMY7Jv21wf0PBgtf4WmcDwqLBTCCj2sGD7
        qn5PFRrk+Op7SK58MlQWP0j0XGVLdhLzPgVmz2E=
X-Google-Smtp-Source: AKy350bjmVe90c2xoke5HECjQfjReFMAgZ1UIzSTbeid+wldhjePYTV7JmeMTY+vLdMHIgBFJV8hruS75qIVUS76Llo=
X-Received: by 2002:a05:600c:378a:b0:3ee:143f:786d with SMTP id
 o10-20020a05600c378a00b003ee143f786dmr2210789wmr.4.1680768013687; Thu, 06 Apr
 2023 01:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230328150335.90238-1-Naresh.Solanki@9elements.com>
 <20230328150335.90238-2-Naresh.Solanki@9elements.com> <c88d3cdd-fb2f-c3ac-a9e8-e49f8e98b811@gmail.com>
 <17934bff-f728-d57a-c3c8-956634bd48c8@roeck-us.net> <3be67394-6082-1aeb-8a8d-90149217bdc7@gmail.com>
 <aea044ab-3a83-2369-aff7-5ef153618619@roeck-us.net> <0672fe4d-7293-4374-9186-29b008e5f8a2@sirena.org.uk>
In-Reply-To: <0672fe4d-7293-4374-9186-29b008e5f8a2@sirena.org.uk>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Date:   Thu, 6 Apr 2023 11:00:02 +0300
Message-ID: <CANhJrGO3X7pSsMBg6Gtf-q3=_JiCX4Qs=pGudL=etooM2F676g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] hwmon: (pmbus/core): Add regulator event support
To:     Mark Brown <broonie@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, Sascha Hauer <sha@pengutronix.de>,
        jerome Neanne <jneanne@baylibre.com>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ke 5. huhtik. 2023 klo 18.19 Mark Brown (broonie@kernel.org) kirjoitti:
>
> On Wed, Apr 05, 2023 at 07:18:32AM -0700, Guenter Roeck wrote:

> > Same situation. I though a regulator driver would notify the regulator subsystem

I think this notification is not processed by the regulator subsystem.
It is just delivered to the consumer driver(s) who have subscribed the
notifications.

> > if it observes a problem with the supplies it regulates, but based on your feedback
> > I am not sure anymore what those notifications are supposed to be used for,
> > and if such notifications are appropriate. That means I'll have to read up on all
> > this, and I don't have the time to do that in the near future given that I am buried
> > in pending reviews and the work I am actually getting paid for.
>
> The theory is that if a consumer detects that the device it's
> controlling has bad power then it can take corrective action if there's
> some specification mandated error handling (for something like a
> standard bus) or risk of hardware damage.

The problem I see here is that, if the error information itself
(severity + notification type) does not 'classify' the error handling
- then I don't see how any consumers can do handling unless they are
targeted to one specific system only. My original thinking has been
that ERROR level notifications are sent only when HW is no longer
operable - and consumers are expected to do what-ever protective
actions they can, including turning off the faulty regulator. That is
why I originally asked about handling the PMBUS errors.

As I said, this is my understanding only - I am not in a position
where I can tell people how to use these notifications. Still,
assuming PMBUS has its own handling for these errors (separately from
the regulator events), and assuming PMBUS does not want regulator
consumers to interfere with this handling - then I might avoid at
least sending the ERROR level notifications to regulator consumers.

> It can also try to avoid
> interacting with hardware if that might not work.

It'd be great to have documentation / specification for sending and/or
handling the regulator events. I don't think we currently have such.
As far as I understand, the notifications can be picked up by all
consumers of a regulator. I am a bit worried about:
a) Situations where notification handlers 'collide' by doing 'actions'
which are unexpected by other handlers
b) Situations where different notification senders send similar
severity-level notifications for faults expecting different types of
handling.

Or, is it so that no "generic handling" of these errors is to be
expected? Eg, consumers who implement any handling must always be
targeted to a very specific system? My thinking has been that the
device sending the notification knows the severity of the problem and
- for example the REGULATOR_EVENT_REGULATION_OUT is only sent with
such severe problems that consumers can try disabling the regulator,
whereas the _WARN level notifications may not warrant such action. But
again, I don't think we have a specification for this - so this is
just my thinking - which may be off.

Yours,
    -- Matti

-- 

Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

Discuss - Estimate - Plan - Report and finally accomplish this:
void do_work(int time) __attribute__ ((const));
