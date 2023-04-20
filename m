Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972CF6E9714
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 16:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjDTO3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 10:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjDTO3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:29:37 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FD730E8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:29:36 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id dx24so6724630ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682000974; x=1684592974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfCcV16gTVHrk1jOSyJnGJ7kV2rgJwjcCd2ItLoWL/M=;
        b=ln0ji5CjVFHiN0s10aJtxtCVE0gJXh9xSx6glw2SV0KeDMAmrYkg3vlTipK0Rzav0a
         uyR6sUC02/T0cZldCXhGyq8io+0wU6rhBzYnH13rfXaJUErYa1ZAZAfoGcxUc7jiA+W0
         zRnek2TbzgLJdeRBAlB2UavkRp5nbNJBevcfAf2tlvFfeCp+Ty1CW3H8ZkAZC9B6ve8Y
         jc839qPh9FhKUXNB/MElVO0gu85LyPGf/IOnNcK8LuzmepW0e7BSq4cXBQXzm7pil8bX
         WiHUm9g8bnoPyG6XZIB4wMknnBVq7HPZBzrvS6Zjd9FmcqwGLb3Ex0eJgXW2bJaVTt+W
         e6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682000974; x=1684592974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfCcV16gTVHrk1jOSyJnGJ7kV2rgJwjcCd2ItLoWL/M=;
        b=ay/wmvZj/kmcWB3GlN80ozHqpzCNZfOd8tw43hr8s/FnT1O9Jg33OTHUoc8Y/JonRp
         A6WLLwn7tXboslSdSU0Vxt8fHefWW/oL/jVxO8fsH+49vbkYLAW8jAtuFPoz8wa4+Zcx
         yVBqLOwqB8PiydY3IEEIm40SDL8a96mhDftDgnAgW11vc3FW582VimEoZvKV8XeSOitj
         ZBrqtKlf774PykiMTTy64UkXc9vt6LUV4oVf4Gu7fJ0Crurwzqb5nojkKM3UgqWlnuuY
         Sa//HBgVwccTUj/MwCWwMW52fg7yvdf8UImGYD/nbr7Hp+JpnZO7SlwFK71I6mKYQ64R
         2Ruw==
X-Gm-Message-State: AAQBX9ef6WsSKBzJwyGTl/8mTkj0PFE/TSGdmWlZES5miBqnHNd7kgnJ
        qQAjWc2kf6RyDqYg1hniErE=
X-Google-Smtp-Source: AKy350Ym6VgN7iFnbtZa++HNCUYXdDwB/7v+x/C6nG13kWRrpr1UrmkkQYzzcab6+6MgFC2goaPR1Q==
X-Received: by 2002:a17:906:b088:b0:94f:8aff:c8b3 with SMTP id x8-20020a170906b08800b0094f8affc8b3mr1781982ejy.28.1682000974374;
        Thu, 20 Apr 2023 07:29:34 -0700 (PDT)
Received: from PCBABN.skidata.net ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id g10-20020a170906594a00b008cecb8f374asm814617ejr.0.2023.04.20.07.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 07:29:33 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
To:     mazziesaccount@gmail.com
Cc:     DLG-Adam.Ward.opensource@dm.renesas.com, bbara93@gmail.com,
        benjamin.bara@skidata.com, broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, support.opensource@diasemi.com
Subject: Re: [PATCH RFC 1/2] regulator: introduce regulator monitoring constraints
Date:   Thu, 20 Apr 2023 16:29:24 +0200
Message-Id: <20230420142924.541206-1-bbara93@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ad59933d-714f-6444-b835-ecd9791934aa@gmail.com>
References: <ad59933d-714f-6444-b835-ecd9791934aa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the feedback!

On Thu, 20 Apr 2023 at 13:33, Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> Hm. Is there a reason why we need to perform these checks for each of
> the calls?

No, I guess there might be a more efficient way to set a bit somewhere
during registration instead. But I thought it might be "clearer" to have
it all in one function to clarify what is required that something
actually happens.


> Also, could we just directly have function pointers to monitoring 
> disabling which would be populated by the driver.
> So, could we perhaps have function pointers for these in the ops
> instead of flags? Core could then call these if set? Do you think that
> would work?

One goal was to reuse the existing set_{under,over}_voltage_protection()
methods for voltage monitoring. For me, disabling is basically the same
as setting the limit to REGULATOR_NOTIF_LIMIT_DISABLE. Of course, we
could also introduce new "disable_monitor_on_*()" ops, but I think it
should do the same job as set_*_protection(disable_limits), and
therefore only leads to duplicated code in every driver that wants to
use "dynamic monitoring". Also, I think we might need at least 6 new ops
methods to cover the different state changes, except if we do some kind
of "old state -> new state" function to identify if turning off or on
the monitor is required (which is basically now done in the core).
I am not sure if it improves things, but I could modify the approach to
be more "driver-centric". What do you think?


> Or, do you think it would be worth making this a tiny bit more generic
> by just doing some 'pre_enable' and 'post _disable' callbacks which
> driver can populate? 

To be honest, I am not sure. For the da9063, it might not be worth it.
For others, it might simplify the usage of voltage monitoring and move
the "mental complexity" of handling all the possible cases, where the
voltage monitoring must be turned off, to the core.
The driver must just set the monitoring constraints to "please turn off
while the regulator is turned off, turn off while the voltage is changed
and while the regulator is in STANDBY mode".

For me, it would also be fine to let the core turn off voltage monitoring on
all defined cases (while regulator is off, while voltage is changed, while in
IDLE, STANDBY mode). The constraints would just let the driver decide more
specifically when it is really necessary and skip the other cases.


> I think that some PMICs I've seen had separate 'disable/enable all
> monitors' bit which needed to be used when monitoring was
> disabled/enabled due to an operation [voltage change/disable/enable].

I think this case could be handled by my "possible next step" in a very
simple way.


> If we allowed driver to populate the disabling callbacks, then this
> would support also those ICs which need to disable multiple monitors
> for the duration of an operation (or do some other strange stuff)

I think that these should also be handled in the case of
set_*_protection(), but I am not 100% sure here.


> It would also allow drivers to add delays to the function(s)
> re-enabling of monitors when needed - at least the bd718x7 had to wait
> for new voltage to stabilize prior re-enabling the monitors.

Also not 100% sure about this one, but I think these cases could be
covered by a mandatory regulator-*-ramp-delay, when necessary?

I can provide a RFC v2 with the stuff handled from the driver instead.

Thanks and best regards,
Benjamin
