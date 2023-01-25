Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3504567BC94
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbjAYUcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbjAYUcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:32:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6834DBEE;
        Wed, 25 Jan 2023 12:32:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A1AE61610;
        Wed, 25 Jan 2023 20:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEC8C433EF;
        Wed, 25 Jan 2023 20:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674678728;
        bh=q0VRdRwpXP7FsVF4ZbtxJ6aYm3asCpN+2fDBGNWxCxI=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=LModYztWvXKNZwQBVMF8CkEsDJTyMgKcUsC1x3db8eMwrEBbvHZCq1EO7F6nvD82E
         a36BmU8DEAqSmD90yOYt7PdvdemfYHZ0IdfKW6qowp66R6bqJ5lnCH2v6rfUYdGUpR
         1wizBF1UqsbA5gVPZxgcl9TRPp/90wEq/o3PQcAq3dMZU8lwdObe/I8ejspQOqasvw
         ERWKE67StJS+iBZUAl/LU8u7NeJdSX2xT8tY14+J6nxiffTz8Bc8JBrxfMAbSHVyH+
         xs0t9BMMp6f/KOjz+EV/QQfO3gSBxPqegNZAhfOAdtqmgQIp5TdsNSg3x5INXB733v
         DanbYiFL1Crqw==
Message-ID: <dfaa9ea3598e9a59d262b4afa7a52999.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <277a46d9-587f-324b-10cf-064302bdd2c5@linaro.org>
References: <20230119130028.106817-1-krzysztof.kozlowski@linaro.org> <b676c36565da1b73c53ced6218ef6de1.sboyd@kernel.org> <277a46d9-587f-324b-10cf-064302bdd2c5@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: clock: qcom,sm8450-camcc: constrain required-opps
From:   Stephen Boyd <sboyd@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Date:   Wed, 25 Jan 2023 12:32:06 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2023-01-21 10:59:21)
> On 20/01/2023 23:15, Stephen Boyd wrote:
> > Quoting Krzysztof Kozlowski (2023-01-19 05:00:27)
> >> Be specific how many required-opps are allowed.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> ---
> >>
> >> This change is independent, although logically is connected with my
> >> dtschema pull:
> >> https://github.com/devicetree-org/dt-schema/pull/95
> >=20
> > Do you want to take it through dt tree?
>=20
> I think it would be better if you take it.
>=20

Ok, applied to clk-next.
