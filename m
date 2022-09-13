Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF505B69A9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiIMIgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiIMIg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:36:28 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B965C57E2C;
        Tue, 13 Sep 2022 01:36:23 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id b81so5461858vkf.1;
        Tue, 13 Sep 2022 01:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=ivmnXTLvhTwmbAEp7t6pe69Pq/r2wv5rtccxOKjcfIg=;
        b=bmS0Ji8sRmRAjbdRpP6CyIH9JBqW82fXDxz638KWlN1c/c+XjhS67p6q24DOjYO985
         Gt4bgOGZrLgfRj3ExGF5aNhmPosmuypV2qQTYcarOmSD/Z/l9e87ZSTsi8Wo7Lbs7FdG
         w2+rLtem3qhcwTNq3USzP9nMiWmkUOtnDCs35sjltJNRlnKKLabKxHXggt5ozZVBdXWp
         job1RxSaL2PomDUUal7JY0IyYVh79Kygdam3cFB5UB8EXs2XGEVC1KIAgzOVFK1bLMqp
         7gDt+Ypn/1aEPUGBP/udYVGjvApddz62bce4y/3/MSFH0phSHTJLwmqFqWiyCRulv0vf
         J4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ivmnXTLvhTwmbAEp7t6pe69Pq/r2wv5rtccxOKjcfIg=;
        b=OWQeLyAScPmiUOpINgCLxj8u0m9/bO6qnGpX11J+ALEYm765oM0Th9uVOZNUuwXlpw
         8XNZHXgBVss4jipVFLB6HGEH0nkuFpxrjTOJWmLgRqBkW7UxbX3EwZnFrLv6ZaBRSIsH
         biBoAFQNr8kNcE3gVAbBql55JAR+fEIrtXR5KAPDMpxnGSar9jHMoEKJHmC2tp69iQdp
         8HT3eRswTIrWQ9Ey9G/z6lwDiYYevek/LZmebvmDSqPnGxs2oSaH51gUMnGA6JbmrkYK
         Sv7yRc170fle/jwn+yZ/FjyAbxK3cq+uJ6JTyGEruWwh2haK4qI2BEYwtMQaoY992RTH
         KXYw==
X-Gm-Message-State: ACgBeo19MbsxVukMstXimBgdUfk3gkcr84lfhPf25kmbZsxB7PWzD+FT
        wdhzGQXXu5nCv2/mgR8lq8x8FeEbJgh6H1lyTkQ=
X-Google-Smtp-Source: AA6agR76SqNzeF8iz54UmQh54NUQMtQIk1eQ1p+Zfax4WkA33daqGpypXu1O1HRPZoPBO/mTU4kuU8sKbFFytvVtoQY=
X-Received: by 2002:a1f:b254:0:b0:345:87e4:17fb with SMTP id
 b81-20020a1fb254000000b0034587e417fbmr9714431vkf.25.1663058182771; Tue, 13
 Sep 2022 01:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <CANXPkT6mYusYe8O0dbq3vW+24SsUZ19PqhOL+wLFRnbFXwu0Zg@mail.gmail.com>
 <CANXPkT7nOhH+5bD0ycyRBT9FKQBBszCVuWkqp4tFtVRf2+8DFg@mail.gmail.com>
 <CANXPkT5k9Pw4ka6CihyCg0oTd-32Te-ox=f3=9rtCphVgrdctA@mail.gmail.com>
 <165590120140.1149771.2257818527859865760@Monstersaurus> <4883f0a7-6a1b-31bd-33fe-db8f6dcf73fa@selasky.org>
 <CANXPkT73ssg6RRyfDtp7c_8sO60a-UT0-Y4S1_=D=M_mcLNN9g@mail.gmail.com>
 <CANXPkT4qYOYPL+F=-Pi_NbQErq9WwrR-M-BHe=gP9Ay4bSs+=w@mail.gmail.com>
 <CANXPkT5=ryAFvb1cO+Wb0CQYmytwedS2dqVTYqt2Km1fkK4w9Q@mail.gmail.com>
 <CANXPkT7vt8gq5UO4OXK2pTUyyB102ANJ5i9s92AW+a3rAioMog@mail.gmail.com>
 <085b9025-bc23-37d4-d430-afc432b4d783@selasky.org> <baf121ae-a5a4-47a3-bc3a-9255708009b9@selasky.org>
In-Reply-To: <baf121ae-a5a4-47a3-bc3a-9255708009b9@selasky.org>
From:   =?UTF-8?B?7Jyg7Jqp7IiY?= <yongsuyoo0215@gmail.com>
Date:   Tue, 13 Sep 2022 17:36:13 +0900
Message-ID: <CANXPkT44_qCcddg9Ayvk=cRLsUDq8G06toMTBGCsJ3kf+g+h-g@mail.gmail.com>
Subject: Re: [PATCH] media: dvb_ringbuffer : Fix a bug in dvb_ringbuffer.c
To:     Hans Petter Selasky <hps@selasky.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, 0215yys@hanmail.net,
        =?UTF-8?B?7Jyg7Jqp7IiY?= <yongsuyoo0215@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Hans Petter Selasky

I understood your points.
Thank you for your kind explanation
I found that the buffer size is 65535 like below source code.
The 65535 is not the power of two.
So it can still be a problem.
...
#define RX_BUFFER_SIZE 65535
...
rxbuf =3D vmalloc(RX_BUFFER_SIZE);
...
dvb_ringbuffer_init(&ca->slot_info[slot].rx_buffer, rxbuf, RX_BUFFER_SIZE);
}
...

2022=EB=85=84 9=EC=9B=94 12=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 9:36, H=
ans Petter Selasky <hps@selasky.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

>
> Hi Mauro and YongSu,
>
> Answering my own question: The reason nobody has triggered this yet, is
> because the buffer size used is power of two. Because unsigned modulus
> is used, the result becomes correct. See below. But if non-power of two
> ring-buffer is used, then the result becomes incorrect. There is no
> block for non-power of two sized buffers. See:
>
> https://github.com/search?q=3Ddvb_set_pesfilter&type=3Dcode
>
> cat << EOF > testX.c
> #include <stdio.h>
>
> int
> main()
> {
> int consumed_old;
> int consumed_fix;
> size_t idx =3D 3;
> ssize_t pread =3D 15;
> ssize_t size =3D 256;
>
> consumed_old =3D (idx - pread) % size;
>
> consumed_fix =3D (idx - pread);
> if (consumed_fix < 0)
> consumed_fix +=3D size;
>
> printf("old=3D%d new=3D%d size=3D%zd\n", consumed_old, consumed_fix, size=
);
>
> size =3D 254;
>
> consumed_old =3D (idx - pread) % size;
>
> consumed_fix =3D (idx - pread);
> if (consumed_fix < 0)
> consumed_fix +=3D size;
>
> printf("old=3D%d new=3D%d size=3D%zd\n", consumed_old, consumed_fix, size=
);
>
> return (0);
> }
> EOF
>
> cc testX.c && ./a.out
> old=3D244 new=3D244 size=3D256
> old=3D244 new=3D242 size=3D254
>
> So either push the suggested fix, or block non-power of two buffer sizes!
>
> Best regards,
> --HPS
