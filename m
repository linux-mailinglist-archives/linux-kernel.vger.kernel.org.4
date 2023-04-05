Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52276D81C8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237929AbjDEP1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbjDEP1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:27:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A1B59E2;
        Wed,  5 Apr 2023 08:27:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1878462846;
        Wed,  5 Apr 2023 15:27:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C336C433EF;
        Wed,  5 Apr 2023 15:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680708463;
        bh=ZJ164SnGgqIvXyjNNV6hdkEgoumLpXWqRzQfJEslbyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AkpWeNScttPdj2sshYPtKjTL45rilXQgp2j0Ogxq32B4OFuAWqTJtcIOrfniU9tXs
         IJp3XzmtGrOSCWVXdn/JpHYoqU0Uv0FSKW/pBgTI5n58Sz18n1Uf8t8Q+3IJ0clHjC
         yGxe2ltW3F87uyoyvVkHIKIE7MnbdNG9WCqCNUlNreQJevarw0/Llskc/IR4MKPdkt
         vHlOilgLiklygioe7sns7juZYiE/71sEL9FXjap7ilmNyn1S9MO+vuxUt/brUtUPtw
         vQW5F8lh7BTKmSX9x6eEMpWIAA3LQ8FAjYaZYBrSaEugKDSHcywcqrwd69bTEh2qgg
         YztXv+g1A6udg==
Date:   Wed, 5 Apr 2023 16:27:37 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jacky Huang <ychuang570808@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH v6 05/12] dt-bindings: mfd: syscon: Add
 nuvoton,ma35d1-sys compatible
Message-ID: <20230405152737.GP8371@google.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
 <20230328021912.177301-6-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230328021912.177301-6-ychuang570808@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2023, Jacky Huang wrote:

> From: Jacky Huang <ychuang3@nuvoton.com>
>
> Add Nuvoton ma35d1 system registers compatible.
>
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

--
Lee Jones [李琼斯]
