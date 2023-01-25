Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AB567BE91
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 22:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbjAYVbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 16:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236703AbjAYVbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:31:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3322279B;
        Wed, 25 Jan 2023 13:30:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62132B81BDC;
        Wed, 25 Jan 2023 21:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A74C433D2;
        Wed, 25 Jan 2023 21:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674682197;
        bh=Gvkn27TVndvlLjIXA3MlgXmmFcYs5DdYv/Gy7nAcp8Y=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=r6cxzmTmE9NKvzQLp07En7UgeUtH/sUI+qu5Na4cQuCsEnuXtyu9+hxYXfYwHViKN
         P1DeOJGb+WRgEALEUtt7tYjb3bRsInbgawZg/A/l2DeiT7YDowzi0qfARIx3BQYXwk
         BTQXQ1BEs0MWNtJUPkHkiw6yp4NlybWCncgt4fM+RFrkwrBEZrJI0N80WeueNEcAGz
         SwaPrWLRj2DzLnfl6MImAC2Bu8epTqM+YpAZg01G12tzM4PpkTlgJLiNI0VykxqFgw
         6r32F2PYCDldycoLj3imXZSMZSF18F3vAo2FRUGHysjmVGTp0eIPZcZ2E5IQRbpNvU
         qajZEcU4XxL7w==
Message-ID: <2987f2ce9377bd17d1cd85fce4bd3c28.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230120082631.22053-1-quic_kathirav@quicinc.com>
References: <20230120082631.22053-1-quic_kathirav@quicinc.com>
Subject: Re: [PATCH V5] clk: qcom: clk-alpha-pll: Add support for Stromer PLLs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        Sricharan R <quic_srichara@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
To:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com
Date:   Wed, 25 Jan 2023 13:29:54 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kathiravan Thirumoorthy (2023-01-20 00:26:31)
> From: Varadarajan Narayanan <quic_varada@quicinc.com>
>=20
> Add programming sequence support for managing the Stromer
> PLLs.
>=20
> Co-developed-by: Sricharan R <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
