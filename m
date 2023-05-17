Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61217070F4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjEQSja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjEQSj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:39:28 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7767AA7;
        Wed, 17 May 2023 11:39:16 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4QM2246QrlzyWs;
        Wed, 17 May 2023 21:39:08 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1684348752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8YcIUdxitzihe1t5/ZGI9wvkvaRoi0KQ1Kz7/8cndvM=;
        b=BzxLMX11TUdNJlNteF/kvfYKG3TEVjtCurDgWBTYDdYZKDCEZ9YyAOIQR6+CrneeYyv4ib
        tgv74KUKpnn+QmDxoO641Oxe/FYb5tOSr7fIUglT5RWliWV4/UILXig+2n/iCmGHKXo9LE
        GT58Ldcjv8pgMzsZxNiOqU6hNkjJM6M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1684348752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8YcIUdxitzihe1t5/ZGI9wvkvaRoi0KQ1Kz7/8cndvM=;
        b=xIILG9xexUktDZ/49ewHgLVaOAmhxn3+MdP5YT7g2vanlcaMsSBCvUd4/izV7CSrkIdbxY
        rXivjcUOCRvrevUoVJbC0+ZS4yKrRJxcdVzYyaof2P/42jINz8aEPGquPvx30Wez63EzRM
        KxUQKX8pugKm2srcobeZs0s/+7zet+s=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1684348752; a=rsa-sha256; cv=none;
        b=v3KzjL4T/vcd4IpVf0JO6WN6RbQfWLq+PzjJMPvg3pzKOjjB+tkwwgpeRe9ZPEzhG46TEF
        FNxXniXOogtG6J0m/8OmE6uneLBkNV8Mfzf62y5Cv0WX4Enjzu1j5Tof0WM02WumLXW4Q/
        ovc3DM5euPh/p36XrY/MZG/AewfLYeU=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 28A6F634C94;
        Wed, 17 May 2023 21:39:08 +0300 (EEST)
Date:   Wed, 17 May 2023 21:39:08 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Michael Tretter <m.tretter@pengutronix.de>
Cc:     Jacob Chen <jacob-chen@iotwrt.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Subject: Re: [PATCH RESEND 2/2] arm64: dts: rockchip: Add RGA2 support to
 rk356x
Message-ID: <ZGUfTP1EXtlJbtxJ@valkosipuli.retiisi.eu>
References: <20230119-rk3568-rga-v1-0-43d4d14365e6@pengutronix.de>
 <20230119-rk3568-rga-v1-2-43d4d14365e6@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119-rk3568-rga-v1-2-43d4d14365e6@pengutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

On Fri, Jan 20, 2023 at 10:14:22AM +0100, Michael Tretter wrote:
> The rk3568 also features a RGA2 block. Add the necessary device tree
> node.
> 
> Acked-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>

Can this patch be merged via the media tree? I don't expect merging the
other one via a different tree being an issue either, so alternatively to
the 1st patch:

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Regards,

Sakari Ailus
