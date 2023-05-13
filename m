Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F358E7017FF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 17:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239292AbjEMPOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 11:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjEMPOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 11:14:11 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D2E2704
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 08:14:10 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id cad2b6cb-f1a0-11ed-b972-005056bdfda7;
        Sat, 13 May 2023 18:14:02 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 13 May 2023 18:14:01 +0300
To:     Sukrut Bellary <sukrut.bellary@linux.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi:pic32: Fix missing error code 'ret' in the failure
 path
Message-ID: <ZF-pOdkzE88--xdm@surfacebook>
References: <20230513122653.45226-1-sukrut.bellary@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230513122653.45226-1-sukrut.bellary@linux.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, May 13, 2023 at 05:26:53AM -0700, Sukrut Bellary kirjoitti:
> smatch warning -
> drivers/spi/spi-pic32.c:634 pic32_spi_dma_prep() warn: missing error code 'ret'
> 
> Currently in case of pic32_spi_dma_config() failure, SUCCESS is returned.
> Capture and return the error code in the failure path.

The comment above the pic32_spi_dma_config() call on the caller side suggests
that DMA is optional. With that in mind the current code won't prevent us from
using the driver in PIO mode.

> This is based on static analysis only. Compilation tested.

That's why I think it's incorrect fix. You need to fix smatch.

-- 
With Best Regards,
Andy Shevchenko


