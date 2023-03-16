Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164FE6BC495
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjCPDTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 23:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCPDS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:18:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919C7A4B2A;
        Wed, 15 Mar 2023 20:18:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FBFF61E4A;
        Thu, 16 Mar 2023 03:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3AEC433B3;
        Thu, 16 Mar 2023 03:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678936685;
        bh=koTj7fPng3rbr7CisUXzllSEFJ/TrcwUQQysfl0mu38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S4ccpVCR3eoLlE3o2xW+WFxzT1EF8oTfDjyupkVHE4h9BQDsD5lHiUEmNrPoY8k27
         H3dFKPShMuDImRVFu/yVdkwzNGHkCIny8TKv4YaITfI90u5xbNsjpGy71rB8y4rzbC
         FYJvWnuPyCFdFpU0KHQqWeYmlIiEIaPfKIN2a05w6KndiF+RyNdU/4Av5vIWEaj4uf
         Gsb2RHoCfhu0EIWRh6mAJ6dSqgDnkjjwOMd5WfJBKVl/Cex+x6D6jrOeS2zfqTtmVH
         WLqmMbtipipeL+9JtZFLYQQNjb0yRNnGwCgDyT8tR/6lt2/Mb21ge0b8efmIDt1iop
         GDmO3KjKHlwWQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Robert Marko <robimarko@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: (subset) [PATCH v2 0/7] remoteproc: qcom_q6v5_pas: Add support for QDU1000/QRU1000 mpss
Date:   Wed, 15 Mar 2023 20:21:04 -0700
Message-Id: <167893686410.303819.12606519784601951345.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306231202.12223-1-quic_molvera@quicinc.com>
References: <20230306231202.12223-1-quic_molvera@quicinc.com>
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

On Mon, 6 Mar 2023 15:11:55 -0800, Melody Olvera wrote:
> This patchset adds support for the mpss found in the QDU1000 and QRU1000
> SoCs.
> 
> The mpss boot process now supports late attach for an already running
> mpss. For this, it uses an RMB register space to perform a handshake
> with the mpss for the late attach process. This is implemented in the
> patches below. The patches also address issues with split binary
> detection to support loading of split binaries more robustly.
> 
> [...]

Applied, thanks!

[1/7] dt-bindings: firmware: qcom,scm: Update QDU1000/QRU1000 compatible
      commit: bbf97c274da60fcfbb8ebde70a1c3abc6102c709
[2/7] dt-bindings: soc: qcom: aoss: Document QDU1000/QRU1000 compatible
      commit: 9559342891be54d9ffd13061022d9e5d24b2577a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
