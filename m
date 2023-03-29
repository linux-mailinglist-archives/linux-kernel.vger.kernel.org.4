Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530036CF277
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 20:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjC2StY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 14:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjC2StX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:49:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9E059F3;
        Wed, 29 Mar 2023 11:49:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A201E61CEC;
        Wed, 29 Mar 2023 18:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2547C433D2;
        Wed, 29 Mar 2023 18:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680115753;
        bh=5p6YnGsD+1poKvYeYhGjDRM8SQYk9DWmK37TyDldT0Q=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=V/NDO6FCrLjrVJNrxEhpRRkX/CW6bgG86pTgXFxjtAVUJGpGPs/yUdSEXpx9Ua7FS
         Xnq0W5NV1q4vERS0ULX5pPdcUKmeT91caL2aJay/EaBJ8fkK6CE+XpTxhhEa6usCMO
         keYa1nI4dAKHRj7uDfM8kVcpQSSNqFh6x5QUo1LQGRaTT+VZXPgb76+y7TXywD9b1k
         M2Z9kPto0fA082woTpnmVWyD380kBT4gJZIdn6D3tCEunzI5XhBhTzIzCEOtpsrXee
         NVbY1LaTDLp5B15t3WKW4jo+6z6a7Lt6E61GvVmb0UWDKZmvevlyur5/EYmFlhSENq
         y9B4Qu707In7g==
Message-ID: <e91f5bee6815d60301473c069ad7199c.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230307132928.3887737-1-konrad.dybcio@linaro.org>
References: <20230307132928.3887737-1-konrad.dybcio@linaro.org>
Subject: Re: [PATCH v2] clk: Print an info line before disabling unused clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, agross@kernel.org,
        andersson@kernel.org, linux-arm-msm@vger.kernel.org
Date:   Wed, 29 Mar 2023 11:49:10 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Konrad Dybcio (2023-03-07 05:29:28)
> Currently, the regulator framework informs us before calling into
> their unused cleanup paths, which eases at least some debugging. The
> same could be beneficial for clocks, so that random shutdowns shortly
> after most initcalls are done can be less of a guess.
>=20
> Add a pr_info before disabling unused clocks to do so.
>=20
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

Applied to clk-next
