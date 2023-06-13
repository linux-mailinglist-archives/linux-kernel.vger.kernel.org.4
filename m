Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6C572E1BC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbjFMLdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjFMLdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:33:03 -0400
X-Greylist: delayed 1241 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 13 Jun 2023 04:32:59 PDT
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA86CA;
        Tue, 13 Jun 2023 04:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:Reply-To:
        Content-ID:Content-Description;
        bh=tgIF/0cV3jzRQsm+ETxVbgy42xpfIw8aPttpqREa1ws=; b=dg4TNTqc+XsZQGvqQ9sFHH/WUC
        DftqlpPwSPrwBU5Be7hzDIDWj8uJVxHAKJtwEjeKiw+ln4Yq7+yvUYSszHuxv2Hzrp6R39Gt2kqw1
        iNfvXU1k1cVyKOCJODoKuKvJPqW/MXdVPp+8x6cPx0EWYdD64RrClPJPWgGISDNrNl/k4JYq/97+x
        LDzUpq2AoFMVozm/ZA1Mes1sxI7gQCd6dBKjo2ysLDI85Z2vGrVJ/bm1lOe7opzvoDkubvdQxS152
        o3MuEkiS675Cob7C0sV+wOorSh3RCS83MpupV/JHe6vGiBKIf1b7XAM7bSrB070pTMNynx+MOLXkD
        XQDHm85Q==;
Received: from [10.22.3.24] (helo=kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1q91vt-000yDF-BI; Tue, 13 Jun 2023 13:11:28 +0200
Date:   Tue, 13 Jun 2023 13:11:21 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 01/23] dt-bindings: interconnect: Add Qcom RPM ICC
 bindings
Message-ID: <ZIhO2Tgh5q4heBi6@kernkonzept.com>
References: <20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org>
 <20230526-topic-smd_icc-v3-1-5fb7d39b874f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526-topic-smd_icc-v3-1-5fb7d39b874f@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 08:24:18PM +0200, Konrad Dybcio wrote:
> The SMD RPM interconnect driver requires different icc tags to the
> RPMh driver. Add bindings to reflect that.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  include/dt-bindings/interconnect/qcom,rpm-icc.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/dt-bindings/interconnect/qcom,rpm-icc.h b/include/dt-bindings/interconnect/qcom,rpm-icc.h
> new file mode 100644
> index 000000000000..ef61006c9c58
> --- /dev/null
> +++ b/include/dt-bindings/interconnect/qcom,rpm-icc.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_RPM_ICC_H
> +#define __DT_BINDINGS_INTERCONNECT_QCOM_RPM_ICC_H
> +
> +#define RPM_ACTIVE_TAG		BIT(0)
> +#define RPM_SLEEP_TAG		BIT(1)

BIT(n) doesn't work in dt-bindings (syntax error), can you change this
to (1 << 0) / (1 << 1)?

Thanks!

-- 
Stephan Gerhold
Kernkonzept GmbH at Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael Hohmuth
