Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942E86A6E55
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjCAOZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCAOZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:25:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7F059E9
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:25:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13D816125A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 14:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFD0C433EF;
        Wed,  1 Mar 2023 14:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677680718;
        bh=N7017ys/7onMG03q2uDc2cModYYDm6BvV3pNEkUmdBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MrTLn69zFLjjAozScFaRP/UlyvbasmO+v7bGqArufjzXlqgD+1Le5GthVVuudmQhZ
         7MupH1wGN4SdmT49pNYqqdY9x4Q90pdcHIO+n/d3wJ48pa0LqfgeZz5JCUPIRcqI2e
         0dZGHi4Bc2fp+y+MZD9TO6z6UYr23Rwwo3nVT7seMZqW23RZwA5mJPkO0BycJWSd1f
         h6S/2ev55N7aZxKenUCNJoCNj9OgiaBOEgAPf+tReSxvNBKnG6wzGrU/ckUKltO7xv
         EQD8G3+aqdsSczIkI3ZTq+Xffurw7QoFv8fI48adSJMjA24Nmo9RTFrllFpBXOx+U+
         o1MdM0C5Uddng==
Date:   Wed, 1 Mar 2023 14:25:14 +0000
From:   Lee Jones <lee@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mfd: intel_soc_pmic_chtwc: Add Lenovo Yoga Book X90F
 to intel_cht_wc_models
Message-ID: <Y/9gSnKz69m8sUV9@google.com>
References: <20230301095402.28582-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230301095402.28582-1-hdegoede@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Mar 2023, Hans de Goede wrote:

> The Android Lenovo Yoga Book X90F / X90L uses the same charger / fuelgauge
> setup as the already supported Windows Lenovo Yoga Book X91F/L, add
> a DMI match for this to intel_cht_wc_models with driver_data
> set to INTEL_CHT_WC_LENOVO_YOGABOOK1.
> 
> When the quirk for the X91F/L was initially added it was written to
> also apply to the X90F/L but this does not work because the Android
> version of the Yoga Book uses completely different DMI strings.
> Also adjust the X91F/L quirk to reflect that it only applies to
> the X91F/L models.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mfd/intel_soc_pmic_chtwc.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
