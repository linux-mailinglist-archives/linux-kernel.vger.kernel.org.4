Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6116093D1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 16:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiJWOFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 10:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJWOFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 10:05:03 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DDD3CBDB;
        Sun, 23 Oct 2022 07:05:01 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id q196so5865957iod.8;
        Sun, 23 Oct 2022 07:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76WT1QUpKp6qzBWxcrAq0oJH066G81f6FsGzE6bBFSs=;
        b=YCveSy386BWW6vtgM4Gl4qo86kzmCFKxTDd8P8Z/Xff54DECtU+F59LnPAUbUy+hj2
         n+b7/EZTNnalwh7RFLRSlNrGTyBWrNYbEEjoYGnYJhoDRn2q6XHV3If+3GqW/oRF/Gix
         tHpUPPjZNri0cjmT2JymTGYvSIHbHH9VjN+bah4iTc+3J0qw00lQ4vxlwDuzhvzY3i07
         0ZOiApcdkLFcPBGJEMP+PDLJ1SGMNBG5gk65WJmA4H6nO60iFUeFeI9aaCC8hefql2MK
         hnpb147iTx1v8lem7jcgiJcna4L3BhSJA3z1HR36kUBujRYquM7VAqJz3fBfFv9kvRIX
         NR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76WT1QUpKp6qzBWxcrAq0oJH066G81f6FsGzE6bBFSs=;
        b=wc7lsKPRq2SH3JXj3iCurm/Vo/fvik4cBtCWmU2WvEhkyQh0gL/9OPcapHsy7WLRf2
         S5TT1Hvs6RmCB4DxUDSYPpRZukwtxxW3ld91w0PXJv+pAIvvNbfWsmidhEX0do/vYoaq
         9zJaKFVOfhU2G5UlAqK1Ot94QMbv9xPpnJ+Luqv1Pv43OaUMMpTlkU/bq+CEtWxnaB19
         /0avBEhG8kxu4tBlv/hWN+5rKqtrqJ+fq0kZRh6wg3RcCRUVQijdut7UcoyH/0ZEz0BE
         +cMh8S7nGh5qFvsgadDwCwgX3gc5+GwjDMs9/sfJjqw6HsM4OSa4hV8QXutXGeFL9ELE
         P7ZA==
X-Gm-Message-State: ACrzQf39ayXc1D7J+GfzzKv7iKSEwKjmfI4oWmRZ0H+F5dgBPGh/GKKK
        o3K20KtCyMaQSncBJgjjkwDKa/al9Vi2Z5eW4lU=
X-Google-Smtp-Source: AMsMyM7W3X3wIg3V7xQwyIZDSWHweIf+MTIvPNcn+4KD4Cv8bwRhrdVqGCe6Q0OANw7dZKAyvozgR4ieGXSa+ABXqmM=
X-Received: by 2002:a6b:6716:0:b0:6bc:113c:22a2 with SMTP id
 b22-20020a6b6716000000b006bc113c22a2mr17383571ioc.12.1666533901020; Sun, 23
 Oct 2022 07:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20221022165047.4020785-1-lis8215@gmail.com> <20221022165047.4020785-3-lis8215@gmail.com>
 <9W76KR.NVDSVG4IWZ3A3@crapouillou.net> <CAKNVLfZmUpFzKsdzY1e_mUTVsM-jnL65Fi6EXYcF80-oNV+DGQ@mail.gmail.com>
 <YE87KR.VC65A15U1PH41@crapouillou.net>
In-Reply-To: <YE87KR.VC65A15U1PH41@crapouillou.net>
From:   Siarhei Volkau <lis8215@gmail.com>
Date:   Sun, 23 Oct 2022 17:04:49 +0300
Message-ID: <CAKNVLfbJaGd0t==AzxyT5Q7fVD7PwK75-S5dbb+G9GZUPpagZQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] serial: 8250/ingenic: Add support for the JZ4750/JZ4755
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=B2=D1=81, 23 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 12:16, Paul Cercue=
il <paul@crapouillou.net>:
> Do you have such hardware?

No

> Don't add support for cases you can't test.

It's just a side effect of that approach.

> For what we know - all JZ475x use a 24 MHz crystal and all JZ4760(B)
> use a 12 MHz crystal, until proven otherwise.

Ouf course it just confirms the rule but I found one exception: JZ4750 & 12=
MHz
Link: https://github.com/carlos-wong/uboot_jz4755/blob/master/include/confi=
gs/lib4750.h

Regarding your proposal:
In my opinion enabling the divisor unconditionally is a bad practice,
as it's already enabled (or not) by the bootloader, with respect to the
hardware capabilities.I think it's better to keep the driver as it is than
adding such things.

BR,
Siarhei
