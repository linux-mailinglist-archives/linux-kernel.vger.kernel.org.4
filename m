Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1F8748006
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjGEIp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjGEIpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:45:25 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A67F1729
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 01:45:21 -0700 (PDT)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 55DA13F10B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688546720;
        bh=EhBgbfMMNPfoW5bol7yuNsWA9PiXcWNElnIKvGjgKG4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ItM5uGK4hXfzwpTpqIVcRUE2xsv8Vg9n47Oq6CjRiikvhEsyw+s4xs71qdLKhOjjB
         Dtlks52vqBZ3u8w/jHXtBAg/+m3sQ6CHzHJj6GGB6zK+Qehgei4mJvjrWiF3cKTTZA
         N+6fqCZat3XkBAxcEwwk6SnAuALeoZzGGmLhMT2Swth3I0CU6YLmtoubt/w2/FnFcq
         I07ircVwFRMwV3nzCOfuhbeBjee4kFHa5DbMG9HMgpViikAx2twLUavXOHX5HS9nOd
         1Rr2c/O3Y6xdAgWg2N8UNQ1xfdMe29AYpqkKvE9gZUutNOmqW/7jVkZgB5nflcZGGd
         MWCzr6F8x4u8g==
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-666ecb21f16so8578589b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 01:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688546714; x=1691138714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhBgbfMMNPfoW5bol7yuNsWA9PiXcWNElnIKvGjgKG4=;
        b=e7DoGvKKBVlZjvNf5o0YDkv4PIiYaWdNkkRMcmI6wZyppUJXbQL52pkGb1sCkQR41i
         /aMBP2dLweB9U1yVjv+9Cpew+VIlieZhxegH+ZFmEpOxUOqvAoq+Pn1iumbJd01W0ubg
         Hl4OKmXFOqC2z48cyef+3cIVaZ0/UxaRG403lXjq3Q2QdoUD0i/dddA+qpVFa8yWkdmy
         PFLFCiqnc01fiJdSnxIdNPUWaeMAKHbsObX1db6nuqt0jMAqfB+AyrPNKVLYZNmRNQoH
         ybq5sXSRakPlZvj1wOBgNZKcC56wzxHBoKTo01EeWYsF9vmokwwDFi+xpTGBhNTU7X98
         yzqg==
X-Gm-Message-State: ABy/qLYRzki3TfWmBMvmJ4oDnaD6Z4n36QfgNkS2RnruGhetROykEQO6
        dzW/OGOUxzlpBNYmxp2m6lsRJOW/W9wFzyt7RRGquUoLeHQEyXbmdHkdmABjIBOAVhW2CxWJP0v
        ftNCSZPyBQWsVe0T2GnWKET6wm4COmt56XE1jZP5M+8QbZAW755qzhCGQRQ==
X-Received: by 2002:a62:17d1:0:b0:666:8cbb:6e02 with SMTP id 200-20020a6217d1000000b006668cbb6e02mr16496629pfx.8.1688546713833;
        Wed, 05 Jul 2023 01:45:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGPsN2XwaB28oN7la+m6ycw2aZ7zvlnCnXD23EYRBZizfqasNPWxPXnC+DaWSeSWxpwIbpeArLp0ZNI+pR8rbc=
X-Received: by 2002:a62:17d1:0:b0:666:8cbb:6e02 with SMTP id
 200-20020a6217d1000000b006668cbb6e02mr16496613pfx.8.1688546713250; Wed, 05
 Jul 2023 01:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230703162509.77828-1-koba.ko@canonical.com> <4ec2b7d2-11a5-6ab6-087a-175ed31faca4@web.de>
 <SJ1PR11MB60839A0FC6B5E79E3E5A7997FC29A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAJB-X+UB+eYoYOOVH2bqnnVEJcLrxaj5A7-zyfgBM7hOf4y8zw@mail.gmail.com> <SJ1PR11MB608383A5841E4AE8D3A64B79FC2FA@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB608383A5841E4AE8D3A64B79FC2FA@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Wed, 5 Jul 2023 16:45:01 +0800
Message-ID: <CAJB-X+VFYyTiQ7yhX=Z8-Q4QW-GMsGXMuEWxLjuoZ1aDB98qXg@mail.gmail.com>
Subject: Re: [PATCH v2] EDAC/i10nm: shift exponent is negative
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 12:08=E2=80=AFPM Luck, Tony <tony.luck@intel.com> wr=
ote:
>
> > I shared the whole dmesg through g-drive.
> > https://drive.google.com/file/d/1epnDZNezGiJsK1eT4UNOi8_igcBSXtiF/view?=
usp=3Dsharing
>
> The EDAC driver was OK for MC#0, but then failed for the other memory con=
trollers.
>
> Can you send some more information about your system. Output from the
> following commands:
>
> # head /proc/cpuinfo
>
> # dmidecode -t 17
>
> # lspci
please check through this url,
https://drive.google.com/drive/folders/199k3BX6IipNYCDfuMGy8W26ZtYRDIYZr?us=
p=3Dsharing
>
> Thanks
>
> -Tony
