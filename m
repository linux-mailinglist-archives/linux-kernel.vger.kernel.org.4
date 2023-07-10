Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC1074CC12
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjGJFJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjGJFIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:08:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C870E1737;
        Sun,  9 Jul 2023 22:06:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92A5A60E86;
        Mon, 10 Jul 2023 05:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4337CC433C8;
        Mon, 10 Jul 2023 05:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965503;
        bh=saShK635QSs3orwJA8c812VOrfMx0o4gXTyjxnyGwyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c2l0ZC3yc3up6GwYqwgSOG6MjkjngvVxw15HWEDyF5vmA7hYEFW52gomHHdPAz0PQ
         GriWkisfU+RVb4cjWzckQPCheAM0IPvM+3/Ubxct4TVZdAlqxiKPcrXvzWiUTIwZ/5
         TnYQzO+FVjxTXX+4ZDsVOcv18Y3wE1v1gSbjuufJUmLm2mHVu6oHEulk0EUJL2NEmW
         h2CYUpLljBhZWnfePWnAnWuVajiAvVucm9xNMt/dC4QRPeuJDVu89EwxfGULTB1eA5
         PB2ovr/eiDlVLt7tygMWi+vfU7v9FWPPfRyFva+KkA3u0QhD+rOyzROO30nPesmE0K
         zhgKINpin4xLw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] arm64: dts: qcom: add chassis-type to reference platforms
Date:   Sun,  9 Jul 2023 22:07:40 -0700
Message-ID: <168896565967.1376307.11264681031668585319.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230622-topic-sm8x50-upstream-chassis-type-v1-0-13f676eb71f3@linaro.org>
References: <20230622-topic-sm8x50-upstream-chassis-type-v1-0-13f676eb71f3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Jun 2023 10:57:17 +0200, Neil Armstrong wrote:
> Add the chassis-type property to the Qualcomm MTP, QRD and
> HDK reference platforms.
> 
> 

Applied, thanks!

[1/5] arm64: dts: qcom: sm8[1235]50-mtp: add chassis-type property
      commit: 46b17dfd0154b3720b22a4056c0f060ba0c7ec66
[2/5] arm64: dts: qcom: sm8[45]50-qrd: add chassis-type property
      commit: b047b90261791fd439dfd0d885e1a3e995c05985
[3/5] arm64: dts: qcom: sm8[1234]50-hdk: add chassis-type property
      commit: 8fef2422f53a84ec32f9d7ac8d6af1fa9426e835
[4/5] arm64: dts: qcom: msm89xx-mtp: add chassis-type property
      commit: d8d1d994246f7d44241c5332817c8e850e1b2e73
[5/5] arm64: dts: qcom: sdm845-mtp: add chassis-type property
      commit: 2b08da0d791ff08e1c29ee3abd2563ce0a9da7b9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
