Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA54D6459EF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 13:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiLGMiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 07:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiLGMiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 07:38:08 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A259DC56
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 04:37:59 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id f9so16262843pgf.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 04:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vJpWKzcufnxvrG4FDvIiDfDPCvOWzz7Bie3aByLyjGA=;
        b=EaZc+tV9EivblvWu0jwweYQvTfdciUyXndefS0cdFocY4gBgc8Qv242gf3JdqcfrOL
         Krox+LdAG9cvMfYydtq0V3SAKf+IP8XsKGITQfJAibIODttF4nx5eYwtNRsB92yk3+cZ
         vBt6kDbu1gXKAljaDFsiCbAPYVlN553sfZGwjB7+vGPuxr/Jh0uTqB6v3QHAPrk/l6VG
         14xq5x/5Qh06MNplKvI09yMXc6dPDIH7Zi3ETBtLAv6XZNG2ThgBGuZY6NejGc2VVZhK
         30bVwOIi0JCo1VD62AXrHm/jHmRAzsS+tpeaB4ajjrAyK5hzk/U8X2ETdjXXNlz3N/Sx
         TeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJpWKzcufnxvrG4FDvIiDfDPCvOWzz7Bie3aByLyjGA=;
        b=n+R4902JYp5A1NLyWeJ95/E+INzomZ0sf5XTe8dWz19Tkgpw78BAOqe2v1D1AabFIi
         6FUOrlpzQ+0DkEYrjetn6TrK422eT6L+himGM3XHDTbjVuT4hZufZsLMRwdigDrvo+k9
         L1C7qyAWAXBavs0KjKtzwsECeZA17wbfKR/NXKa3PDSBlKJOkR52d4vJ6qICqKAlUyKE
         Qp/+cmO0jUXXJkcJbi/5vPn1vK2baDnBJki1fDiLUFlrX+eSWadMUbJ7qtymCYZ+VhSY
         UjXesLrQGypaZqgpQeQMgyOJjXdC6DfMrkJ5T/1ggT0a5CIW7rryQAbKge1Oho1gKJQQ
         SC5g==
X-Gm-Message-State: ANoB5plOf/iqfmvUM08xIBBdBpYRq6B+fvy5tcBj79RKsapkhS+5w5mU
        63t51DV7XCAJlTvOTZeL01miyxaeG1Tmt4se5qZdyc6nuw0/6A==
X-Google-Smtp-Source: AA0mqf4F73nkDpLKoHQMfc2A7c1ijf/S4SR6XUOnX2+swfIccB2ewi2eg+kpxC/iknpspWWbVIxErOFl9wpExPNRWNU=
X-Received: by 2002:a63:2154:0:b0:477:b650:494b with SMTP id
 s20-20020a632154000000b00477b650494bmr62080305pgm.434.1670416679067; Wed, 07
 Dec 2022 04:37:59 -0800 (PST)
MIME-Version: 1.0
References: <202212021031575255977@zte.com.cn>
In-Reply-To: <202212021031575255977@zte.com.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 7 Dec 2022 13:37:22 +0100
Message-ID: <CAPDyKFoP8DBFg-HvWzZq28mdkTrbA_Jhmvio=DN7FQr8cgU6sg@mail.gmail.com>
Subject: Re: [PATCH linux-next v2] mmc: sdhci: Remove unneeded semicolon
To:     zhang.songyi@zte.com.cn
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2022 at 03:32, <zhang.songyi@zte.com.cn> wrote:
>
> From: zhang songyi <zhang.songyi@zte.com.cn>
>
> The semicolon after the "}" is unneeded.
>
> Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 42aaeabcad22..8413180a1039 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2289,7 +2289,7 @@ static bool sdhci_timing_has_preset(unsigned char timing)
>         case MMC_TIMING_UHS_DDR50:
>         case MMC_TIMING_MMC_DDR52:
>                 return true;
> -       };
> +       }
>         return false;
>  }
>
> --
> 2.15.2
