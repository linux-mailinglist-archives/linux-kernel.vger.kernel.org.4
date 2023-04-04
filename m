Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107596D7030
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 00:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbjDDWgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 18:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236550AbjDDWgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 18:36:21 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F09C10F6
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 15:36:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-4fa3ca41383so30039a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 15:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680647779;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mb4LYTz6ltLsND5GCzIBKn5H+VpjQGr9vlRB0NuV50c=;
        b=UR6uJgyAbnJbaOqQeyrdC5UmqrJ2A+MoqW0nVpx/LLHxmxxD7AkXWBdxOL8JEOr8t7
         hTfNLRFT5vClkKltGeEep2vb1MmlBQtmOSRFwHzD3oUuN1Na7j37sEdSrdswFSaR2tuO
         0fuDzMH/w7uqlzqRTqjNgKSZi2H9mMTNL5X0ZUIKDR14LbNog57Eu1sfkcCiXlK/DOec
         2sv6Rf1/zY7KXkhJVXr0t701zWw9vFub3ypuT1IXytLZ63Ji92PD5+drheTLXkByrV1F
         6ZpJCt+cdrkmE28lB3IoWBIanLfC1eYR+AOHjy3y5xvKoXunyr8UEY+/7nYI4Ac3DMO3
         taSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680647779;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mb4LYTz6ltLsND5GCzIBKn5H+VpjQGr9vlRB0NuV50c=;
        b=AZJ1KUwpPs5d6d1HwlvNfbXDpJY2lNVo5d94Bz6DY6z8nnyEapS6meGgxxF7Q2A+5c
         KF90rs/2wNmw9hsNq0z70bIkcPupCh3+v6jmK3bTTIpnJocyN39xKzm+io0js/336WKA
         ZOSWgB1jqG3L3S7BhsuKo1/RF5OMabvrg6TVVdU1NFF4eY3GjwIFSIYQgz7o/IBMPE4U
         DFLfbel8LszxiMyQNQiYxmVaC8bHWsBNl7l8+FRUjUtSJVK93zu2jrQK0LycAoeLHxl7
         ITm6+C7UiHZY6uL6elX5TP1w+QJ5IE+xqVdETrZ+mQ/SjY5vLX2Kyq1nGFUnIm4C/a0o
         wXng==
X-Gm-Message-State: AAQBX9f/0Y0qPUfzncLMPt83vsNM09xZWLgRo6hsIM54MthnKmUBJzk6
        lqcz1AtsNL/oevgbNVFj2/mJ+B4pHPx21JKM8Ak=
X-Google-Smtp-Source: AKy350ZVT1zO/muVW1BUis1jWxXGXDHvJYowuMbt3LMSuLPNT+9K9Bx3PNFtdnM4XawpinC9WP5xJ9LR2yHHOFUkes4=
X-Received: by 2002:a50:a6db:0:b0:501:d2fb:44bb with SMTP id
 f27-20020a50a6db000000b00501d2fb44bbmr76676edc.5.1680647778629; Tue, 04 Apr
 2023 15:36:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7208:3085:b0:65:6323:deb4 with HTTP; Tue, 4 Apr 2023
 15:36:18 -0700 (PDT)
Reply-To: lilywilliam989@gmail.com
From:   Lily William <amina570073@gmail.com>
Date:   Tue, 4 Apr 2023 14:36:18 -0800
Message-ID: <CAEQd_CuLpHsE4NyA7TT5NRqe9P5z90qC52yTqGVcUZYU-Mmybw@mail.gmail.com>
Subject: Hi Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dear,

My name is Lily William, I am from the United States of America
presently living in the UK, Its my pleasure to contact you for new and
special friendship I will be glad to see your reply for us to know
each other better.

Yours
Lily
