Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AB86E9070
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbjDTKjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbjDTKjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:39:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB798A7F;
        Thu, 20 Apr 2023 03:36:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14D0C64732;
        Thu, 20 Apr 2023 10:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92792C433D2;
        Thu, 20 Apr 2023 10:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681987015;
        bh=w0fd5yrWbjgttI2C+r5ejTi50O12PXHjFCdNN7uEFpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n6aosSq9fPEr4/jLahDzC1ZKlp8tPrGhuOAZp2erXS5vwf2huzEuM9tYOiBQPujtY
         XSvoMqwiRWzu8z3PBDBeKl5aOSZJb1s9IVdDBG7e+uFHVkCo4w7xAMobV3NN305e1M
         66FHhOyxA39CgKHHOkwy0uhiRVpshv0b3rpzuXaIotZjRiYBMKgucpKXkuuSdQ4tW3
         0N21PB0nBNnhcz63jLrCAdsa+0nXgh9vsqet7SJdlH5kTXTMkMIlGynRKNTTSaguj+
         q98PQk5sAQqUtwSqtxgv1XLrVQ7j+orEI8AvfsnzPoM44r0VYKkr2oMRHtDcPr5q7T
         2wOBBH9A+qlmg==
Date:   Thu, 20 Apr 2023 11:36:50 +0100
From:   Lee Jones <lee@kernel.org>
To:     Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2] dt-bindings: mfd: stm32: Remove unnecessary blank
 lines
Message-ID: <20230420103650.GJ9904@google.com>
References: <20230417181342.v2.1.I483a676579cc7e3ac07e1db649091553743fecc8@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230417181342.v2.1.I483a676579cc7e3ac07e1db649091553743fecc8@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023, Patrick Delaunay wrote:

> Remove double blank line.
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
> 
> Changes in v2:
> - update commit title and commit message to reflect what the change is
>   V1="dt-bindings: mfd: stm32: Fix STM32F4 DT include file"
> 
>  include/dt-bindings/mfd/stm32f4-rcc.h | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
