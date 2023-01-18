Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C69F6728FC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjARUFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjARUE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:04:57 -0500
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AF059761;
        Wed, 18 Jan 2023 12:04:50 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id y11so120930edd.6;
        Wed, 18 Jan 2023 12:04:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYqhoJmoJb6YJL3uVlmiN1AfZHw+rBK4PG67UqSeJlo=;
        b=wKnzl4t+jJ89XF5NsRd8My22iDV8UEPy6gKFX17ytValLkBabN9s9fbnrPAdIq+Hjj
         TsEGvkWjd1lP73BOhQsgTvW5fYWW5lCHe83xpVK7Te8TtxNsPxxfgz6FCez+tmzjNoXb
         YmIaf1s5DowTYv4QVmzQRzjwmasrbTCz6wr6ofV/i6W9UL3e+5Jo2fpot6OSTjhFyXV1
         fp9FrbATt9Tc3fe/V7zNHgROQrk2Ye5HZ7HmUZqpJEXJa1ouGFDkhcW5zTk83+ut+PVv
         sNkQIpE8OJHegi7rOipNMZ7Ho1edYUqCOupaWU6UesnEx2T6Rt1lWblCMMWZZYw2SaOK
         C0hA==
X-Gm-Message-State: AFqh2kqOnXECTYIu9F/NySgZSjGvsxK56Rtfv0clRb3i0x5ITB4kQm3S
        Y0M/kJnNLilqGTIF4MEfIOpICPtyB8jUnQisdpo=
X-Google-Smtp-Source: AMrXdXuHO0wmN6pgwxtfJledZud+cVIlKlvRCmM5bb4+W6FJd7fkqKGo2TOTPc3Wf+4fwiv+cPuDldnJNpPWdZ9oVB4=
X-Received: by 2002:a05:6402:94a:b0:47f:7465:6e76 with SMTP id
 h10-20020a056402094a00b0047f74656e76mr833058edz.181.1674072288871; Wed, 18
 Jan 2023 12:04:48 -0800 (PST)
MIME-Version: 1.0
References: <20230118012057.4423-1-wangdeming@inspur.com>
In-Reply-To: <20230118012057.4423-1-wangdeming@inspur.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 Jan 2023 21:04:37 +0100
Message-ID: <CAJZ5v0i+2a_Bm1oBoYGoU0Sps-w+w2Eb5YWuVXvjxZvz97fGEg@mail.gmail.com>
Subject: Re: [PATCH] thermal/intel: Modify function description
To:     Deming Wang <wangdeming@inspur.com>
Cc:     sujith.thomas@intel.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 2:21 AM Deming Wang <wangdeming@inspur.com> wrote:
>
> Delete the wrong description and add the corresponding description.
>
> Signed-off-by: Deming Wang <wangdeming@inspur.com>
> ---
>  drivers/thermal/intel/intel_menlow.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_menlow.c b/drivers/thermal/intel/intel_menlow.c
> index 3f885b08a490..5a6ad0552311 100644
> --- a/drivers/thermal/intel/intel_menlow.c
> +++ b/drivers/thermal/intel/intel_menlow.c
> @@ -232,9 +232,9 @@ static DEFINE_MUTEX(intel_menlow_attr_lock);
>
>  /*
>   * sensor_get_auxtrip - get the current auxtrip value from sensor
> - * @name: Thermalzone name
> - * @auxtype : AUX0/AUX1
> - * @buf: syfs buffer
> + * @handle: Object handle
> + * @index : GET_AUX1/GET_AUX0
> + * @value : The address will be fill by the value
>   */
>  static int sensor_get_auxtrip(acpi_handle handle, int index,
>                                                         unsigned long long *value)
> @@ -254,9 +254,9 @@ static int sensor_get_auxtrip(acpi_handle handle, int index,
>
>  /*
>   * sensor_set_auxtrip - set the new auxtrip value to sensor
> - * @name: Thermalzone name
> - * @auxtype : AUX0/AUX1
> - * @buf: syfs buffer
> + * @handle: Object handle
> + * @index : GET_AUX1/GET_AUX0
> + * @value : The value will be set
>   */
>  static int sensor_set_auxtrip(acpi_handle handle, int index, int value)
>  {
> --

Applied as 6.3 material with edits in the subject and a modified
changelog, thanks!
