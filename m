Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB8A5F3BE5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 05:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJDDyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 23:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiJDDyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 23:54:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F48720BFB;
        Mon,  3 Oct 2022 20:54:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 066E3B818F9;
        Tue,  4 Oct 2022 03:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90338C433D6;
        Tue,  4 Oct 2022 03:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664855643;
        bh=ujHEZHhUHzNSsXzRgFH4/o/r/QxfMcUb/AE7VpSuEYE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YZir0L19tYUe+VrtKeYvi0J/Ph0vvlYOFF7923f4GRBggeJ7IU2P9We8dJSCne0L0
         ng3xLSQKxpS+/Mgjd5plQ4LAKq8wZyZ9rmkBlIVecXK0qsFEEheOQmToceWQXtAX3X
         2LoMM8NMKAr7wYjlXwuOIVm237C1JkHubazFreCAC1CbpIkemy1qe6K3vZBXO4jMat
         exsyVRoNCnX9m4u4tKiolXbf/+LiAAqgumJWnGxSCVKTpuH3hpbiGwmAQAgDCktChg
         Ad3QiUpwAHimeu6onGld1RxPowpMDQHek6mPDURapjncaAYr3QdxVEwLPLlrqYqhF/
         hCBsi2milcHEg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221003211438.25691-1-konrad.dybcio@somainline.org>
References: <20221003211438.25691-1-konrad.dybcio@somainline.org>
Subject: Re: [PATCH] clk: qcom: gcc-sm6375: Remove unused variables
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Konrad Dybcio <konrad.dybcio@somainline.org>, agross@kernel.org,
        andersson@kernel.org, linux-arm-msm@vger.kernel.org
Date:   Mon, 03 Oct 2022 20:54:01 -0700
User-Agent: alot/0.10
Message-Id: <20221004035403.90338C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Konrad Dybcio (2022-10-03 14:14:38)
> gcc_parent_data_15 and gcc_parent_map_15 are not used in this driver.
> Remove them.
>=20
> No Fixes tag, as the commit introducing it is still in -next.
>=20
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---

Applied to clk-next
