Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AC267FBFB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 01:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbjA2Alo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 19:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjA2Alk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 19:41:40 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3994712F0F;
        Sat, 28 Jan 2023 16:41:40 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id c124so5546220pfb.8;
        Sat, 28 Jan 2023 16:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=da5pnEaL8+0pDhSp/BkP4Rwr6DtXuiQDQA4NoCQPyO0=;
        b=Qlw7ez0NWn81/JzRd3zxiU3DQ8l5o51d2xj+ju1R8BzrFSPIngQ7s6ifXGEYkGx1KP
         KKdgZUY/YUMG3WyNj5LzDdDOr+crJ1Wn6nuTqE2yGnZWtZQNkStfHzLSGLhetJcCYVA+
         LNUupIXzdvs1pnCv0EIQyCOgNyfPXly8wxDSJNa1g6YfHij69pzs3NYg2PPgdfhSlzEZ
         E2JvcUZyk70jyeH/C6UOOoN47M3SVKRBdkjaAR3WBjZupV+OogURDXwzO6cmY25NQRVO
         KKcNjDyFH3TRmjkC/S04PUDzGKztgbtLx1d2znTmcQ+nytNeJrI0ja341Iz/St/2u7PI
         X/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=da5pnEaL8+0pDhSp/BkP4Rwr6DtXuiQDQA4NoCQPyO0=;
        b=XAgJyf3ChCUwXrtQpTzn5mXKTIXuILO2c0KDD5HfyY/wuTTS1kgGs8jdpIDD3kxU+M
         1sPsRjQc4N+rJdv/Y0F4hmKMmDSAdqjp5MdFMziRBJB7rCEDK7v2tg2MripMOYmE+drl
         vKRW8wA3Vu3KdhSw8wFj4DqSn/tOxZG345Ant0S8LBU8iS/R8szoem725sfOlXRZVybN
         WtGAGgUdCsiCBqqXbc4DX9C14uTQptrwf6iVvY5+9hkQE0UV16xqnx5INolhloTyB9wj
         vkI6LNRAqlpvCy3UqZl6prEwJ1pKtbWGei6soxEkXqxemqVgBFv1ZuGKc9W9q3+O/B9m
         q/+w==
X-Gm-Message-State: AO0yUKVTDHkpG33pQeVALElQ8lq7mzd8jKDRYtbPeYxIprYu/a5ZBWm6
        PxqIMNpYB0GwndqfCFxTJcdBsDGYDIM=
X-Google-Smtp-Source: AK7set/v+1OUq0+ss5I0iYxcKSYo7JfDdD8mYCeZy1AqbZM5xmZMc8spQZSYek1ZAKg6wfDDXekbXg==
X-Received: by 2002:aa7:85c3:0:b0:592:629a:c9b5 with SMTP id z3-20020aa785c3000000b00592629ac9b5mr6415359pfn.14.1674952899460;
        Sat, 28 Jan 2023 16:41:39 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:1619:2ad0:738:563])
        by smtp.gmail.com with ESMTPSA id y15-20020a056a001c8f00b0059260f01115sm3648341pfw.76.2023.01.28.16.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 16:41:38 -0800 (PST)
Date:   Sat, 28 Jan 2023 16:41:35 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v6.2-rc5
Message-ID: <Y9XAv4p0H9aU4+yz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.2-rc5

to receive updates for the input subsystem. You will get:

- a revert to Synaptics driver switching touchpad on HP 15-* laptops
  back to PS/2 emulation mode as native RMI4 causes loss of keyboard
  function on HP 15-da1xxx

- a quirk added to i8042 for Clevo PCX0DX/TUXEDO XP1511 to make sure
  keyboard is responding after resume

Changelog:
---------

Dmitry Torokhov (1):
      Revert "Input: synaptics - switch touchpad on HP Laptop 15-da3001TU to RMI mode"

Werner Sembach (1):
      Input: i8042 - add Clevo PCX0DX to i8042 quirk table

Diffstat:
--------

 drivers/input/mouse/synaptics.c       | 1 -
 drivers/input/serio/i8042-acpipnpio.h | 7 +++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

Thanks.

-- 
Dmitry
