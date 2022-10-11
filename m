Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4155FA990
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 03:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJKBCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 21:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJKBCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 21:02:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19ED77A515;
        Mon, 10 Oct 2022 18:02:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A92F0B811AB;
        Tue, 11 Oct 2022 01:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5309BC433C1;
        Tue, 11 Oct 2022 01:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665450154;
        bh=zcXH80VIubUtjARujJgG86GwyASuWetjqOesyQMJLlQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=vFAocQy/EhmJpjmLNiQL61LMYwzOZhhzWMzTABGB7vVwYkUfIty1ucREoBORIFlhY
         xMgwquU/eHb3Gvzz1URmTgt1SrwSGEOMElor6gkH64lX7bp/tSndMJkOT9RsD2GLta
         w4GNwD4FlPSMf494o7Tc1RSLWSj8JSL9iMIINaePCF/MHI1TbkZL4OhSN40kNO30NY
         47IIr8gQ9mTkagXGECj8qMIpJw78Arq+CxoJKPKFOKfkAa9VuM/Yk6S8q7WSw2tQDG
         5O33MWtu3Tbs6yCVzN7l0M+Od35m9jy4F0jE2feZeN+xRmZ50DQzCyogxA360nzyRf
         dBQi97uu7f7GA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221010155546.73884-1-konrad.dybcio@somainline.org>
References: <20221010155546.73884-1-konrad.dybcio@somainline.org>
Subject: Re: [PATCH] clk: qcom: dispcc-sm6350: Add CLK_OPS_PARENT_ENABLE to pixel&byte src
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Date:   Mon, 10 Oct 2022 18:02:32 -0700
User-Agent: alot/0.10
Message-Id: <20221011010234.5309BC433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Konrad Dybcio (2022-10-10 08:55:46)
> Add the CLK_OPS_PARENT_ENABLE flag to pixel and byte clk srcs to
> ensure set_rate can succeed.
>=20
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---

Any Fixes tag?
