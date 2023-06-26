Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9E673EB1D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 21:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjFZTRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 15:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjFZTRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 15:17:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62897126;
        Mon, 26 Jun 2023 12:17:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 312E060F52;
        Mon, 26 Jun 2023 19:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66A5C433CB;
        Mon, 26 Jun 2023 19:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687807039;
        bh=rkjWIfbK3YebeF1MEXAL65ADnay9qjJ8ivuCSqI8mlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ihs2F23wElm6hQ/AtEwqeHq7IbUQmj3CbDatoXHo1IRubVEEvV0LGrz9EaIwjnYzI
         UR86dPbeJVpldceMVSG2ty64C1ePtwvQB8NA5wqntcyJs/JuSDH0RqFevEpgZun7ge
         QPijFW60xRDzdfMPtGewR9aDlhuGCJriaaBMvmwBE2al1MdyP9SkSX00WLGlUvHbZF
         djxGizVSh4M8H/irGJlDofxIX7iMN94YNt1Vn3lubANIjF/pB10yACkacXdj/RIuj7
         9mlyGfY3nWcCJaxw7U8cqcZL6bHFtQgUE8oBMtsJGWebDjM0OWA6ygr9/trxPid4+M
         Xn//ViVZ6iSaA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Luca Weiss <luca.weiss@fairphone.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8350: fix BAM DMA crash and reboot
Date:   Mon, 26 Jun 2023 12:21:12 -0700
Message-ID: <168780207959.2579463.5860632674478467624.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626145959.646747-1-krzysztof.kozlowski@linaro.org>
References: <20230626145959.646747-1-krzysztof.kozlowski@linaro.org>
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


On Mon, 26 Jun 2023 16:59:59 +0200, Krzysztof Kozlowski wrote:
> SM8350 HDK and MTP boards were silently dying and rebooting during BAM
> DMA probe, probably during reading BAM_REVISION register:
> 
>   [    1.574304] vreg_bob: Setting 3008000-3960000uV
>   [    1.576918] bam-dFormat: Log Type - Time(microsec) - Message -
>   Optional Info
>   Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
>   S - QC_IMAGE_VERSION_STRING=BOOT.MXF.1.0-00637.1-LAHAINA-1
>   S - IMAGE_VARIANT_STRING=SocLahainaLAA
>   S - OEM_IMAGE_VERSION_STRING=crm-ubuntu77
>   S - Boot Interface: UFS
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sm8350: fix BAM DMA crash and reboot
      commit: f470c3a03eb3099a6dd8ca58ffddd9a9a7d93c9d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
