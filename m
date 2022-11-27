Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657B3639DA1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 23:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiK0WnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 17:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiK0WnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 17:43:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1F363D6;
        Sun, 27 Nov 2022 14:42:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6617260F0D;
        Sun, 27 Nov 2022 22:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFE6C433D6;
        Sun, 27 Nov 2022 22:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669588978;
        bh=xPml7px6Oku3roIslNdkT4oQ4o/v9f557wuY4c/VBBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mj/Bxd/KQUQnElBEBNTwy87wMnyw+ToUpT0zzu2QRRWCOjjq1zIRYcQZDolRjKkdA
         uwZ/H4G5+mbO+da1x36Y+Y8g3dFOtKQ5FWZyhNK1ppL8RUKYnAg/2qyeTvUEXc054M
         a5HYJdjL5ePRM9ycXu/OH8sfsaKB5Cw+9O0xvHiHbGFkalIASpo+QKcZDNb0zebYwe
         MNINzhKoJOcmEQJCHpEQynQ2Uuiz7pCErommCVZ33x0nh+wRVJOnvA9OgyGA+59jfh
         6u1k9qi7yE/UjBRdVRBgJeIsCI43NIl71SbJBtcs3gC3LOPwecB325RSoq6R5pcjO0
         LkAWfqGWj1i0A==
Date:   Sun, 27 Nov 2022 23:42:55 +0100
From:   Pratyush Yadav <pratyush@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     robh+dt@kernel.org, akpm@linux-foundation.org,
        herbert@gondor.apana.org.au, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, broonie@kernel.org,
        qyousef@layalina.io, arnd@arndb.de, atishp@atishpatra.org,
        anup@brainfault.org, tkhai@ya.ru, quic_abhinavk@quicinc.com,
        vasily.averin@linux.dev, baolin.wang@linux.alibaba.com,
        colin.i.king@gmail.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at
Subject: Re: [PATCH] MAINTAINERS: Update email of Tudor Ambarus
Message-ID: <20221127224255.uw66dpsl7o757tg6@yadavpratyush.com>
References: <20221122125244.175295-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122125244.175295-1-tudor.ambarus@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/22 02:52PM, Tudor Ambarus wrote:
> My professional email will change and the microchip one will bounce after
> mid-november of 2022.
> 
> Update the MAINTAINERS file, the YAML bindings, MODULE_AUTHOR entries and
> author mentions, and add an entry in the .mailmap file.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Acked-by: Pratyush Yadav <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav
