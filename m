Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDE966539E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237809AbjAKFWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjAKFSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:18:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF65113F75;
        Tue, 10 Jan 2023 21:10:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D4A261A35;
        Wed, 11 Jan 2023 05:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F15C433F2;
        Wed, 11 Jan 2023 05:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673413815;
        bh=7jagrjjrGHGmvUJP8miOGt1z2GyFHP5RC70cx7MAS3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d/iJhZNtugoPrDibqDBqHmQh6T0wZICNTPfuZg4r2Tcwf5NpCWkLHJmWXwm5SIFhp
         pfMLe/yIrSG52qdpiMRmjsblLMG/iEVIjnfLax6tPbQYXWVmYuLZzuWFWw+zly8Jj6
         hQQ4SwkKT3Sus0JG3/86UujF5CpTeLNQv0zIjSMTX40g64AuhRdN4WNmyi/RdEkPLy
         8pauIEtBrJz/hRdvdMLg+PciUW8CThlz0zx204B8vvpgbcrvi2XDU7Gro8XbA8LPMZ
         GBuAwt6Tzw6VJlznEbUYamdDonLFHdLwpObZGC8tO63QxxsPDzZ0M2bvrobiXBHfwV
         PE5n4alxvvR4w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        robh@kernel.org, konrad.dybcio@somainline.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Fix CPU nodes compatible string
Date:   Tue, 10 Jan 2023 23:09:41 -0600
Message-Id: <167341377720.2246479.16265274252431181232.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221207211327.2848665-1-robh@kernel.org>
References: <20221207211327.2848665-1-robh@kernel.org>
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

On Wed, 7 Dec 2022 15:13:27 -0600, Rob Herring wrote:
> 'arm,kryo' is not documented and is not an Arm Ltd thing either as that
> is Qualcomm branding. The correct compatible is 'qcom,kryo'.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: Fix CPU nodes compatible string
      commit: 9293c3e85a200d3a453ca208548d5dfc9d1af70a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
