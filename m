Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911445BADB6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiIPM7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiIPM7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:59:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB253E44;
        Fri, 16 Sep 2022 05:59:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9B2F1D34;
        Fri, 16 Sep 2022 05:59:36 -0700 (PDT)
Received: from mail-lj1-f175.google.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1579A3FA27;
        Fri, 16 Sep 2022 05:59:30 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id p5so25902822ljc.13;
        Fri, 16 Sep 2022 05:59:30 -0700 (PDT)
X-Gm-Message-State: ACrzQf1EL/V/NA7W0+bb0ejSfuWzbhiJa5Xsj/EfYxxGCtOyPXlm0lyv
        /U6dIeHnfqh3nHLw3dmTvYNKqkyFTb69dNXXfVI=
X-Google-Smtp-Source: AMsMyM5zb6sbg9Akkoeqw41O3a7tT0OI2on/RoHYCjx2kWfVMfp2wj0n2s9pGIfAXPaS0tVRCfGQzWwVjaFensa6SiY=
X-Received: by 2002:a2e:8e78:0:b0:26b:fa73:914f with SMTP id
 t24-20020a2e8e78000000b0026bfa73914fmr1441949ljk.57.1663333164717; Fri, 16
 Sep 2022 05:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220916111912.42733-1-vijayenthiran.subramaniam@arm.com> <f8c9a6ce-aec8-e13a-7c68-93152bf67383@arm.com>
In-Reply-To: <f8c9a6ce-aec8-e13a-7c68-93152bf67383@arm.com>
From:   Vijayenthiran Subramanian <vijayenthiran.subramaniam@arm.com>
Date:   Fri, 16 Sep 2022 12:59:08 +0000
X-Gmail-Original-Message-ID: <CAC0BY-derD+ekgbVzqDbWH7aG44h5ZifFqB4mPg=i8a2bRZ7GQ@mail.gmail.com>
Message-ID: <CAC0BY-derD+ekgbVzqDbWH7aG44h5ZifFqB4mPg=i8a2bRZ7GQ@mail.gmail.com>
Subject: Re: [PATCH] coresight: acpi: add support for amba dma-330 controller
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Vijayenthiran Subramaniam <vijayenthiran.subramaniam@arm.com>,
        rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        thomas.abraham@arm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Fri, Sep 16, 2022 at 11:46 AM Suzuki K Poulose
<suzuki.poulose@arm.com> wrote:
>
> Hi
>
> nit: on subject. This has no relation to CoreSight. This
> could be :
>
> acpi: amba: Add support for xyz.

Ack. Will send a v2.

>
>
> Suzuki
