Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EDC6F94B8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 00:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjEFWJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 18:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjEFWJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 18:09:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CAF1D94A;
        Sat,  6 May 2023 15:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=7Nqo5bKfuTZba1hZN68GWMHPj4YsyKzg7tKEqE/0XMo=; b=cnCchV7wfZz3LVTKwt/fyWKBUA
        jRAo1TsWPoxS5NO/QJuTVLqghxqboaPpI0W5UfX5WfAJnL9Kl5m8b1TnKjRj2/cQylTAbc6CO8JoL
        XA0D5OeRB8KEHgYX7RsPXVDkSC56Ho8JI/0cwxfsDTQg5nUeIwbByHSZfVf1D/LbkPccc+3T7sYk4
        N1IXnyjFXHh4Lb9L1FSj2KpRT3Zj1S7VFnswbZGhDb6c83ck6Lg9x4FNkWJjn2IM1stkAeaqezUtg
        /Dy1KYp+vW67z+veJz4k/SXUdRk2GPHklQ3ZuOZt/4lxAknUMkdiA9dxT7tTw8S9s+ojPui0lq35I
        TC1+KVQQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pvQ5e-00ET1N-1F;
        Sat, 06 May 2023 22:09:18 +0000
Message-ID: <4b0249cd-7538-6df4-777b-d25a72f06668@infradead.org>
Date:   Sat, 6 May 2023 15:09:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2] docs: dt: Make references and mention kernel
 abstractions
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
References: <20230505-dt-docs-refresh-v2-1-56bf359c53b4@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230505-dt-docs-refresh-v2-1-56bf359c53b4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I am noting a few grammar nits below...

[and + linux-doc]

On 5/5/23 05:43, Linus Walleij wrote:
> This document is named "Linux and Devicetree" so I think we
> should write a bit more about how the device tree fits into
> the Linux kernel frameworks these days after we have created
> the fwnode and swnode.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> These docs are old and outdated and need to be edited to
> reflect the current situation.
> ---
> ChangeLog v1->v2:
> - Spelling mistakes
> - Resend because nothing happens
> ---
>  Documentation/devicetree/usage-model.rst | 45 +++++++++++++++++++++++++++++---
>  1 file changed, 41 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/usage-model.rst b/Documentation/devicetree/usage-model.rst
> index b6a287955ee5..37605cb549cf 100644
> --- a/Documentation/devicetree/usage-model.rst
> +++ b/Documentation/devicetree/usage-model.rst
> @@ -75,7 +75,44 @@ out of mainline (nios) have some level of DT support.
>  If you haven't already read the Device Tree Usage\ [1]_ page,
>  then go read it now.  It's okay, I'll wait....
>  
> -2.1 High Level View
> +2.1 Linux Kernel Firmware Abstractions
> +--------------------------------------
> +
> +The Linux kernel supports several different hardware description
> +frameworks and DT is just one of them. The closest sibling is the
> +:ref:`Documentation/firmware-guide/acpi/index.rst ACPI`
> +DSDT (Differentiated System Description Table).
> +
> +To make it possible to write a device driver that will adapt to DT
> +or other hardware description models, the kernel has grown some
> +abstractions, first and foremost the firmware node API, exposing
> +device properties. The firmware node "fwnode" internals can be found
> +in ``<linux/fwnode.h>`` while the device driver-facing API can be
> +found in ``<linux/property.h>``. The idea is that if a driver is using
> +the firmware node API, it should be trivial to support DT and ACPI
> +DSDT alike in the same driver.
> +
> +The fwnode framework also makes it possible to modify and extend the
> +Linux in-kernel model with software-managed nodes "swnodes" to apply
> +quirks or manage registration of devices that cannot be handled any
> +other way. This API can also be found in ``<linux/property.h>``.
> +
> +Further, when the DT core register devices these need to fold into the

                        core registers

> +Linux device driver model, which essentially means that some kind of
> +``struct device`` has to be created to match a corresponding
> +``struct device_driver``. This API can be explored in
> +detail in :ref:`Documentation/driver-api/driver-model/index.rst the driver API documentation`
> +but what you need to know is that the Linux DT parser code will on its
> +own mostly spawn platform devices and AMBA devices on the platform
> +and AMBA bus respectively, and apart from that it will augment devices
> +spawn on other buses where applicable.

   spawned

> +
> +Every Linux kernel subsystem that want to supply additional data to

                                that wants

> +detected devices using the device tree, or that want to provide

                                              that wants

> +resources to other devices in the DT, will need to implement calls into
> +the DT abstractions.
> +
> +2.2 High Level View
>  -------------------
>  The most important thing to understand is that the DT is simply a data
>  structure that describes the hardware.  There is nothing magical about
> @@ -97,7 +134,7 @@ Linux uses DT data for three major purposes:
>  2) runtime configuration, and
>  3) device population.
>  
> -2.2 Platform Identification
> +2.3 Platform Identification
>  ---------------------------
>  First and foremost, the kernel will use data in the DT to identify the
>  specific machine.  In a perfect world, the specific platform shouldn't
> @@ -180,7 +217,7 @@ However, this approach does not take into account the priority of the
>  compatible list, and probably should be avoided for new architecture
>  support.
>  
> -2.3 Runtime configuration
> +2.4 Runtime configuration
>  -------------------------
>  In most cases, a DT will be the sole method of communicating data from
>  firmware to the kernel, so also gets used to pass in runtime and
> @@ -217,7 +254,7 @@ On ARM, the function setup_machine_fdt() is responsible for early
>  scanning of the device tree after selecting the correct machine_desc
>  that supports the board.
>  
> -2.4 Device population
> +2.5 Device population
>  ---------------------
>  After the board has been identified, and after the early configuration data
>  has been parsed, then kernel initialization can proceed in the normal
> 
> ---
> base-commit: 457391b0380335d5e9a5babdec90ac53928b23b4
> change-id: 20230505-dt-docs-refresh-515edbdbbd01
> 
> Best regards,

For @linux-doc: Is there something in ReST that does auto section numbering
so that this renumbering does not have to be repeated in the future?


Thanks for the additional documentation.
-- 
~Randy
