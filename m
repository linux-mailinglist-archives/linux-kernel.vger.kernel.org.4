Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74096C36D3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjCUQVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCUQVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:21:41 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D328AFF02
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 09:21:39 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id ek18so61913262edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 09:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679415698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lN54tDUmXf9hwv+PXMNCl+jsvxs7b+LzMxVySPVN8ik=;
        b=TP7xcMAp4UQxJz2ItJv3FiZYU+VFst7DjGgMIXfyglYpdwVEdVDe03mdwalZVRAzcJ
         XKpUZ1MP82LkAsPWPjKY29lBDwMQSzhIjnF7LV7TzlLXf4Ad9f/qOf/NEs1Tf7vUDBhl
         VNVz4ccP4nCVi+i7jH9H8m+/VTzwGF01Za/sFk7gVV8EMFc2gIi89YkGHXRdfpPxOtM5
         sL9KLhhIJ8nZTPR4bys4F5iwSbmUAbEyqoI8lCbsbznO4xrtzLvd+gDp0XRI6IStzUxe
         yuCU1diSGOVnsU75ns8aRPohEq6t/mJQVoXmNKjDk03CYHEo6V+CHF14f9Qhu2tLrcZO
         hnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679415698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lN54tDUmXf9hwv+PXMNCl+jsvxs7b+LzMxVySPVN8ik=;
        b=OhUFM7UCRQFmj11j4kw023f4h7CpsRtEBmUVINiKnyBuoblIXoZiV3AUfxTSQ+wOUy
         YAPBwyHcmX/VujDUTjw9TRkk2Q5wuhz959wyp/9hVsgTtnwweqK5z2F4QNmH6QPY41Ut
         Tgt/gwAqWjhHVBmE/F9fX5xWRWIKzvEeIlHUbS7I1qoFjUBbD578hsFr8fd5A5ueNsDZ
         dBAKLNqxWNi1Ve6IhoLe4F7NaVBa3aZOhZtN4pkkve3RVG0i3noJcRBMuoubuHP+gWC4
         k4e9FX0lwVRnX+PdW5TxG1vCJYaHlyrDHLvwomUtnND9kNHn87eI3pYnm/ldfXvOI1EB
         trQw==
X-Gm-Message-State: AO0yUKUNH1rwetn1lt2jSpIsKJ+uQy9agdJNI+as1/DNETyzs1R1bCU5
        DrelQQZ8Ok+liE6rb9aAM2swNzD/KMNUUonr
X-Google-Smtp-Source: AK7set9n+TEYOTN5JF+wpsOMVpXYpeA2AgUrMGIGu3uxrhtF1oKub2rMRl/BdhdUV2wyGEenG8Sf2A==
X-Received: by 2002:a17:906:d14d:b0:931:de86:1879 with SMTP id br13-20020a170906d14d00b00931de861879mr3945437ejb.9.1679415698145;
        Tue, 21 Mar 2023 09:21:38 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id v19-20020a1709067d9300b008cff300cf47sm5977472ejo.72.2023.03.21.09.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 09:21:37 -0700 (PDT)
Date:   Tue, 21 Mar 2023 21:21:35 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: greybus: merge split lines
Message-ID: <ZBnZj3JbTOsplHvw@khadija-virtual-machine>
References: <ZBgYsqkpdYpGQniB@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBgYsqkpdYpGQniB@khadija-virtual-machine>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 01:26:33PM +0500, Khadija Kamran wrote:
> If condition and spin_unlock_...() call is split into two lines, merge
> them to form a single line.
> 
> Suggested-by: Deepak R Varma drv@mailo.com
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
> 
> Changes in v3:
>  - Removing tab to fix line length results in a new checkpatch warning,
>    so let the fix length be as it is.
> Changes in v2:
>  - Rephrased he subject and description
>  - Merged if_condition() and spin_unlock...() into one line
>  - Link to patch:
>  https://lore.kernel.org/outreachy/ZAusnKYVTGvO5zoi@khadija-virtual-machine/
> 
> Link to first patch:
> https://lore.kernel.org/outreachy/ZAtkW6g6DwPg%2FpDp@khadija-virtual-machine/
> 
>  drivers/staging/greybus/arche-platform.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> index fcbd5f71eff2..6890710afdfc 100644
> --- a/drivers/staging/greybus/arche-platform.c
> +++ b/drivers/staging/greybus/arche-platform.c
> @@ -176,12 +176,10 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
>  				 * Check we are not in middle of irq thread
>  				 * already
>  				 */
> -				if (arche_pdata->wake_detect_state !=
> -						WD_STATE_COLDBOOT_START) {
> +				if (arche_pdata->wake_detect_state != WD_STATE_COLDBOOT_START) {
>  					arche_platform_set_wake_detect_state(arche_pdata,
>  									     WD_STATE_COLDBOOT_TRIG);
> -					spin_unlock_irqrestore(&arche_pdata->wake_lock,
> -							       flags);
> +					spin_unlock_irqrestore(&arche_pdata->wake_lock, flags);
>  					return IRQ_WAKE_THREAD;
>  				}
>  			}
> --
> 2.34.1
>

Hey Outreachy Mentors,

Kindly take a look at this patch and let me know if it is okay to work
on this file or should I look for other cleanup patches.

Thank you for your time.
Regards,
Khadija

