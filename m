Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61175B7D48
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 00:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiIMWsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 18:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiIMWsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 18:48:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6000552DCA;
        Tue, 13 Sep 2022 15:48:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12EBCB8116E;
        Tue, 13 Sep 2022 22:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B951C43140;
        Tue, 13 Sep 2022 22:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663109293;
        bh=MENSv+WJhCxh7t871Tua7lJxyFXhRm+It0tZOQhjkeM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=by/AYS0HXgeUfYbgz2cqSxWHmVaWEQEYUTzzmPT3N4gs1MPljvYflrRN8xxCwcef4
         BfQsYRrXuhGFHA71E2Mi7eC61bCulKYkHDiNhsVTr6r66H072SClwmH4BCh6tZdiKi
         oi2zyOYg45Il36fhUjq8wI8uJAtSN+dzdUTTaycmRVm3czSndRR/0zBciczm0vhP1I
         8luJKTjQdc4VvUV6CyTp7WZdKDvD9iEkibVa7vLuky7blLgVBHSRjVnki6kpwAw0Km
         xs2hVBQdbNr3ohiQ33CiYddHuT3M2donFJZepirgTsBcczNiIiR8IlFqAQ0UsFJUp/
         x9vx3LTMhxbNw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-kernel@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH] dt-bindings: power: qcom,rpmpd: drop non-working codeaurora.org emails
Date:   Tue, 13 Sep 2022 17:48:06 -0500
Message-Id: <166310928489.670084.9081414668421801077.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220911112508.202995-1-krzysztof.kozlowski@linaro.org>
References: <20220911112508.202995-1-krzysztof.kozlowski@linaro.org>
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

On Sun, 11 Sep 2022 13:25:08 +0200, Krzysztof Kozlowski wrote:
> Emails to codeaurora.org bounce ("Recipient address rejected:
> undeliverable address: No such user here.").
> 
> 

Applied, thanks!

[1/1] dt-bindings: power: qcom,rpmpd: drop non-working codeaurora.org emails
      commit: bcd8868b1d84d91409b0c8a3daa3d04dc1733b37

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
