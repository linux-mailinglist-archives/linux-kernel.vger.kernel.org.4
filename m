Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26276644B29
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiLFSUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiLFSTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:19:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0ADF9FCB;
        Tue,  6 Dec 2022 10:19:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C95161844;
        Tue,  6 Dec 2022 18:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1412DC433B5;
        Tue,  6 Dec 2022 18:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350777;
        bh=Ia4EtakdBM9YAvPIg9qfcOdh/UEfgRXFHWDpeAghtW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WFwt6Q7n7T+oS5fycwrhUGQV1PVULOSabsn4bJAchAjmmsB/L0jWh81WpHn+c2IJ8
         0CPaIwkbLFYYdXdp1jm2jKZsKRsN1fZOmQc1x4xOEz2lSrQubODjM46yzQlNM05ECo
         PQRSxbV0hHDnIUdH7g0+99fBxt3SYXqAP2Sn/kBob94KBLKjR0+fkh+yT0l6OdmREo
         tA3+1HjKcweWkDqP0JavkYslGm2oHZ2MQ9DC6pK0qcyClWbZLApubB/nNeJKdRRKf1
         /lvW1Y9pxE9UlP0PuCPQ4LYVDzUU/brMqxSnJHlCCxbjydBUQG998xwNDsL8xgtsTL
         WP6lmpbVg3Kng==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        konrad.dybcio@linaro.org, abel.vesa@linaro.org, robh@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: socinfo: Add SM8550 ID
Date:   Tue,  6 Dec 2022 12:18:44 -0600
Message-Id: <167035076337.3155086.14328171383140020084.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221116112438.2643607-1-abel.vesa@linaro.org>
References: <20221116112438.2643607-1-abel.vesa@linaro.org>
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

On Wed, 16 Nov 2022 13:24:38 +0200, Abel Vesa wrote:
> Add the ID for the Qualcomm SM8550 SoC.
> 
> 

Applied, thanks!

[1/1] soc: qcom: socinfo: Add SM8550 ID
      commit: 147f6534b8ffdd766c2fd3a28b0b1d6fd41c81e4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
