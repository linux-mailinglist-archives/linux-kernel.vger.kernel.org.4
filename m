Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62896609B50
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiJXH2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJXH2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:28:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5284260698;
        Mon, 24 Oct 2022 00:28:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A146B80E23;
        Mon, 24 Oct 2022 07:28:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F55C433D6;
        Mon, 24 Oct 2022 07:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666596523;
        bh=MffOR/T1WlwBDzbjXkfystAwGNvGe8P+IC3A3If7o5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q5i1WtCjy5doyPithNm34nm+si6W2TtLLdf2O/tOxLIuj6LoTbKiN/C/BHKJM85iB
         tGtrSZwyVFp/i/AcmlvTWBaJCtq1YnJdqszyOvuQe7L2c7wA+Pdigi8Ku4iPqHR51J
         YIYu5pJqDgySkPctizIjq+Zff846aFixg145uzYs5Gc/f87BDt1ZJydVf7TPhx9YKt
         j0JriiRDIjhsq7q4jqKkloVHe7hojophBApSpwj91NM1YN663kA5/f1UPVZaH27e9s
         W2OJjVh2mSeODdKT+wKmuIC75dkeEt6OleqB67ScgGo7VgdpTL9i07rPY2f+HFWwc4
         CIG5BRFZkTogA==
Date:   Mon, 24 Oct 2022 08:28:35 +0100
From:   Lee Jones <lee@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 07/21] power: remove s3c adc battery driver
Message-ID: <Y1Y+o2aDz2Cd+ZG8@google.com>
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-7-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221021203329.4143397-7-arnd@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2022, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The s3c-adc driver is removed along with the s3c24xx platform,
> so the battery driver is no longer needed either.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  MAINTAINERS                            |   7 -
>  drivers/power/supply/Kconfig           |   6 -
>  drivers/power/supply/Makefile          |   1 -
>  drivers/power/supply/s3c_adc_battery.c | 453 -------------------------
>  include/linux/s3c_adc_battery.h        |  39 ---
>  5 files changed, 506 deletions(-)
>  delete mode 100644 drivers/power/supply/s3c_adc_battery.c
>  delete mode 100644 include/linux/s3c_adc_battery.h

Any idea why I was Cc'ed on this (and only this) patch?

-- 
Lee Jones [李琼斯]
