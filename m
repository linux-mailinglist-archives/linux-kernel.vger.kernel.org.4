Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2320E68EFD9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 14:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjBHNd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 08:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBHNdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 08:33:53 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC6F97
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 05:33:33 -0800 (PST)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BE39F3FC17
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 13:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1675863211;
        bh=B5Phcg37Y+0iYYa8mFPFNHEfBbc2aHtLt5zfOJMH2SQ=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=pOeGyo4RmwW0gOlcHSvJ6vCzlNkdE6WJT+J6EwWmNtf0TR6MJC8UV7n5aStETJbFj
         jFIrxFaNac1wq5ljVTZG9nfwMfAUnkFHqIerf13nWPTKkuaIHlBsWKud9Gt3cgjand
         hTO2FZkMRaAj148HZUL/pY/8dhDmbbLx3z1HBEfnTT/PP6KkSivWk3ie3HnGYDA4Oe
         SsTEQqKPo3bY1iJ2+ClN+GVIq8uWkE6RTCotmr+S80l7+mM8pZatefgdj4auj1FRHX
         VLqJCTznkupCYdc8f/wFa7YklaiZzAxsYjVqQg+BrqhCwJkOVvwwiOc8uzR3c/hSWV
         wcYDr/AaU2U9Q==
Received: by mail-pj1-f71.google.com with SMTP id pb12-20020a17090b3c0c00b0023086f62807so1064902pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 05:33:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5Phcg37Y+0iYYa8mFPFNHEfBbc2aHtLt5zfOJMH2SQ=;
        b=v+u7QX+rR0G7iuBJnDfTbLleBNFViYxHdB0oP2ok+0L0kJ9vN0tmY7pKaDkbKODnzy
         VkosQkxZrN8mvOHiFQcL0a9OeaYKDlGXMMO7S+UH8iWXdTPm6vVSLjSHF8PMuIWlJJQP
         /MKvRVuZLu4NOFLQJ+Z1GGycw+BM0Y6vhGBtSipo6iEJikBzcW1XrxsOhpTapTV2NcvC
         UM6gooG08r7nB6NJ28CoZgxv++1JPaD5LHEb+JVKsAAlTo3agjJbesO+JSBl4IZZZeZe
         A485iUYE/GA0Ao8MKDuhsbGFzDT6BC9j4Dh/pxtC7BGur8A0cGEZ16UoUTEeiZuvR61C
         DZVw==
X-Gm-Message-State: AO0yUKW4/Ro51bdtRyokRAwhH/cYBlGOdzVbZ8JgwiIwHF1EunRRpUFF
        a4k/zj/eeCWCnwhWBOHJ6dIjOLg2yhuMG2WgvR+e7Q0b106VsjG/46MLRUz8JIWREJ0Qe5Isxmd
        ivx4Tfg7qalHofeSQ1gEGdxFkyOApIXUGRYmpU1VifqrZ6jQSsGZW7dk31g==
X-Received: by 2002:a17:90a:b017:b0:230:fd55:84fd with SMTP id x23-20020a17090ab01700b00230fd5584fdmr835946pjq.39.1675863210291;
        Wed, 08 Feb 2023 05:33:30 -0800 (PST)
X-Google-Smtp-Source: AK7set/HhS1iOjK16EHBamexw44qy0ph9/0PLKL7RkWCRFx+p9BYtzJ0XFB/3mZ6qdXfcO/n1Sjl4P6cIEXJJPTCU7Q=
X-Received: by 2002:a17:90a:b017:b0:230:fd55:84fd with SMTP id
 x23-20020a17090ab01700b00230fd5584fdmr835940pjq.39.1675863209978; Wed, 08 Feb
 2023 05:33:29 -0800 (PST)
MIME-Version: 1.0
References: <20221226153048.1208359-1-kai.heng.feng@canonical.com> <20230117231416.GA158056@bhelgaas>
In-Reply-To: <20230117231416.GA158056@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 8 Feb 2023 21:33:18 +0800
Message-ID: <CAAd53p78cLYFCuE1jftygeZttGPvzegv-JDsGJnZxPxMiZUSwA@mail.gmail.com>
Subject: Re: [PATCH] PCI/portdrv: Avoid enabling AER on Thunderbolt devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Stefan Roese <sr@denx.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Sorry for the belated response.

On Wed, Jan 18, 2023 at 7:14 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Dec 26, 2022 at 11:30:31PM +0800, Kai-Heng Feng wrote:
> > We are seeing igc ethernet device on Thunderbolt dock stops working
> > after S3 resume because of AER error, or even make S3 resume freeze:
> > pcieport 0000:00:1d.0: AER: Multiple Corrected error received: 0000:00:1d.0
> > pcieport 0000:00:1d.0: PCIe Bus Error: severity=Corrected, type=Transaction Layer, (Receiver ID)
> > pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00008000/00002000
> > pcieport 0000:00:1d.0:    [15] HeaderOF
> > pcieport 0000:00:1d.0: AER: Multiple Uncorrected (Non-Fatal) error received: 0000:00:1d.0
> > pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> > pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
> > pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
> > pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 0a000052 00000000 00000000
> > pcieport 0000:00:1d.0: AER:   Error of this Agent is reported first
> > pcieport 0000:04:01.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> > pcieport 0000:04:01.0:   device [8086:1136] error status/mask=00300000/00000000
> > pcieport 0000:04:01.0:    [20] UnsupReq               (First)
> > pcieport 0000:04:01.0:    [21] ACSViol
> > pcieport 0000:04:01.0: AER:   TLP Header: 34000000 04000052 00000000 00000000
> > thunderbolt 0000:05:00.0: AER: can't recover (no error_detected callback)
>
> Is this a regression?  E.g., is this something that started after
> f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native") or
> something similar?

Reverting the commit doesn't help. Because 0000:00:1d.0 is already
native so AER is already enabled.

Kai-Heng

>
> Bjorn
