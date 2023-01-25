Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C73E67C089
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 00:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbjAYXA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 18:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjAYXAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 18:00:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D301713DD8;
        Wed, 25 Jan 2023 15:00:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E9AEB81C55;
        Wed, 25 Jan 2023 23:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2922CC433D2;
        Wed, 25 Jan 2023 23:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674687621;
        bh=RZksb65p0COvQF0t0733KNOTzQrC/hPGvtjudMm7qIw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=KG+P6oi76PcsMbhOHkhtWTkaqTl0yrOxQLKNJ9uoB/Zoi3L0Wyslfptmz49fVIJgB
         ovbXowfC0jy9c6ho58PvqGWeyeB7F8IGV1bUwfGh1KoG4xv+2erniNbpEdVxYB4hB7
         9s6Ccv3ferDUP6aPmjNRyodxdfEsURyCRLYADCgcQTKU+M52pRphsO7vZrxD4yImD1
         bVqVpX+5Er6gtDHTb+Ls44qFse2d9N3jy5YGMI5IqiiVMwRdfifWT8dYchfSTzskh6
         keBzE3bW6bq+2hrJmcBvING8m2F80bXgKZYsoHx3cAny3wwJmQQXLpbTd/GiGYDwbS
         q0xxzpxGf/HTg==
Message-ID: <a7058fb92642a1661995d7d3ca6411bd.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4c531c68-b74f-2f90-e8f6-98a4b0316cd4@ansari.sh>
References: <20230121192540.9177-1-rayyan@ansari.sh> <20230121192540.9177-2-rayyan@ansari.sh> <06d53a3fa48080d902476b71308e69bd.sboyd@kernel.org> <4c531c68-b74f-2f90-e8f6-98a4b0316cd4@ansari.sh>
Subject: Re: [PATCH v4 1/3] clk: qcom: smd: Add XO RPM clocks for MSM8226/MSM8974
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
To:     Rayyan Ansari <rayyan@ansari.sh>, linux-arm-msm@vger.kernel.org
Date:   Wed, 25 Jan 2023 15:00:19 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rayyan Ansari (2023-01-25 14:25:08)
> On 25/01/2023 20:58, Stephen Boyd wrote:
> > Quoting Rayyan Ansari (2023-01-21 11:25:38)
> >> Add the XO and XO_A clocks to the MSM8974 clock list, which is also
> >> used on MSM8226.
> >=20
> > Why was this missing for so long? Does this break suspend? Why are you
> > adding it now?
>=20
> I am adding it because of a recommendation from a maintainer on an older =

> patch version.
> See=20
> https://lore.kernel.org/linux-arm-msm/20230119023337.h6a7f56lizhv4tcy@bui=
lder.lan/#t

So nobody has tested this on msm8974? Can you add this information to
the commit text? And can it be tested on msm8974?
