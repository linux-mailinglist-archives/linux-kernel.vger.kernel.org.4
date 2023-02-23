Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9666A0BA3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbjBWOPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjBWOPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:15:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1916B54A1D;
        Thu, 23 Feb 2023 06:15:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C725AB81A31;
        Thu, 23 Feb 2023 14:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0197BC433EF;
        Thu, 23 Feb 2023 14:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677161746;
        bh=3yE9cBw7btwrfszgHuljFDDAK2lDLslRo8oj6IAz5dI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N/R10CfbZr62IET1sfkf2wfs0kkpLrrfHOB3kxTxzMwAvnK7NR388xCdfa4fGfikC
         g+Ns3U5n0EwswyGMHaTi2px4hHpZo/3R3Bib5TE9gZEyYZmWd7qjVXwBIkgH8wHd3n
         PWSvDcDKcN5+N/5kt0JWu1vQxUf8TB7FER1yvdj0iqh7RPKtMEGmhZst4tqI3T5Thr
         AznlSSaaRdd3YdVfSqNmL+F4wfCy/r0m1fq3MbUXVOq9BIqO1PD1ZV3ZWJ9SQMnWac
         PsLKgdOscTXjRPNJHDmXVdeg+4C8hckPXpkxSvnza93/vLmjIJn10Yf3ya9YXAIaNu
         PPEjjXbc36DkA==
Date:   Thu, 23 Feb 2023 14:15:41 +0000
From:   Lee Jones <lee@kernel.org>
To:     David Virag <virag.david003@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH 2/2] rtc: s5m: Drop S5M8763 support
Message-ID: <Y/d1DY/mXe7R5q8W@google.com>
References: <20230131183008.4451-1-virag.david003@gmail.com>
 <20230131183008.4451-3-virag.david003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230131183008.4451-3-virag.david003@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2023, David Virag wrote:

> The S5M8763 MFD has no device tree compatible, and since board file
> support for it was removed, there's no way to use this MFD. After
> removing the remaining code for it from the MFD driver, also remove
> support for it in the s5m RTC driver, and all remaining references to
> it.
> 
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---
>  drivers/rtc/rtc-s5m.c            | 82 ++------------------------------

>  include/linux/mfd/samsung/core.h |  1 -
>  include/linux/mfd/samsung/irq.h  | 50 -------------------

Acked-by: Lee Jones <lee@kernel.org>

>  3 files changed, 3 insertions(+), 130 deletions(-)

-- 
Lee Jones [李琼斯]
