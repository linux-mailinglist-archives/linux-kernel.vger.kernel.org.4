Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99B9619533
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 12:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiKDLNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 07:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKDLNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 07:13:09 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE471BE87;
        Fri,  4 Nov 2022 04:13:08 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id v8so2794558qkg.12;
        Fri, 04 Nov 2022 04:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaR1JfU6kCmmHBaKD5CB8dCLANATLZOut14SwAR1j0k=;
        b=HHccgit7GqUtAU1s9Bi+Tj+ml3XERrYI6e9VcIECWWYeRmEeuiV8lapVAetrdjCRfN
         Cq5G1Zs2tDs7DZYtAvSXtyeGcAw4D+e0CdKnTpMRtV8eUhbxt8Wom1X/MRvqAWIowcsA
         kBqEa3Idf6hAhsRRYs5COdkFWbRSEtnoTIcJFM8k2STNf0cnxMFIMlds/zO4wtNsfLAE
         4iFXONJCUV47BiRO65aiC4KgSiCaZNwEKwdUUyzo+oE9TPhOETpOYqur8HOPNcdIQqUR
         vkBCDJVtiyqwr9BRNFjqOmD2ZVMs46wVBo2fopkwd5oFKhvpk3+wktKmyYibJZI6T5pM
         G2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CaR1JfU6kCmmHBaKD5CB8dCLANATLZOut14SwAR1j0k=;
        b=z3i73EhkKrnhnSNBPIR0gTKFcG7h4lexoGziMbLkd6pZ6Bi4VfQ1YbjozJQcNHAGeP
         Iy9aIiJX8kK/RM5Ppl7mcumnxWlkR7F/KxF6UkLTqyahKzS9tJ3nC3M5y7Qwsfjgzr0p
         OlFXpLXFOLUenNYIzvWfZJglJ9jvdtS4zgqqg841RSpdnv9AEep1IVMCB0yBmY89U0jv
         NCxeKU5Mksq+3kIK+ey2PP1TvP9OOzCxHqAs5iNmpfKDG08qbIyKlrYo1LlWr58nz1QM
         6lUfPYI0Kfs+3AU9G/hg2btQd/E0jxtdwoGMcMqh05/RzU1zS5NYqzHnVvm6SCObGhp/
         o+yg==
X-Gm-Message-State: ACrzQf1E1p58hqFS7Lk2EJv4anXHavjR5DOdcMZGX6+Z/r+8Q0z/iO7i
        5lhf9gCtCyw8fRIKJSIyPm8=
X-Google-Smtp-Source: AMsMyM6QMHETvsyBDigXiPc8Ko0cOx86MG1Bq9LMe6VCjGVjqYj18GNwZIug9JPLOQw2J5hmYXxI1w==
X-Received: by 2002:a05:620a:2844:b0:6ef:757:2be7 with SMTP id h4-20020a05620a284400b006ef07572be7mr24826610qkp.253.1667560387960;
        Fri, 04 Nov 2022 04:13:07 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id s7-20020ae9de07000000b006ce76811a07sm2682728qkf.75.2022.11.04.04.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 04:13:07 -0700 (PDT)
Message-ID: <ec7046ebd4798b6b1116bbbd46430bf5363f6c38.camel@gmail.com>
Subject: Re: [PATCH 4/4] MAINTAINERS: add maintainer for ADF4377 driver
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 04 Nov 2022 12:14:34 +0100
In-Reply-To: <20221104092802.90725-5-antoniu.miclaus@analog.com>
References: <20221104092802.90725-1-antoniu.miclaus@analog.com>
         <20221104092802.90725-5-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-11-04 at 11:28 +0200, Antoniu Miclaus wrote:
> Add myself as maintainer for the ADF4377 driver.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> =C2=A0MAINTAINERS | 8 ++++++++
> =C2=A01 file changed, 8 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e1bc31a6624b..19a2f689e43e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1189,6 +1189,14 @@
> W:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0https://ez.analog.com/linux-s=
oftware-drivers
> =C2=A0F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Documentation/devicetree/bindings/i=
io/amplifiers/adi,ada4250.
> yaml
> =C2=A0F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/iio/amplifiers/ada4250.c
> =C2=A0
> +ANALOG DEVICES INC ADF4377 DRIVER
> +M:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Antoniu Miclaus <antoniu.miclaus@analog.=
com>
> +L:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0linux-iio@vger.kernel.org
> +S:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Supported
> +W:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0https://ez.analog.com/linux-software-dri=
vers
> +F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Documentation/devicetree/bindings/iio/fr=
equency/adi,adf4377.y
> aml
> +F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/iio/frequency/adf4377.c
> +
> =C2=A0ANALOG DEVICES INC ADGS1408 DRIVER
> =C2=A0M:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Mircea Caprioru <mircea.caprioru@an=
alog.com>
> =C2=A0S:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Supported

I think this file should be already added on patch 1 where the only
file would obviously be adi,adf4377.yaml.

I believe checkpatch should complain about this?

- Nuno S=C3=A1
