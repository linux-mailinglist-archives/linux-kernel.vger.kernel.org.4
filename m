Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46721644B37
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiLFSUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiLFSTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:19:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CF61D654;
        Tue,  6 Dec 2022 10:19:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45CD7B819F3;
        Tue,  6 Dec 2022 18:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68224C433D7;
        Tue,  6 Dec 2022 18:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350789;
        bh=0JrW3wEFjds5MjZeIHwOd4D/wUK3TReXwxoNDVZJ788=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZMUHSg3zrQIEOKrnR8K5c7w8FiHGJjBd1p/aVEh919tfpskA/2YiDlQaPAjnnwJ2z
         rh0DEcw/zBjkP1gLwQrFMnxl9HO2MjnqmCfw98n0KbMOhqtgpk24QxO8oiZ3p1GRnI
         TKlYgFYPuL40Ay02k/TID/lbGgw4VCgYRc6OVSBp+hrt3n864QeL5Vnx4vOxc+1Kbk
         d5jq4ZCwIYEmovyOWCIFgekOYQlaamyCOCtPSLu/o7XlXsSHzBIGzlw3Xu2LmM5PMJ
         zIwIyUCQRkmbhKpPrHjj3L8ecT6dTPY/5Ty+M7F3KmLqADymKA9P040ETdp4bNzHGG
         Ri1kVglm0lrPg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-kernel@vger.kernel.org, dsankouski@gmail.com
Cc:     robh+dt@kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, konrad.dybcio@somainline.org,
        krzysztof.kozlowski+dt@linaro.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: (subset) [PATCH v12 0/2] add device Xiaomi Mi 6 (codename sagit) and board binding
Date:   Tue,  6 Dec 2022 12:18:53 -0600
Message-Id: <167035076330.3155086.7438680660851383396.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221112203300.536010-1-dsankouski@gmail.com>
References: <20221112203300.536010-1-dsankouski@gmail.com>
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

On Sat, 12 Nov 2022 23:32:58 +0300, Dzmitry Sankouski wrote:
> Add initial support for Xiaomi Mi 6 phone (codename sagit)
> 
> Dzmitry Sankouski (2):
>   dt-bindings: arm: add xiaomi,sagit board based on msm8998 chip
>   arm64: dts: qcom: sagit: add initial device tree for sagit
> 
> .../devicetree/bindings/arm/qcom.yaml         |   1 +
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/msm8998-xiaomi-sagit.dts    | 711 ++++++++++++++++++
>  arch/arm64/boot/dts/qcom/pm8998.dtsi          |   8 +
>  4 files changed, 721 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: sagit: add initial device tree for sagit
      commit: f86ae6f23a9e038a70f9cd0067a609da0b10893e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
