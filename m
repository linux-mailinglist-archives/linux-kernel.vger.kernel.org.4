Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9446DC439
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 10:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjDJIT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 04:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjDJITz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 04:19:55 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3BA2105;
        Mon, 10 Apr 2023 01:19:54 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e2so3772395wrc.10;
        Mon, 10 Apr 2023 01:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681114793;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=byTwI4OqmTEe5I8sJVHbwYg2j3SFXMpSEW7IJRnCz9U=;
        b=eaHh02fyIIw3zrfFXKxRGiQKduM0qyRkZDCslQF1vIhbDJOgy7Y02hlgGYw3wPvVHl
         HPciC1YouYyWhSn6mKEZ0cqZqRy7XgTj7qmLtZAHjkLbSr2puMcF0LW79AJkcmsiu+MP
         VYsmIvBZTV+fDyqHOQzq7p8QkR1o9FfI+F0rQ7+QijgPRNH4jVpNgqlKDg8gwv+u76y5
         /+mGhquErLl+rRq8OxBSV1xihQ0FQH5iMB/x9u729EoXY893HIzkFxumCghA1rL3WdOT
         btQMUwrWHqS2VJt3F3HA4nV93hPII95IyFX0AQBZubgz6viss15GzLiNkJIwjXv4iOcJ
         FiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681114793;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=byTwI4OqmTEe5I8sJVHbwYg2j3SFXMpSEW7IJRnCz9U=;
        b=pzVwXOa4t4tc+h+5R09jXosV859kR8zYYzW0Mx6GqZtER7Sx1U7YTTzq5p1b7CgQjR
         KbWlaOWJ1PsD0XP8v22dNByrc+qlTiwkbhQ586WXRRtCU1tGd9uXfL+weM7S6jLA2X25
         WHlfRbT9CCL44fyrtC0obyg/FFtQyfUSHbtN63zGRGYNGTvIYb9mrqptC39Pu7L4CDIH
         gK66g4PuqxMHg+UbCgomHZfAEI6BfTbC6G9r9bLGnvs6GEaUXFXaj+Bb9hLjFcXFuOmi
         +cGDGmgmxFpMX/kquz5LffCDeB8pGviVDQLIpFC6m3Mo0mvqegsGsWZ5y7HUsCm3x+F0
         np6g==
X-Gm-Message-State: AAQBX9fQvJXOsixOUHQBmLBqT0KZNBFcPPn/gCNbNyldJmg6N/iuuRSd
        jr4GO6Jq0LBMdKN/OA7v5+QY4mFlBDgmh735b5A=
X-Google-Smtp-Source: AKy350aSUqytqn4pNHEcICog2NjhpBMZ1fu4WtbEp8H4HOS6gsvm3mHJin9YxjnxPC+xOwjNMZj37VcaZDq/K6YPwqU=
X-Received: by 2002:a5d:6a4d:0:b0:2ca:4533:5d6a with SMTP id
 t13-20020a5d6a4d000000b002ca45335d6amr1626338wrw.7.1681114792855; Mon, 10 Apr
 2023 01:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230328150335.90238-1-Naresh.Solanki@9elements.com>
 <20230328150335.90238-2-Naresh.Solanki@9elements.com> <c88d3cdd-fb2f-c3ac-a9e8-e49f8e98b811@gmail.com>
 <17934bff-f728-d57a-c3c8-956634bd48c8@roeck-us.net> <3be67394-6082-1aeb-8a8d-90149217bdc7@gmail.com>
 <aea044ab-3a83-2369-aff7-5ef153618619@roeck-us.net> <0672fe4d-7293-4374-9186-29b008e5f8a2@sirena.org.uk>
 <CANhJrGO3X7pSsMBg6Gtf-q3=_JiCX4Qs=pGudL=etooM2F676g@mail.gmail.com> <d6a3ca82-7245-45e1-b8ff-a9970671b04f@sirena.org.uk>
In-Reply-To: <d6a3ca82-7245-45e1-b8ff-a9970671b04f@sirena.org.uk>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Date:   Mon, 10 Apr 2023 11:19:41 +0300
Message-ID: <CANhJrGMkwi1TVW_wGw=Boj1vRO_wGrd9=atOxKfbbdM4cwPGsw@mail.gmail.com>
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

to 6. huhtik. 2023 klo 16.43 Mark Brown (broonie@kernel.org) kirjoitti:
>
> On Thu, Apr 06, 2023 at 11:00:02AM +0300, Matti Vaittinen wrote:
> > ke 5. huhtik. 2023 klo 18.19 Mark Brown (broonie@kernel.org) kirjoitti:
> > > On Wed, Apr 05, 2023 at 07:18:32AM -0700, Guenter Roeck wrote:

> > > It can also try to avoid
> > > interacting with hardware if that might not work.
>
> > It'd be great to have documentation / specification for sending and/or
> > handling the regulator events. I don't think we currently have such.
> > As far as I understand, the notifications can be picked up by all
> > consumers of a regulator. I am a bit worried about:
> > a) Situations where notification handlers 'collide' by doing 'actions'
> > which are unexpected by other handlers
>
> I'm not sure what you're expecting there?  A device working with itself
> shouldn't disrupt any other users.

I have no concrete idea, just a vague uneasy feeling knowing that
devices tend to interact with each other. I guess it is more about the
amount of uncertainty caused by my lack of knowledge regarding what
could be done by these handlers. So, as I already said - if no one
else is bothered by this then I definitely don't want to block the
series. Still, if the error handling should be kept internal to PMBus
- then we should probably either say that consumer drivers must not
(forcibly) turn off the supply when receiving these notifications - or
not send these notifications from PMBus and allow PMBus to decide
error handling internally. (Again, I don't know if any in-tree
consumer drivers do turn off the supply regulator in error handlers -
but I don't think it is actually forbidden). Or am I just making  a
problem that does not exist?

> > b) Situations where different notification senders send similar
> > severity-level notifications for faults expecting different types of
> > handling.
>
> Like I say I'm not sure how much practical difference it makes to think
> too hard about differentiating the errors.

I would do at least two classes.

1) critical class - it is Ok for the consumer to forcibly shut down
the regulator, or maybe the whole system.
2) warning class - it is not Ok to forcibly shut down the regulator.

OTOH, after writing this down - if this was the division, then it
could be clearer to implement the shutdown at critical errors in the
regulator driver (or core) and just send a specific notification to
consumers telling this was done.

> > Or, is it so that no "generic handling" of these errors is to be
> > expected? Eg, consumers who implement any handling must always be
> > targeted to a very specific system? My thinking has been that the
> > device sending the notification knows the severity of the problem and
> > - for example the REGULATOR_EVENT_REGULATION_OUT is only sent with
> > such severe problems that consumers can try disabling the regulator,
> > whereas the _WARN level notifications may not warrant such action. But
> > again, I don't think we have a specification for this - so this is
> > just my thinking - which may be off.
>
> Do we actually have practical examples of systems sending warnings that
> aren't followed in very short order by more severe errors, notified or
> otherwise?

No. I don't. I will send one more question about the real-world use of
BD9576 'warning' level IRQs - but I am highly sceptical I will receive
any real information.

Thanks for the education and time Mark & Guenter. It's a bit hard for
me to let go of the thought that we would benefit from the handling of
different severity level errors - but maybe this was just my illusion
after all.

Yours,
    -- Matti

-- 

Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

Discuss - Estimate - Plan - Report and finally accomplish this:
void do_work(int time) __attribute__ ((const));
