Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B08F70D206
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 05:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbjEWC76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbjEWC7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:59:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D17FD;
        Mon, 22 May 2023 19:59:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1623662E6A;
        Tue, 23 May 2023 02:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF3EC4339B;
        Tue, 23 May 2023 02:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684810776;
        bh=pvIPSBiyBTpkvVfSwN63rDE4OUcBOntmu3pG7JF4pM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pBNo98v/I8TLYz51F0mLTu3e0ywIvlOErKtgztFMPiwoSpky4KSaPoh5Byk/Ll65f
         nN08jjT6lb4IKGaXTxp21aILbJVvHFcTRIaz+axDfWdKtsUY9PunO4lhmVrzsr/gM8
         Fz2nH4ChHxoq79j85zFrAl37KS34sIxPWEbkQFKpCph8DWzlw++ckXyP3t8Y3j3+Lf
         IsUGHP5YyG87EDSedD3XmbRC3vTk1jTOmWL4u15ucRyEnrpGm2Y/MjeVBjgwKOvcTv
         XloOHjJOD0U5WhxcpkaAEXo5ABbmYw8kyf+/77/As3zxqgRUAHZnZ55KcjkUs0T1gc
         ywCoWk/27S3gw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc8280xp: Add SDC2 and enable on CRD
Date:   Mon, 22 May 2023 20:03:24 -0700
Message-Id: <168481094822.1229550.17088092935862462166.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230517235217.1728548-1-quic_bjorande@quicinc.com>
References: <20230517235217.1728548-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 16:52:17 -0700, Bjorn Andersson wrote:
> The CRD has Micro SD slot, introduce the necessary DeviceTree nodes for
> enabling this.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp: Add SDC2 and enable on CRD
      commit: ef026e592baa01dd7402511e5ced90f4b3ac3d2c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
