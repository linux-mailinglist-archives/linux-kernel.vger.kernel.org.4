Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78475B7CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 23:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiIMVrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 17:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiIMVrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 17:47:03 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B1A6C104
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 14:47:01 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id b23so4931552qtr.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 14:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yocom-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=F9e72CVH8beHMQQ9IXxSTC+b48uudP1jPeUhAvu93N4=;
        b=MfQk8WhferHWYJ/rhpAjkQ0kVV9pSpnd1O7rpsfH2zCQm9YTtgAgd01gMBUTw7hBip
         qd0d9kkB1MtC09R4tetkVT5xxy3hjLfKUcQJLIBglqcOh3dVnklHegKtsjMDbbeGNfB/
         KRJmAz75996OA746t0qychUO6zmbKyuCFJMpw/UqTqOZDi81K/lRV5m81hSfs2CYhNtk
         dSoZ8mUI1/mmxhS2PUrW84MkaIb624zaU7ZkA8zPYRavoW2gYpheJR7HwsfhjEXkI7Mp
         YB5jtYn6SCeLoIe8K54jSKU81BVpWE2n5AcnJ09n/VOZTmTKI4rSxiOYqDUXXrmu0RRd
         fTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=F9e72CVH8beHMQQ9IXxSTC+b48uudP1jPeUhAvu93N4=;
        b=shgtbNMiXlKlhZi2pAoC2FqIdA5OFoCRlUCAXdlgVWhMeW/7NZNKSs5koPgQzDZKwa
         onyVtKhbW0DPFFDZ8HbQtdKrbyGxwH0lk3CSqBwhV6snOKwXvOaf1ZVY8uObubVnUroJ
         5PDtUBkAaJOxF4MqZmiKCSHWIH0WBUgGLb+mMiCWexzKih/E8eStcuWGQR2RQWKXoWgu
         zJi05qHDZ1d3gOjw2s+tVIB5MyZr5Uv0YT4rTU6AfwZRtYgHtf3oHHInUFv0MffvWd4E
         iNxtR2dqT2YAj4ymSgd6zEwxT9/EcO282l/BSLMK+7qa0RnHWscSHB533pvooiwz7IWb
         xCnA==
X-Gm-Message-State: ACgBeo2yrZ7AfqAKLGiF3p5yHwF6yJHZYzR0OPglgrFnWPHIsv0aLMfK
        hIkyWfQgs6QxP6OOgoPTgFf9+kBfYqfeeN5pPCTbeA==
X-Google-Smtp-Source: AA6agR75XlClAfp+/9d1/WfjZc6QSfduqs+XplBXecUZvYUkRbxx7wKY6AnjyU9P7u37HWbscJntZ7fcpzTD+r751/I=
X-Received: by 2002:a05:622a:8e:b0:35b:acbe:cb48 with SMTP id
 o14-20020a05622a008e00b0035bacbecb48mr15207815qtw.390.1663105620672; Tue, 13
 Sep 2022 14:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220908173930.28940-1-nate@yocom.org>
In-Reply-To: <20220908173930.28940-1-nate@yocom.org>
From:   Nate Yocom <nate@yocom.org>
Date:   Tue, 13 Sep 2022 14:46:49 -0700
Message-ID: <CAF+10nJmefZ7pb38wTR3VD7LijzYati7eyTe9QZWEpK=sji9yA@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Input: joystick: xpad: Add X-Box Adaptive
 Controller support
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        hadess@hadess.net, benjamin.tissoires@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 10:39:25AM -0700, Nate Yocom wrote:
> Adds support for the X-Box Adaptive Controller, which is protocol
> compatible with the XTYPE_XBOXONE support in the driver with two deltas:
>
>  - The X-Box button sets 0x02 as its activation ID, where others set
>    0x01
>  - The controller has an additional Profile button with 4 active states,
>    which this change maps to an Axis control with 4 possible values
>
> Patch series adds device to the supported table, adds support for the
> Profile button, and adds support for the X-Box button as distinct
> changes.
>
> Signed-off-by: Nate Yocom <nate@yocom.org>
>
> Nate Yocom (5):
>   Input: joystick: xpad: Add X-Box Adaptive support
>   Input: joystick: xpad: Add X-Box Adaptive XBox button
>   Input: joystick: xpad: Add ABS_PROFILE to uapi
>   Input: joystick: xpad: Add ABS_PROFILE to Docs
>   Input: joystick: xpad: Add X-Box Adaptive Profile button
>
>  v2: Fix warning Reported-by: kernel test robot <lkp@intel.com>
>  v3: Break into multi-part and remove VID/PID check for XBox button
>  v4: Rename Layer -> Profile as suggested by Bastien Nocera
>  v5: Add new ABS_PROFILE axis to uapi and use it for the profile button
>  v6: Add ABS_PROFILE to absolutes array and docs as requested by Dmitry
>
>  Documentation/input/event-codes.rst    |  6 ++++++
>  Documentation/input/gamepad.rst        |  6 ++++++
>  drivers/hid/hid-debug.c                |  3 ++-
>  drivers/input/joystick/xpad.c          | 15 ++++++++++++++-
>  include/uapi/linux/input-event-codes.h |  1 +
>  5 files changed, 29 insertions(+), 2 deletions(-)
>
>
> base-commit: 26b1224903b3fb66e8aa564868d0d57648c32b15
> --
> 2.30.2
>

Dmitry et al, anything else I can do to see this through?  Thanks!

- Nate
