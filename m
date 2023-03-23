Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB59E6C68EB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjCWMzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjCWMzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:55:18 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E7EF5;
        Thu, 23 Mar 2023 05:55:17 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id r187so553320ybr.6;
        Thu, 23 Mar 2023 05:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679576116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISNE15I6zaSxAQPnN0sxzeTcFnWMQ3qxrhuU6mm7D/g=;
        b=obbXsD6Xkj43SRB5k8Hk63Wj2lWc99tg5p3t2mW3Znfk2VnMSCR3eUFGK0kfrMwksD
         si6pMdZiJw+1YjpGX/mA241glVL/8ubNlEMZXQIaidsvyjo5i7kzwOOjCVF4C5B0HS6A
         lnRYikqPcpPBFhyydCOQZ8zKaBH+PK5d2rzjrd+w+Wz5ob6A1ljdrCODDGfEbe0oRPFe
         gBEIdHZIxmhqh+DL+9RHhnpdFt3Mu4Oz3CcfBpnlkA76LwSsDdUEJP0JXCb8jhWxCK3/
         +ttnZnZt7uUz3by6HT2CCmvyVofvwWbcg2YjjW6q+qDK/sxv16jQUP52k1C3dW4D7C9b
         W1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679576116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISNE15I6zaSxAQPnN0sxzeTcFnWMQ3qxrhuU6mm7D/g=;
        b=EB9l3UkG7MSXv7T6RjoUVV2EtPMFnZzh2L3++wOsuXDE4MEKuuj0k9SJykdEoooJTb
         5USXHYkPk2sznEqUwjL1jwLMVbutPBwP/T1hPFQ8xfCbe03RRg+c8ywxbapLLQrwqptH
         P7GDNZss88vsAJwpWEB8+JaJJFcPDCcbx1Eo7966S+q8zzFMQb821axrLRI2BrZeBXX0
         dX5309zh8/V/VjAGczLkL6+whPvjTW4RcBB+hVidrONmpQtMS8u0cdIDTesfQMW5/HxM
         fUBMofPJmo4BNJsL/0Qyaw/bdBKY8ib0Aa0/RtOlp1Dwwl9FDb+2u9z9bUFG/HVLQe3c
         MQsw==
X-Gm-Message-State: AAQBX9fGsAwvV+kYxrwsfjA66OZB//c6vhccgigey7DHsp0tnXGJbDz0
        hHcqzfamNvCwBS2RO0KX06Y7wJpkfY/65QfTYfQ=
X-Google-Smtp-Source: AKy350ajsSH3bjPX97LUk0SQpzJRBv6W0MBm7d3pkgLTNBNI2ud97ge35PAHVbP9tprvCQnq6q1iOAiH+rWW76PA/x4=
X-Received: by 2002:a05:6902:1586:b0:b6c:a94:9bf3 with SMTP id
 k6-20020a056902158600b00b6c0a949bf3mr2200866ybu.9.1679576116524; Thu, 23 Mar
 2023 05:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230323124510.2484808-1-noltari@gmail.com> <20230323124510.2484808-3-noltari@gmail.com>
 <3e0fa788-173d-a014-20d5-0b4ca4d890b4@linaro.org>
In-Reply-To: <3e0fa788-173d-a014-20d5-0b4ca4d890b4@linaro.org>
From:   =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Date:   Thu, 23 Mar 2023 13:55:05 +0100
Message-ID: <CAKR-sGfnKdWmbGwTSgu9qiuJF+qFS=AiwORFDMcKf1x1PpY4Ng@mail.gmail.com>
Subject: Re: [PATCH 2/2] mtd: nand: raw: macronix: allow disabling block protection
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        masonccyang@mxic.com.tw, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

El jue, 23 mar 2023 a las 13:47, Tudor Ambarus
(<tudor.ambarus@linaro.org>) escribi=C3=B3:
>
> Hi,
>
> On 3/23/23 12:45, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
> > Some devices hang when block protection is enabled, so let's add a bool=
ean
> > property to allow disabling it.
> >
>
> Why do they hang?

At first I thought it would be due to the low level op not being
supported on BCM63268 brcmnand controllers, but after debugging it
seemed to be working...

This is the log with block protection disabled:
[    0.495831] bcm6368_nand 10000200.nand: there is not valid maps for
state default
[    0.504995] nand: device found, Manufacturer ID: 0xc2, Chip ID: 0xf1
[    0.511526] nand: Macronix MX30LF1G18AC
[    0.515586] nand: 128 MiB, SLC, erase size: 128 KiB, page size:
2048, OOB size: 64
[    0.523516] bcm6368_nand 10000200.nand: detected 128MiB total,
128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-4
[    0.535912] Bad block table found at page 65472, version 0x01
[    0.544268] Bad block table found at page 65408, version 0x01
[    0.954329] 9 fixed-partitions partitions found on MTD device brcmnand.0
...

This is the log with block protection enabled:
[    0.495095] bcm6368_nand 10000200.nand: there is not valid maps for
state default
[    0.504249] nand: device found, Manufacturer ID: 0xc2, Chip ID: 0xf1
[    0.510772] nand: Macronix MX30LF1G18AC
[    0.514874] nand: 128 MiB, SLC, erase size: 128 KiB, page size:
2048, OOB size: 64
[    0.522780] bcm6368_nand 10000200.nand: detected 128MiB total,
128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-4
[    0.539687] Bad block table not found for chip 0
[    0.550153] Bad block table not found for chip 0
[    0.555069] Scanning device for bad blocks
[    0.601213] CPU 1 Unable to handle kernel paging request at virtual
address 10277f00, epc =3D=3D 8039ce70, ra =3D=3D 8016ad50
*** Device hangs ***

As you can see, when block protection is enabled, the bad block table
isn't found and when the device is scanned for bad blocks it just
hangs...

If you want me to debug something I would be happy to do it, but I
need some guidance here...

Best regards,
=C3=81lvaro.
