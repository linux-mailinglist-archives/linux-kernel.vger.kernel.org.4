Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54AD7671BA5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjARMNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjARMMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:12:47 -0500
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com [IPv6:2001:4860:4864:20::44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9964F85B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 03:32:07 -0800 (PST)
Received: by mail-oa1-x44.google.com with SMTP id 586e51a60fabf-142b72a728fso35124951fac.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 03:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=55Y4YtZy3no6NXxp1QTppiz3LuF/Us7jNEd8Yd3D5/Q=;
        b=dHRRhtPhX07Cz7GVVOo3qo3moqwVeeCA/PD5xMlfzxy2qPHeFPv4CMkX7Cc6/vTPVV
         wyHJuZbyb9MM6juZLS+Y70aQCUzqyLSZU7q7So+qfEbUvXpe+kr0WlWEa2iZQLoT+U3x
         JNhrm3Zr4WEA1myH5mqzoDomPHcg5AAnOVByTu6MrWBdO/6HjnELxKpD9339EvOwYq/2
         1g7SF8Cri+IFrWoO9v/FI6cJxligqR3hbWna656Nz25+xSe+37vUeqLynQrgxYbV+XQI
         eAd4GCydrJgsXHCGCP19VC2Y7pwX3dP9sQLiG9tmhiiSfm8x0povUKHSA8BrDgJnaxle
         ajrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=55Y4YtZy3no6NXxp1QTppiz3LuF/Us7jNEd8Yd3D5/Q=;
        b=1l1ga690c1mCa2s3wlTLQf7808QvayDLl67pVUY6JbINtiiRLdNvoRfhr+W+qmOXFb
         otOELmPEvqa1NYyBivFCyfxLzj4pRsrBWukAj0BCrSmL03gINKeM38+wqCIVGhfHZgJn
         1dpdG/NxSf7LIBLYOV5NGroDxCsIczwt3kpEu1huAQti1i11SeXeNrTwTO0mQZMf1teM
         RjqlZrebgCWoP5Ea92ONqu6Qj/uKrE+VPOIYN7rr3EFLmJnOpV+a8IV676YR+EHqfFMK
         4IjcJek1JrZ59RecggkB4/v6ZSlJuAZ0y8TjoT7fH5aMrT0OLx6zSWGbXTxpp4bh1sHF
         7oGw==
X-Gm-Message-State: AFqh2komZt2/bpJaVNKHhEjL9P5OuHnihm+c/USzE/rBf/EAGLqsF74j
        3uCbge+V8TgQt+WYhfcFW44h1HQngMFXW9+4g4I=
X-Google-Smtp-Source: AMrXdXtUCw+ePriHNnmx30wEZFqbqz49HCSnQWgLik2pP6BB1s6JHyySVHfWqLuRPUiBVlMKEGgFy/a8UP2yVFUZl3U=
X-Received: by 2002:a05:6870:6783:b0:15e:f9bc:9c42 with SMTP id
 gc3-20020a056870678300b0015ef9bc9c42mr667645oab.159.1674041527033; Wed, 18
 Jan 2023 03:32:07 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6358:18d:b0:ea:5706:809 with HTTP; Wed, 18 Jan 2023
 03:32:06 -0800 (PST)
Reply-To: christinedeschamps200@gmail.com
From:   christine Deschamps <christinedeschamps2027@gmail.com>
Date:   Wed, 18 Jan 2023 11:32:06 +0000
Message-ID: <CAJUkVpa+G9rZo7oKdeXSuwyZLk5CYjPsqfNxhowzExHXJYNbJg@mail.gmail.com>
Subject: Bonjour
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:44 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [christinedeschamps2027[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [christinedeschamps2027[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [christinedeschamps200[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Je me permets de vous contactez afin de pouvoir partager, dialoguez donner,
et vous informez de mon projet de donation dont je cherche
actuellement un fid=C3=A8le partenaire. Je m'appelle Christine Deschamps,
de nationalit=C3=A9 Canadienne, n=C3=A9e le 03/01/1948 =C3=A0 Montr=C3=A9al=
. Veuve et
sans enfant. Cause de ma situation actuelle, je me retrouve dans
l'incapacit=C3=A9 de faire face personnellement =C3=A0 mon projet de donati=
on
dont j'ai mobilis=C3=A9 une somme de 2.000.000.00 Euros disponible dans mon
coffre aupr=C3=A8s de ma banque. Je cherche quelqu'un disponible et de
bonne fois, afin de lui faire parvenir cette somme pour qu'il puisse
investir, ex=C3=A9cuter et r=C3=A9aliser mon projet dont la concr=C3=A9tisa=
tion sera
pour moi, ma mani=C3=A8re de remercier l'=C3=89ternel pour sa bont=C3=A9 to=
ut le bien
qu'il m'a fait durant toute ma vie. C'est un acte humanitaire que je
fais =C3=A0 travers votre personne. J'ai besoin de vos conseils si vous
=C3=AAtes disponible veuillez m'envoyer une r=C3=A9ponse a mon adresse mail=
 :
christinedeschamps200@gmail.com
