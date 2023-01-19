Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85054674C8E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjATFhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjATFgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:36:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F9D6A325;
        Thu, 19 Jan 2023 21:33:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6596B82070;
        Thu, 19 Jan 2023 04:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F27C43392;
        Thu, 19 Jan 2023 04:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674104043;
        bh=tnRloJ1g4UNmQ2OE//o+mlwI90CLntajf6uqMAcod6Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Tn6yomvZl0Wxo4GoEvVVH8r/k3SvbSwEx83NsdNBfVWUYPrZS/PsqjvVQepovBOq/
         I/CC4MwFkyZ+bURVQgZjM1syevPls6pnP0JHJgIcWI6BLrUvSRMFZr0g5Rwua8r4JV
         /r76UdPruChJESmWW3hvcF/3IjSibaW1g7eVGHVhcDNPHafzBOGFs86Iz3NVAKk7PJ
         zry2c48UZyX2jOqLA+sfOy1n6NeVOlHdaSJPK5FeGdXh0gkrUPLnbh2n9LRYznsK0p
         7ydlmYx+mpAJyYXFZWKzOqGVaSLK8MJCdt8gRuk28OzJrOrEACF29NoLT7uqt7KPk2
         4L5Z60zo/FUKA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-db845c: drop label from I2C controllers
Date:   Wed, 18 Jan 2023 22:53:58 -0600
Message-Id: <167410403676.3048186.7922935740926520662.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230113145231.79280-1-krzysztof.kozlowski@linaro.org>
References: <20230113145231.79280-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 13 Jan 2023 15:52:31 +0100, Krzysztof Kozlowski wrote:
> Geni I2C Controller node does not allow a "label" property and Linux
> driver does not parse it:
> 
>   sdm845-db845c.dtb: i2c@a8c000: Unevaluated properties are not allowed ('label' was unexpected)
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sdm845-db845c: drop label from I2C controllers
      commit: 3e7a2e8bd9b7350e34b7b0ad3eaad8219b5f5cf6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
