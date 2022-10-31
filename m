Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3C161390E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiJaOez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiJaOew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:34:52 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12281C7;
        Mon, 31 Oct 2022 07:34:51 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id i12so8460748qvs.2;
        Mon, 31 Oct 2022 07:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kKV7aE0TxR3j7oQ5UpL5QeWqb8LMrLP1KR71Ce0rJdQ=;
        b=Rhf10q6s3JMCa80g+eJaEamzQZpN1yURXdbXndhTf19Lbs3ezO4iuqo9uCGZW7Qm5P
         OHoKidMajn+7raOR+VijMDz1lfTx5Ij4kHzoiy5yHFJetjbXtPUKr40IOUzdPieqj/JQ
         RIghApZkawv0hVCb5r00KXhtyRLVm2JqKOHXnh0tlHrGvUaBs8dJ5ilwrXDVyzSqewrV
         w67gXZBGThncWtznOjXrW65E/z9KhCBsp5JNzgC5/hXUDVWl7jrlGaGrm9uD+lASH20f
         eEVc2pKGC2je1ff8W3kyK9KtemtXtOpACjwljeIdHdw93OfVeDEmLhb8vp96rVVDZBTJ
         MnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kKV7aE0TxR3j7oQ5UpL5QeWqb8LMrLP1KR71Ce0rJdQ=;
        b=IBbu/lQa6fVZhjRLtaleWndsn0qnLX6dqftGX3XdmJ0PeoZviDmkNod/mrZEfCetRA
         IcdrApNr2peS4r80gDoahw9bKTQepMNZM5urHCYdn6VNGD2HYWYVA6VMlUGbWp+qWyII
         +WTkEYqDsW1pTnHLfL+n9IQD96X6347EQtJFLAoYTlReQSkZiKCwmjS4SGt+niwJDNPt
         UE7k9vIg672k/2oW9MeSrvSBDjjsqiOWbhz2QSb1mATnhiZJ+9R42Ogeizrq1KDRlbU2
         2lxXln40sZ/D91BcQmAAeT2B771cgy0QBGIU1ilu7GyCwYvu+YVMgIsVnK7lA8rpvlse
         +cfg==
X-Gm-Message-State: ACrzQf1eoao/n5aGP7eqPIASrceRZ8ZqIG4H+RCfk1f8vtUyzH2Az06m
        25SAFcU0/gHWX2nM+oVQhZaznopz5xaJwE14iWw=
X-Google-Smtp-Source: AMsMyM4y1ykqVDED54Le5Jc1Sa/VyglNecTz9VeFpLkd8G+tt9SRPN/a7OQaD8oOiHi640FBB8gcp0b+oCBxz/xd/D4=
X-Received: by 2002:a0c:f00f:0:b0:4bb:6167:d338 with SMTP id
 z15-20020a0cf00f000000b004bb6167d338mr11256789qvk.11.1667226891093; Mon, 31
 Oct 2022 07:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211217115708.882525-1-tanureal@opensource.cirrus.com>
 <20211217115708.882525-8-tanureal@opensource.cirrus.com> <CAHp75VdQGBixkUStPiq3VuoL+9TJo946ObfRA-L-D72DaFHnrw@mail.gmail.com>
 <Y19fSL2Z6xq8TCFS@google.com>
In-Reply-To: <Y19fSL2Z6xq8TCFS@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 31 Oct 2022 16:34:14 +0200
Message-ID: <CAHp75VfwqsiiRM-=BGii45-kX_6v4CHxDMTgwPnG5SBwu6655w@mail.gmail.com>
Subject: Re: [PATCH v6 07/10] hda: cs35l41: Add support for CS35L41 in HDA systems
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lucas Tanure <tanureal@opensource.cirrus.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        patches@opensource.cirrus.com,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Oct 31, 2022 at 7:38 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Jan 06, 2022 at 02:29:58PM +0200, Andy Shevchenko wrote:
> > On Fri, Dec 17, 2021 at 5:45 PM Lucas Tanure
> > <tanureal@opensource.cirrus.com> wrote:

...

> > > +       cs35l41->reset_gpio = fwnode_gpiod_get_index(&adev->fwnode, "reset", cs35l41->index,
> >
> > Please, do not dereference fwnode pointers.
> > Also, why can't you use the device instead of fwnode?
>
> We are doing "acpi_dev_put(adev);" a few lines above, so using adev in
> the call to fwnode_gpiod_get_index() is technically use-after-free,
> isn't it?

Right, but I believe this is in response to the author and not to me.

> Also, why can't we do
>
>         cs35l41->reset_gpio = gpiod_get_index(acpi_dev, "reset",
>                                               cs35l41->index,
>                                               GPIOD_OUT_LOW);
>
> since acpi_dev is device structure corresponding to adev and we are
> getting the rest of the properties from it?

I remembered that I have also stumbled over that, but IIRC the point
here is that ACPI tables might be broken (since the multi-instance
device is a gray area to begin with). So we need clarification from
Cirrus to understand what the cases they want to cover with this
twisted code to get a GPIO.

> I saw downthread that there was supposed to be a patch addressing
> several issues raised by Andy, was it ever submitted?

-- 
With Best Regards,
Andy Shevchenko
