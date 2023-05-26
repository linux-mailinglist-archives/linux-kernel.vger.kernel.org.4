Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89361712DA5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243310AbjEZTfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243809AbjEZTe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:34:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BF9A3;
        Fri, 26 May 2023 12:34:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B9816530C;
        Fri, 26 May 2023 19:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E94C433A0;
        Fri, 26 May 2023 19:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685129695;
        bh=gT9IKrR0prQstcetiEJhX3nmV1xde8J90JVRdjDHsEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U4Z8sFB1uz2LsZIgyrwMRjwu6yEXVUo/R+l/xHjqrzasRTnO+dhaE15asdlqpr+Gv
         wQJ+rd21J0jI0l/EKIH4vHoiGctVO4VHF5GvCsVFpY535Z1rIF2lZ+Zey5+cb6NnYs
         Lzx86bjC/9TEE1x4sy8/wSG0xBPWeNbprfaqb3ztlnWcH8W25UuDdxoYNqdpVKJ/gR
         r0hwBjFFoy6GFefyvd6UDDOqcUnX7Mkfnai36TbehzawMSbqqkhhRtZerRzqQAgzzs
         sUZwC+09mg3ynZ714t8CYEgFlnDXqnwMMhcjHQWODpl5U/tyMSZp52gk5/Fyg3d0Wu
         Ih2W8xwghkhLA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@linaro.org, sboyd@kernel.org, robh+dt@kernel.org,
        mturquette@baylibre.com, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org,
        Devi Priya <quic_devipriy@quicinc.com>
Cc:     quic_poovendh@quicinc.com, quic_kathirav@quicinc.com,
        quic_anusha@quicinc.com, quic_sjaganat@quicinc.com,
        quic_srichara@quicinc.com, quic_arajkuma@quicinc.com
Subject: Re: (subset) [PATCH V3 0/6] Incremental patches on minimal boot support
Date:   Fri, 26 May 2023 12:38:34 -0700
Message-Id: <168512991477.248818.1956117241654375356.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425084010.15581-1-quic_devipriy@quicinc.com>
References: <20230425084010.15581-1-quic_devipriy@quicinc.com>
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

On Tue, 25 Apr 2023 14:10:04 +0530, Devi Priya wrote:
> Patchset V9 of the series: Add minimal boot support for IPQ9574 has been
> merged and is available in linux-next/master.
> V12 being the latest revision posted in the series, the delta between
> revisions V9 and V12 is posted as a separate series as suggested by
> Bjorn to avoid possible confusions.
> 
> This series adds the delta changes between revisions V9 and V12.
> 
> [...]

Applied, thanks!

[6/6] arm64: dts: qcom: ipq9574: rename al02-c7 dts to rdp433
      commit: d9556c5c6c51aad2c2f760ce953735afa9162f94

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
