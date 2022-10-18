Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295216021A5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiJRDGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiJRDG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:06:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE73D72FE0;
        Mon, 17 Oct 2022 20:06:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 613016136D;
        Tue, 18 Oct 2022 03:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1828C43140;
        Tue, 18 Oct 2022 03:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062383;
        bh=XKRjOQqBxVxL4uhfuktgUfjYnNmMRTMPndm8hO4kjHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PaEIivy/IzeXwHemo+3vHbI19X2FQpDHU8uLAlzABfagkaEYZlPgfsUSRUAZaXV4+
         nWZOWiOBcKLRX2kv2I9rg/Bc01RyW4E4Pv8Z0UBEN/vcvQSCAeyQ9KuJthxI6Ofvon
         QXcT06Hu0LwJfV9eG7h3TXgDvyheLEh0VG/Bhmu0yJlAvwPGgcSOYOLtNEmnL0yU/a
         1Ts2byXs4QJ3vSSWbPA3uuyLGrUAlTcsvE//lMTrWUg9I50yBPPnNjAyXF5T9edfR9
         XUBe0fHXYE2ydDtpe1PwhDIVzL1EZTA32DmxxyTJO7onP4BMH5FrECDt9xQer+Q+yB
         /4w+SL0CtpzSQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     bmasney@redhat.com
Cc:     ahalaney@redhat.com, echanude@redhat.com,
        konrad.dybcio@somainline.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, robh+dt@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4] arm64: dts: qcom: sc8280xp: correct ref clock for ufs_mem_phy
Date:   Mon, 17 Oct 2022 22:05:05 -0500
Message-Id: <166606235845.3553294.1368183713429983227.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221006145529.755521-1-bmasney@redhat.com>
References: <20221006145529.755521-1-bmasney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Oct 2022 10:55:29 -0400, Brian Masney wrote:
> The first UFS host controller fails to start on the SA8540P automotive
> board (QDrive3) due to the following errors:
> 
>     ufshcd-qcom 1d84000.ufs: ufshcd_query_flag: Sending flag query for idn 18 failed, err = 253
>     ufshcd-qcom 1d84000.ufs: ufshcd_query_flag: Sending flag query for idn 18 failed, err = 253
>     ufshcd-qcom 1d84000.ufs: ufshcd_query_flag: Sending flag query for idn 18 failed, err = 253
>     ufshcd-qcom 1d84000.ufs: ufshcd_query_flag_retry: query attribute, opcode 5, idn 18, failed
>         with error 253 after 3 retries
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp: correct ref clock for ufs_mem_phy
      commit: f3aa975e230e060c07dcfdf3fe92b59809422c13

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
