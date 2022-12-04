Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA0B641D6B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 15:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiLDOTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 09:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiLDOTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 09:19:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67704167DC;
        Sun,  4 Dec 2022 06:19:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D291B80926;
        Sun,  4 Dec 2022 14:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE22BC433D6;
        Sun,  4 Dec 2022 14:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670163588;
        bh=xZkBew3Fuzfr7oqLmJurxFUhwqQkOLe/nyGcHc7MpRg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bj1BZvhuCNkAy1H1CgFN67WZm50icZdB10u5wEJsTgawtHXhUwbp1OUstlD3GwKXn
         r2YkySc7rj/o1zasuvwv0t5WfHY0CEc5MARW2v99HmLvrvngmWdL3kBs+gw+ZdoVtx
         6Qy2SuQ7uzjpX0I6eywH+bnDGS4zy9igsqFOdsJqEiCupWvCuYOhtbSbPJrGI8DjCT
         EBbEYCBu8hJV9Ryw/LgWKcky+5D3CYju8agv4UGnLJgD/i9nVsIv2nUPK827eNEN+/
         vBblcVS5HB1hHvoUFOImjlr7LYfvz49g/OtvUc8vjjiKuAEuFPTphnSkM71KmxzZ+L
         LiOLtylS3KJiw==
Date:   Sun, 4 Dec 2022 14:32:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Leonard =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>,
        kernel@pengutronix.de, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: add TI LMP92064
 controller
Message-ID: <20221204143234.77fd74ee@jic23-huawei>
In-Reply-To: <997ba29d-6fc3-529a-c069-3688d5a72bc8@linaro.org>
References: <20221128133503.1355898-1-l.goehrs@pengutronix.de>
        <997ba29d-6fc3-529a-c069-3688d5a72bc8@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Nov 2022 22:25:20 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 28/11/2022 14:35, Leonard G=C3=B6hrs wrote:
> > Add binding documentation for the TI LMP92064 dual channel SPI ADC.
> >=20
> > Signed-off-by: Leonard G=C3=B6hrs <l.goehrs@pengutronix.de>
> > ---
> >  =20
>=20
>=20
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Series applied to the togreg branch of iio.git. This is now 6.3 material
as the merge window will open soon so we've missed this cycle.

For now I'll push out as testing to let 0-day look at it prior to rebasing
the branch on rc1.

Thanks,

Jonathan
>=20

