Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9F3625B5E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 14:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbiKKNpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 08:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiKKNo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 08:44:57 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5284D6035F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 05:44:56 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso4763362pjc.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 05:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vixtechnology.com; s=google;
        h=content-transfer-encoding:content-language:in-reply-to:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9f0eJ3gwtCls0GONPaz0H+Xp2yebKRpiGI7r4n7KzpY=;
        b=tPIgGAgEoKv0Rq8ecSzBJGz1cGb9ii4/Fkdf+R4cMNSrSkpA11yzSn5jEflC+L5kcn
         6bzQM/ooiLPYr0ZyyBC6+pFPXenJf2WMqy2pJ4cMnwHVfrJRgSNjQWOXIFm/sfpYiTmm
         1whbFmNPk8E4jsw17aqKLDr7lI2v1piiAyAXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9f0eJ3gwtCls0GONPaz0H+Xp2yebKRpiGI7r4n7KzpY=;
        b=qJR7vgOykjLu3d1smpzCssOiyADRIj51Dm5QAsaDzV4CKFd/sSoogc/56aUbw2dtRI
         t6kxzX/NgEO5pVPxgUfuvSpPFEU4Vf+EbkasfuP969eNyYJPCqFcHRxcEX2bSMvo5hVd
         +Kivee7kXjTcN1jf58FseYrfLoncvM4B0Ebn7rb4JigQ7SwqI/3kilHYcL11E4Qc7fES
         rnpylGaAnuZD0tqX+QtVI1SRD1NXExEw+xLs+zfuUqQlTaGnLwldjhr2BkAYDx8YZIrP
         AUOt+cvDwmbjOWcIkQsXFzBsZrzIkJX8KRlCHwM/hf4zueiXJzIq5C70X/r9spRO4JMN
         l5Jw==
X-Gm-Message-State: ANoB5pnzMncYVKEeALr2AmSkFy5YIa6MZC2KGhpEAnCOqTHAq+LMmWGw
        XvlWL1zfNFIgTBrsWARCEGGTRXoeHIwYzlg39y9pWJwOJzAE2EqiQuwmcvYd8MFQFxv7bKL43NJ
        UKHX/N3Bj4AdpEsgc
X-Google-Smtp-Source: AA0mqf73qGoRRZZc00nwDkqW5m80LFJehT/4U0FSDFe5P+atBiJUzifEoEGUU5uo7gEso6c3gVPzSA==
X-Received: by 2002:a17:902:7249:b0:17d:95af:fb59 with SMTP id c9-20020a170902724900b0017d95affb59mr2476324pll.154.1668174295296;
        Fri, 11 Nov 2022 05:44:55 -0800 (PST)
Received: from [192.168.1.110] (106-68-237-135.tpgi.com.au. [106.68.237.135])
        by smtp.gmail.com with ESMTPSA id q12-20020a170903204c00b00186a8beec78sm1711544pla.52.2022.11.11.05.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 05:44:54 -0800 (PST)
Message-ID: <380ae3c3-14c2-db1a-954c-caf8180746f0@vixtechnology.com>
Date:   Fri, 11 Nov 2022 21:44:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] iio: light: apds9960: Fix iio_event_spec structures
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20221110101241.10576-1-subhajit.ghosh@vixtechnology.com>
 <CAJCx=g=qRd+WaCLOHwnEjg1Myg4Ng=PK0sxcGgEG9VT+VpondA@mail.gmail.com>
 <b6ac2692-3152-dfc4-5388-7986042970f0@vixtechnology.com>
 <CAJCx=g=WaGiBFYJTTjNgzrnW3We0qpuMvyy9iFAVDC8Mkbscsg@mail.gmail.com>
 <20221111111049.0000467f@Huawei.com>
From:   Subhajit Ghosh <subhajit.ghosh@vixtechnology.com>
In-Reply-To: <20221111111049.0000467f@Huawei.com>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm.  Given that event enables often cover a couple of different things
> (as done here) it isn't unknown for those to not be as easily covered
> as you have done.  As such, we have drivers were the ABI allows for
> enabling one event to end up enabling several others (even though they
> have separate enable attributes).  It's always been permitted for one
> IIO attribute write to have an effect on other attributes simply because
> we can't represent all dependencies.
>=20
> Now the bigger complexity / surprise here is the return of the either
> direction in response to enabling either rising or falling.=20
> That is going to rather surprise your average writer of userspace cod Thi=
s is where the inconsistency was found. When an ALS threshold rising=20
value was given and as soon as it was enabled, interrupts started firing
in low light conditions as there was some value present in the ALS falling=
=20
threshold(reset value is not defined in the datasheet for this register),=
=20
but falling threshold value was neither fed nor enabled!

> So patch covers what we should definitely have had in the first place.
> Hence it's a question of risk of someone running code that will be affect=
ed
> by the ABI change.  One of those fingers crossed moments...
I understand that breaking existing userspace applications is not the best
thing to do.

>=20
> Jonathan

Thank you for your time and comments.

Regards,
Subhajit Ghosh

--=20
This email is confidential. If you have received this email in error please=
=20
notify=C2=A0us immediately by return email and delete this email and any=20
attachments.=C2=A0Vix accepts no liability for any damage caused by this em=
ail=20
or any attachments due=C2=A0to viruses, interference, interception, corrupt=
ion=20
or unauthorised access.
