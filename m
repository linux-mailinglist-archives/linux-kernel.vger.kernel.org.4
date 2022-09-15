Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15A75B9568
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiIOH3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiIOH3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:29:05 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A895E8F95B;
        Thu, 15 Sep 2022 00:28:14 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id bn9so21092157ljb.6;
        Thu, 15 Sep 2022 00:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=wYU31/8d3gxQlUCSkAHVEYuiz/qL0YLfNq0blIqdw8o=;
        b=fyjz71aqhPBtqi6+rZLIsVhUOHcd9agMjqqRqyZ6CtYvaod9P1OVo5lIV8UpsxClhL
         968ACjfcXTtHupmcWiy81FzbWbn5K3tGVEL6rdvZCX/GxDOZpWlvicIQWdX2KUy1YIJ3
         7VciJ0INfj7DALKy/1Y9fn8rgtQSHrVuSGAB6Q5cMuEbMIFsQ4wLjV+YTn0OCBhQKsmA
         lwaUa42aB9+i9kmNfyIVe0H/o2SmHN9qT23528DkZjXZ6UeFW8ecHcB5XKs875rtvbmB
         D3pu9iRwLdfpUJPBPen6lJXxBtvjWwi2H9KGUFYQ3FTvX2TrUwpcCHao3ryodRTNUkJA
         qktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=wYU31/8d3gxQlUCSkAHVEYuiz/qL0YLfNq0blIqdw8o=;
        b=DsBJi7ec446jAeAbtuGEG1dlMJPmFVEAzf8R+VI/b66019gPdxBSlz08EXUVtc4Xb0
         o/HpAlOfspesxoC8gCuxcMP/dNhV119oYxXZlxpSE/UERYBVmb5tM2+HCr5kDpewZk6u
         7Jk7UjKvY4U/mc7zT/Vtn53yfV9jKxj/yZ4p9gBSlv40wZw6Kl0bcIsHyi7+YVZjKYBg
         O/P9Sz8Z+0WphLF4OVfHeMuQ2SdlSFVc3VJ64inNrnC2iGcr+a4dfREsfoV8NLJIqAi+
         gsoEWlHZYR2Sw8ku0WdV1ezdADZDiwA1zHlfItCd0JAoh0oMc/tH7do8d2Ijmb4zH//w
         ZFUg==
X-Gm-Message-State: ACgBeo3/cJ3pOqlrO+QfkIkAf3//HwK/Kt8NiQf62izcrGGbrUApClQU
        yvnMHG8UpZa32i9oTNEYU3JNEwe9pFo=
X-Google-Smtp-Source: AA6agR5qE4ZfrId7Zsi915zW1lLzJ/nmT+AUdmlEqaLyhbpIKTcPQwz6fQIHBForDg5OjHrP/UkERQ==
X-Received: by 2002:a05:651c:1146:b0:261:d36a:7ff8 with SMTP id h6-20020a05651c114600b00261d36a7ff8mr12551652ljo.363.1663226893022;
        Thu, 15 Sep 2022 00:28:13 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id o20-20020ac24bd4000000b0049c29292250sm1544457lfq.149.2022.09.15.00.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 00:28:12 -0700 (PDT)
Date:   Thu, 15 Sep 2022 09:34:06 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Jiri Kosina <jikos@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Subject: Re: [RESEND PATCH 1/2] HID: Add driver for RC Simulator Controllers
Message-ID: <YyLVblZkIPCvNd/2@gmail.com>
References: <20220822060936.769855-1-marcus.folkesson@gmail.com>
 <CAO-hwJ+3Yrr--cr=r5+jvs4A=A-cmDtrKQETo=YOYDC3nXTMBg@mail.gmail.com>
 <YwTvrNuulKx0SB6H@gmail.com>
 <CAO-hwJKiq50fWwXNUGcXeWtWcUXb65ZmJMsADfrsUTac_Xj2dw@mail.gmail.com>
 <YwcbVJswrL1Doi4s@gmail.com>
 <CAO-hwJJ86oAuaFD+uX7Rwv7cASO=4mchRJ1UBTxz9gYs6M1rUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YVygXAnhv+jF8ybR"
