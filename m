Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA56F64E8FF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 11:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiLPKCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 05:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiLPKCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 05:02:08 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D054049B79
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:02:03 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 2so1764163ybl.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eqGMnzJ4Et1n9dwKrUIft9bF2vnqMW/4pT/9VNxrM7k=;
        b=Nst6sempuwKjNJHSb9Yob8jl1E3RGL0zElMBgh6Rz+LxNqvCtg8xxbG/4xf+sZMVpN
         lp4eXnnJhmm1YXABSk5d3S3NiHcVM0pa6xS8Y811E70i0ZkY03uckdtful2O8+k0LzII
         AI7kEiC1r/bV+8NgjNovzQAoQWf9Vb5c7QDXFhXxamaYY8SNNsTeEKi84e6rT2KwZ//R
         aVnw+OWdQo3/50hI/sC//qDqOdmyVo55Ed+STlDVAULIvCpxbcfyXVp1sioGn/5ZKhqH
         y5JWBzXurMXpb8xtHj4O7ZbqUHcBZOHFPaBiqTp0WAsByC8eqPy0MSy41v/eQTUt7MKq
         /5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eqGMnzJ4Et1n9dwKrUIft9bF2vnqMW/4pT/9VNxrM7k=;
        b=LQ5W07mheAbWaKT6E07C/cJ16KzS1aKj7rABt5AD8kYsq8hKSVt5qjg62uKi4w7MeF
         oZ/cwkbkRROv7zPy1zyzYzBDz5nAtyCsGzzO4PK0EDhMsQDxMZ3aU/y/aoX3YNtgaFQe
         JFDElrDnEFQVcQ1rpfsO+q89G98/d2u48ZGbD2P43iiL6hjHTOBhf7/9skNhMKOHO9WL
         gZmVKcbREfXqwUdNLXUV6EViCahaGTb9BR0GdWKImHprGmcDZuZuoCBDRCrBn3BRZw2a
         6+RBHws2W9xcTmxuhmNbga38mZfcASg94/tiBpcqWN13F91KqZENXRZpoCKg76RGW1QR
         GzFA==
X-Gm-Message-State: AFqh2koem0Ik9KJtEHFgDIbq95Z+QqC6hF6XVjBJpNH1MNqZPoHmZiJy
        djKtgV/CUP9IEj7G/VgKMzeVSSCm89yLHV21HTo=
X-Google-Smtp-Source: AMrXdXvmpCF6FNq8Haq5XAYSHx6aaG+Z2mpZh85M6o2tekgHkNygJEFA3ssgQ49v8CgxUYk/+fXQ2dG/rVWh0/TWmxc=
X-Received: by 2002:a25:be92:0:b0:738:7de4:1201 with SMTP id
 i18-20020a25be92000000b007387de41201mr369981ybk.608.1671184922946; Fri, 16
 Dec 2022 02:02:02 -0800 (PST)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 16 Dec 2022 11:01:52 +0100
Message-ID: <CAKXUXMxpWOXCUY-dd02P4ckAhF211VJtPTFeTriCMozZon7A5w@mail.gmail.com>
Subject: No matching files for file entry added in MAINTAINERS
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Christoph,

with commit 894799e1f496 ("MAINTAINERS: Add DHCOR to the DH electronic
i.MX6 board support"), originating from
https://lore.kernel.org/lkml/20221117105131.7059-1-cniedermaier@dh-electronics.com/,
you have added a file entry to DH ELECTRONICS IMX6 DHCOM/DHCOR BOARD
SUPPORT, but there is no file matching this entry in the repository.

Are there still files to come or should this pattern actually match
certain files in the repository, but they are named slightly
different?


Best regards,

Lukas
