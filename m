Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B40F6A0CA2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 16:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbjBWPLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 10:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbjBWPLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 10:11:43 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9925E4C6C9;
        Thu, 23 Feb 2023 07:11:41 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id q16so593113wrw.2;
        Thu, 23 Feb 2023 07:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H5fTkCkDaxfnGshYLT3cOpahyGxRQ44b857x8HjilP4=;
        b=YCrAk06Zt4/0KSU47OoxuWzyCw6lHBUIsMECENX6WlirrCVp9fp/69ffP6RUBGeyru
         mzE2V0FJ2y3uVQtXNO9fV5B8cAEFweVVaNC26VP+ta1ZPcE97XY0s8F8Kb7e5qOOzdQ9
         z4zLnLMfScOkeVvQHfY0b4VOtmdGvNnSqR+b5UmHjOZpy6EJnvoN9Uq1ymq3ZIOeD7t/
         EsScLMlCKHRfIXcmpeOUeSC0nvOqwtwshDUZvuID+Y6u6N3NUVOYQsH6eDR3JEUhfOoO
         Wz5cLTzo70o0Mw+VGURmuhNJUzwuPEvEs5neKme7/fH3mp1a2EhqtSAydyAuybbxWBPp
         J9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H5fTkCkDaxfnGshYLT3cOpahyGxRQ44b857x8HjilP4=;
        b=asLNyt4Ix0Gsv+kAQ29mOPQ0ZrQwbIJUrXyZrW5l6ze9G9PwISW8VHhWbHqBJEot2T
         0Mpcbzf75LS5j0wMkFzXday4RQ4+7E5yo+Sn8tQzQXo4AYDTEE7/tCqq7SYnhjBe3NR7
         h+ckHayaVEDuqo/cdxKdZcLW95Z8/Mv44zDdigLWXYIOPsv460RyOyMDl3XHqUnfaCeP
         tqqL2IzWlbvXrhf6UF2dsFqJp7JAOdWd4PhExvpQAx9KvnVeiBQpdiosLn2gkR3+pX6t
         +C1GmMrXdAjpq7D2tBmbg7WBMlC+VW3P1DguXLYRlPNCaayBXLl5yCcWI9ZG8MZ2CLYX
         17IQ==
X-Gm-Message-State: AO0yUKWvYEqB+2DF22xzcLE2pqHRZ1IMZB3yps1GZG7KYOfXafjwdMMI
        2zBsoEfEPeX+iAFgAH5rE+s=
X-Google-Smtp-Source: AK7set9sGSBVZgedDoV8xG05V1S3SWucDMrlQvYtvjYUvrQC78MrbnJhjwi11n8P+DE6bViOJL0Ztw==
X-Received: by 2002:a5d:5045:0:b0:2c5:8a5a:fc01 with SMTP id h5-20020a5d5045000000b002c58a5afc01mr11031113wrt.11.1677165099855;
        Thu, 23 Feb 2023 07:11:39 -0800 (PST)
Received: from ?IPv6:2a02:ab88:368f:2080:5d6e:322:57b6:5f03? ([2a02:ab88:368f:2080:5d6e:322:57b6:5f03])
        by smtp.gmail.com with ESMTPSA id h7-20020a5d6887000000b002c5501a5803sm8577472wru.65.2023.02.23.07.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 07:11:39 -0800 (PST)
Message-ID: <3a8e24921b9b47834199a7ca78af4d22ed370586.camel@gmail.com>
Subject: Re: [PATCH 2/2] rtc: s5m: Drop S5M8763 support
From:   David Virag <virag.david003@gmail.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lee Jones <lee@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-rtc@vger.kernel.org
Date:   Thu, 23 Feb 2023 16:11:47 +0100
In-Reply-To: <Y/eAPXwdv0kclEVA@mail.local>
References: <20230131183008.4451-1-virag.david003@gmail.com>
         <20230131183008.4451-3-virag.david003@gmail.com>
         <Y/d1DY/mXe7R5q8W@google.com> <Y/d1omGzBMFqjQx+@google.com>
         <Y/eAPXwdv0kclEVA@mail.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-02-23 at 16:03 +0100, Alexandre Belloni wrote:
> On 23/02/2023 14:18:10+0000, Lee Jones wrote:
> > On Thu, 23 Feb 2023, Lee Jones wrote:
> >=20
> > > On Tue, 31 Jan 2023, David Virag wrote:
> > >=20
> > > > The S5M8763 MFD has no device tree compatible, and since board
> > > > file
> > > > support for it was removed, there's no way to use this MFD.
> > > > After
> > > > removing the remaining code for it from the MFD driver, also
> > > > remove
> > > > support for it in the s5m RTC driver, and all remaining
> > > > references to
> > > > it.
> > > >=20
> > > > Signed-off-by: David Virag <virag.david003@gmail.com>
> > > > ---
> > > > =C2=A0drivers/rtc/rtc-s5m.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 82 ++----------------------
> > > > --------
> > >=20
> > > > =C2=A0include/linux/mfd/samsung/core.h |=C2=A0 1 -
> > > > =C2=A0include/linux/mfd/samsung/irq.h=C2=A0 | 50 ------------------=
-
> > >=20
> > > Acked-by: Lee Jones <lee@kernel.org>
> >=20
> > Actually, looks like this should probably go in via MFD, so I need
> > an
> > RTC Ack.
>=20
> There were comments on 1/2 so I was expecting a v2.
>=20
>=20

Krzysztof commented there about the removal of an enum value that's
actually removed in 2/2 since it would break the RTC driver if it was
removed in 1/2. He realised that and corrected himself. No need for v2
AFAIK, unless something else is found.

The patch should definitely go via one tree (or by waiting for it to be
merged upstream, I guess) since the order has to be kept.

Best regards,
David
