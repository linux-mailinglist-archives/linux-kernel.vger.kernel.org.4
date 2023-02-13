Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3400B693B64
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 01:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjBMAfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 19:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjBMAfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 19:35:50 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C3BEFBF;
        Sun, 12 Feb 2023 16:35:49 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id n25-20020a9d7119000000b0068bd8c1e836so3279417otj.3;
        Sun, 12 Feb 2023 16:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xwk1XI4T0qnu1n1jfvnzGZ0v5aWuLGABipmobiXhSvg=;
        b=ko+7ji5/CfLIBMNtmGWzudXwb2KQc8WHDKqDX6UsmbKxHtjGBm186rRMijEvnoC0Ui
         zzaukjr0YTrfW23RBrhmoc0o2H8YIPo5jFXpUVN7Oq7UfdIHGLaxTBWmPPzGcFsHUlqg
         idmb4ahWYcDJGitHWwgK5tG3gkethjw5IHo1YOIidmIKiGHiKNHAQIvdFIJoncCC1Gww
         NeIoQjCWRsisIaIutyL20ogwpvugBZ1Eblwa8OD30BWx9JijWWzNO7EheeI3XvrXAUh7
         So+wdqr23YVx0g1t/fmfJu35F936LCddjsGvWY15ooD8kXMiHud/0yiFgaeptb0lBuJ9
         xqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xwk1XI4T0qnu1n1jfvnzGZ0v5aWuLGABipmobiXhSvg=;
        b=JsL46bbdyIoaRNDDRmFowC4j+PicbRHjXPdRsRiHXefZ61JkXoFhPLTsF4kI/EpEaS
         IgcOxiapfvdLmoeinJCY5NBMaCN93KQu8poi5zZxFO/tE2c9Vh9rKGTukmirsBoI5hZz
         NsenhRw+4dMICImBtAh0Wp4Qrs/dlmGkhKY7kirysXGFHLrn9nN2uTdBmgvHHbHm+0wa
         w5Y5u8KqHcuaglCehroEB2b0YQnk//cgM89xHfMRzOnw/VB57erD2CbZB6q2Ndr4xsQk
         D8NyfHQ/KAEMaCVPcKMTrGMRIdYqIVK0hlQ4wXZJSBrQ8r3/t5Lz4u9j+F0WeELX8GMo
         6YGw==
X-Gm-Message-State: AO0yUKUumrV32BVus66QrqeOXph68PksfhGN2qVgjWJaI2JtWbuVbh1N
        pOQ9TRIScJtlr1n1XGAu6pQ=
X-Google-Smtp-Source: AK7set9ePtxr+butsPUWLN6x1vNMrrqbFO6H5nZXoYU7jVLvrylRt44a7j9blEGfSdrMnisoyzx9rA==
X-Received: by 2002:a05:6830:54:b0:684:c243:8584 with SMTP id d20-20020a056830005400b00684c2438584mr7001820otp.2.1676248548546;
        Sun, 12 Feb 2023 16:35:48 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t15-20020a9d748f000000b0068d3ec1427bsm4649781otk.69.2023.02.12.16.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 16:35:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 12 Feb 2023 16:35:46 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] ACPICA: Replace fake flexible arrays with flexible
 array members
Message-ID: <20230213003546.GA3280303@roeck-us.net>
References: <20230127191621.gonna.262-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127191621.gonna.262-kees@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 27, 2023 at 11:16:25AM -0800, Kees Cook wrote:
> One-element arrays (and multi-element arrays being treated as
> dynamically sized) are deprecated[1] and are being replaced with
> flexible array members in support of the ongoing efforts to tighten the
> FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
> with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.
> 
> Replace one-element array with flexible-array member in struct
> acpi_resource_extended_irq. Replace 4-byte fixed-size array with 4-byte
> padding in a union with a flexible-array member in struct
> acpi_pci_routing_table.
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/acpica/acpica/pull/813
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

This patch results in boot failures of 32-bit images.
Reverting it fixes the problem.

On the failing boot tests, I see messages such as

ACPI: \_SB_.GSIA: Enabled at IRQ 117440528
ERROR: Unable to locate IOAPIC for GSI 117440528
ahci 0000:00:1f.2: PCI INT A: failed to register GSI

ACPI: \_SB_.GSIG: Enabled at IRQ 117440534
ERROR: Unable to locate IOAPIC for GSI 117440534
8139cp 0000:00:02.0: PCI INT A: failed to register GSI

Given that 117440534 == 0x7000016, that looks quite suspicious.
Indeed, after reverting this patch, the messages are different.

ACPI: \_SB_.GSIA: Enabled at IRQ 16
ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 6 ports 1.5 Gbps 0x3f impl SATA mode

ACPI: \_SB_.GSIG: Enabled at IRQ 22
8139cp 0000:00:02.0 eth0: RTL-8139C+ at 0xd0804000, 52:54:00:12:34:56, IRQ 22

Guenter
