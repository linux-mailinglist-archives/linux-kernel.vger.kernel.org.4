Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F015773B791
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 14:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjFWMkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 08:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjFWMko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 08:40:44 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E51910C1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 05:40:39 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-666e3b15370so302150b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 05:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687524039; x=1690116039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISCGsibdUDqUNcisOUEtsn5XzzcugHFWIWC+2smDI/w=;
        b=ZaQ6V3LFlsVPXQ1/nHw/8mokcLZlAHGv7k9rEhtVIGudRKVcbD9yIbaotUHUQC/VBU
         SKX5xiijFqj2iBrA4nCKYMMjQcQBHC2HEptprgw4ihMlqRVfK1hCYfy9T7vJrGvj51Uk
         5vGQGV0ZWgoQMGNkbSTlktLcL3Kux9kN/wi9eJeQu+WjTWevlW9mXx3yW/E1MCy4al7G
         BDXhdIP+6xW3xhcr4FTpq3EjNucY9D/z4kRJOP9pOkF97DJflzcCMutQS1NEGWY1SrPX
         7acRb8gTgOFzWX3NA5PAVvmgiqftvZmAgYVF01Di1uoTeNiDrSOfbY+sN78UBDUYYcVr
         YFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687524039; x=1690116039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISCGsibdUDqUNcisOUEtsn5XzzcugHFWIWC+2smDI/w=;
        b=VSGtN/uYnmzYffRGBRckhlRpA8K1LmgzRBAAxVVdReKy6lagZzbZyuSQuz9zVP/ih2
         m/s41zQPg+xgEDArUWpurvqpCRE83JpCMNDxAOL44D8l/dZqat6bG3WMj5ycEP3uto5+
         CHeghFkvXd0+k+wcqkWhSFZ7TiHgQyoEtaF5ET1jqmJTbiuULrYBkCUorIMB/SiWk5M/
         lTur1Stnmjd9aa+F9CNx1ZKddpxQeG+mqORK9+J8pQZ/ogMWjnFK9kkrNZimgiKhmdDb
         oRHv4joNee1h8Cf8VoIkQtVDGkKoNl7TtsX9ID/JX7JGIrR4mHmnTpymv15zrvyjuItp
         SxYg==
X-Gm-Message-State: AC+VfDzHWu5qoyIE2RRw2b2unJl8YioKn5oVPpg/pOG3RP/dOud4zB+v
        XLoDTXuzO60rc7KKkcXVSeAoR0XbRbIHo89u+NA=
X-Google-Smtp-Source: ACHHUZ6beUCCKWcQZv8PMUIOiUxvk5oOmD1JrHaSMdAONNWSVlWOi04Y/5bh6NdWhcS4AORccJgq1GC6g2pQBxD6Res=
X-Received: by 2002:a05:6a20:4410:b0:121:7454:be2a with SMTP id
 ce16-20020a056a20441000b001217454be2amr15686808pzb.45.1687524039092; Fri, 23
 Jun 2023 05:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <CA+fCnZfi_o6QbfDamUjsPXjtnEwKyBn8y+T8=zxV2mEpA=DUyQ@mail.gmail.com>
 <20230623075805.1630-1-chanho.min@lge.com>
In-Reply-To: <20230623075805.1630-1-chanho.min@lge.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 23 Jun 2023 14:40:28 +0200
Message-ID: <CA+fCnZfrUY+EZ8w6zDhfjOr=JSFS6bHO7JjVHx0pEykNXZQecg@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: fix mention for KASAN_HW_TAGS
To:     Chanho Min <chanho.min@lge.com>
Cc:     dvyukov@google.com, elver@google.com, glider@google.com,
        gunho.lee@lge.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ryabinin.a.a@gmail.com, vincenzo.frascino@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 9:58=E2=80=AFAM Chanho Min <chanho.min@lge.com> wro=
te:
>
> This patch fixes description of the KASAN_HW_TAGS's memory consumption.
> KASAN_HW_TAGS are dependent on the HW implementation and are not reserved
> from system memory like shadow memory.
>
> Suggested-by: Andrey Konovalov <andreyknvl@gmail.com>
> Signed-off-by: Chanho Min <chanho.min@lge.com>
> ---
>  lib/Kconfig.kasan | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index fdca89c05745..f8f9e12510b7 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -124,7 +124,8 @@ config KASAN_HW_TAGS
>           Supported only on arm64 CPUs starting from ARMv8.5 and relies o=
n
>           Memory Tagging Extension and Top Byte Ignore.
>
> -         Consumes about 1/32nd of available memory.
> +         Does not consume memory by itself but relies on the 1/32nd of
> +         available memory being reserved by the firmware when MTE is ena=
bled.
>
>           May potentially introduce problems related to pointer casting a=
nd
>           comparison, as it embeds a tag into the top byte of each pointe=
r.
> --
> 2.17.1
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thank you!
