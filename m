Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D425EB8BB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 05:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiI0DY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 23:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiI0DXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 23:23:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9440EE02B;
        Mon, 26 Sep 2022 20:23:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50D24B80D9D;
        Tue, 27 Sep 2022 03:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B3AC433C1;
        Tue, 27 Sep 2022 03:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664248986;
        bh=+WAqlaESI/TBL/hp0OKeXlB44156QT7krk6MvuFccXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P8GXRK8/k1qvBCOfPnC3z4J/Q9OcuTlsKtkkeOLrM/pCqGZewEiC5/qWO/2dXZUXS
         SlzIHNqTe/IpoyDeBhQBryTr7Jbsii75iA62BihoTUuMNXVUAG/gHsp2NMHTabZanb
         4Nf73/rVt3x3iH/DeAiruVuqSdhhZqYQne+E7wlT+iNzoJNiRrVwk02UcE4S8qfU+m
         25kutHFfkXofvgmGpsy4+iDWkRsTr6iXETs0vCHZkrNmPEeLMw9Drg+zTbAVqY6/vW
         RUO9UYiTBK61AZQ/+iiLKDqAIIrmSb7vn+t4GPHwUGyP04jNKz8iD1JgZuCaADOhm2
         59QE4T7I1DRew==
From:   Bjorn Andersson <andersson@kernel.org>
To:     a39.skl@gmail.com
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, krzysztof.kozlowski+dt@linaro.org,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org, agross@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Add DISPCC driver for SM6115
Date:   Mon, 26 Sep 2022 22:22:57 -0500
Message-Id: <166424897976.1766486.17695490545987558939.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220911164635.182973-1-a39.skl@gmail.com>
References: <20220911164635.182973-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Sep 2022 18:46:17 +0200, Adam Skladowski wrote:
> This patch series introduce support for SM6115 display clock controller,
> this driver is based on QCM2290 one.
> 
> Changes since v1
> ================
> 1. Changed bindings file names to Vendor,SoC-IP format.
> 2. Changed include in dispcc-sm6115 to reflect name change of bindings.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: clock: add QCOM SM6115 display clock bindings
      commit: 38557c6fc0771be5791e16837342db581daa6379
[2/2] clk: qcom: Add display clock controller driver for SM6115
      commit: 9b518788631cf7bc2b10d3967fd2343d1c88d65c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
