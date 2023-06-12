Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A3372D40C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbjFLWEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 18:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238394AbjFLWEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:04:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E79C19B4;
        Mon, 12 Jun 2023 15:04:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 550AB62F81;
        Mon, 12 Jun 2023 22:04:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546E0C433EF;
        Mon, 12 Jun 2023 22:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686607456;
        bh=o8pg4ZX5DZm8yL8MwC3nddKosjqNfwdqs0rYWMpPiUQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Q6YQsEzd9JlSwSQuTPKSi41xOwDSQSZyvys1KyQrM6IpWVwhbmvdwyrkTolGwTApu
         TTcmmd/sHJNEnabJSpkhKedY+SN9266MlGkn9fLzQytY107gQOFJYS1+7XnMF7H8g2
         gWAQb/Ox4PMyxwbxRcOiKL0X1iI+z2MUKwKIlnFbO2bBL+jXuZ28muj9FYdYn/2o7o
         9h+rT4BfJPRXEcMLVZRH7lICNn1RyTjM9/xiW07EUyXALdwKFGfzolBQHLAkAg5DiK
         dHgXSrQUKD3pG5CbJnYoaYNKio2U/6pGJO6jhncKjXFJbP0H48WajWh3cIMwUTMliz
         M5h3jF5tsm4rw==
Message-ID: <624a2280-a16e-749c-9351-17284d505cd3@kernel.org>
Date:   Tue, 13 Jun 2023 07:04:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 3/3] ata: ahci_platform: Make code agnostic to OF/ACPI
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20230612161011.86871-1-andriy.shevchenko@linux.intel.com>
 <20230612161011.86871-4-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230612161011.86871-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/23 01:10, Andy Shevchenko wrote:
> With the help of a new device_is_compatible() make the driver code
> agnostic to the OF/ACPI. This makes it neater. As a side effect
> the header inclusions is corrected (seems mod_devicetable.h was
> implicitly included).
> 
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

