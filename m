Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B6572EF67
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240633AbjFMW2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240551AbjFMW1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:27:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DA91BEB;
        Tue, 13 Jun 2023 15:27:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF66E63B9D;
        Tue, 13 Jun 2023 22:27:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71183C433C0;
        Tue, 13 Jun 2023 22:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686695251;
        bh=EKtYnbjdmzG18C1xM2bANYW8GbxfW0CSkbluJCVFnQk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bLRnGfp8P8rzxGJkWSKodg/ZfT9nMi/aZa0HKWx2XhenWF8OBFXnUd5vfSWOPvSUl
         aXKIeF67cFb5khYvG8MLGIfkWYePDsqHeSl1xAXbWfWeXh4EU3bq4gYhDF1uIgc+l2
         wRsMI3FiyvyZ4pMuXjuAGn50PgVJxei6T22j8h3l0wcEE0q0UunBQiD9twdpIpAd/a
         Sh4284PX8SgYza6MZ5lYRt3Lkx+KoH3P+Nc7Gqn8qFUCP2ZzRQuPK2bmOHIzKTtCCC
         YBxNvBgivU5ubUW4oFTLOmdW41S4BVzsw/Kp+cWoY2Nf+nz5BedOZF8H3OqEPFLFUK
         +pLgz1TZ/x4cw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Kathiravan T <quic_kathirav@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH V2 0/4] Add initial support for RDP474 of IPQ5332 family
Date:   Tue, 13 Jun 2023 15:30:27 -0700
Message-Id: <168669542895.1315701.3480979194432341949.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230605080531.3879-1-quic_kathirav@quicinc.com>
References: <20230605080531.3879-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2023 13:35:27 +0530, Kathiravan T wrote:
> Add the initial device tree support for the Reference Design
> Platform(RDP) 474 based on IPQ5332 family of SoC. This patch carries
> the support for Console UART, eMMC, I2C and GPIO based buttons.
> 
> Most of the features of RDP474 is similar to RDP441, except that the
> QDSP will not be used in RDP474, whereas it will be used in the RDP441.
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: arm: qcom,ids: add SoC ID for IPQ5300
      commit: b56715957bc820ee4b01adfd6fa63fea63cd212a
[2/4] soc: qcom: socinfo: Add Soc ID for IPQ5300
      commit: f471f91a0d63539107004a8e826ff017ed4d2588

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
