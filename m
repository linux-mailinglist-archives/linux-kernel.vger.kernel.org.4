Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6F65E8EAA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 18:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbiIXQ4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 12:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiIXQ4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 12:56:07 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CD28284D;
        Sat, 24 Sep 2022 09:56:06 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id j8so1863922qvt.13;
        Sat, 24 Sep 2022 09:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=2alwuq6T22+l7tsq01aDJyHbKbwXThP2O3Hb5R6vV1k=;
        b=0XxHv7XKFiwJRKC2biTa27VhWduWPHj5c5o6Mlpag0GBAvhLTHVeTU/yckdxS6+O0S
         QyM5umhHR6hEtfgGSSWmNllRiY+F1Q3/nBTL6LT3dsFvzSDVd7AUBsHtG56r8zCFhL1R
         rHBIQOEZead6oO7JWISwmgMWT1M8ymDHoEox54tqoOnGdQrzApUe2bYAH3//gUlSUbf1
         mcqdDnW3wEUwn0UW8IzteOVwpQZaWHdhKotc6pBGYRGhuOZ47Y6oLsr+hAYSOpUORZe4
         7WOQG8Z6GQLM4oIEYWWRyQYUzlJXeZ8ytHVlJ5mh05ymP75Gn0BuaZWd8yvHD1NcRxw8
         v2EQ==
X-Gm-Message-State: ACrzQf16DO1F6DbBryNC7+YWsd5JYJ38pMcwDB3dJ1l8+iLduUGuxYCp
        zxkrFGK652dPUFhyLBZWu+I6uNvPc1/PeDj685j6dIrI
X-Google-Smtp-Source: AMsMyM7e+nM+Fe1kxjW+74yG7wpTMJUfczsapG40d1OOl6rctBor6/OHKirmTh2tqxVkZo3h2ljWJ5iJkpYu3Y1dLF8=
X-Received: by 2002:a05:6214:f24:b0:4ac:a9fd:8b42 with SMTP id
 iw4-20020a0562140f2400b004aca9fd8b42mr11467783qvb.22.1664038565511; Sat, 24
 Sep 2022 09:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220921143244.16282-1-vijayenthiran.subramaniam@arm.com> <20220921144854.ug2adlz4ofglxp7c@bogus>
In-Reply-To: <20220921144854.ug2adlz4ofglxp7c@bogus>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 24 Sep 2022 18:55:54 +0200
Message-ID: <CAJZ5v0ikzf22Kgq728vvjpXAgt5fHN4bQwQA=qf=9t99sRwftA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: amba: Add Arm DMA-330 controller to the
 supported list
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Vijayenthiran Subramaniam <vijayenthiran.subramaniam@arm.com>
Cc:     Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        thomas.abraham@arm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 4:49 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Sep 21, 2022 at 08:02:44PM +0530, Vijayenthiran Subramaniam wrote:
> > Add ACPI ID for ARM DMA-330 controller to AMBA id supported list to
> > allow the probing of the device.
> >
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>
> Rafael,
>
> I assume you will pick this up as usual through your tree.

Sure.

Applied as 6.1 material with under edited subject, thanks!
