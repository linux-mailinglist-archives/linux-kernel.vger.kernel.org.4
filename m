Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25BD6A46DD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjB0QTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjB0QTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:19:34 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F69EB53
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:19:32 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id r7so6824578wrz.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O3Cw24KLigNkVEaZQzic/541IpYXu4mBgTeKvIb8/Fk=;
        b=dI6Qr8/3ijsxkqQv787ZDxdNBvKqYsQFV4U6+O1BU3WqueHlXSBQl298fVQDY+4qiw
         /Rws3knrO3eUXlJtbkATsxiUqQmG4YLSES/tylGrQfB+nH7GOCaPEnXcCAK5JVmriuCi
         4ejEcOqgv7ubtoHpgaGJL+91kP1SCYkWc8lSG8et9VtFLb7AZboiyf2tKz3l2G0ld7b6
         K7AI1upJ49PAkDdiB5ISCIet6tdJNra4s12Eqs2YYb/FB7aTEQjRBdbk3HtS1YiN6v5u
         CYwke5oQq45IhpE4rCiPQo0sEJjKhOuKu337gf+FJT2jArucm1Uv/lP+gl7zees8fXkE
         431A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O3Cw24KLigNkVEaZQzic/541IpYXu4mBgTeKvIb8/Fk=;
        b=jH1vEpgQQ0TMSo/iEhFNWotYkRsWb1cPieqLTdxdVn/UtdZFI9SB75zXVtBgC3i/tY
         b/0L1p6lnatOYgt7AzGtsxj3Aqb944SCt2VTc4XQVM5aTFSCBC92RbH1z31Ipk986jbW
         wN7IV8NctSwQal7rnqIVE6udcH3gDsYmH+5jTlVO3i9TJL+pH85sixLVzNaVe2I/Hnyn
         CJ57NQLnjTNgZgy+GvBRbC2gilQRFX7L7z9YufFW3ywUs6SxhUVnqV7XmI1dAztSOEkO
         j+HpoXUIyMklwBfZPHE/nXf8/RBHzmg7DZyTDKPfg5FXYXC36oBaTjPdgaZM7RODAv8Q
         I/ug==
X-Gm-Message-State: AO0yUKUKwOyPs6WekXDLjNQcdeXwrYCuG5DH81ehESZDYPUpE4bEy+/b
        tNl6Ph2DzoJm0qBtMbyzZHRFyICMXJaczylUeBM=
X-Google-Smtp-Source: AK7set/WNcG3VcJBinnwdTQWCWbcZ6Kj2aMPrS6f74ANSPFsiIHQZNS2e1RNZDhPmjasAUMeP8MKyyiqbtGzscDSi0U=
X-Received: by 2002:a05:6000:118e:b0:2c9:8df7:b385 with SMTP id
 g14-20020a056000118e00b002c98df7b385mr1331692wrx.1.1677514770452; Mon, 27 Feb
 2023 08:19:30 -0800 (PST)
MIME-Version: 1.0
References: <20230227130542.GM32097@pengutronix.de> <Y/yt8nzVuO4sUg3v@sirena.org.uk>
In-Reply-To: <Y/yt8nzVuO4sUg3v@sirena.org.uk>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Date:   Mon, 27 Feb 2023 18:19:19 +0200
Message-ID: <CANhJrGMRoR5BfoTswmF8RtLbBd1RxQ77o_W4bNyAgEqZSzdU7A@mail.gmail.com>
Subject: Re: About regulator error events
To:     Mark Brown <broonie@kernel.org>
Cc:     Sascha Hauer <sha@pengutronix.de>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
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

