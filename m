Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3C7623774
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 00:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbiKIXaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 18:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKIXaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 18:30:10 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085E9E003;
        Wed,  9 Nov 2022 15:30:09 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id v17so525640edc.8;
        Wed, 09 Nov 2022 15:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAvE+zmS2KRIMgnsrjebgmPG4+u2jRS9iMLFQsNWlzM=;
        b=TeL5fw501TdmYB+S0bqSmi4rWOTLEyLBPDNa1z0oqzbUu71nT5AVEQb+AVJwvGwP99
         AVxncPhSzbXwfwqxm8+H7NmHidGlr/fwrg+GxCrxHIbj1LYwXgZNmkncjTBCbWJSi0pF
         uiANWPwOTPmLWxGAHchE04VluTznStBm28XqwUIqFlBlzbMWdtooE+uToLgI99rrADDe
         OpnKFHsRM4bU5VY0NHlFmI8LF6ohvQ6300ZvKskCnp7jnEjG5rw2OoqQrcLoNK7qc2r8
         wPN9kSDVu4cJxUXyEdJY8f5F+Hh5CkUOAm2s4PBcsZMc9E9MbwEUDREKSDslztQyu3zw
         1jFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAvE+zmS2KRIMgnsrjebgmPG4+u2jRS9iMLFQsNWlzM=;
        b=Qtj0SnmXwKCoZ6rYO30S3ILAt4ToO+56yI+JqaoeMZEspFMCd03cUqfwMy7QFz1okV
         8O+gs9HKk56zlZSuVp657PRZ8JJKTY+9OJtYBUuZGv3W9K/SnPXfcBiQgCMC1L2swZoE
         6Q6i6+DtIEKIb4UFNAwii6lSLejkQv6GQ11Bo+wmlapXBxhB1d/iPS4GmztLxQBAKxYh
         79JSFN8kRqXqcQXIA8iXy6LerdYJTrLMGooIxtLnXmAVLTLi+IqMcuSS+QTB/fmu5oNe
         uRD/H4Ibjy6/krNZJv7nmQbbUy8+2nwJ8zsEqCHC5sX5ihJegEv2T/VFseJ+cwF1cgWy
         ydUQ==
X-Gm-Message-State: ACrzQf31OskhSG0EEBt8ANOtCgRUOK2pYWxAtJstSROamUhd14wWv60y
        gRu8MfCvoNPOhaIltCAXfOM=
X-Google-Smtp-Source: AMsMyM5G52Uk5JJgv+lLd/5HS64MTU2tuQrNv0/SblnZv7Q8PuX1moHfcSZJY9pqGWAqnrAli0PR6w==
X-Received: by 2002:aa7:cd12:0:b0:463:69ac:a5d3 with SMTP id b18-20020aa7cd12000000b0046369aca5d3mr53912084edw.269.1668036607529;
        Wed, 09 Nov 2022 15:30:07 -0800 (PST)
Received: from eray-Lenovo-Z50-70.. ([188.132.247.187])
        by smtp.googlemail.com with ESMTPSA id a12-20020a50ff0c000000b00458b41d9460sm7468800edu.92.2022.11.09.15.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 15:30:07 -0800 (PST)
From:   =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
To:     hdegoede@redhat.com
Cc:     benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com,
        erayorcunus@gmail.com, ike.pan@canonical.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgross@linux.intel.com, platform-driver-x86@vger.kernel.org,
        pobrn@protonmail.com
Subject: Re: [PATCH v2 0/7] Add camera access keys, IdeaPad driver improvements
Date:   Thu, 10 Nov 2022 02:30:04 +0300
Message-Id: <20221109233004.9751-1-erayorcunus@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <9e0074f8-4cbf-e390-6680-39fe3649bbc4@redhat.com>
References: <20221029120311.11152-1-erayorcunus@gmail.com> <0b298830-47cc-bb94-0e73-493e4e9244f7@canonical.com> <9e0074f8-4cbf-e390-6680-39fe3649bbc4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 11/9/22 19:38, Hans de Goede wrote:
> Hi Eray,
> 
> Sorry for the long silence, I have not done any pdx86 patch review
> the last 2 weeks due to personal circumstances.

Oh, I wasn't even aware I had to wait for pdx86 review, and Ike Panhc
just sent his Acked-By anyway, no problem at all.

> On 11/9/22 13:58, Eray Orçunus wrote:
> > On 11/08/22 06:56, Ike Panhc wrote:
> >>
> >> Thanks. Also test on my ideapad s410 and it looks good.
> >>
> >> Acked-by: Ike Panhc <ike.pan@canonical.com>
> > 
> > 
> > Thank you :)
> > 
> > I need some advice since I'm new in here, sadly another patch has been
> > merged to ideapad-laptop along the way and currently it's not possible to
> > merge patch #7, does that mean I should send v3 of my patch series?
> 
> No that is not necessary, I can rework it to apply on top of the other
> patch.

Oh, that's great, thank you.

> For the touchpad patches I would first like to get
> a better handle on how to fix things more generic.
> 
> Specifically patch 1/7 will cause priv->features.touchpad_ctrl_via_ec
> to get set to 1 on more models and since that is causing issues
> I don't think that is a good idea (even though the patch does
> make sense) and for 7/7 I hope to come up with something
> more generic.
> 
> If you can run the tests from the touchpad mail soon that
> would really help!

That sounds great! I will try to help as much as I can. And yeah,
I couldn't guess patch 1 can cause a regression on some IdeaPads.
 
> > I think that is the only subsystem whose maintainers haven't replied yet.
> 
> Correct, but I have replied now :)

Hehe, this reply was very informative, thank you :)

Best,
Eray
