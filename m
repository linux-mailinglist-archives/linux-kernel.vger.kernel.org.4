Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E82600BDC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiJQKCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiJQKCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:02:49 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7914E5E66E;
        Mon, 17 Oct 2022 03:02:42 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id t25so6281311qkm.2;
        Mon, 17 Oct 2022 03:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wSknhvKCk5o/x9TVU4GalEKfHnOaonV1t5oNy9vyfok=;
        b=G/qIaYn3+KtKvU4aX0FC+DrmZaCntcukw4rZS59KG8ePbLndlLp0zisIM54/rq3Vud
         Zof0QCUOVZoy4XNPsxVd85w39DekR5plIf2/TP4f8xW27Rkw39riiQEN5UMFT0JD77BQ
         /yp/b0FouEcOIypF6DnV4l1s5yCb8hmBxm1bRavzEfmOzauV3Wck1ONW5glvKXx4IS9M
         dT2CtcgiHr+4pxqTxYKE/oumU6plcxBR8TGF5I44QlElOyijEWxGikXsP2qX5jNrNIdR
         Yyfn83vOzTRAPuI9w0NYUlVT9dcmj4sXipr2+Isgl+iPXGh3c2xqRB1j8P2gsNPhZGvS
         Varw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wSknhvKCk5o/x9TVU4GalEKfHnOaonV1t5oNy9vyfok=;
        b=0SW5EPRNQzooCEEVrzXyBXu5VDDKQ5XnRY/H4UIrf7vWNEY/XP1STmkQCUBdBpbzwC
         bJF31C89ntnNeJbOc1Wwu6+gp6Fic3q9LA+PVU7KX7Gglfl4pn1ncFSBys4qZN+iYa79
         Z5rxSZ2Ah8Gua5Torpf0pljF6YkPATLS55U5Dgmqhv57J/mneyDu9qbSijLfcT+F2hfG
         4Go2dy1kKYJrm7l99JGorEUBK2tUtznrs8DN/8p2qve9/rlfjBrg8v6yvGeOAoTjcjwH
         wl/IrLmIuQ1aKgAQafhgYEOtt39Aw6fu3CHOdU0I8H2V31rggun8RmX9K8uM0TWHjdY+
         Qr4w==
X-Gm-Message-State: ACrzQf2ZowwgvaFYLVDVWH38SehDYAWqRB63kRvbthU1LZo1D3I50FmV
        iIfG3dC82iInaRmHnX5EHAo=
X-Google-Smtp-Source: AMsMyM4s/zCsc0XAZzflO7hzuHB1nV0SwwdXmx2a7jjD4PzpLthggqUrBv7HFn1Vu201L3hLzmozmw==
X-Received: by 2002:a05:620a:4306:b0:6d4:1a11:38ad with SMTP id u6-20020a05620a430600b006d41a1138admr6806068qko.422.1666000961201;
        Mon, 17 Oct 2022 03:02:41 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id f14-20020ac8464e000000b0039ad65104fasm7264788qto.12.2022.10.17.03.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 03:02:40 -0700 (PDT)
Message-ID: <886e20eaf53870447f397bd5e7242cc0bdde3867.camel@gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: iio: temperature: ltc2983: support
 more parts
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Date:   Mon, 17 Oct 2022 12:04:02 +0200
In-Reply-To: <f003f3ffa86fbeae6898c23638a4b0e1228a8657.camel@gmail.com>
References: <20221014123724.1401011-1-demonsingur@gmail.com>
         <20221014123724.1401011-3-demonsingur@gmail.com>
         <28c88be7-a416-3612-3e13-5346a6e92565@linaro.org>
         <f003f3ffa86fbeae6898c23638a4b0e1228a8657.camel@gmail.com>
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

On Mon, 2022-10-17 at 11:38 +0200, Nuno S=C3=A1 wrote:
> Hi Krzysztof,
>=20
> As I wrote the original bindings, let me reply to some of your
> points...
>=20
>=20

Just realized now there were already some replies (forgot to 'lei up'
before replying...)

- Nuno S=C3=A1
