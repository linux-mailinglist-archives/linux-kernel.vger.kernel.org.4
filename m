Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D026E9167
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbjDTLCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbjDTLBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:01:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAFB8698;
        Thu, 20 Apr 2023 03:59:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 801F3647B0;
        Thu, 20 Apr 2023 10:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957A1C433EF;
        Thu, 20 Apr 2023 10:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681988344;
        bh=38GdaOC/ZdsLruczbK6dZAmJPEO/Z19GwYh7RGf94T8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r5eHJyx34GhxJIkKbtNxdWPJ2p5RIfjz09FFsSdtJKyiVigc2w3W5wZOwvfHvbNFi
         ARMirrK+wJL2QxB9j3J3fG6rXY1L0vhbdKkMW8gJNIYZEmFfU+cAWs7UwgUy2I8Gga
         UUkrKuqtRbOsyrT/dNZ9sWtO2jw6qB2Ia4k46QbOyDl1cGrwI27KHCi6GUv3LHafpy
         neDIDEjfMBHLcDHb7MJrAtvVAhCliPvqVr7gf3gwBdloF1zMyRWNZfrYqzWueRilxP
         K76hMiIHBdHBAzEADc42uBZDTySZkx5TSpfxzO85A48g4yTIEUu+S3h+IDG6tXIQJM
         uedDm6N7VQckQ==
Date:   Thu, 20 Apr 2023 11:58:59 +0100
From:   Lee Jones <lee@kernel.org>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        DLG-Adam.Thomson.Opensource@dm.renesas.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
Subject: Re: [PATCH v3 3/3] dt-bindings: mfd: dlg,da9063: document voltage
 monitoring
Message-ID: <20230420105859.GL9904@google.com>
References: <20230403-da9063-disable-unused-v3-0-cc4dc698864c@skidata.com>
 <20230403-da9063-disable-unused-v3-3-cc4dc698864c@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230403-da9063-disable-unused-v3-3-cc4dc698864c@skidata.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Apr 2023, Benjamin Bara wrote:

> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> Document that the da9063 only provides under- *and* over-voltage
> monitoring in one, and therefore requires both to be configured with the
> same severity and value. Add an example for clarification.
> 
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> ---
>  Documentation/devicetree/bindings/mfd/dlg,da9063.yaml | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
