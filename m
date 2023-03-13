Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A181E6B7F06
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjCMRMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 13:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjCMRMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:12:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8754378CAF;
        Mon, 13 Mar 2023 10:12:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB84061381;
        Mon, 13 Mar 2023 17:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E9CC433D2;
        Mon, 13 Mar 2023 17:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678727457;
        bh=TfkrdOzkQUc6TYJLSK83JqRjukZ8MCdi1haBPS0yyd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pg5VRXnIcngq7qvpO+FpDE6R2M9IgmqIhh4f6wpLvdqtR1ZOtUNyoCm781m0KZWH6
         My3GnouAAoEZZwcWEGA+9gJJg9ydwXakZnwJcx4wPt/0QU9gb7AIPKNgTt3uwzX36a
         wR47lRLAQcQFTZFHgkSwVxvtuJM7RuqUdVxnSBpU7lNI2iNa4Imue5Ody4fUQODdc6
         bktL8HhNj65VSir3iPDevgmTF2/3rETPzWdtzAAUa+9olqPQHZ0yS7JclZtrFzk8GM
         KecJM6MW3Bfnhc3EVLcdHMVcH/StNCI564vOghwn4W8tCCfuwKxkR4RQK2D2dNs1it
         QBMwARQKz/Kag==
Date:   Mon, 13 Mar 2023 17:10:53 +0000
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: tlc591xx: Mark OF related data as maybe unused
Message-ID: <20230313171053.GX9667@google.com>
References: <20230311111717.252019-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230311111717.252019-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Mar 2023, Krzysztof Kozlowski wrote:

> The driver can be compile tested with !CONFIG_OF making certain data
> unused:
>
>   drivers/leds/leds-tlc591xx.c:138:34: error: ‘of_tlc591xx_leds_match’ defined but not used [-Werror=unused-const-variable=]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/leds/leds-tlc591xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

--
Lee Jones [李琼斯]
