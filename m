Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4203E67C2A3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 03:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjAZCFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 21:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjAZCFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 21:05:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BE75EFA3;
        Wed, 25 Jan 2023 18:05:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F447B81CA1;
        Thu, 26 Jan 2023 02:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C67C433EF;
        Thu, 26 Jan 2023 02:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674698717;
        bh=1ZKDHuzqTTMDm+ZaUKoQD2C9STYg5gBiSN93t16ynUA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=A+oKlTIbk0kTs3W5bmBB2K38oQmsJ+0jBj+4w80VAarnUd2SfPKCQNFC0jUJOhm/1
         S9yO9Uw6ihKbKgpdlDP7+M8FMRvd8p28FeuuNyJ1lVV2QBHI7x3BXrNTD9YWAnTh0s
         ACS0PoyuirJiOdW4XkQmEttvTfUjmDn0yH+en2qeEvqnsVbYXDt/IPhZnkdeCT/cjP
         0YlWU7GxA3N7/Dgo6twPSAiO7MjVVko/Wt3JI05R+PZpz2A7otESldBckFb222Gmrj
         V9QER2yYMAFX1dw5k4XxUGTg+La4PF8Pxb5copYde+8IaniV6lETBwQ8oS1W++5KGH
         pYTXm7KFg9M9Q==
Message-ID: <124f081819a80482b3bffd8e12d747fc.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8ae4469e-ed2c-5019-605b-013a49af77ea@gmail.com>
References: <20230118031509.29834-1-moudy.ho@mediatek.com> <20230118031509.29834-2-moudy.ho@mediatek.com> <8ae4469e-ed2c-5019-605b-013a49af77ea@gmail.com>
Subject: Re: [PATCH v6 1/4] dt-bindings: arm: mediatek: migrate MT8195 vppsys0/1 to mtk-mmsys driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Wed, 25 Jan 2023 18:05:15 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Brugger (2023-01-19 08:08:48)
>=20
>=20
> On 18/01/2023 04:15, Moudy Ho wrote:
> > MT8195 VPPSYS 0/1 should be probed from mtk-mmsys driver to
> > populate device by platform_device_register_data then start
> > its own clock driver.
> >=20
> > Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
>=20
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
>=20
> Stephen, if you want I can take 1/4 and 3/4 through my tree. 3/4 shouldn'=
t be a=20
> problem, not sure about this patch. In any case if you want me to do so, =
I'd=20
> need a Acked-by from you.

Do you need to take them? I'm picking up mediatek patches currently so I
can probably just take 1 and 3 if there isn't any build dependency.
