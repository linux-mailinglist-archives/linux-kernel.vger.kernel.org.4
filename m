Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4A866E6BA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjAQTOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbjAQTKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:10:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49845C0D1;
        Tue, 17 Jan 2023 10:24:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 946E7B819A6;
        Tue, 17 Jan 2023 18:24:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C01C433D2;
        Tue, 17 Jan 2023 18:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673979879;
        bh=gGzSAHGhaOKYr/g4hrhGTS7W6RNOV6z+c+Gj5oaXjjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YbB5v3kL/OS++r5Uu/t2OUFLmA1ovcHdWBR1+BrOuxr7zOLpWMG3SQFvtIKI/h1aZ
         WrSqyk8TYjUTTNC+YptLJlAYV9UIBdF7dNVeYBLxymA9Q8+UzXW0nXSSTSKy6iXRKE
         OfVaWr5wqfcrMd4w4IZEyF5G22Te0UARZ5TuS+UF/EQLPRH10dJ5O8K/ojwuDQ+C59
         xvN5Yt4w6DcMTcH7a8H1E+188Mz6OeZUUuc1tcbD9I246MFZqw/V2vlmyyhWsn1TGS
         cklcbjJEdKXZKGElKbufCZn3eqzZxVR4CDqUcjuOPTSg3HDJ8wjt7doxmvH22oa94i
         1OAaV2XQHHrvQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        krzysztof.kozlowski@linaro.org, konrad.dybcio@linaro.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marijn.suijten@somainline.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 1/2] arm64: dts: qcom: sdm630-nile: Don't use underscores in node names
Date:   Tue, 17 Jan 2023 12:24:24 -0600
Message-Id: <167397986262.2832389.5984507396288650689.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230116141451.470158-1-konrad.dybcio@linaro.org>
References: <20230116141451.470158-1-konrad.dybcio@linaro.org>
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

On Mon, 16 Jan 2023 15:14:50 +0100, Konrad Dybcio wrote:
> Rename the reserved-memory subnodes such that they don't use
> undescores.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sdm630-nile: Don't use underscores in node names
      commit: 305db81657b47cbf041a45aa4c0845ed600e3157
[2/2] arm64: dts: qcom: sdm630-nile: Reserve simplefb memory
      commit: 2f20f276dd4f2796eba88a06a0fb90b5a9bbbd4b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