Content-Disposition: inline
In-Reply-To: <CAO-hwJJ86oAuaFD+uX7Rwv7cASO=4mchRJ1UBTxz9gYs6M1rUg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YVygXAnhv+jF8ybR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Benjamin,

On Tue, Aug 30, 2022 at 02:45:11PM +0200, Benjamin Tissoires wrote:
> On Thu, Aug 25, 2022 at 8:44 AM Marcus Folkesson
> <marcus.folkesson@gmail.com> wrote:
> >


[...]
> >
> >
> > Is the fact that more than one button share the same
> > byte hard to describe in the report?
>=20
> No, this is actually easy to describe. You say that there is one usage
> of "something" which has a report size of 1 bit, and then you have
> another usage of "something else" with the same report size.
>=20
> But usually you have to add padding after to make up to 8 bits (so 6
> bits in that case).
>=20
> I was referring to the case  where you are parsing the same bit on the
> wire, and give a different usage based if you have received an odd or
> an even number of reports. In that case, we probably need to use move
> this bit to a const field in the original report descriptor and say
> that the data is now not const:
>=20
> - initial report (completely random example):
>   X (2 bytes) | Y (2 bytes) | button this_or_that (1 bit, depending of
> odd or even received reports) | 7 bits of padding
> - we can declare it as:
>   X (2 bytes) | Y (2 bytes) | button this (1 bit) | button that (1
> bit) | 6 bits of padding

How about if there is no unused bytes?

The XTRG2FMS has 8 10-bit channels and use every byte in the report.
Should I specify 8 8-bit channels instead and fix that in raw_event?
If so, should I only use 8bit values then?

(Are you at the ELCE conference btw?)

Best regards
Marcus Folkesson

--YVygXAnhv+jF8ybR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmMi1WkACgkQiIBOb1ld
UjKsqw//Wa6YTjHrge5PlXpvnR0ytTXsv9mlzSouMVgMQkV1WsYPUxHHZ/CkhpQh
XImYzh0AE6gBMBVKOhoqD4qXt2LYIiAhdFHBjaYVx4ZVyv/s75D5E2kwTgrWPXdU
ImLA4N2SpMP7CmyadNWTcp4RrL79HxXzVABSP+rJz/+B+OfehoqKttlKX+02RDEP
O67fi0AiT7v4fmiI5In9n3Qu7tHNuE5TP9+Vt/S5uKRZGZ71Ms1xOWFFgs5Uk+6I
ekRelq/6Qe9FKIQSd/el6LxM5iSoeQJsUpLuUXBpXqhE9VYEa6WJW3qqO/k4syIb
cYCye1H7ktEmEeD5ld4MwDhNCNcjzIjScbx7eKK18TMVq2302sXvSV0QCVSINlCH
whaP8yotWIAWw3IQPQIOr2Xqb8No9SdUv/qhUqFIbnv6q5WSKuMICyXgwtZ01TFv
hKXdE/pqMQtD1zycoKbeqZyhKvbPvp+MCpD/6Z/gW14tvmV+/XO1K0fN/K11rHEy
glqGbV+Q4du7Q7VJjfTHy0WWIw+MA5Vkbnc1FAQNdbTZkUKKV6gFTBsIUdlFMmLU
hzNN1gmQq+xG5ZgUDC2cnhPa7RbtoMRUZiZWdgR1UvHyHPQwKp1+74dJ4RY9OEY5
hunre9lxYArInS5gAVkCoaFnHy5n/85389f6zotWnoKx8vdJxI4=
=rjYL
-----END PGP SIGNATURE-----

--YVygXAnhv+jF8ybR--
