Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3D96C4E59
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjCVOoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjCVOn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:43:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CC46544F;
        Wed, 22 Mar 2023 07:42:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D809B81D16;
        Wed, 22 Mar 2023 14:42:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F80C433A0;
        Wed, 22 Mar 2023 14:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679496140;
        bh=jhJueB/1YrrZQH3plQccA0lyUO6gBVkwPKqvwy9qYmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V3FfifU7a4zJDoCB8iithYM2fGoJRH/FcOuTtvm5Ibmy1HS5ie+EuxMSCK9131wU6
         mJOitSQaEditBpJg+NA4BgBS8rrwjo34f/BNKnmFYL8a/hE6JhegTNmmmUhcGMTVpr
         TekKKjnpjoZtjqHy57tAw8p5b4lburbFnVDu+TfT73/jERb5tnOhVUNk5ZSE+gOHxS
         sog8F3q/RiXzKyHDUf/OhCEQNGl8Tb5fvkU0aC3Yd3Xfy4CHGa4RHsfM4lwBLkFmCy
         M6os17Jeo1i5RtaVEjMCmHpqqrw9yz0XLfWZQTm/ORDKw0NTxBx74P0CrhX3wESnXM
         9lHfeNvjmgIEg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        marijn.suijten@somainline.org
Subject: Re: (subset) [PATCH v2 1/3] clk: qcom: gcc-sm6375: Update the .pwrsts for usb gdsc
Date:   Wed, 22 Mar 2023 07:45:11 -0700
Message-Id: <167949631653.1081726.2869819428689611150.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307123159.3797551-1-konrad.dybcio@linaro.org>
References: <20230307123159.3797551-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Mar 2023 13:31:57 +0100, Konrad Dybcio wrote:
> The USB controller on sm6375 doesn't retain its state when the system
> goes into low power state and the GDSCs are turned off.
> 
> This can be observed by the USB connection not coming back alive after
> putting the device into suspend, essentially breaking USB.
> 
> Work around this by updating the .pwrsts for the USB GDSCs so they only
> transition to retention state in low power.
> 
> [...]

Applied, thanks!

[1/3] clk: qcom: gcc-sm6375: Update the .pwrsts for usb gdsc
      commit: 03b49487130ed907db787dc7b4e39392f077861b
[2/3] clk: qcom: gcc-msm8996: Update the .pwrsts for usb gdsc
      commit: 78a2f2a04fb5f1182f03f2ed1f9433982f66346f
[3/3] clk: qcom: gcc-msm8998: Update the .pwrsts for usb gdsc
      commit: 83fddbcc833766d02d8bcdb3a3866f0c20b02349

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
