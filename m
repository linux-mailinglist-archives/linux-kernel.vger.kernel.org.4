Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0DD5E7461
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 08:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiIWGvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 02:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiIWGvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 02:51:21 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44771128891
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 23:51:20 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a14so13561186ljj.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 23:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=5n36C2tqfcTCjqcGkGfBQuKpTNAA2BKA5lMbPoJLYUQ=;
        b=fJmGGepxP+6q2bIHI5328Lq4ITyrloOYv1zS43szF3ZREYrzkBnONf42D6jHk+s25l
         RV2QvL/SeyLmojPAck86cTnW+P/VtmvtOTV7cohizBPTykbHHF+0S+z9GfWCWz6Fu4YC
         wwmFQ3wyyOSX2irMzapqbBkQ44KA2MW7ZzaScBU64k4eq6SzYDRtcoPtOp+G8fQaMAT9
         chVIkxfXJALs4DlMhQilRH/ZyGIEdFTyXK+Ty62ay8SkeNa8R+VaEz+OdIsrf+NzsNF9
         5ct8+yG0BbEBt8blD+5XJYs6ASJqofVKx47FlbA5iwaZpeDBeRt8DfVc+BXbdtljP5xb
         DiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5n36C2tqfcTCjqcGkGfBQuKpTNAA2BKA5lMbPoJLYUQ=;
        b=NkGiSTqgVR2yLXgeX9/LJJBbP2ZWKz201Ovp+zmAFcX0NXhdlusaLPfrQsGqKrXA2J
         Hv23izmqhujDnn6mkL+yqY6bPTGfUHmc3Q07tkpBWvRec+dh67YL3wRGEFkkhkm0X/Cn
         X62da7q8FgOtvRcG5SwQyhXndvCXupdBcfq3w4VAVm/fFAN2c4CSk06JcI2h0UOy4I0j
         +y5w8qOZVRXxsRmmJGMwwAjj0zdWh/K6RqJi5wPuwNilLtzvXFs6XL3KsObBXc54dbSr
         vaFiRa9u3oEyc+pmRUA3a65x6v4uvkO/6D60YqNNnY8R7Uvlc/TM9O8QpkMR9UzX9J4k
         asuA==
X-Gm-Message-State: ACrzQf1Mat1GYl6oXizWU5cFnJ1xHiXH3PIZj8EOvgudt80zF0BRYPX+
        JGC4JbX5hONQ+suHRp0ujGjsVsubggRqTpR9thThdw==
X-Google-Smtp-Source: AMsMyM4SYRLgKDTQtFAegqm3ErVf2J0G8v6d3X72fLkW2LgxrDp+F7ox3cOfwCkywNJMh76S2LXalTh5KpfVW9XypK8=
X-Received: by 2002:a2e:bf21:0:b0:266:2be3:61e8 with SMTP id
 c33-20020a2ebf21000000b002662be361e8mr2243397ljr.383.1663915878464; Thu, 22
 Sep 2022 23:51:18 -0700 (PDT)
MIME-Version: 1.0
References: <Yyy31OuBza1FJCXP@work>
In-Reply-To: <Yyy31OuBza1FJCXP@work>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Fri, 23 Sep 2022 08:51:07 +0200
Message-ID: <CAMGffEnPaZPw8PKq4HaB-0cbd-XyxDY4Hzrs5GxsoQKQJiCK5Q@mail.gmail.com>
Subject: Re: [PATCH] scsi: pm8001: Replace one-element array with
 flexible-array member
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jack Wang <jinpu.wang@ionos.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 9:30 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element array with flexible-array
> member in struct fw_control_info.
>
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
>
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/207
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/scsi/pm8001/pm8001_sas.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
> index c5e3f380a01c..b08f52673889 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.h
> +++ b/drivers/scsi/pm8001/pm8001_sas.h
> @@ -612,7 +612,7 @@ struct fw_control_info {
>         operations.*/
>         u32                     reserved;/* padding required for 64 bit
>         alignment */
> -       u8                      buffer[1];/* Start of buffer */
> +       u8                      buffer[];/* Start of buffer */
>  };
>  struct fw_control_ex {
>         struct fw_control_info *fw_control;
> --
> 2.34.1
>
