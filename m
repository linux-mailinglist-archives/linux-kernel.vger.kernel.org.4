Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CC1713A5E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 17:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjE1P1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 11:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1P1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 11:27:47 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FC5B1
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 08:27:43 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-626149fbc8eso11298696d6.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 08:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1685287662; x=1687879662;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HageycISbSSx1UO8biOw9yDuyV183bJnOZAqf4f2IBo=;
        b=N2Q3HAR5hu05Fr3VKHJjxtu4xCZtgsQ77PxLBv+AvKnFLiGBzwYrsFj+6NpiNGMFN3
         ZhODuC+ls8jGmlHj929+4A7dAewHqaDiULvT4nRxHa/sBQaZii27niMZdHBZd6ec4O9g
         dxJxONiEdi3MnX7/LlA7vctIy8janQiZBfCChXxvoxYnOipaxwDKKm+D9MxWaCJ5bph3
         XhQzVagi3qksPhfgoklAkFM6eykb86ZxDD0kofUAVv1wW9Zs8SOi1Z/zj5pFAuf8SFUc
         UY/PECnnyGgTJJhbXZ3BtBQl+kSl5cZqLNz33rHDCJco1NnxIyVCb2X2CnnMRg1BbWvk
         1ABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685287662; x=1687879662;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HageycISbSSx1UO8biOw9yDuyV183bJnOZAqf4f2IBo=;
        b=PdlcMsNAnr+ZmDpbCFc9oHhOTC2+IsMNRYFgk2sJy8MMj5bi9iWRNRFODiRfbfO1Oa
         bOzvDlKTEm3tiGxH7rd0lniaNWSOqmrZhX0mYangi54saRmNFIjkAwWXJvULGkmRuYOl
         DHBVDyknXml0GgMaykhH3AlmVCxUaVCK+AFdSARjUyFuCHQp2G0td4UTTLE+uEo4tyF+
         iT72fouG358dIR88Ket2gDGne34k/vbhnqQzkZi1kl2EoO7ME4dDfmavmy1A/gpy2Y9g
         x7kjj7kXKClI/tTwX5o1Ym+s3yRklCOKzFQWXULFqG0XJH6vtTaCrlUzpplKNUSQQZ8F
         QGpg==
X-Gm-Message-State: AC+VfDywLYh4z8ttKDXCwErjo8A9gO2cYuFnhpSTT1nxuMLLdNmk6BTW
        HXZHZNShP6Ik4IjolsYaIjQfilSd0oKG7aQU7XsMxg==
X-Google-Smtp-Source: ACHHUZ5dWlq2uk1j1aFHgK9e9qvV97x9ixaOX8Pm9TynMA1mR1PWkW4cN7JTRYDDieQFdJ2iqNbDCA==
X-Received: by 2002:a05:6214:2242:b0:5f1:606b:a9c8 with SMTP id c2-20020a056214224200b005f1606ba9c8mr9332307qvc.22.1685287662428;
        Sun, 28 May 2023 08:27:42 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:63:8ae3:1d73:c16f:91db:4626])
        by smtp.gmail.com with ESMTPSA id q2-20020a0cfa02000000b00621623264a8sm2944202qvn.35.2023.05.28.08.27.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 May 2023 08:27:41 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.2\))
Subject: Re: [PATCH] staging: rtl8192e: Fix BRACES warning
From:   David de Barros Tadokoro <davidbtadokoro@usp.br>
In-Reply-To: <2023052830-steep-runway-fceb@gregkh>
Date:   Sun, 28 May 2023 12:27:38 -0300
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <80495326-3EB0-4AE3-A328-D93BB9109AD0@usp.br>
References: <20230524040051.235250-1-davidbtadokoro@usp.br>
 <2023052830-steep-runway-fceb@gregkh>
To:     Greg KH <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3696.120.41.1.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 28 May 2023, at 06:10, Greg KH <gregkh@linuxfoundation.org> wrote:
>=20
> On Wed, May 24, 2023 at 01:00:51AM -0300, David Tadokoro wrote:
>> Fix checkpatch warning "braces {} are not necessary for single =
statement
>> blocks".
>=20
> Why do you have "BRACES" in the subject line as all caps?  Where did
> that term come from?
>=20
> No need to shout :)
>=20
> thanks,
>=20
> greg k-h

Hi, Greg

Thanks so much for your feedback.

You are right, this commit message is horrible. I based it on
a previous commit that cleaned the same warning instead of writing a =
good commit message myself. Going to fix that.

Sorry for the mess ;)

Many regards,
David=
