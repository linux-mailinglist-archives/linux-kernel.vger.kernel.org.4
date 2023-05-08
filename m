Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3606FA115
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbjEHHcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbjEHHcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:32:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B64C5BA2;
        Mon,  8 May 2023 00:31:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AFEB60A6D;
        Mon,  8 May 2023 07:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFFBC433EF;
        Mon,  8 May 2023 07:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683531115;
        bh=uFm7amat6u5/NTy02eKQykrRvo7kkoqHKGb741TnEf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lddSyqHXQphaywKV2TuBbmDUA2mtJJfRsde3Rdqlk1ahvi9QnaIYW/jvcvFb0WzMs
         qxYcKeHi/GrV9Xg303yXbvHIHpfwivcEdyOwW0xIxW+5q4tr3BAVx/NdNugxfpoS1g
         32ngqaqWKokfjbxUMS4x3MUKsbBRM2bKzBmWiTitUDiZdxnKfmQQoVjuBav4uWnxaA
         cX5mvj7h46dOMaRfDgz3s7j8Q9go6LOuXydgcGFp8MV0BhPs9wQW+fNH0B3RGG1lZ9
         7cKvoyGQK8dHhe04ZQwAbuIyIPTLmd8s5jonU8UCQVdDFRogEVJSHthcCTaZ2mHZso
         ADV0Nhx+C98Yw==
Date:   Mon, 8 May 2023 13:01:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 0/7] soundwire: qcom: add support for SM8550
 (Soundwire v2.0.0)
Message-ID: <ZFilZ9MYdjmjtv0i@matsya>
References: <20230418095447.577001-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418095447.577001-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-04-23, 11:54, Krzysztof Kozlowski wrote:
> Hi,
> 
> Changes since v2:
> 1. Use uint16 for qcom,ports-sinterval.
>    DTS will be fixed in separate patchset.
> 2. Add tags.
> 
> Changes since v1:
> 1. Patch 1: Increase maxItems to 16 for port-related properties.
> 2. Re-order patch 1 and 2.
> 3. Patch 3: Drop unneeded semicolon.
> 4. Patch 5: Fix lang typo in subject.

Applied, thanks

-- 
~Vinod
