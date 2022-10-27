Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C9D6104BF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237059AbiJ0Vvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237047AbiJ0Vvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:51:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5B26FA29;
        Thu, 27 Oct 2022 14:51:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA783B827B3;
        Thu, 27 Oct 2022 21:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA71C433D6;
        Thu, 27 Oct 2022 21:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666907501;
        bh=t5fiZPd8YqRPakj+Z4a+yqrq/UBh6ClTJeeNuWXkERs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JE5DmVNp+1GU7FThHB5o8iMjKXhJZUnz7luxyvWhA79p54eUs6byQ9yW+hjLdFN0L
         bY+/LCNfEp4caeODt50ZHgsFoFLlvDUF9QBdNIr9Jp0dDy3iqJ+v/toon7UQiPMWVp
         a6hyn9xIggZSC78oc0wEpYfazS1qrRqXmbgYiRD108na4dMEBSk8TS0xq2pIG7xNYL
         y7kBo/uXYjHXMLWWebGB4kOShe0a4muFsW6lPObKJ2IO96mwHD+2FWEE8vbS/vBjav
         PrAlVhk6XVOvCyZGNUnoJhsV71Y9+n5AgRqnvHyvW94a/dsa5sL3fRUsNeSCISRbSN
         CKd6BeLXyYlCw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221027192024.484320-2-lis8215@gmail.com>
References: <20221027192024.484320-1-lis8215@gmail.com> <20221027192024.484320-2-lis8215@gmail.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: ingenic: Add support for the JZ4755 CGU
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
To:     Siarhei Volkau <lis8215@gmail.com>
Date:   Thu, 27 Oct 2022 14:51:39 -0700
User-Agent: alot/0.10
Message-Id: <20221027215141.7AA71C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Siarhei Volkau (2022-10-27 12:20:21)
> Add documentation for the clock generation unit (CGU)
> of the JZ4755 SoC.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
> ---

Applied to clk-next
