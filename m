Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612DD5ED312
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 04:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiI1Cgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 22:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiI1Cgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 22:36:51 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A792EFF59
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 19:36:50 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q35-20020a17090a752600b002038d8a68fbso598696pjk.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 19:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yocom-org.20210112.gappssmtp.com; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date;
        bh=oMcd+FFX5RAblF4LVrAjJE9mqUlyhd7hVi7olDl6ec8=;
        b=YAwcRm61faOxH5iGYddzzw3PFkZo5L1mJ1ZGDAw0bT6criCW/zNAEk52HelbZybyEx
         CxBsEmuOEy+CwyTyMHcg5YiJz1e+GCywN5bs1FDtQNxLQOEYdUYE8/aLdeVh1eGm+3Oa
         h8vCknh5Sx3OPmHQIsKtmUgmFwdGDLVRQQxr0kbvvzNC0zfayphxeQKzUUtXmrh/ZudH
         KYM0bqzPRCVC0tN6o9YinkQZaya727m6bpYY2aA6B2uLb1FrD5Rbbj4ykDe5Svmnt1ky
         0becT8s3lP0h/AT6hJta2qCKyqwT/CkDJbNoFxnfIrawDfBlQUVB6qTSs+kqXIYpJv/N
         0orQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date;
        bh=oMcd+FFX5RAblF4LVrAjJE9mqUlyhd7hVi7olDl6ec8=;
        b=14tUwdy6YmfukqkxMDTB0oeb1ySO7NQGE5UZI7rPmrVcyleLUIvQ/e7LRxuOXvTvXf
         hcCOx3B+5QbqQy+nifRezV1HZdQx6XKJ5/mk262trJEgAV8MdidQrZAX9Qjz/5vaD6XW
         WNgPWBTAQPZpjzoV0J7H34M0wmY0rHPrgn5cL8P2UBU5J1Igto5WFUeraPcJo+nWKGM8
         6deZjqqYNJnfv17+vbYWS+7AcZdCKG+9V0+LUrCEZj6aPnPHThbRmc7a+3/qZBGi3rGJ
         1GZ4lSSjnPPnnmcqCDIvRDBKbfbFhU9BQ0MGUIZ2Dh3nsqN8NwmGLh4zuGdRitDMUDsR
         nc0Q==
X-Gm-Message-State: ACrzQf2KazPcuDAeq/fXuCn+6ECUwWDLBW5xpthzTpOdbnR5xrVyM4wz
        zFXDRdKsFwvg9ojFkw63+rEe64Tb/63Hvw==
X-Google-Smtp-Source: AMsMyM7icsOgCjXEgRaIea8w88/lVqbT+M00uCdtdN8v5WxMA28xFqu/QQB3KQrcARh9glwd/CGpsA==
X-Received: by 2002:a17:902:8c90:b0:178:b9c9:9793 with SMTP id t16-20020a1709028c9000b00178b9c99793mr29998914plo.151.1664332609755;
        Tue, 27 Sep 2022 19:36:49 -0700 (PDT)
Received: from smtpclient.apple ([2600:380:4924:843d:a486:4a30:ae99:11b1])
        by smtp.gmail.com with ESMTPSA id b8-20020aa79508000000b005363bc65bafsm2546916pfp.57.2022.09.27.19.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 19:36:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Nate Yocom <nate@yocom.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 0/5] Input: joystick: xpad: Add X-Box Adaptive Controller support
Date:   Tue, 27 Sep 2022 20:36:46 -0600
Message-Id: <AC05A8B6-3596-489C-9357-5A9F5AF05403@yocom.org>
References: <CAF+10nJmefZ7pb38wTR3VD7LijzYati7eyTe9QZWEpK=sji9yA@mail.gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        hadess@hadess.net, benjamin.tissoires@redhat.com
In-Reply-To: <CAF+10nJmefZ7pb38wTR3VD7LijzYati7eyTe9QZWEpK=sji9yA@mail.gmail.com>
To:     dmitry.torokhov@gmail.com
X-Mailer: iPhone Mail (20A362)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sep 13, 2022, at 3:46 PM, Nate Yocom <nate@yocom.org> wrote:
>=20
> =EF=BB=BFOn Thu, Sep 08, 2022 at 10:39:25AM -0700, Nate Yocom wrote:
>> Adds support for the X-Box Adaptive Controller, which is protocol
>> compatible with the XTYPE_XBOXONE support in the driver with two deltas:
>>=20
>> - The X-Box button sets 0x02 as its activation ID, where others set
>>   0x01
>> - The controller has an additional Profile button with 4 active states,
>>   which this change maps to an Axis control with 4 possible values
>>=20
>> Patch series adds device to the supported table, adds support for the
>> Profile button, and adds support for the X-Box button as distinct
>> changes.
>>=20
>> Signed-off-by: Nate Yocom <nate@yocom.org>
>>=20
>> Nate Yocom (5):
>>  Input: joystick: xpad: Add X-Box Adaptive support
>>  Input: joystick: xpad: Add X-Box Adaptive XBox button
>>  Input: joystick: xpad: Add ABS_PROFILE to uapi
>>  Input: joystick: xpad: Add ABS_PROFILE to Docs
>>  Input: joystick: xpad: Add X-Box Adaptive Profile button
>>=20
>> v2: Fix warning Reported-by: kernel test robot <lkp@intel.com>
>> v3: Break into multi-part and remove VID/PID check for XBox button
>> v4: Rename Layer -> Profile as suggested by Bastien Nocera
>> v5: Add new ABS_PROFILE axis to uapi and use it for the profile button
>> v6: Add ABS_PROFILE to absolutes array and docs as requested by Dmitry
>>=20
>> Documentation/input/event-codes.rst    |  6 ++++++
>> Documentation/input/gamepad.rst        |  6 ++++++
>> drivers/hid/hid-debug.c                |  3 ++-
>> drivers/input/joystick/xpad.c          | 15 ++++++++++++++-
>> include/uapi/linux/input-event-codes.h |  1 +
>> 5 files changed, 29 insertions(+), 2 deletions(-)
>>=20
>>=20
>> base-commit: 26b1224903b3fb66e8aa564868d0d57648c32b15
>> --
>> 2.30.2
>>=20
>=20
> Dmitry et al, anything else I can do to see this through?  Thanks!

Anything missing here? Any chance of getting this in?