ma 27. helmik. 2023 klo 15.19 Mark Brown (broonie@kernel.org) kirjoitti:
>
> On Mon, Feb 27, 2023 at 02:05:42PM +0100, Sascha Hauer wrote:
> > I have a board here which has some current limited power switches on it
> > and I wonder if I can do something reasonable with the error interrupt
> > pins these switches have.
>
> Just noticed that Matti (who's been doing a bunch of work here) wasn't
> CCed so adding him.

Thanks. I just hoped I had more to say...


> > The devices do not have a communication channel, instead they only have
> > an enable pin and an error interrupt pin. See
> > https://www.diodes.com/assets/Datasheets/AP22652_53_52A_53A.pdf for a
> > datasheet.  The devices come in two variants, one goes into current
> > limiting mode in case of overcurrent and the other variant switches off
> > until it gets re-enabled again.
> >
> > At first sight it seemed logical to me to wire up the error interrupt
> > pins to REGULATOR_EVENT_OVER_CURRENT events. That was easy to do, but
> > now the question is: What can a regulator consumer do with these events?

This is a question I have asked too.

I was asked to create a driver for a ROHM BD9576 PMIC - which has the
usual configurable over-current, over-voltage, under-voltage and
over-temperature protection limits. (Well, the temperature limit is
fixed). This means that when limits are exceeded - the PMIC shuts down
the power outputs by hardware.

What was new is that the BD9576 also had configurable warning-level
limits (stricter than the protection limits) - and when these were
exceeded only a 'warning IRQ' was issued. This setup was requested
from ROHM by a customer - and the information I received was the
customer had a use-case where they wanted to do 'mitigation actions'
before things get more severely off. Unfortunately, I never received
the information about these 'mitigation actions' when I tried to ask
what those could be. I am under impression that either out HW
colleagues did not know the customer use-case in details, or that this
information was 'top secret' (which seems to be the case pretty often
:( )

> > The strategy I had in mind was to disable the regulator, enable it again
> > to see if the errors persists and if it does, permanently disable the
> > device.  Disabling the regulator only works though when there's only one
> > consumer.

If it is obvious that disabling the regulator is required for
preventing the damage, then it might be justified to use the
regulator_force_disable()? Now, the question when this is obvious is
hard. I think it is the board designer who should be evaluating this -
and as such, I would say that the information about the severity of
error should come from hardware properties - eg. from device-tree.
Now, I am not really sure but I have a feeling that ideally the
regulator driver (provider, not the consumer) should have this
information about the severity level in device-tree and select the use
of notifier flag based on this. If an ERROR level event is emitted, it
should mean the hardware has really failed and forced disable could be
justified. If a WARNING level event is sent, then the handling should
be more graceful - probably done by some very system specific driver.

My problem here is that I don't have the visibility or understanding
regarding current use of those events. Not sure if all the hell would
break loose if the regulators are forcibly shut down. By the very
least I would expect such a consumer handling to be disabled by
default - either via configs or via some runtime enable/disable
mechanism.

 With multiple consumers only the enable count decreases, but
> > the regulator itself stays enabled. This means implementing such a
> > policy at the consumer side is not generally possible. Implementing a
> > policy in the regulator core seems awkward as well, as a good strategy
> > likely differs between different consumers.
> >
> > A first good step might be to notify the user somehow. While we can get
> > the overcurrent status of a regulator from
> > /sys/class/regulator/*/over_current there doesn't seem to be any way to
> > get a regulator event in userspace, right?  Would patches changing that
> > be welcomed?
> >
> > There doesn't seem to be much prior art for handling regulator error
> > events in the kernel. It would be great to get some input what others do
> > in this situation, or to get some ideas what they would do if they had
> > the time to do so ;)

I did submit a talk proposal about these regulator notifications to
ELCE next summer. I don't really have much to say - but I do hope that
I could gain some insight exactly to the question: "[where / how]
these notifications [are / could be] used?" With a lot of luck the
talk proposal gets accepted - and with a bit of luck people in the
audience know more than I do ;)

I think it was qcom-labibb-regulator.c which does try to disable the
failing regulators and then call BUG_ON() if even that fails. Back
when I did implement the regulator irq_helper, I did decide to try
supporting similar logic for drivers which explicitly request failures
to handle these protection IRQs to be treated as fatal errors - except
that instead of calling BUG_ON() (which to my understanding does not
necessarily lead to reset on all configs) - I try to run the poweroff.
This, however, is probably not a good generic solution.

I am all for adding notification sending to user-space. Still, I am
not against a kernel-level protection either - that can be used in
cases where user-space or user-space handling is not available / to be
trusted for a reason or other. What should be known then in-kernel is
whether the handling should be left to user-space (or other consumers)
- or if the kernel driver should take some protective action(s).

Yep, I know this was not much - sorry :( As I said, I do lack the
insight to real-world use cases...

Yours,
    -- Matti

--

Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

Discuss - Estimate - Plan - Report and finally accomplish this:
void do_work(int time) __attribute__ ((const));
