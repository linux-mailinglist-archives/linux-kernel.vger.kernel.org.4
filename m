Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491426CBCEA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjC1Kzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjC1Kzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:55:42 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C276594
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:55:40 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id x37so6933381pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mechatrax-com.20210112.gappssmtp.com; s=20210112; t=1680000940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+41omAo7mrv9HdvTIOTewb/FQOWfrqtOekDOFTV4tcM=;
        b=4u4GAkpbFOZ/YLXAUn9dolc+H7EAPN4kk66wgfpL6RUlLUySVHlYVXxDwzhIsRzpLR
         sQ4HptGSBB1HSKCejxXifULA2LGv4JQC0Dz9K9Ea7mEzXDAmWWy7fpg/VzVe/l/oeL7f
         muW/yio/ifJxEq34YtLqiSFv24yJmuvp1axJm7QF3lx7/NyL5QAayiHosCdiZoMOg2tS
         vPZxMTSXvzV16TX5MMfpTzsd7lMuwrye8NtmMtU9ReHgzPGDe4S+rY7UKkAfmQsEi8UC
         phy6uko/Z4Z/QRTFCSV48Kh+/pJCrjDVnFYDidFEk6pdrNZ1P/exCVGuY6fQjvwzqwpj
         6SxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680000940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+41omAo7mrv9HdvTIOTewb/FQOWfrqtOekDOFTV4tcM=;
        b=YD4U5fDPYQSsBRbbGT3En4i3yQzs1laKZFnOuGSGkzeUxfQfVZbT2/wrNM0MQ5fuXW
         8IL1DYtiMATw5hkMGydMkXi0Xl96ms40EYnrtfXnWH65/vX9OuKUgYR65EzLh6LQ4/Ar
         jhdodLj+Nb+KPvogJm+owKf/sjzTV2R2auS8qtFq0AZmnDnH7UVE6agNcmE8XM1Gub+5
         NBwomlkSooyfiGf3iQklFRtjv9JU5UhyEw4MLqz5JKwLjpsS8hL6l04i8Td3SqL+SZIp
         hUHgl0382xyv6N614eihED3Yilz2INOiqhCdxkbos69tKheSc8N6yxKR+AcWgEbVCHJJ
         HuEw==
X-Gm-Message-State: AAQBX9cyoG8W5UN3sJlZwtdJ+jPvNq/1dO0E951Ji2Jax3bVjnMIiVDk
        EGTm/uLph2jpicsD1sl3/9fr4E/FOs4+l+ijcYJIdFPvQBY4OFmhoi4=
X-Google-Smtp-Source: AKy350Y88U0UftP1ihbjyf3FFPjYFJgxLmhbJQr7qam1nnAx3JGqLJNrZXB2Swa1MiBY3EePSSH510UO2qcbHbTiGd0=
X-Received: by 2002:a63:5f12:0:b0:503:3747:cea3 with SMTP id
 t18-20020a635f12000000b005033747cea3mr4198382pgb.10.1680000940006; Tue, 28
 Mar 2023 03:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230306044737.862-1-honda@mechatrax.com> <6e1fe1015235ae7d7eb9ef2526fd64b6d6d628d7.camel@gmail.com>
 <CA+Tz-SHQxNzx=eS8ex=3Hps0th5bTY+K1qSWrZqWC8ryv+d0RA@mail.gmail.com>
 <CA+Tz-SFbt2RAz3POMRoTHqz+tNyQOn3UsssZV9EvHUhhR+XJbQ@mail.gmail.com> <2a108acdd79682f47e3ac923fe005b943a4a00c0.camel@gmail.com>
In-Reply-To: <2a108acdd79682f47e3ac923fe005b943a4a00c0.camel@gmail.com>
From:   Masahiro Honda <honda@mechatrax.com>
Date:   Tue, 28 Mar 2023 19:55:02 +0900
Message-ID: <CA+Tz-SHL1ybx37vM_uon+XxYC4FXD_Ci1HTcZyb+5e0iD6t=uA@mail.gmail.com>
Subject: Re: [PATCH] Fix IRQ issue by setting IRQ_DISABLE_UNLAZY flag
To:     =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 9:26=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
>
> So, my suspicion was right... We are getting stalled data (which is
> obviously not good). AFAIU, when disabling the IRQ, we don't
> immediately mask the IRQ and we only do it in the next time an
> interrupt (sample) comes which means (I think) we'll process (right
> away) that outstanding interrupt next time we enable the IRQ.
>

Thank you. I understand.

> > > > Some research on this also seems to point that we should (need?)
> > > > call
> > > > irq_clear_status_flags(irq, IRQ_DISABLE_UNLAZY) when freeing the
> > > > IRQ.
> >
> > I have understood that I need to call irq_clear_status_flags.
> > However,
> > I cannot find a code to free the IRQ in ad_sigma_delta.c and other
> > Sigma-Delta ADC driver source files. So, I would like to implement
> > only irq_set_status_flags.
>
> Well, that's because we are using devm_request_irq() which is a device
> managed API. So, I can see two options in here...
>
> 1) You do not use devm_request_irq() and use request_irq() +
> devm_add_action_or_reset() and in your release() function you would
> call irq_clear_status_flags() + free_irq().
>
> 2) You add a devm_add_action_or_reset() after devm_request_irq() and
> your release() function would only clear the flag. But in here we would
> likely also have to be careful in the case where devm_request_irq()
> fails. So option 2) seems a bit more "ugly".
>
> I would likely go to option 1) but maybe Jonathan or others have better
> ideas.
>

Thank you very much for letting me know about the API and ideas.
I'll try to implement 1).
