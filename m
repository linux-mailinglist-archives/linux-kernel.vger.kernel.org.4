Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682406AE019
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjCGNOH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Mar 2023 08:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjCGNNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:13:39 -0500
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0246281CDA;
        Tue,  7 Mar 2023 05:12:13 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id cy23so51879522edb.12;
        Tue, 07 Mar 2023 05:12:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678194696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcWbwYDV8vURZUGRIiHatb53Pd15aln+ErHySas8WwE=;
        b=qXJzLaSNBoxvWQmPzFQwbXeBaK0/w+mqFbMLnZjpeuohMxgRKI88Ftw36SVbQ+a93l
         SNyDrpbbv4Z/9MmeuqAtVLQSdhYy8RMx5h/xew7VwxhpbFnI3la87kHKHgBYCZad/tPh
         JyLBDgwamePE26hvwjoVXSLo2AQGPh2tprToh/RFAX0QqzbGnOM28mjf5uf4/I90FXuY
         vYJa8Ay3eQGrK8m70BR/rUo8TgnTslhh0w89AyI5Ei8iCdnGeyZIQW+BSsANPNPORPiI
         TJZR5nEAz5gbGNSnkpJIRTVLeS1auZnQ2bnJAakUwG01DfkkqTjY5OfkXjKUdkuUvgcD
         h9GQ==
X-Gm-Message-State: AO0yUKXPd0oCN1iMf55zUI5sFhsEDgIuDTIcIwL1QFxwKL4hz+pTYeYR
        lMqXOCxsFVvhdErLSs4FYa9Oe4J4V44kmv98sN0=
X-Google-Smtp-Source: AK7set+VvmehQAGFAgXhSKTqlmkDfoqJGnIfHbhCLx+kzKsOZIrAq+R/RNh9PE9OvN9VzFK8psutsoaXt4s1LOmH7ks=
X-Received: by 2002:a17:906:d041:b0:8b1:3298:c587 with SMTP id
 bo1-20020a170906d04100b008b13298c587mr7118198ejb.2.1678194696101; Tue, 07 Mar
 2023 05:11:36 -0800 (PST)
MIME-Version: 1.0
References: <20230302161212.38142-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230302161212.38142-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Mar 2023 14:11:24 +0100
Message-ID: <CAJZ5v0gxUbBj8iggT5e0YEwpRG=SpoN1t2MVss+i6-peBTDBEw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v1_1=2F1=5D_ACPI=3A_docs=3A_enumeration=3A_Correct_?=
        =?UTF-8?Q?reference_to_the_I=C2=B2C_device_data_type?=
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 5:19 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> I²C peripheral devices that are connected to the controller are
> represented in the Linux kernel as objects of the struct i2c_client.
> Fix this in the documentation.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  Documentation/firmware-guide/acpi/enumeration.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
> index b9dc0c603f36..56d9913a3370 100644
> --- a/Documentation/firmware-guide/acpi/enumeration.rst
> +++ b/Documentation/firmware-guide/acpi/enumeration.rst
> @@ -19,7 +19,7 @@ possible we decided to do following:
>      platform devices.
>
>    - Devices behind real busses where there is a connector resource
> -    are represented as struct spi_device or struct i2c_device. Note
> +    are represented as struct spi_device or struct i2c_client. Note
>      that standard UARTs are not busses so there is no struct uart_device,
>      although some of them may be represented by struct serdev_device.
>
> --

Applied as 6.3-rc material, thanks!
