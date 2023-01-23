Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EB067802F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjAWPmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjAWPm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:42:28 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342182B0BB
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:42:21 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id az20so31647418ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xVr3vB2hzZ3F0yO7EPlpiTN2lX/kuFDnddqTHol07pA=;
        b=YX0hdTjGa8dEyzk23hSWQZWrLFyzO+cJSSiGYizMp06adkWCiZGSdj7UVSEeHkGadw
         dlj7MMWWozp3X5fXVmjnsXq/desS5mdDxMIy94tbGuar96qpDBWfq6Og0b6ta/+8ngbo
         hz3b4TtiXIYy+lXd8AIfFl3lbNltYkR8tt6WaE4KXxm5HiqwgZsHqGtFAir7gHi4rRxj
         G7LNlow5tNKNLrEaJxwo7VKaB+xgDN62kPYGgng5j6Ctg2Sdf/kAW2DPBvBt/M3YmY1E
         C8NhuwqnHDStB+R7VKIXGIEsr8S2E7eZJszEAE9u3ZvTJoCgtW/V7M/oZjDzvssqth1/
         x5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xVr3vB2hzZ3F0yO7EPlpiTN2lX/kuFDnddqTHol07pA=;
        b=ycRYmDw82+EExJYDMifsGYCFNxaeF1R5/PXB2/DG10d2eX/J97Fq41O52n3di0O/W+
         XBoPajQKo9sMneWvw5nKUNCmIbSzWdgjhcFiwLQiggCjMZI2oF1PenfpBygSUIuhw2cd
         0/VuOhd2W5z1JGxaDv2VeAt4WOilWFMYsLeXvKCQcddxhRGTfc0vOuzt5BbE58Mb3+Bo
         UeNc0M0ifeTHGP4eehPgF7XVo9xVeYkmClXvKtls7pi9QRy89NAp4DTF7L6kfOJsIAj5
         GNqlhKo/045pqokTlFCiRa6HoQBMYbh0fNFscDNULmduEsEEoQhobeEY0wFvJb1gjg0l
         4O2A==
X-Gm-Message-State: AFqh2krIGVZJsGoAf9x2qv6ClaAe+AegAkwCiIhxkw+EuPa5G2lCJLcT
        0FsluvN9CTF5dBEAXPzKN/qaxqYvmBK8l3PWltpZP7eXE1aoqw==
X-Google-Smtp-Source: AMrXdXsBgqjTnRSztvCW0oWV43HFQpfHDgSAdrJdaM2m4Pgp4mPeLCStLGJudP2CP5l+vRWe9Hv8+4SewYLmgxsZ+xA=
X-Received: by 2002:a17:906:cf9a:b0:84d:347f:1522 with SMTP id
 um26-20020a170906cf9a00b0084d347f1522mr2305675ejb.319.1674488538878; Mon, 23
 Jan 2023 07:42:18 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a50:4d1:0:b0:1f2:a072:bdb7 with HTTP; Mon, 23 Jan 2023
 07:42:18 -0800 (PST)
Reply-To: georgebrown0004@gmail.com
From:   george brown <georgebrown00005@gmail.com>
Date:   Mon, 23 Jan 2023 16:42:18 +0100
Message-ID: <CA+CaFy0UOuw6DNDYJqFG2YMVKCP4_zcCLcORsxGHOX7fRpsqtA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BBuna ziua

Numele meu este George Brown. Sunt avocat de profesie. vreau sa va ofer
rudele apropiate clientului meu. Ve=C8=9Bi mo=C8=99teni suma de (8,5 milioa=
ne USD)
dolari pe care clientul meu i-a l=C4=83sat =C3=AEn banc=C4=83 =C3=AEnainte =
de moartea lui.

Clientul meu este un cet=C4=83=C8=9Bean al =C8=9B=C4=83rii dumneavoastr=C4=
=83 care a murit
=C3=AEntr-un accident de ma=C8=99in=C4=83 =C3=AEmpreun=C4=83 cu so=C8=9Bia =
sa
si singurul fiu. Voi avea dreptul la 50% din fondul total, =C3=AEn timp ce
50% va avea
fie pentru tine.
V=C4=83 rug=C4=83m s=C4=83 contacta=C8=9Bi e-mailul meu privat aici pentru =
mai multe
detalii: georgebrown0004@gmail.com

Multe mul=C8=9Bumiri in avans,
Domnule George Brown,
