Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8A367E897
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbjA0OsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbjA0Or6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:47:58 -0500
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21EAA5C4;
        Fri, 27 Jan 2023 06:47:51 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id me3so14325645ejb.7;
        Fri, 27 Jan 2023 06:47:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5me8lH3pgTa/DmTSAOi6nOH6JQRARB47Lugm5ahDMX0=;
        b=o73ZSI+DMxS6IQSTH1YA1VF3Ck4EYHPGspsI3QbamlG5hiWDFHHsAExCAqVhj7L+Kb
         tGkZ8W+TtBhqci5GTPbOaxnVcdcrcVh2J0A6k97jA9G/GoY2qJnVCLFy7I602nv6aRjX
         3gLXg8IsspJ+IsFrSkMEHQkxxhScc78FN0rFjFzdko+P6f4PttmiDAmZIozBQnTLZUxP
         TtsvcpGh56ZLCqWgtAm7ND3m417AlWVHmRiU5+DjM79vouEKtIYvGxM6FioZQ23HZBNN
         ikP5OgqIcusXnJsMm7xe/Ni+lb4rUxTbok/ryfyMiRCV34s6JfNHFNth/+e0ASmFrrLO
         iFWA==
X-Gm-Message-State: AFqh2kqhlNiTovsTkPfv0LuZH/iqDRSGZMPghHi1X262gqzxfkwHPFcv
        uvWAGx+GT05i81TVTGnm7wjEFcQs+hFoOpkPrwPrEwljI80=
X-Google-Smtp-Source: AMrXdXuGI4kw8ZnMqc3nnwa6G8UtmTtEA15K2gzlVsrcauttnFipd7ola0AM6Y5iKKt2GaANLuRiZrg7vaKD2uMldPo=
X-Received: by 2002:a17:906:70d2:b0:844:44e0:1c4e with SMTP id
 g18-20020a17090670d200b0084444e01c4emr6046209ejk.291.1674830869527; Fri, 27
 Jan 2023 06:47:49 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 27 Jan 2023 15:47:38 +0100
Message-ID: <CAJZ5v0gFS6URrN3fe4p6fv5oGL34XuT7-xGNdLnYELZOgfwjmw@mail.gmail.com>
Subject: [GIT PULL] Thermal control fixes for v6.2-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.2-rc6

with top-most commit acd7e9ee57c880b99671dd99680cb707b7b5b0ee

 thermal: intel: int340x: Add locking to int340x_thermal_get_trip_type()

on top of commit 2241ab53cbb5cdb08a6b2d4688feb13971058f65

 Linux 6.2-rc5

to receive thermal control fixes for 6.2-rc6.

These add locking to the Intel int340x thermal control driver to prevent
its thermal zone callbacks from racing with firmware-induced thermal
trip point updates (Srinivas Pandruvada, Rafael Wysocki).

Thanks!


---------------

Rafael J. Wysocki (1):
      thermal: intel: int340x: Add locking to int340x_thermal_get_trip_type()

Srinivas Pandruvada (1):
      thermal: intel: int340x: Protect trip temperature from concurrent updates

---------------

 .../intel/int340x_thermal/int340x_thermal_zone.c   | 28 +++++++++++++++++-----
 .../intel/int340x_thermal/int340x_thermal_zone.h   |  1 +
 2 files changed, 23 insertions(+), 6 deletions(-)
