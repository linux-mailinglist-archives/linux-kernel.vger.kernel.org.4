Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D942768E310
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 22:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjBGVjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 16:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjBGVjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 16:39:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3790625E33;
        Tue,  7 Feb 2023 13:39:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3EB9B819B5;
        Tue,  7 Feb 2023 21:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3364BC433EF;
        Tue,  7 Feb 2023 21:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675805945;
        bh=X9FmzFpavaMPEya4hOTMSIodokCbf5ETtvdZDmHKjuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=foMtLIZLc9CQzHcey4t+Tw8H4iaHubna8jHxLoFS3ngVW3x7nvd+cVG+NeFrcd7yI
         Hmfa3z1o8EFtB0uAcv6YbqPCvttnR0Q/8VFho2PwwkAP0EkHD5fwZZXdN74p7R6L3j
         8sPuW8uCy9DjIKUNNtQi/DXhDsIeZw2D87xfFzDYLQRcd/s5udgfTibTDUWdXhijg9
         mOtOHacqmsM8fNH7v8rDp4bCmEdCfzcXtEvYUA9OUAQsERAlwTeOF65Ygu7N44kOhC
         fHqG/xvuleo/qV0orTUP+/LB+QoBwkpprlMczN2xIY+Cz40VpTrGV9BiN3M+WX7/nw
         oXd5CPJsoFpkA==
Date:   Tue, 7 Feb 2023 13:39:03 -0800
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        thunder.leizhen@huawei.com, festevam@gmail.com
Subject: Re: [PATCH v4] dt-bindings: leds: Document commonly used LED triggers
Message-ID: <Y+LE9/H7tsr42Q0H@google.com>
References: <20221129174906.97749-1-manivannan.sadhasivam@linaro.org>
 <41ade5cb-98c1-e859-be4d-68eb05d0ea44@linaro.org>
 <Y+KcndmBBQw16hfM@google.com>
 <639db6ae-c7de-eec2-de4f-516aba471d47@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <639db6ae-c7de-eec2-de4f-516aba471d47@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Feb 2023, Krzysztof Kozlowski wrote:

> On 07/02/2023 19:46, Lee Jones wrote:
> > On Tue, 07 Feb 2023, Krzysztof Kozlowski wrote:
> > 
> >> On 29/11/2022 18:49, Manivannan Sadhasivam wrote:
> >>> Document the commonly used LED triggers by the SoCs. Not all triggers
> >>> are documented as some of them are very application specific. Most of the
> >>> triggers documented here are currently used in devicetrees of many SoCs.
> >>>
> >>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >>> ---
> >>>
> >>> Changes in v4:
> >>>
> >>> * Removed the sorting of triggers
> >>> * Removed the "items" as they were not needed
> >>> * Reworded the description
> >>> * Dropped Zhen Lei's tested-by tag as the patch has changed
> >>> * Added kbd-capslock trigger
> >>
> >> Any plans for this patch?
> > 
> > Who are you asking?
> > 
> > This patch is not in my inbox.
> 
> Mani and Pavel. I Cc-ed you just for completeness.
> 
> I would expect Mani to rebase and resend it.

Yes, please do that.

-- 
Lee Jones [李琼斯]
