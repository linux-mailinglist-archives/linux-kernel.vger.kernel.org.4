Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA04D69C2D5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 23:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjBSWOK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 19 Feb 2023 17:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjBSWOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 17:14:09 -0500
Received: from smtprelay05.ispgateway.de (smtprelay05.ispgateway.de [80.67.31.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1EF166E9;
        Sun, 19 Feb 2023 14:14:08 -0800 (PST)
Received: from [80.82.223.85] (helo=mail.piie.net)
        by smtprelay05.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <peter@piie.net>)
        id 1pTrLJ-0008LS-Oh; Sun, 19 Feb 2023 22:35:33 +0100
MIME-Version: 1.0
Date:   Sun, 19 Feb 2023 21:35:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: RainLoop/1.16.0
From:   "=?utf-8?B?UGV0ZXIgS8Okc3RsZQ==?=" <peter@piie.net>
Message-ID: <08478e74cab0a5621fbcd4e0f0a97ccb@piie.net>
Subject: Re: [PATCH v1 16/17] thermal/drivers/acerhdf: Remove pointless
 governor test
To:     "Daniel Lezcano" <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Mark Gross" <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org
In-Reply-To: <20230219143657.241542-17-daniel.lezcano@linaro.org>
References: <20230219143657.241542-17-daniel.lezcano@linaro.org>
 <20230219143657.241542-1-daniel.lezcano@linaro.org>
X-Df-Sender: cGV0ZXJAcGlpZS5uZXQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

19. Februar 2023 15:38, "Daniel Lezcano" <daniel.lezcano@linaro.org> schrieb:

> The thermal zone parameter specifies the bang-bang governor.
> 
> The Kconfig selects the bang-bang governor. So it is pointless to test
> if the governor was set for the thermal zone assuming it may not have
> been compiled-in.
> 
> Remove the test and prevent another access into the thermal internals.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Peter Kaestle <peter@piie.net>


> ---
> drivers/platform/x86/acerhdf.c | 7 -------
> 1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
> index 61f1c3090867..71b9c1f922d9 100644
> --- a/drivers/platform/x86/acerhdf.c
> +++ b/drivers/platform/x86/acerhdf.c
> @@ -697,13 +697,6 @@ static int __init acerhdf_register_thermal(void)
> if (ret)
> return ret;
> 
> - if (strcmp(thz_dev->governor->name,
> - acerhdf_zone_params.governor_name)) {
> - pr_err("Didn't get thermal governor %s, perhaps not compiled into thermal subsystem.\n",
> - acerhdf_zone_params.governor_name);
> - return -EINVAL;
> - }
> -
> return 0;
> }
> 
> -- 
> 2.34.1
