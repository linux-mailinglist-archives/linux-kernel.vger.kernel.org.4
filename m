Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4B26572D6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 05:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbiL1Ejd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 23:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbiL1Ehu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 23:37:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E04EE21;
        Tue, 27 Dec 2022 20:37:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21109B81253;
        Wed, 28 Dec 2022 04:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09A1C433F0;
        Wed, 28 Dec 2022 04:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672202238;
        bh=zK4KG+wi5Wa08lcLF0tB8OlbmsQ5n/OSo7cZ9RjgR+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ST04L/w8jEMQGWrWMKn5gS66mPGnrtLU/YZNVL8/aDtqBLRm0jIecoRvXRp+v5Yus
         NaK0hIdSce74g02Ipnlb2tmnxo49YizZBnyQ2tWO2H3iWzbG3OL+JdeipARdyXrzP5
         +Fueq/1WIqtjGh80Z/p+xrg6Nj1vAX004iScYUYfLxpXqIY+F5KrCMQs/8ChOFUO/8
         6ax7jRoIIMKEyo5V/j2IrqU7xpl2GWmv6qNyxoO0FhIyCMGc3k2yrcaHFD8VJAwVgE
         neOPJKHOzJkyKbVWr3bMW/NV289g2dBboDbeKZflRTO2jCWn/4dilxfR5RLrXFhdeS
         MNQbQlmocytvw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     konrad.dybcio@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, luca@z3ntu.xyz,
        Martin Botka <martin.botka@somainline.org>,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, jami.kettunen@somainline.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, kholk11@gmail.com
Subject: Re: [PATCH] arm64: dts: qcom: pmi8950: Correct rev_1250v channel label to mv
Date:   Tue, 27 Dec 2022 22:36:53 -0600
Message-Id: <167220221232.833009.2894100544345630055.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221209215437.1783067-1-marijn.suijten@somainline.org>
References: <20221209215437.1783067-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Dec 2022 22:54:37 +0100, Marijn Suijten wrote:
> This was pointed out in review but never followed up on thanks to
> sidetracked discussions about labels vs node names.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: pmi8950: Correct rev_1250v channel label to mv
      commit: 3c3d2cb221b8647d1c547b4c44d2d6060cc742a9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
