Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78325674BBE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjATFHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjATFGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:06:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D34F11641;
        Thu, 19 Jan 2023 20:54:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74DB5B82482;
        Thu, 19 Jan 2023 14:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4207DC433D2;
        Thu, 19 Jan 2023 14:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674137965;
        bh=nHFbFijfAK88CEeJ3L488W0Py49g4R3Feb8a7Q7xov0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dFOMC1Q6bTTJFPLlpRnM0iksgfXztxrKd3MX+LBKkzZA3FVrYP8JvM/I8JGtUYac3
         dafX+hxkx6Pn6SmJq5cSpc7OPCiwD+2f3yAQvup7A7JfS1Lb9XDD543FOrrg9xgqb9
         2YAoyODvMUcaUTc3YB1uFwDzVek0xo710To1OF7GpD5Zxa8v7t1YrWJ1h0bsrLerpK
         sCq9nFgucq8G/WZ5qkxzSGk5NsuNFp32qrNdYd3CR8ZqwhQnz6qs4QK9HiiGv0P4Xu
         nGieUsJ0Xi48MdiEreSf7APLx/TS/Jv67DIDHhj7/pKY5YAMQkJo5bL7xFQFomO2vN
         zLj+hHeT+9izQ==
Date:   Thu, 19 Jan 2023 14:19:14 +0000
From:   Lee Jones <lee@kernel.org>
To:     Brad Larson <blarson@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, brad@pensando.io,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        davidgow@google.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v9 05/15] dt-bindings: mfd: syscon: Add
 amd,pensando-elba-syscon compatible
Message-ID: <Y8lRYnfLgL8SbZmW@google.com>
References: <20230119035136.21603-1-blarson@amd.com>
 <20230119035136.21603-6-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230119035136.21603-6-blarson@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2023, Brad Larson wrote:

> Add the AMD Pensando Elba SoC system registers compatible
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
