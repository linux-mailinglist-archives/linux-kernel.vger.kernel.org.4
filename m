Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE80374669D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 02:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjGDAdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 20:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjGDAda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 20:33:30 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AD8130
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 17:33:29 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5703d12ab9aso61471867b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 17:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1688430808; x=1691022808;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6AJP2wH0ETjrE0zuL86OkwmRXQF6/z9/4/4NlxWIdZs=;
        b=Jv4pzt0AbMyEm6wCS/G5PV0QxBwIr3eu5EODIuyqbTr/UKzQTA7cUyuyhl94BcpnxK
         WweULpGfyZ38uUpDVy9LOTNGW1e0vAlQ0WZ1qWFjAyB+NWI8RFaS+6QkzZDblM0vS7g/
         6WNpwDduq88+vOe7cOEJLu87TUWyREt70pd3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688430808; x=1691022808;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AJP2wH0ETjrE0zuL86OkwmRXQF6/z9/4/4NlxWIdZs=;
        b=CqpSmEMVw1CyO8mTyp+VUGJ/59Wp4VhwkHQ3UUL5hk8UKIMOSrdx92UZvH7Jm2CEZt
         wMplCXHP3a9/ZgkdrRZ8rsFWkr+zPsKTGIyr810/ZOHpuI99WGinjqsENP3NlCtGQp1s
         Nf7b/ltg4RLxBvc5LPin06vRsGG7utbD9Y9scLSZrGLXmTbaBFs4gMzOnnFcWuJm39sf
         0ppWEOlhuDb8RjRSOnO40Qg0MVrsbLNnLQpA6I4AWiPdaEwBVZiOeHq4apyjwm52VoBg
         jOEcmgTUsH8yOA284ZaAzZ8Jg25uXun6EjrvZCNG1aZb4Yvc374igFJqwasvtevcTIJK
         kGTA==
X-Gm-Message-State: ABy/qLYGjcqb8zArvTyVcBP0qHNd/jAEZhEqV1Q59f1v1SdsMkoUCG2i
        aLZt19JqtKB7Eot2zD1cmn+dwzmalWZMHnKEFWW5Ww==
X-Google-Smtp-Source: APBJJlHPtWWE5zO5SqMH3XypLZhrCovqHjmhDnK1l9zpL8pJuY5eySZWH9xC+HwLMlqIYUGMzBALoDzlmFO6XR75YHA=
X-Received: by 2002:a81:91c9:0:b0:576:896a:dbc5 with SMTP id
 i192-20020a8191c9000000b00576896adbc5mr10986100ywg.48.1688430808397; Mon, 03
 Jul 2023 17:33:28 -0700 (PDT)
From:   William Zhang <william.zhang@broadcom.com>
References: <20230630202257.8449-1-jonas.gorski@gmail.com> <20230630202257.8449-2-jonas.gorski@gmail.com>
In-Reply-To: <20230630202257.8449-2-jonas.gorski@gmail.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKplYVuMBNPa1j2zXARcZmt/Gt4/gIajcgBrfNZLrA=
Date:   Mon, 3 Jul 2023 17:33:25 -0700
Message-ID: <5df7744e02a87a207d608739ac414215@mail.gmail.com>
Subject: RE: [PATCH 2/3] spi: bcm{63xx,bca}-hsspi: update my email address
To:     Jonas Gorski <jonas.gorski@gmail.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Mark Brown <broonie@kernel.org>,
        Anand Gore <anand.gore@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000095124a05ff9e6ec0"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000095124a05ff9e6ec0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Jonas Gorski <jonas.gorski@gmail.com>
