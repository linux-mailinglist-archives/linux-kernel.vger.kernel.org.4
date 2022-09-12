Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E255B6329
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 23:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiILV4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 17:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiILV42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 17:56:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DBC4DB19;
        Mon, 12 Sep 2022 14:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=qeScmlSI8Hi8VVYRvf9aNKdlS+V7Mh8b/pcQ1tMazl4=; b=h0TIXi8rk3Oq+o1oppxN9crjkW
        I6+Vy0ALGJv3j1R0EsfAgysvp9GJC0NXpqoh+4uyIyyscGZuw56P5cfq14tRXa6Fy04uPsbiotmR7
        g3vZ/sl1+OsiYl32F0lPYvjvhZH6Z4pJPaPytub1uV0IjDFk+EageOIjDC3+Qq/aPISDnEaLZ0fIC
        pgR25ntwkSeL8ul/g47jKm342pdTw1C3vtmgiv7ULwodTPnh+SbQHTiQQ30Kcys+ofQwql2B5pGVA
        LEJk1740hi5XuHAnSCcJkPZrLVI0pcACUQbP+QTtZOYQwzdR/Xi0OTIJMzasxIxEUIXbaD1YcHue2
        zXSP2PpQ==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oXrPY-00EPu2-Lx; Mon, 12 Sep 2022 21:56:13 +0000
Message-ID: <b1b794b4-f6c3-7697-5d5a-b811809a9313@infradead.org>
Date:   Mon, 12 Sep 2022 14:56:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 5/5] platform/x86: dell: Add new dell-wmi-ddv driver
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, hmh@hmh.eng.br,
        matan@svgalib.org, corentin.chary@gmail.com, jeremy@system76.com,
        productdev@system76.com, platform-driver-x86@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220912125342.7395-1-W_Armin@gmx.de>
 <20220912125342.7395-6-W_Armin@gmx.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220912125342.7395-6-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 9/12/22 05:53, Armin Wolf wrote:
> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
> index 25421e061c47..209e63e347e2 100644
> --- a/drivers/platform/x86/dell/Kconfig
> +++ b/drivers/platform/x86/dell/Kconfig
> @@ -189,6 +189,19 @@ config DELL_WMI_DESCRIPTOR
>  	default n
>  	depends on ACPI_WMI
> 
> +config DELL_WMI_DDV
> +	tristate "Dell WMI sensors Support"
> +	default m

You should (try to) justify default m, otherwise just
don't have a default for it.

> +	depends on ACPI_BATTERY
> +	depends on ACPI_WMI
> +	help
> +	  This option adds support for WMI-based sensors like
> +	  battery temperature sensors found on some Dell notebooks.
> +	  It also supports reading of the batteries ePPID.
> +
> +	  To compile this drivers as a module, choose M here: the module will
> +	  be called dell-wmi-ddv.

-- 
~Randy
