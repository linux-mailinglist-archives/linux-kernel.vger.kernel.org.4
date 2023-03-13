Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A1C6B7939
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjCMNmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjCMNmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:42:18 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47BD62B79
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 06:42:13 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B0DCDE0007;
        Mon, 13 Mar 2023 13:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678714932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQfjLHn0hc/LhzNeHhR21iVt0zMEaX3G+uok5izD1iw=;
        b=KqzhHPkRI8L/xdrJa59vCdamwXCECstAKvIHzNVZtBTZZ2kfiOKqjs7l8wMDrZ6CkRUCo/
        tEyXveeYVFbRI6JJ+QuRYNRDqu1cw+zFehju8mF8W+OvdOZkcY1rOaYDbMqBC37ps5Gz+8
        PnkXI/m7bdKQF7PrdEyAcjNs3nM+wkksQrxJNV3hgpgjPB3Zp+JgzJhAHt706m44mDnRLG
        jCJLimH5KqBUV84j/3TEMlDpazXYHAdEXMDDotxhKarGX3kCzxskyBiPNwAcaytt/8z4/R
        OVVQyULkL+pQFZAPzFn2CWtcCXxXjOdlekAvIVLt+ifz68yk1rT0uKrTP/sW4g==
Date:   Mon, 13 Mar 2023 14:42:09 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] i3c: dw: drop of_match_ptr for ID table
Message-ID: <167871488920.397851.11346721699258114456.b4-ty@bootlin.com>
References: <20230312132535.352246-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230312132535.352246-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 12 Mar 2023 14:25:35 +0100, Krzysztof Kozlowski wrote:
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it might not be relevant here).  This
> also fixes !CONFIG_OF error:
> 
>   drivers/i3c/master/dw-i3c-master.c:1201:34: error: ‘dw_i3c_master_of_match’ defined but not used [-Werror=unused-const-variable=]
> 
> [...]

Applied, thanks!

[1/1] i3c: dw: drop of_match_ptr for ID table
      commit: 1dae3f1df7005e27a0040855ce8b3c21c262e3b2

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
