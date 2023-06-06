Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B58724AB1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbjFFR6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbjFFR6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:58:33 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7293F10CA;
        Tue,  6 Jun 2023 10:58:32 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6b0d38ce700so4799677a34.2;
        Tue, 06 Jun 2023 10:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686074311; x=1688666311;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RF5ru2LGTiIKHMD68g8nkck885E+N9o191hpk/S2YYk=;
        b=i1HLXl0Bc/QvqsfJVj9LXi6s8Kh9zVynjjm8WOscavsU8JsQjrVIvTpzvBvzf3fd6R
         AUyfK8eTj/NgreTHI9s2mi6RAcT7+VuR8uQADYZ+iYJGbRDFNfbeuCr7V7HwxywV8OPv
         BQvBGUrcssWGMqEc0YH+iycPkoiC230cwdPmZtCzlumg9VfDRedYzQFlHguBtLqPVejh
         IAUk1eQScnnQi0Z0FmW6aMHyz/xUZOwPzQVipjUuJHWvVAVXTPVj0551AJoDIJ2kd6WE
         rhqIa/0KkLgvNI/bihoCWl1PDa2ux5PEliYkgHfSXozGnaB3s7/exWDoAlpf91dJg3RI
         BXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686074311; x=1688666311;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RF5ru2LGTiIKHMD68g8nkck885E+N9o191hpk/S2YYk=;
        b=fat0hn5ayidAFtdeu+Stk1Pv2KViD2yA30eLT1eIPLwQG/rVT3LqFAhVEu+xfaYfDG
         74sSczpzL1ZJMUYBXRGo34y3O5NaVs6CFZ6mlOzX4yGUbMY9NiKSW46qZKLB/Le6O7ob
         MdZH1eu90IBFtP9zy3uwI4DlMwFh4WuBkxEJK/vAJR7d6tZTxewJKKGoInBlCgzYlIlr
         RFzbGb7MNoqo+leErTDF2qgB0h2RttzP7W3GzmWC/m9tAyRv02VZF3cTJNEHFskCPbnR
         bztaismV8BpiF/wrRnVmN+mY5uMIpQ7D4nuIX/WtuGKOdHRIKJXQGJK4ChoKa3UxW84Q
         YT9Q==
X-Gm-Message-State: AC+VfDxBHvX8J9jvGnMIHNioViHkfepuZWYbp2uPoLVX6FVJjVS8YduG
        7UivuY5zIKVHT/99X4/UjLxAr1RA11A=
X-Google-Smtp-Source: ACHHUZ79VcjpgkIKaa9W/nVIKsjOkN+n1/EhVlZgB9B/FTRvdY7FcSrOd6m2vTv7wwWYQc1TLqr9pg==
X-Received: by 2002:a05:6830:13c6:b0:6af:95c0:fe1e with SMTP id e6-20020a05683013c600b006af95c0fe1emr3113844otq.5.1686074311149;
        Tue, 06 Jun 2023 10:58:31 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:f59e:5ad5:28cc:2003])
        by smtp.gmail.com with ESMTPSA id x22-20020aa784d6000000b0065980654baasm4140830pfn.130.2023.06.06.10.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 10:58:30 -0700 (PDT)
Date:   Tue, 6 Jun 2023 10:58:27 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v6.4-rc5
Message-ID: <ZH9zwxXvAd3kacKH@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.4-rc5

to receive updates for the input subsystem. You will receive:

- a fix for unbalanced open count for inhibited input devices

- fixups in Elantech PS/2 and Cyppress TTSP v5 drivers

- a quirk to soc_button_array driver to make it work with
  Lenovo Yoga Book X90F / X90L

- a removal of erroneous entry from xpad driver.

Changelog:
---------

Dmitry Torokhov (2):
      Input: fix open count when closing inhibited device
      Input: psmouse - fix OOB access in Elantech protocol

Hans de Goede (1):
      Input: soc_button_array - add invalid acpi_index DMI quirk handling

Ismael Ferreras Morezuelas (1):
      Input: xpad - delete a Razer DeathAdder mouse VID/PID entry

Maximilian Weigand (1):
      Input: cyttsp5 - fix array length

Diffstat:
--------

 drivers/input/input.c                 |  2 +-
 drivers/input/joystick/xpad.c         |  1 -
 drivers/input/misc/soc_button_array.c | 30 ++++++++++++++++++++++++++++++
 drivers/input/mouse/elantech.c        |  9 +++++----
 drivers/input/touchscreen/cyttsp5.c   |  2 +-
 5 files changed, 37 insertions(+), 7 deletions(-)

Thanks.


-- 
Dmitry
