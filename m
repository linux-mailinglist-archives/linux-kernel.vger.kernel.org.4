Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DDA70CFD3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 02:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbjEWAtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 20:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbjEWAsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 20:48:30 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F407CA7
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:33:02 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f608ba2e06so5420245e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1684801981; x=1687393981;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrFGl63UuCEpD0/cTn8zK2OoUmxoYf1cLwIERUmWju0=;
        b=eTt828dUiWmLDNAB9dxn4tYuW5E06NyZpscH/7KYbHvT3H/7gyKD7v0rjwTuwrtiQW
         NUJxrc4sE+j9UsAJmC0FfdetMEqHf9lZai2ji0gZXVr7gxyVHvN872ikUfMSm+9ukLO2
         PVXZuLKuIJ3m9Q3JoqHNO6MzDAIh7w8ieL/1/NBdk4OzfdBxMPtioHoLJNar73hHho/H
         mcesOgI1rZFfIr6dwqHyxNtX5WIdbM3adoCndWrVSUiYwXYXQsDa4isiCAO7aWGt9+hk
         scm1zheIYZF3iEPPpA335kiav3/+saa/D73Ypsb3YErwfAKAFwdcGFqYnmdJS1sHbvka
         WzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684801981; x=1687393981;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrFGl63UuCEpD0/cTn8zK2OoUmxoYf1cLwIERUmWju0=;
        b=WLhIS4Rj2J9mdEaWN/nSeDKjRZtVB3RBwyOxSBdyPPKddbbP8mk+3i59sxhpWheh3Y
         KUlCVdOIGsFjXuvaFYDXiJUuDuucw2hpDChz2x5WaX8XhA6zkt5Ohlvif1PxoqKoGNCn
         UrDR7e8QLfRT+DAvLv+odSkdYjKxxFkcVehKzcoKjIb8elISArwE0bso25lqnYDpj7bd
         +Ft4oRO6Ua58oPQNQ/XEuY6FeN9kG06Ywq1zMnW02D+QkiqekahmKdc713MC5RqyP0US
         7P8kx9OhTVJGso7gzGEZ3IMhMpxt6451MHp7evZbn1qWQhqlpFaZvODGQXFrbbVU+IyB
         v4GQ==
X-Gm-Message-State: AC+VfDxftkwZ4GQK9xmwWyObP76wgHmYVvhIXiUDKb2UrPkKwRuYydrP
        9RjysCI1oUC601NFIN15ZJiBOg==
X-Google-Smtp-Source: ACHHUZ4CZCrzym57qPoHumfgDh1AfJecnm6yW7KJJLL5ovCAtDUwzXSiFcYUjymp+3V9VRRgsl4rIg==
X-Received: by 2002:a7b:ca54:0:b0:3f4:3562:f799 with SMTP id m20-20020a7bca54000000b003f43562f799mr8697189wml.28.1684801981473;
        Mon, 22 May 2023 17:33:01 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.246])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c22c800b003f4289b18a7sm9924645wmg.5.2023.05.22.17.33.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 May 2023 17:33:00 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH v1] Documentation/process: add soc maintainer handbook
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20230522-concrete-unpeeled-7e4718e61b46@spud>
Date:   Tue, 23 May 2023 01:32:49 +0100
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        soc@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Olof Johansson <olof@lixom.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-riscv@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3B8DFBEF-9EA1-4375-998D-944EA18D3E4E@jrtc27.com>
References: <20230515-geometry-olympics-b0556ff8a5f7@spud>
 <cf1c6b8c-8a3f-eca1-948f-e41946d4c34c@linaro.org>
 <20230522-concrete-unpeeled-7e4718e61b46@spud>
To:     Conor Dooley <conor@kernel.org>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 May 2023, at 22:34, Conor Dooley <conor@kernel.org> wrote:
>=20
> On Tue, May 16, 2023 at 10:31:19AM +0200, Krzysztof Kozlowski wrote:
>> On 15/05/2023 21:20, Conor Dooley wrote:
>=20
>>> +devicetree ABI stability
>>> +~~~~~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +Perhaps one of the most important things to highlight is that =
dt-bindings
>>> +document the ABI between the devicetree and the kernel.  Once =
dt-bindings have
>>> +been merged (and appear in a release of the kernel) they are set in =
stone, and
>>> +any changes made must be compatible with existing devicetrees.  =
This means that,
>>> +when changing properties, a "new" kernel must still be able to =
handle an old
>>> +devicetree.  For many systems the devicetree is provided by =
firmware, and
>>> +upgrading to a newer kernel cannot cause regressions.  Ideally, the =
inverse is
>>> +also true, and a new devicetree will also be compatible with an old =
kernel,
>>> +although this is often not possible.
>>=20
>> I would prefer to skip it and instead: enhance
>> Documentation/devicetree/bindings/ABI.rst and then reference it here.
>>=20
>>> +
>>> +If changes are being made to a devicetree that are incompatible =
with old
>>> +kernels, the devicetree patch should not be applied until the =
driver is, or an
>>> +appropriate time later.  Most importantly, any incompatible changes =
should be
>>> +clearly pointed out in the patch description and pull request, =
along with the
>>> +expected impact on existing users.
>=20
> I'm not really sure that I like this truncated section so much, but =
here
> it is... I kept the last paragraph intact as it does not talk about =
the
> ABI, but rather exceptions of submaintainers.
>=20
> devicetree ABI stability
> ~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Perhaps one of the most important things to highlight is that =
dt-bindings
> document the ABI between the devicetree and the kernel. Please see
> :ref:`devicetree-abi` for devicetree ABI rules.
>=20
> If changes are being made to a devicetree that are incompatible with =
old
> kernels, the devicetree patch should not be applied until the driver =
is, or an
> appropriate time later.  Most importantly, any incompatible changes =
should be
> clearly pointed out in the patch description and pull request, along =
with the
> expected impact on existing users.

Do you have an opinion on acknowledging the existence of other OSes =
here?

Jess

