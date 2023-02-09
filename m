Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5B268FECA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjBIEaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjBIEaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:30:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246AC30B14;
        Wed,  8 Feb 2023 20:29:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5236AB81FF9;
        Thu,  9 Feb 2023 04:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6256BC433D2;
        Thu,  9 Feb 2023 04:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916512;
        bh=InxRbtZBoNwVuU6WQX7VSnRLr+tCZS1HHP2deH+Q6uA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=IqYGLH6H0u+WxbLPp/E6xLA1x2ZsA5OKScioWtX3b0AuvEQ9SsOEs7XSCfrxGEYFe
         h28dkYK1k72Z10DT+rg7GkA2d+j035tHgNwrB8hDnU6kgqf/NVVC8+6LyBfKaZ8eqp
         qg4yyDBO0i6I97XJPua1u0pDD42ljDem42tjf9fC+XWW9sBrEYU+eobwkp8j8Y76gp
         a1y4Fe1bICqAJzLFcR9V2AeOmfSrHKd0arqVUzCVi3Bmprt5CQH/Lg0+NeOUsl9pnV
         9xhdOB0tnscF7azy+qxU4SHG7jOfQ3g7rjl97b+kPGOMCz3u/eZ/7k09Yah8lh7ffn
         C0ToDGsLgwJKg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: align OPP table names with DT schema
Date:   Wed,  8 Feb 2023 20:23:08 -0800
Message-Id: <167591660369.1230100.6945192170167804779.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230120072113.138656-1-krzysztof.kozlowski@linaro.org>
References: <20230120072113.138656-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 20 Jan 2023 08:21:12 +0100, Krzysztof Kozlowski wrote:
> DT schema expects names of operating points tables to match certain
> pattern:
> 
>   qcom-ipq4018-ap120c-ac.dtb: opp_table0: $nodename:0: 'opp_table0' does not match '^opp-table(-[a-z0-9]+)?$'
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: align OPP table names with DT schema
      commit: 68e8dd352adc2c279f9608eaecbe2ced2f398b48

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
