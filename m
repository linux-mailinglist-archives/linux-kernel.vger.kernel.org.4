Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCCA6CA2B3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjC0Lot convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 07:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjC0Lom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:44:42 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D487C26AE;
        Mon, 27 Mar 2023 04:44:41 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id eg48so34760394edb.13;
        Mon, 27 Mar 2023 04:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679917480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V74MttDGipmP3UUISAOxBKVfXHyUPafNiovI+8V4B4s=;
        b=DcaHHwHnGS4BI/3cHwhqdNGKomJRYLxq7E2JvK3shbG86UpkrKhUncVgCiuZcOdz+V
         gaFzyVLvH7L+dgbrYqFcYcQGzAsfHL3Q07k/YUxr1wgykcdiKf7Nv5FOznEMHSllh6jU
         DD62tjzvBbtsjSqk8y+QEG4WivrL2+/1V+zcPMT58jbdU86ju9aaB4mQ1+nYu16d183Z
         d39gIa6hDB+BXQaknVLrZHsY0s9f9Am+4D4xGyWurvePL0cgL8yBgJkOOWYFydXtj5p/
         DDxiNLuKxqbaXLEERB3qyumVUpIgHPLWpzkTX8iInZUxvYGjjh9KALTHCgH6827bQNdI
         NYBw==
X-Gm-Message-State: AAQBX9frY4FDnkfyd24pUYz/JYpjyWzf6QJbseiRecfDENfRfwKDEhq3
        iEbO2DJbuizcqk/cfg7s/P1dLfVFZ/53+yF8tdA=
X-Google-Smtp-Source: AKy350YiEnQTTYCB59d+rlZZV64ak1hGpJIWSCnrQFLGEB85R8q2bvDmtfN3C1e3r23xJ0RsNYERoWeQo9HvOL902gA=
X-Received: by 2002:a17:906:fe49:b0:8b1:3298:c587 with SMTP id
 wz9-20020a170906fe4900b008b13298c587mr6062971ejb.2.1679917480419; Mon, 27 Mar
 2023 04:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <5687037.DvuYhMxLoT@kreacher> <11fab8f24f976112aa4d025d03f0f322.squirrel@mail.panix.com>
In-Reply-To: <11fab8f24f976112aa4d025d03f0f322.squirrel@mail.panix.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Mar 2023 13:44:26 +0200
Message-ID: <CAJZ5v0gAyGNAT-t=pQ9wEbNAqzixEfm5dKZuRJVv-YQ=1=LbFw@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: bus: Rework system-level device notification handling
To:     Pierre Asselin <pa@panix.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 4:54 PM Pierre Asselin <pa@panix.com> wrote:
>
> Rafael, the patch is good for 6.3-rc1 (boots to early userspace).
> I'll try a full install now.

I'm wondering if this has succeeded?
