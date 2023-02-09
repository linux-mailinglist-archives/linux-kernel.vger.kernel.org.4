Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3B968FEDB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjBIEbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjBIEax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:30:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316F734319;
        Wed,  8 Feb 2023 20:30:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E4D8B8201D;
        Thu,  9 Feb 2023 04:22:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9EBC4339B;
        Thu,  9 Feb 2023 04:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916533;
        bh=nPHePlOg2TVzbWzoVq/Zf+yZwqcVkigLUAqLBgPLE1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ynot8nJo0/k6TB6jbpP9Xy9oLhd9qJTHMd6Xb7y6z5ZKsEBMqo4uO0q8FMnuHWvg5
         sB+CSPuz4/d3OF3Kpn2jBU3CvMxnoTZJ80GrYsSQp3mqZz0ZYyFZC7KzLcNceE0cxi
         wTBplO+bYvnDiYSkSmh7tsQv3oQUsAQlrucxQsEyO9Txsy9/282Z/CeB0SLnxbCU37
         igqgW4jQERvLwFP+9Wi3u1XIUn40MSrxzXHRy6MfkRZdJpshhMp+Ug8m3O1EN80gVV
         +VX73kwZoE+cXZg5kcycvU6FfsI26HUbFnSIdjN5O5MUgAjeqStn/y8SQwaljbffBJ
         Jvob/56Vl5t3Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@linaro.org, Kathiravan T <quic_kathirav@quicinc.com>,
        agross@kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org
Cc:     quic_varada@quicinc.com, quic_srichara@quicinc.com
Subject: Re: [PATCH 0/2] Add socinfo support for IPQ5332 variants
Date:   Wed,  8 Feb 2023 20:23:27 -0800
Message-Id: <167591660372.1230100.7967103598592944908.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208055709.13162-1-quic_kathirav@quicinc.com>
References: <20230208055709.13162-1-quic_kathirav@quicinc.com>
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

On Wed, 8 Feb 2023 11:27:07 +0530, Kathiravan T wrote:
> This series adds support for qcom-socinfo for IPQ5332 family of SoCs.
> 
> Functionally this series needs SMEM support which is added in download
> mode support patches.
> https://lore.kernel.org/linux-arm-msm/20230130170155.27266-1-quic_kathirav@quicinc.com/
> 
> Kathiravan T (2):
>   dt-bindings: arm: qcom,ids: Add IDs for IPQ5332 and its variant
>   soc: qcom: socinfo: Add IDs for IPQ5332 and its variant
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: qcom,ids: Add IDs for IPQ5332 and its variant
      commit: 4ad66c3f4bcb83414181434a7d439cd80ac91a1a
[2/2] soc: qcom: socinfo: Add IDs for IPQ5332 and its variant
      commit: b0bc8c893ae07acd4829a158e83902897a31a490

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
