Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8F466539B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbjAKFWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbjAKFSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:18:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64AC13F69;
        Tue, 10 Jan 2023 21:10:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52E90B81AA0;
        Wed, 11 Jan 2023 05:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A339C433F0;
        Wed, 11 Jan 2023 05:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673413813;
        bh=8eNqRedA6q9VpBGdIGpcQR8D7AKpnlHhr1E6FnFe47M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mVjx4SwOxeAp2avJvXDHEU7sD58fexRU4pCcGhpg/8DicoXLFfGrFDCgnAs2b3OWv
         s65e1SwVlMATHAnP3uNEpdL8/NNDdET1XuMg8X3+8rn2DNiN5jX0gXezxN/TwMUvbU
         zKiUmbrGCct1vgKqaVUb0EWqs5sO0nBbjbUq1/G6DZdfJ9SOMoyChdTCz5G4vY+8Jx
         ClHSLuwRHXwYSkAKj3LExjZvsAqnQm0BNw0df2xbaf+y/a1L+o4Ef816fHvoceeS0h
         R3F6fccUeskL5Ed6aCwxOKXVhaJJCK9TxvNkFzMud7OJm+R0DClzrQS8aME6lGhcKZ
         NFH+xNVjiSbEQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     quic_gurus@quicinc.com, konrad.dybcio@linaro.org,
        quic_molvera@quicinc.com, robimarko@gmail.com, agross@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v5] dt-bindings: firmware: scm: Add QDU1000/QRU1000 compatible
Date:   Tue, 10 Jan 2023 23:09:38 -0600
Message-Id: <167341377729.2246479.1613184788965831967.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221216231312.22574-1-quic_molvera@quicinc.com>
References: <20221216231312.22574-1-quic_molvera@quicinc.com>
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

On Fri, 16 Dec 2022 15:13:12 -0800, Melody Olvera wrote:
> Add compatible for scm driver for QDU1000 and QRU1000 platforms. These
> drivers only require the compatible field, so update the bindings
> accordingly for these platforms.
> 
> 

Applied, thanks!

[1/1] dt-bindings: firmware: scm: Add QDU1000/QRU1000 compatible
      commit: 5b8db5b4f756bcb3a3f9b6577f32fc0d3867496f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
