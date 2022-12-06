Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD01644BAA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiLFSXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiLFSWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:22:45 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA55419BF;
        Tue,  6 Dec 2022 10:21:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 67809CE1AF4;
        Tue,  6 Dec 2022 18:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B21DC43470;
        Tue,  6 Dec 2022 18:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350824;
        bh=W0rW7LGVlEly5PDyeTXseV6iTTymteal8/GSAJxVVqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U4BBuvgu7RoJKxn9GS1yP36WlGuI178RC3KJfxj4H8HIIG7tcsXBGb7U2GmumatOg
         kzouq2Qap51RmAwsjZr5LdqJJ80/t9TCgMbQJo9L74X386eWB13BP3LNdfVwxpbL+t
         5WO39/nus8Dxu4drZvo7+C/bfdjhv723DM2UIR2DmpGW7cZ2KXxIIKIBgTmndLqSD1
         VYGhz0EjULLM5ojuSDDYzz6wpUJ+QnRLmXfTuXga6KIB69Ze0WiF4FgcuQacT4hfuu
         KT7EjaOViJA2qWbf8F64qHUMuEgTsbDLmBf3nBPIFNUTOjQHvhWPF1DiozfK4zCD1A
         3Mb2R0cbIvWFQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, konrad.dybcio@somainline.org,
        krzysztof.kozlowski+dt@linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, quic_jinlmao@quicinc.com,
        Andy Gross <agross@kernel.org>, mike.leach@linaro.org
Cc:     quic_yuanfang@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        quic_tingweiz@quicinc.com, quic_hazha@quicinc.com,
        devicetree@vger.kernel.org, quic_tsoni@quicinc.com,
        quic_taozha@quicinc.com
Subject: Re: [PATCH] arm64: dts: qcom: sm8250: Add coresight components
Date:   Tue,  6 Dec 2022 12:19:29 -0600
Message-Id: <167035076333.3155086.6623755717508254704.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221114091251.13939-1-quic_jinlmao@quicinc.com>
References: <20221114091251.13939-1-quic_jinlmao@quicinc.com>
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

On Mon, 14 Nov 2022 17:12:51 +0800, Mao Jinlong wrote:
> Add coresight components for sm8250. STM/ETM are added.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8250: Add coresight components
      commit: 7960de64218136e928fe90635ec9132e68d41015

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