> Sent: Friday, June 30, 2023 1:23 PM
> To: William Zhang <william.zhang@broadcom.com>; Kursad Oney
> <kursad.oney@broadcom.com>; Broadcom internal kernel review list <bcm-
> kernel-feedback-list@broadcom.com>; Mark Brown <broonie@kernel.org>;
> Anand Gore <anand.gore@broadcom.com>; Florian Fainelli
> <f.fainelli@gmail.com>; Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: [PATCH 2/3] spi: bcm{63xx,bca}-hsspi: update my email address
>
> Update my email address to a working one, as the openwrt.org one is
> broken since ages.
>
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---
>  drivers/spi/spi-bcm63xx-hsspi.c | 2 +-
>  drivers/spi/spi-bcmbca-hsspi.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-bcm63xx-hsspi.c
> b/drivers/spi/spi-bcm63xx-hsspi.c
> index ee2528dad02d..9e218e143263 100644
> --- a/drivers/spi/spi-bcm63xx-hsspi.c
> +++ b/drivers/spi/spi-bcm63xx-hsspi.c
> @@ -2,7 +2,7 @@
>   * Broadcom BCM63XX High Speed SPI Controller driver
>   *
>   * Copyright 2000-2010 Broadcom Corporation
> - * Copyright 2012-2013 Jonas Gorski <jogo@openwrt.org>
> + * Copyright 2012-2013 Jonas Gorski <jonas.gorski@gmail.com>
>   *
>   * Licensed under the GNU/GPL. See COPYING for details.
>   */
> diff --git a/drivers/spi/spi-bcmbca-hsspi.c
> b/drivers/spi/spi-bcmbca-hsspi.c
> index 8cbd01619789..ca1b4741e9f4 100644
> --- a/drivers/spi/spi-bcmbca-hsspi.c
> +++ b/drivers/spi/spi-bcmbca-hsspi.c
> @@ -3,7 +3,7 @@
>   * Broadcom BCMBCA High Speed SPI Controller driver
>   *
>   * Copyright 2000-2010 Broadcom Corporation
> - * Copyright 2012-2013 Jonas Gorski <jogo@openwrt.org>
> + * Copyright 2012-2013 Jonas Gorski <jonas.gorski@gmail.com>
>   * Copyright 2019-2022 Broadcom Ltd
>   */
>
> --
> 2.34.1

Acked-by: William Zhang < william.zhang@broadcom.com>

--00000000000095124a05ff9e6ec0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
YDZuuBJwnyCzevMoPtVYPharioL5H3BRnQi8YoTXH7/uRo33dewYFm474yFjwwnt82TFtveVZkVq
6h4WIQ4wTcwFfET8zMkELnGzS5SHCl8sPD+lNxxJ1JDZYwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRp3aWxsaWFtLnpoYW5nQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUq65GzwZxydFHjjYEU/9h
xHhPWlwwDQYJKoZIhvcNAQELBQADggEBAA2hGG3JPAdGPH0ZdohGUCIVjKz+U+EFuIDbS6A/5jqX
VhYAxZlzj7tSjUIM7G7IhyfqPC46GKJ/4x+Amz1Z6YxNGy71L68kYD6hIbBcA5AM42QBUufly6Oa
/ppSz3WoflVyFFQ5YXniZ+eU+2/cdnYZg4aVUnFjimOF5o3NfMLzOkhQNxbaDjFUfUYD8hKmU6v4
0vUBj8KZ9Gi1LIagLKUREn8jku0lcLsRbnJ5Ey5ScajC/FESPyYWasOW8j8/1EoJksmhbYGKNS6C
urb/KlmDGfVrIRYDbL0ckhGQIP5c6L+kSQZ2sHnQK0e0WgIaZYxaPYeY5u0GLCOze+3vyRMxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwxuh2XG3FXRL1W
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJB6SsddAHPxxnjUqILA0lz87t0Z
Q0n9YAa5PYwjSuzwMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MDcwNDAwMzMyOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAIfulFlg+X5KTgHb83nDTU9cEt7pTF6sTC3XoAu/+An3jU
ylrky5VfrTYPWv7xM9pUw2Y3WQnKWtKq4BkUl7Cj+Hc7KVr54RjLrGf/QirfEH7097mTohk+Ye0I
e+YWMsToevV/xFuRpjfZkBieJmkAmOQWfCdUsZdNLHQGW+aRjm3c7oHxR1B72oHFGDZICt6BjKF3
JVi/pMc0UkLMAv0VD7y2z6uYrq6q+YhrvPZUhsZ5RoZEYmPNVhHv2EQY8ZYfKkk3U1THpPKS1YsI
T/d8040AJntNTdiskOE/VYoIjL4DbUDEJkEArMZEtsXQSVltdE2sLCcCe5lQo5W7rSfy
--00000000000095124a05ff9e6ec0--
