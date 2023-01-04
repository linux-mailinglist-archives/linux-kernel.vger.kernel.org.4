Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A8365D7EF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239831AbjADQJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239758AbjADQIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:08:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053B93B91C;
        Wed,  4 Jan 2023 08:08:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 939A4617A0;
        Wed,  4 Jan 2023 16:08:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70D5C433EF;
        Wed,  4 Jan 2023 16:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672848512;
        bh=7kCvAn5U3yiaqbh6ae/GtIcNV+lKuLqxtoKLOT/FmbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ks/4/BMJ5K+D+Y2wiZxGFRuRWLzFyIWo/idePmv2Ebg0eM/vdpW2K34A8TADQC5NJ
         Hz+wuB2bihBwvRYcgRUQTcfbIF68oQvgpyDHU5aUVx3rAnfU2rVNgA3KifHKuNIpFM
         EB3BwGBMBLyMSM880iZez/WNsy9TImLmCIeTSNg2EFIVYktfOon8/3MjUEv1zw8hY+
         dwrBPLHZBmGAYLILbdm1hGaRNxzxifeRz4n0He4A/dxVzDLcbCPludY41FSfIR1oTZ
         FBYdtYuIUkYiuwYhDx7fao6OjTYTVsX9hoTCY6vEdPTTb3isxo6Ju7HLKgBLx2s6HH
         k0U9acuo5UAMA==
Date:   Wed, 4 Jan 2023 16:08:24 +0000
From:   Lee Jones <lee@kernel.org>
To:     Mark Hasemeyer <markhas@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Raul Rangel <rrangel@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v10 2/3] dt-bindings: mfd: Add compatible string for UART
 support
Message-ID: <Y7WkeCi7/x/t37JM@google.com>
References: <20221207104005.v10.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
 <20221207104005.v10.2.I9e018ecb8bdf341648cb64417085978ff0d22a46@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221207104005.v10.2.I9e018ecb8bdf341648cb64417085978ff0d22a46@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Dec 2022, Mark Hasemeyer wrote:

> From: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
> 
> Add a compatible string to support the UART implementation of the cros
> ec interface. The driver does not support the reg and interrupt
> properties, so exempt them from being required for UART compatible nodes.
> 
> Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
> Co-developed-by: Mark Hasemeyer <markhas@chromium.org>
> Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> Changes in v10:
> - No change
> 
> Changes in v9:
> - Rebase onto for-next
> - Update node-name from uart0 to serial
> - Remove reg and interrupt property requirement for UART compatible
>   nodes.
> - Update authorship
> 
> Changes in v8:
> - Update commit message
> 
> Changes in v7:
> - No change
> 
> Changes in v6:
> - No change
> 
> Changes in v5:
> - No change
> 
> Changes in v4:
> - Changes in commit message.
> 
> Changes in v3:
> - Rebased changes on google,cros-ec.yaml
> 
> Changes in v2:
> - No change
> 
> ---
>  .../bindings/mfd/google,cros-ec.yaml          | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)

I changed the subject line and applied the patch, thanks.

-- 
Lee Jones [李琼斯]
