Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5995C0024
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 16:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiIUOnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 10:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiIUOm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:42:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67D2415720;
        Wed, 21 Sep 2022 07:42:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B92FC1FC4;
        Wed, 21 Sep 2022 07:43:02 -0700 (PDT)
Received: from mail-lf1-f52.google.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F3E03FB2A;
        Wed, 21 Sep 2022 07:42:56 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id o2so9563962lfc.10;
        Wed, 21 Sep 2022 07:42:55 -0700 (PDT)
X-Gm-Message-State: ACrzQf0GgcDbs+4XVqsmjF6oVteHmrQlrUdNdYxUacc6jVoLbagPBQI2
        D0u6nqDpu5ngaRMR4VASkw+9+VAXTQX2N5DgLGM=
X-Google-Smtp-Source: AMsMyM790hR1Uc42ms4FeVutq1kH1DNtec2Z2EPKfLP9D4Jo3umawZLN02/pspdSpgB6OILhBxMTFX/k4ZJlOzetnzg=
X-Received: by 2002:a19:7411:0:b0:49f:517c:9889 with SMTP id
 v17-20020a197411000000b0049f517c9889mr9105780lfe.283.1663771370682; Wed, 21
 Sep 2022 07:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220916111912.42733-1-vijayenthiran.subramaniam@arm.com> <20220916130035.pbavnjlkh4envc4u@bogus>
In-Reply-To: <20220916130035.pbavnjlkh4envc4u@bogus>
From:   Vijayenthiran Subramanian <vijayenthiran.subramaniam@arm.com>
Date:   Wed, 21 Sep 2022 14:42:38 +0000
X-Gmail-Original-Message-ID: <CAC0BY-fpRTie=CA+kOK2aRYdchZDiMOmUvyykA+aNEgmyAB9mA@mail.gmail.com>
Message-ID: <CAC0BY-fpRTie=CA+kOK2aRYdchZDiMOmUvyykA+aNEgmyAB9mA@mail.gmail.com>
Subject: Re: [PATCH] coresight: acpi: add support for amba dma-330 controller
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Vijayenthiran Subramaniam <vijayenthiran.subramaniam@arm.com>,
        rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org, suzuki.poulose@arm.com,
        thomas.abraham@arm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On Fri, Sep 16, 2022 at 1:06 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Sep 16, 2022 at 04:49:12PM +0530, Vijayenthiran Subramaniam wrote:
> > Add ACPI ID for ARM DMA-330 controller to AMBA id list to allow the
> > probing of the device.
> >
>
> $subject pattern is simply wrong and I see this is just copied from the
> previous commit which makes no sense here. You can see other commits
> and their patterns too.
>
> Use prefix something like:
> ACPI / amba:
> or
> ACPI: amba:
>
> Also "Add .." in the $subject sounds like you are adding the support for
> the controller here which is not the case.
>
> Enable support for Arm Primecell PL330 dma controller
> Or
> Add Arm Primecell PL330 dma controller to the supported list

Ack.

I have posted v2 with the subject:
[PATCH v2] ACPI: amba: Add Arm DMA-330 controller to the supported list.

>
> --
> Regards,
> Sudeep
