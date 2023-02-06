Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C707B68C966
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 23:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjBFW2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 17:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjBFW2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 17:28:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65E0FF3A;
        Mon,  6 Feb 2023 14:28:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78F4261055;
        Mon,  6 Feb 2023 22:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38B9C4339C;
        Mon,  6 Feb 2023 22:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675722508;
        bh=CbTs6jSJqxv2QMcaAUoTt2nvuLb4C8YilnRQZQW2QN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DcTBndKz8p4jZj1A50e4hi5D4E9y0pSKSqnC5FV0VLSIfdYxsFk8aGtvWJngmh7Ch
         lkVoGdKaxnDuI+blS0+bmPiXrY9PA3n4bdY00Q1mpiY1Yy4L3s1fMBPjmcC7vWiB6n
         ch6/tfbZM67RwYp6bcx9M+Oe87o5Okn0cSOUUmpFK2DqTnFKxv7sgXJzqQxa5Dd+8U
         fGMY8pG+atZ8LNZjOiiuimTU/BQ/c8S3sUxwxD4c920Fi3yEdmXdrmJI/aS81X+Muu
         Mow2YJefCa9GU8I5V/T9f7sOsKM/aftVyfLkdNLJAlY2VbdgjFOWWFvJ3WJSadC9Gl
         U8olg1LuGEeIg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, devi priya <quic_devipriy@quicinc.com>,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org
Cc:     quic_kathirav@quicinc.com, quic_sjaganat@quicinc.com,
        quic_arajkuma@quicinc.com, quic_gokulsri@quicinc.com,
        quic_poovendh@quicinc.com, quic_srichara@quicinc.com,
        quic_anusha@quicinc.com
Subject: Re: (subset) [PATCH 0/6] Add regulator support for IPQ9574 SoC
Date:   Mon,  6 Feb 2023 14:30:35 -0800
Message-Id: <167572263442.3569822.4527590282812934469.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230113150310.29709-1-quic_devipriy@quicinc.com>
References: <20230113150310.29709-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jan 2023 20:33:04 +0530, devi priya wrote:
> IPQ9574 SoC uses the PMIC MP5496 and SMPA1 regulator is used for
> APSS voltage scaling.
> This patch series adds the support for the same.
> Also enables the RPM communication over the RPMSG framework
> 
> This series depends on the below patchset
> https://lore.kernel.org/linux-arm-msm/20230113143647.14961-1-quic_devipriy@quicinc.com/
> 
> [...]

Applied, thanks!

[1/6] soc: qcom: smd-rpm: Add IPQ9574 compatible
      commit: 64dc69f3f36a71a95bfed8054d49600a7872415e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
