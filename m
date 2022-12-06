Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16F4644BAE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiLFSX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiLFSXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:23:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EE7429B4;
        Tue,  6 Dec 2022 10:21:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88E05B81AD7;
        Tue,  6 Dec 2022 18:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B08C43150;
        Tue,  6 Dec 2022 18:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350827;
        bh=u9K3e0WsxTmn1FoVe5DXR4Sa042HRgCOKULMLvQUOHI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SSOTIDrAn1VQM1uuWEuY/oOS8tqBlUcymKK6Bi0sO5IX04oHlHj+OfvjzTIv6/lG6
         eWEQxn5MyPQP4kZ3QQ7hF4EzEefkg2GYDUl20eiJtcxTYVtnJFrN7cZM6j4YHoF7T2
         ONfRAKYaQqnfJXO6IajCLttmZgYzH8Bhx1Wrtw4gftn4Ny35dYkKSagmwsvHabMhlX
         5+xi0EuocM5kN1IB3EfSoFvW6Fb6AVcWylvte/TOH5n6dHPZw4CRsYDn5U31jj/n//
         ZPCu1Quu0EjDahDGSaWK+hdg+nChbDuS7AbPnriLsCQE2zKWc4XZgxQUPz+nnKP2mv
         ynxi6EjA7/J6Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, konrad.dybcio@somainline.org,
        quic_srivasam@quicinc.com, dianders@chromium.org,
        krzysztof.kozlowski+dt@linaro.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, quic_rjendra@quicinc.com, mka@chromium.org,
        devicetree@vger.kernel.org, srinivas.kandagatla@linaro.org,
        vkoul@kernel.org, judyhsiao@chromium.org, agross@kernel.org,
        quic_rohkumar@quicinc.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: Remove unused sleep pin control nodes
Date:   Tue,  6 Dec 2022 12:19:31 -0600
Message-Id: <167035076336.3155086.4193158325471887887.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <1668591184-21099-1-git-send-email-quic_srivasam@quicinc.com>
References: <1668591184-21099-1-git-send-email-quic_srivasam@quicinc.com>
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

On Wed, 16 Nov 2022 15:03:04 +0530, Srinivasa Rao Mandadapu wrote:
> Remove unused and redundant sleep pin control entries as they are
> not referenced anywhere in sc7280 based platform's device tree variants.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: Remove unused sleep pin control nodes
      commit: 7fa58dc94dd274c27cf1ab54b37d2dd54d7e18ac

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
