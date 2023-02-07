Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2165268E073
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjBGSrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjBGSrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:47:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C86159C0;
        Tue,  7 Feb 2023 10:46:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5395AB81A12;
        Tue,  7 Feb 2023 18:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F209C433D2;
        Tue,  7 Feb 2023 18:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675795615;
        bh=79Ve8zbRSZKXUOr26T060d7rk1wu/IUoUiO3VoAxXac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=imfyLm/8XLyx7W4hNcJ8UkbdKqdEXUgXCD2omuZN2z6yBad2IUuR04SxYRxX9Vv4d
         9eGFGxuP4X32xfvf0VD3vdruzFEgqW1WY+PYkt6VUn65C5QYeVuFgTNvPH5faR7jdh
         klZwa9QzmN6E/c0y86i3At1MXKQGMT28+Hq76KZBNd2LSaFFtciGJGrS5nekLB98mL
         M1M+xuRJCLW+bFdcfyzSeHxjzqJX+96zXBsnbe5obhNu6XoYoGW65WmMISDjz+jp0o
         LNJ1GVQhCi/65TGqXJXNrYecK7j+htJLkGRtlma6gzyrr857T5wbl49j43lRqCU9tc
         wASALxsFZwbZQ==
Date:   Tue, 7 Feb 2023 10:46:53 -0800
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        thunder.leizhen@huawei.com, festevam@gmail.com
Subject: Re: [PATCH v4] dt-bindings: leds: Document commonly used LED triggers
Message-ID: <Y+KcndmBBQw16hfM@google.com>
References: <20221129174906.97749-1-manivannan.sadhasivam@linaro.org>
 <41ade5cb-98c1-e859-be4d-68eb05d0ea44@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41ade5cb-98c1-e859-be4d-68eb05d0ea44@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Feb 2023, Krzysztof Kozlowski wrote:

> On 29/11/2022 18:49, Manivannan Sadhasivam wrote:
> > Document the commonly used LED triggers by the SoCs. Not all triggers
> > are documented as some of them are very application specific. Most of the
> > triggers documented here are currently used in devicetrees of many SoCs.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> > 
> > Changes in v4:
> > 
> > * Removed the sorting of triggers
> > * Removed the "items" as they were not needed
> > * Reworded the description
> > * Dropped Zhen Lei's tested-by tag as the patch has changed
> > * Added kbd-capslock trigger
> 
> Any plans for this patch?

Who are you asking?

This patch is not in my inbox.

-- 
Lee Jones [李琼斯]
