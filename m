Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369076EDA7B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 05:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjDYDIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 23:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjDYDII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 23:08:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94C626BD;
        Mon, 24 Apr 2023 20:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=5Dw9Na84TWf8jr/vXEuscnlwEHuChtKcle30ldSq/8k=; b=aeMSJpuGTRsLI19td2arInmMKa
        eYa2HS9z2qzsxq/RNl8dQ5xFhChA3MDEfaYBn2zOl9VdvWSTK2UMCjpOOdKU5BOkVWHpeiV70wmYf
        uIt/ozvzV27zUmagkn/8mEk+gMJwDEaI13wFyqyHk3w1BiuwaKgtqPLbfaCftYs48bUOW+8F41f+P
        +2cVzfQPkfvPZuf202GXuccanophn3Z8uBjYn4wN1+98xTiwzK9lupN+BueccViFWmPW2lMmPZwvV
        CzXxBp/O1ZiCrtMS+2WgQITYpKu9P55IVb7jk2RXgz5zenwO0i+51Ym54p2vJyMmRto0WiXcDH40g
        GmcUoaQg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pr92C-0004jz-0a;
        Tue, 25 Apr 2023 03:08:04 +0000
Message-ID: <d4479730-60db-5e2f-8448-61e2c0ae5c8d@infradead.org>
Date:   Mon, 24 Apr 2023 20:08:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 4/4] platform/x86: wmi: Add device specific
 documentation
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230424222939.208137-1-W_Armin@gmx.de>
 <20230424222939.208137-5-W_Armin@gmx.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230424222939.208137-5-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/23 15:29, Armin Wolf wrote:
> Add a place for device-specific documentation of WMI drivers.
> The first entry is documentation for the wmi-bmof driver, with
> additional documentation being expected to follow.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  .../ABI/stable/sysfs-platform-wmi-bmof        |  7 ++++++
>  Documentation/wmi/devices/index.rst           | 22 ++++++++++++++++
>  Documentation/wmi/devices/wmi-bmof.rst        | 25 +++++++++++++++++++
>  Documentation/wmi/index.rst                   |  1 +
>  MAINTAINERS                                   |  7 ++++++
>  drivers/platform/x86/Kconfig                  |  4 +--
>  6 files changed, 64 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/ABI/stable/sysfs-platform-wmi-bmof
>  create mode 100644 Documentation/wmi/devices/index.rst
>  create mode 100644 Documentation/wmi/devices/wmi-bmof.rst

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

thank.
-- 
~Randy
