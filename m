Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A62F6C4E30
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjCVOnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjCVOnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:43:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C11065C59;
        Wed, 22 Mar 2023 07:42:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C7EBB81D12;
        Wed, 22 Mar 2023 14:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B580C4339E;
        Wed, 22 Mar 2023 14:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679496136;
        bh=aMAns0DThIP0pN0mVF8u71OhI7I3+oIR3SdaciQA7f0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uvMBi7bbu7uUXkAnvsd9BqLLyBEmsKwi5Ql0CseS0Mq8h6DS5/B0vQM/LRD7Y+9q5
         YiS3bWqQEq2kNjPd7zRNCSibiTnyA7dKf2RiPOPlEbZ4Qi9AoA6KM0McAuUlMVTWrs
         PnwKVlAF+TjEbvPvoncPOI7bgx4m7x0omlF/rf2NSOk1B+bo3ApJpjgcO0T+2u8H6l
         P5+kCfNgqRWFsxBrWtqbG/S4WUYKq52k5a9IYRigZ9i/Ums2EU4rKCTD/m4qBnHoRh
         fbNpwaqNLmq/6pwmZa3X2uQfr/Ff1NazQQrIpSwH+CGeFuApnvZbFkA9I0uHvhS0iX
         8zlvlCMQDKQkw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@linaro.org, agross@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        Danila Tikhonov <danila@jiaxyga.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: pm8150l: add spmi-flash-led node
Date:   Wed, 22 Mar 2023 07:45:06 -0700
Message-Id: <167949631651.1081726.16530784335679132025.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321182319.24958-1-danila@jiaxyga.com>
References: <20230321182319.24958-1-danila@jiaxyga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2023 21:23:19 +0300, Danila Tikhonov wrote:
> Add a node describing the flash block found on pm8150l.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: pm8150l: add spmi-flash-led node
      commit: 4f278f71c79f174c027d07f57837d1ca41b2df37

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
