Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48A0654E7A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbiLWJhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236016AbiLWJhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:37:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB7027160;
        Fri, 23 Dec 2022 01:37:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F64D61EA6;
        Fri, 23 Dec 2022 09:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0093BC433D2;
        Fri, 23 Dec 2022 09:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671788237;
        bh=ckXdHWJd/D6qXTZkeUPCk20HE7jxoBJNUZFN5wXvubk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Trp7hRjTB87tqXW9da3OQmi7spGvJmWKW6Qd7PEfQnfLvZYTQpK6li7UY5PHcFt+Z
         H42pEGymqFZ6hwdv+BN632uhBa8+fBjJD8GCJwNidomhxLW5U5HHw/lnD70KsnFD++
         GtpH1hltlKUPxQCp3uyE0qfvRMxG9CELcebNZ1cLN8U+0suy3oKR7RtdZjDGicoZXE
         M9T6Wtcu02F4S0kJd9C+VMy2d9TDGM3BWluLgoopSAKp22wqFnUEmSVGaFFaDVJwm4
         e+osHeGXyZV9rJ5NWlznJjoqqzEZFoqLplcUfuPBLq6CwPXggez2Pb8pL1sXL9Scgx
         Htal40UbnEMXA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p8eVF-0002oB-W4; Fri, 23 Dec 2022 10:38:10 +0100
Date:   Fri, 23 Dec 2022 10:38:09 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Brian Masney <bmasney@redhat.com>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        quic_shazhuss@quicinc.com, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com
Subject: Re: [PATCH v3 2/7] arm64: dts: qcom: sc8280xp: rename qup2_i2c5 to
 i2c21
Message-ID: <Y6V3ATrELEfCWNVJ@hovoldconsulting.com>
References: <20221220192854.521647-1-bmasney@redhat.com>
 <20221220192854.521647-3-bmasney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220192854.521647-3-bmasney@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 02:28:49PM -0500, Brian Masney wrote:
> In preparation for adding the missing SPI and I2C nodes to
> sc8280xp.dtsi, it was decided to rename all of the existing qupX_
> uart, spi, and i2c nodes to drop the qupX_ prefix. Let's go ahead
> and rename qup2_i2c5 to i2c21. Under the old name, this was the 5th
> index under qup2, which starts at index 16.
> 
> Note that some nodes are moved in the file by this patch to preserve
> the expected sort order in the file. Additionally, the properties
> within the pinctrl state node are sorted to match the expected order
> that's typically done in other DTs.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> Link: https://lore.kernel.org/lkml/20221212182314.1902632-1-bmasney@redhat.com/
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
