Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2DA6BC46E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjCPDSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 23:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjCPDSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:18:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A03D984FC;
        Wed, 15 Mar 2023 20:17:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04E05B81FB8;
        Thu, 16 Mar 2023 03:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6268BC433A1;
        Thu, 16 Mar 2023 03:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678936675;
        bh=o9IHfsUjBzby8UwNsdZ7WpQOVeY+bMM9ZzHJ+0jFFrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tEPESCS9bWNcYrlVbNEdGQ/rpTyJLD5IpzaVk89KrwiKGKr5aHiv1eEeQDv18Tael
         w2I4LtJB8H1c31OLtl1XbbRe3IqXqoGXRbvOFH5lDnTwMflNBfOf2j71/EtXnwZ57K
         dNyHjTkvoIIcKhwvM64bdMDpiLYqRt4mxMEHOz628wwK4xY7bK2ktVYjM3COnFZdhC
         2Uea2vq9cbzrqL53Mlq/UB/ijjwB1DKIXJfZ7MaLfKdHu+HVbOv6YlSpNVVCRL1v5R
         l7iEFguj1fY1kNut7l7yffQBG5fudT8fYRn9Uy2Uldj8ERLkKvE2KxxfBmTdMwzcc5
         huup6b+yPrNIw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     broonie@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, Devi Priya <quic_devipriy@quicinc.com>,
        agross@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     quic_sjaganat@quicinc.com, quic_arajkuma@quicinc.com,
        quic_ipkumar@quicinc.com, quic_gokulsri@quicinc.com,
        quic_anusha@quicinc.com, quic_kathirav@quicinc.com,
        quic_srichara@quicinc.com
Subject: Re: (subset) [PATCH V2 0/6] Add regulator support for IPQ9574 SoC
Date:   Wed, 15 Mar 2023 20:20:59 -0700
Message-Id: <167893686409.303819.10412004704489847710.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230217142030.16012-1-quic_devipriy@quicinc.com>
References: <20230217142030.16012-1-quic_devipriy@quicinc.com>
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

On Fri, 17 Feb 2023 19:50:24 +0530, Devi Priya wrote:
> IPQ9574 SoC uses the PMIC MP5496 and SMPA1 regulator for
> APSS voltage scaling.
> This patch series adds the support for the same and also
> enables the RPM communication over the RPMSG framework
> 
> DTS patch depends on the below series
> https://lore.kernel.org/linux-arm-kernel/20230217134107.13946-1-quic_devipriy@quicinc.com/
> 
> [...]

Applied, thanks!

[1/6] dt-bindings: soc: qcom: smd-rpm: Add IPQ9574 compatible
      commit: 56d2156e7c298ecad5a113a81e5550631bcf7fd5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
