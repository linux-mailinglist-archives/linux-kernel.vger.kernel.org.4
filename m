Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437C068FF09
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjBIEcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjBIEbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:31:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855313F28F;
        Wed,  8 Feb 2023 20:31:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CFD6B82005;
        Thu,  9 Feb 2023 04:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F4EC4339E;
        Thu,  9 Feb 2023 04:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916511;
        bh=2UrKti8sbDNHnrB4NYCsWqBESxFsqJZGU6DMkuoyLdg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=iUAo7vDgPGDdwVsVCz3ss+ENpaoF597RlU/SfI1F/gpHnKiyh9cLKdBfkmQ7FqeuO
         meuazBRUfrjwj5Rkfu7zGJfgBvw/8ymNmXiKlYOha1dW5bbR+Y9x2fN2o79H4pwTHn
         IeA79WrYuAzaIJp+2B9MGQt88dIpuhqF841famIqzjNelZnRTUN15mM3RSPZgJa3g5
         DKPX8x8KW8Pi7/6+pFgNYWd5e4E291zBXslsGAj+B/4vIAnR5oKhKXiZastV2xjKQE
         v0837lJu3Ow1gpNQmvQ2b0+C8DsahXqMj0qOWXJxVYwvLhjv7Jytro5uwA+01W5bJ3
         +h9vuq8NvRwYQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8550: add specific SMMU compatible
Date:   Wed,  8 Feb 2023 20:23:07 -0800
Message-Id: <167591660368.1230100.5441050809289183842.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127115513.268843-1-krzysztof.kozlowski@linaro.org>
References: <20230127115513.268843-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 27 Jan 2023 12:55:13 +0100, Krzysztof Kozlowski wrote:
> Generic SMMU compatibles are not allowed alone and we expect specific
> one.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8550: add specific SMMU compatible
      commit: 88ec7fb6751e7e1d05d756c9764667aab7428044

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
