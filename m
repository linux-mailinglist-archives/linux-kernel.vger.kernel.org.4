Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E539624DB5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 23:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiKJWm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 17:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiKJWm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 17:42:56 -0500
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0695C4D5FD;
        Thu, 10 Nov 2022 14:42:49 -0800 (PST)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4N7cL13cW2z9s5L;
        Thu, 10 Nov 2022 22:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1668120169; bh=eTsOkKe/z7V7znmebzl1yS6PW79TQnuYs70ipR6XOX0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bSY4JhCbi9Tx+/NWJZrwXXrDDpzhNYCNAt800P/WsY86vmxiWODSbepF/nFgzQwvw
         DlRhCp43wZbfqYRg6mqk6KY3PRFE/wIwmT7foZR/E2hMEpRfBk/4T9nWR8MW9fE9Jc
         PxURx8lFxamlBgQUwige45ZlywBbGDtG67aKb8Ik=
X-Riseup-User-ID: D0416B78300ACD8DC25C7A895C562117F7327F20D997EA8817293B54645C267E
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4N7cKz3tTWz1yQc;
        Thu, 10 Nov 2022 22:42:47 +0000 (UTC)
Message-ID: <167bf351-97e7-f26a-37c7-b8446f16e087@riseup.net>
Date:   Thu, 10 Nov 2022 19:42:44 -0300
MIME-Version: 1.0
Subject: Re: [PATCH] HID: uclogic: Standardize test name prefix
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221110174955.398885-1-jose.exposito89@gmail.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <20221110174955.398885-1-jose.exposito89@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi José,

On 11/10/22 14:49, José Expósito wrote:
> Commit 961bcdf956a4 ("drm/tests: Change "igt_" prefix to "drm_test_"")
> introduced a new naming convention for the KUnit tests present in the
> DRM subsystem: "drm_test_<module>_<test name>".
>> This naming convention is very convenient because it allows to easily
> run all subsystem tests or all driver tests using kunit.py's wildcards.
> 
> Follow the naming conventions used in the DRM subsystem adapted to the
> HID subsystem: "hid_test_<module>_<test name>".
> 
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>

It is great to see this coming to other subsystems!

Reviewed-by: Maíra Canal <mairacanal@riseup.net>

Best Regards,
- Maíra Canal

> ---
>  drivers/hid/hid-uclogic-params-test.c | 4 ++--
>  drivers/hid/hid-uclogic-rdesc-test.c  | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/hid-uclogic-params-test.c b/drivers/hid/hid-uclogic-params-test.c
> index 57ef5d3e4b74..bfa7ccb7d1e8 100644
> --- a/drivers/hid/hid-uclogic-params-test.c
> +++ b/drivers/hid/hid-uclogic-params-test.c
> @@ -136,7 +136,7 @@ static void uclogic_parse_ugee_v2_desc_case_desc(struct uclogic_parse_ugee_v2_de
>  KUNIT_ARRAY_PARAM(uclogic_parse_ugee_v2_desc, uclogic_parse_ugee_v2_desc_cases,
>  		  uclogic_parse_ugee_v2_desc_case_desc);
>  
> -static void uclogic_parse_ugee_v2_desc_test(struct kunit *test)
> +static void hid_test_uclogic_parse_ugee_v2_desc(struct kunit *test)
>  {
>  	int res;
>  	s32 desc_params[UCLOGIC_RDESC_PH_ID_NUM];
> @@ -175,7 +175,7 @@ static void uclogic_parse_ugee_v2_desc_test(struct kunit *test)
>  }
>  
>  static struct kunit_case hid_uclogic_params_test_cases[] = {
> -	KUNIT_CASE_PARAM(uclogic_parse_ugee_v2_desc_test,
> +	KUNIT_CASE_PARAM(hid_test_uclogic_parse_ugee_v2_desc,
>  			 uclogic_parse_ugee_v2_desc_gen_params),
>  	{}
>  };
> diff --git a/drivers/hid/hid-uclogic-rdesc-test.c b/drivers/hid/hid-uclogic-rdesc-test.c
> index 3971a0854c3e..b429c541bf2f 100644
> --- a/drivers/hid/hid-uclogic-rdesc-test.c
> +++ b/drivers/hid/hid-uclogic-rdesc-test.c
> @@ -187,7 +187,7 @@ static void uclogic_template_case_desc(struct uclogic_template_case *t,
>  KUNIT_ARRAY_PARAM(uclogic_template, uclogic_template_cases,
>  		  uclogic_template_case_desc);
>  
> -static void uclogic_template_test(struct kunit *test)
> +static void hid_test_uclogic_template(struct kunit *test)
>  {
>  	__u8 *res;
>  	const struct uclogic_template_case *params = test->param_value;
> @@ -203,7 +203,7 @@ static void uclogic_template_test(struct kunit *test)
>  }
>  
>  static struct kunit_case hid_uclogic_rdesc_test_cases[] = {
> -	KUNIT_CASE_PARAM(uclogic_template_test, uclogic_template_gen_params),
> +	KUNIT_CASE_PARAM(hid_test_uclogic_template, uclogic_template_gen_params),
>  	{}
>  };
>  
