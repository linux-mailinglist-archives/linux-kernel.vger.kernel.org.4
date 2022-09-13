Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAD35B7804
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbiIMRcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbiIMRcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:32:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BB99F8F3;
        Tue, 13 Sep 2022 09:20:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0E73B80F9C;
        Tue, 13 Sep 2022 15:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D9FC433D7;
        Tue, 13 Sep 2022 15:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663081494;
        bh=5LqduA3tskL2oNsFJWLd4UAprbXLVMGFZMgrSaQcZCM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=daSpTpqAy9o64y6S6etRmYK7vqNcaxzvmSRG6wMkKX/8IXcaqHFDFIuxz0hq6CVws
         ZsbJCkiV9e5zN+1dtD2v9qsfTmKb6rRTJ2mB7IsLb2g70wXPVFS9HO2mmfMRQHvlOO
         WnEj3YjFLw71nyXnWCype1gl0TgAdmSS6T94/YpqWmB5yeO2TSAh/zES24KE8ADZzJ
         BMP3iai3RjTM5M2wcI7O3CWQQdYP5JVuLyGawHGzDAvJGGg4ekq0W1/n4MB+VRCyZn
         FWq8Jn8CHhlJ1vtwAKaZ9pipRRhMvK326MeteeSUzZ/rgFYOLFRcaKvkY+OB6r3CfA
         WmJYCrzagc0Dg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     quic_srivasam@quicinc.com, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        srinivas.kandagatla@linaro.org, swboyd@chromium.org,
        judyhsiao@chromium.org, robh+dt@kernel.org, dianders@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, quic_rohkumar@quicinc.com
Subject: Re: [PATCH v14 00/12] Add soundcard support for sc7280 based platforms.
Date:   Tue, 13 Sep 2022 10:04:46 -0500
Message-Id: <166308148204.625876.4441160183565553499.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <1657200184-29565-1-git-send-email-quic_srivasam@quicinc.com>
References: <1657200184-29565-1-git-send-email-quic_srivasam@quicinc.com>
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

On Thu, 7 Jul 2022 18:52:52 +0530, Srinivasa Rao Mandadapu wrote:
> This patch set is to add bolero digital macros, WCD and maxim codecs nodes
> for audio on sc7280 based platforms.
> 
> This patch set depends on:
>     [LPASS DTS: wcd related pinmux reorg]
>     -- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=657389
>     [Clock DTS: reset control changes]
>     -- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=638002
>     [Clock: External MCLK and reset control driver changes]
>     -- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=650267
>     [Clock DTS: lpasscc node disable and lpasscore node name changes]
>     -- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=657325
> 
> [...]

Applied, thanks!

[01/12] arm64: dts: qcom: sc7280: Add nodes for soundwire and va tx rx digital macro codecs
        commit: 12ef689f09abb50f0862c8e08138dd45cbf27233
[02/12] arm64: dts: qcom: sc7280: Enable digital codecs and soundwire for CRD 1.0/2.0 and IDP boards
        commit: d3219de8bcebe4057696a2f99ce90c8812114c78
[03/12] arm64: dts: qcom: sc7280: Enable digital codecs and soundwire for CRD 3.0/3.1
        commit: d5a959f96be1b27c81d6197d66624cd6cc146fe6
[04/12] arm64: dts: qcom: sc7280: Add wcd9385 codec node for CRD 1.0/2.0 and IDP boards
        commit: f8b4eb64f2003e0a1fa5011009955d46f90af285
[05/12] arm64: dts: qcom: sc7280: Add wcd9385 codec node for CRD 3.0/3.1
        commit: 0a3a56a93fd96cb3e3d42778f275e91750c242a7
[06/12] arm64: dts: qcom: sc7280: Add max98360a codec for CRD 1.0/2.0 and IDP boards
        commit: d6c006f510d9f29ff78761bb3ef50f14ebc05b7b
[07/12] arm64: dts: qcom: sc7280: herobrine: Add max98360a codec node
        commit: 14afeaf917375967bb84b4347cd8e4156b84c470
[08/12] arm64: dts: qcom: sc7280: Add lpass cpu node
        commit: aee6873edb93a3919706f70884e55880d8c727a5
[09/12] arm64: dts: qcom: sc7280: Enable lpass cpu node for CRD 1.0/2.0 and IDP boards.
        commit: 8cf4133bc1fbb6fbc695e4398b940caf3ec59ba5
[10/12] arm64: dts: qcom: sc7280: Enable lpass cpu node for CRD 3.0/3.1
        commit: f10c73ac6e90ca2343fc4f06b61ce8c1824c9bfd
[11/12] arm64: dts: qcom: sc7280: Add sound node for CRD 1.0/2.0 and IDP boards
        commit: ece7d81f2447f4fd4f5d5345e921036871babf2b
[12/12] arm64: dts: qcom: sc7280: Add sound node for CRD 3.0/3.1
        commit: 29e0b604f040ef794cd36d43b97bd9c040ed99e6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
