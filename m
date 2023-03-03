Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2F36A9584
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCCKoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCCKoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:44:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C4C12F31;
        Fri,  3 Mar 2023 02:44:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67A0BB81850;
        Fri,  3 Mar 2023 10:44:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E380CC433EF;
        Fri,  3 Mar 2023 10:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677840287;
        bh=O9t6rwod73Y+QwLDs83WoFzGVxISsuSBLntV5bsTQ14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GUdjn9Sx3Sd5ovumypjljB8z106VrnUudiKYP4a9uS2k2PgGh+dnMlyNfN8P7tduH
         lnrSL/B3oUFuedkTbxJSAf/oqIEjbO9z74DmRV/+tCG4bz0h1M5dQVE5grbT2Zo/tS
         idSYPWUr1S1ehSoqCZixHoBYmQxZFRcdfMBozj2jSgJa3C9hiKnkrp2TsQuRFViX81
         h3W2r/7TdQb9xlvQ0lPCqR37uxz4NRcTGS4GiwuPadcyRNjAenbKVMuyQNxFMSsZ13
         gBbiEbnZAvITa+0xdkRp+27MVrlStSq2eDmXNDe3nyfywFyN9DTnnbus82UmOZWxTM
         0C85VbVI3ktVw==
Date:   Fri, 3 Mar 2023 10:44:42 +0000
From:   Lee Jones <lee@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] mfd: qcom-pm8008: Remove workaround for a
 regmap-irq quirk
Message-ID: <20230303104442.GV2303077@google.com>
References: <20230216222214.138671-1-aidanmacdonald.0x0@gmail.com>
 <20230216222214.138671-5-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230216222214.138671-5-aidanmacdonald.0x0@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2023, Aidan MacDonald wrote:

> Remove pm8008_init(), which according to the comments exists only
> as a workaround for regmap-irq's odd treatment of type registers.
> This workaround shouldn't be needed anymore because this driver
> uses config registers, which are always programmed by regmap-irq
> no matter what the initial register state is.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/mfd/qcom-pm8008.c | 30 ------------------------------
>  1 file changed, 30 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
