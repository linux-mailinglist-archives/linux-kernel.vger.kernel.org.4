Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F95679537
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjAXKb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbjAXKb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:31:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EE13F2BB;
        Tue, 24 Jan 2023 02:31:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9462B80EA9;
        Tue, 24 Jan 2023 10:31:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA936C433D2;
        Tue, 24 Jan 2023 10:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674556283;
        bh=h6wqmaeSg72818E0HuM8wvDpwZQKe1MLEUh3fylym74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qOeJ8B3malNs8GmcREBHPjGGsuPcJbrrt1JGKdLHNCH1YhQS20WjWTEBMOOva9FGF
         apXKxTTgUq/2dAGom0s22T9+BcfEaBvvJG4t8iyd6Gy67bySXFALPapgEG1g3dJYKL
         4RdL0u0HxeZ8kpo8kX8so9Kfg663/SBoMp2aN/jm6skdR4U50mjT8QSnw0Ejqqu+Ak
         eHzOI3ZnqZaB2qyVZ4sLLAobvB2RCwmjQYgr/4ZXYP9+7UuAXanhB0KKuvJT9HtkH1
         b2pcZYdGoAa6q5CN5VBnbWcgih3TiIaTGrzGTOAyXW/4tzIZnirKN9LHU3I4OhxMtW
         5kKuUezJSxpGQ==
Date:   Tue, 24 Jan 2023 10:31:16 +0000
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH v3 3/5] dt-bindings: usb: Convert OMAP OHCI/EHCI bindings
 to schema
Message-ID: <Y8+zdODQTEyKGwpd@google.com>
References: <20230110-dt-usb-v3-0-5af0541fcf8c@kernel.org>
 <20230110-dt-usb-v3-3-5af0541fcf8c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230110-dt-usb-v3-3-5af0541fcf8c@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2023, Rob Herring wrote:

> The OMAP OHCI and EHCI USB host bindings follow the generic binding, so
> add the compatibles and remove the old txt binding docs.
> 
> The examples in omap-usb-host.txt don't match actual users, so update
> them dropping the fallback compatible.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v3:
>  - Fix document references to generic-ehci.yaml and generic-ohci.yaml (0-day)
> v2:
>  - New patch
> ---
>  .../devicetree/bindings/mfd/omap-usb-host.txt      |  8 +++---

Acked-by: Lee Jones <lee@kernel.org>

>  .../devicetree/bindings/usb/ehci-omap.txt          | 31 ----------------------
>  .../devicetree/bindings/usb/generic-ehci.yaml      |  1 +
>  .../devicetree/bindings/usb/generic-ohci.yaml      |  4 ++-
>  .../devicetree/bindings/usb/ohci-omap3.txt         | 15 -----------
>  5 files changed, 8 insertions(+), 51 deletions(-)

-- 
Lee Jones [李琼斯]
