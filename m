Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD46A6DB2DC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjDGSeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbjDGSeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:34:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03940E7E;
        Fri,  7 Apr 2023 11:33:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90B856538A;
        Fri,  7 Apr 2023 18:33:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6744C433A0;
        Fri,  7 Apr 2023 18:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680892439;
        bh=PXMOpaltz4o+8o5QOdDy4+68BOF+8URXJgGf+pc+C10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d61Se7vBo98mnHAAxSm8h0W0Ms/nmQmn8nZCFUe4FNYDa1PhaHObhKpwGPWMAiwxB
         D9wQGsr0KFUbY4+Hr3SE3QNWfD99Ofi/NIdNh9Kndx5qBKsdRsHZQxbF3kKNn/dQ/1
         NELBlMKpZwDk67GHpq9PQjsWRRpaSmt9u7kvqoeOEKzH/FLY+nsRTgePymTOWI/xKL
         V5Ie8we7l6Xv4PmVM0J2hwH74yy/iMLsWpeQSEIj9WGMw3vhUDs7CwHgw3XLAftgFv
         /l912AxSr/SKEvNU9bW3InVU0bzbFTetTa+82L5Dnq4fWGHa0d9z0QY8Jws3SvCygd
         6KH11jWa7NyPw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-media@vger.kernel.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH 0/6] Couple of bindings / dt fixes
Date:   Fri,  7 Apr 2023 11:36:44 -0700
Message-Id: <168089260338.2666024.8372927418104597434.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230407-topic-msm_dtb-v1-0-6efb4196f51f@linaro.org>
References: <20230407-topic-msm_dtb-v1-0-6efb4196f51f@linaro.org>
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

On Fri, 07 Apr 2023 15:28:30 +0200, Konrad Dybcio wrote:
> Couple of trivial fixes to make dtbs_check happy (happier).
> 
> 

Applied, thanks!

[4/6] arm64: dts: qcom: sc7280: Fix up the gic node
      commit: 04b5840664822cefff61deb727f497b59c341e0e
[5/6] arm64: dts: qcom: pm8916: Fix pm8941-misc node name
      commit: 7891372d6c5b3d73c304e26fa1e3b17c022281a1
[6/6] arm64: dts: qcom: sdm845-oneplus: Fix speaker GPIO node
      commit: 149959d0b18113881cb0a47ad8f8d36b60ff6f9f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
