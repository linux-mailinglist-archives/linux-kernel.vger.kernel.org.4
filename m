Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C296EE523
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 17:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbjDYP7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 11:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbjDYP7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 11:59:13 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE4B12CB0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 08:59:11 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-956eacbe651so1056619266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 08:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1682438350; x=1685030350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlVv7Swj2O3m3L5cE82fdv0axa/JD3/qF8vAE3hvBOE=;
        b=ll3RRXB/RVF8ksY5feM+iRM7O6hUuJS5r7TOWhZzn0+nzyq/FqkwBI8cPAlpTaR8ia
         GimbgCjjiy6GHHDfIIy92w7aeFKEW9Z/LtX5DUtoNnv6TchZQISjqelJOnriqe4ZRoTI
         wHEyr/Ju7ICpKgS3EhsURxGqSivt94F3p0lIbtrSWA7SZ2QTPtLqKCKtorkdpX1uL4FW
         SRSv4zstbLnKwasiWRiPB67GXc/WlNS2+/Kv016dLdDmMw9Q3jTCgMmyYtvSlWA6dicX
         JHUoOC3q0WNIS1iFKxREMP5DgaznrRjIaG+qQxQQytDeCPrugYODBVIgHX0cnq8hL9zC
         4pow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682438350; x=1685030350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlVv7Swj2O3m3L5cE82fdv0axa/JD3/qF8vAE3hvBOE=;
        b=RMX4jFLhdvGaLRcb6S/Hag4ngynBf6GoRI3x+D9UdWaYHbx6Ent2UuGKn0VUY46nTS
         Ze3NCz6UJ4/Ee7j5oTlYaypg53BgsqynLP7F2Wd3XUsukEL2EdsuMbxnsNC0HfLxQ+YF
         BjobbaGKIxQPMqKoZPe1rFmotqFxFbxUhg3dVnocR9rtZozNWRChi2eWjq4wcAcszIqG
         vBZHLbpuEk1I2WQCNI01Yl/Qws/bFp7GUf/0fgA4kcIt+CEqygZznCSLV6mpcZGxxKSk
         nfoVDNRU8qRO6eYehd8EAD73CxiYVNOp57IYh/XdyACFGv0LvtgeLfypS0NX+xvbtt1C
         V8Gg==
X-Gm-Message-State: AAQBX9eo0jxbGK3vmL+D8QdEgprSuJ+RgvZibcFIePZJt/fMdRHLeIJJ
        QmV2bwaH1+nosu08dcWtXsc86ypA17ajopZars98Dw==
X-Google-Smtp-Source: AKy350Z6xV1W9xmqBRf3W6EJR3Kb2ztwycysTEDFucgDTYqAdWhplAoM2OTMDqL6AmozTFa+wZ/ng98FtyJI1mEGtSQ=
X-Received: by 2002:a17:906:2646:b0:94f:31da:8c37 with SMTP id
 i6-20020a170906264600b0094f31da8c37mr14188025ejc.52.1682438350230; Tue, 25
 Apr 2023 08:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230414140203.707729-1-pan@semihalf.com> <6d90ad41-bb2d-41a0-8a4a-922b78967a2e@sirena.org.uk>
In-Reply-To: <6d90ad41-bb2d-41a0-8a4a-922b78967a2e@sirena.org.uk>
From:   =?UTF-8?Q?Pawe=C5=82_Anikiel?= <pan@semihalf.com>
Date:   Tue, 25 Apr 2023 17:58:59 +0200
Message-ID: <CAF9_jYRqr498j=5rgeqELEaZEkMRKqBTiNvRJC2ZduZO+399BQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] Add Chameleon v3 ASoC audio
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 6:47=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, Apr 14, 2023 at 04:01:54PM +0200, Pawe=C5=82 Anikiel wrote:
>
> >  sound/soc/Makefile                            |   1 +
> >  sound/soc/chameleonv3/Kconfig                 |   7 +
> >  sound/soc/chameleonv3/Makefile                |   2 +
> >  sound/soc/chameleonv3/chv3-audio.c            | 111 ++++++
> >  sound/soc/chameleonv3/chv3-i2s.c              | 347 ++++++++++++++++++
> >  sound/soc/chameleonv3/chv3-it68051.c          |  41 +++
>
> Please at least make a directory for Google as a vendor, we don't want
> people adding directories for each individual product. That said
> generally we add machine drivers in the directory for the relevant SoC
> family, is there any reason that pattern isn't followed here?

The board is based around an Intel Arria 10 SoC FPGA. The ring buffer
device and all the routing is implemented inside the FPGA. Is it ok to
put the machine driver in the product directory in this case?. As for
the directory path, would sound/soc/google/chameleonv3/* be ok?

Regards,
Pawe=C5=82
