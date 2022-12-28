Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA51657281
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 05:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiL1ESg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 23:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiL1ESd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 23:18:33 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C695B871
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 20:18:31 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id qk9so35962508ejc.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 20:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=28XuF8HNpgudZGFcKBGHer0SJhXOM3cskc7ja0xv4T4=;
        b=B5Zslyd7pp7HUbx/4D4cA2HQ5kBYg/Psby6uUckDUc5XNfjiKKJzmVEFEyIhRogqVY
         zWKuuqR90ZrPaII07CgP3+MYBYGcy62QAcSQXVjECe2JW72VOOZoIvDt/y7dPnULvEar
         p1fmmOm+l4mgGH+n/vUV0lbt1QSJzDB5oo78H2MXnbRE/JxEgzh4kmD6liY1vgEvQ/FQ
         gI9AgUBMc7j6ZArpU+ozl/QRa6IyNzEiDMqb1ESqwlFwS90kXScbjH4cxmnx7OPuMHpV
         i9hKm56GohlYzFNpWn5gdv4jutXPaoFslz7pZmkHldvKgItKySVk16sYUvBgEe5xrJxV
         7PYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28XuF8HNpgudZGFcKBGHer0SJhXOM3cskc7ja0xv4T4=;
        b=OOt7/a02sRQzPPdBU4G3Z9P/BsFFgFUz36zGQm4gLGUI0O5+H9hfIBGlVEkfYeqN/b
         /J82XZHKB27DBEXR90bPlIZKIvl+7kdT4r3ROl2oLIlyklMmnJ7NipJmxSDOaZBhKroe
         SJjBHhVrRelr4b3J8Jk5OlRjesoGn/aVdSOfOc4cNJZUu2bnm+iPDBC2NII0NytsMjQV
         OBRUI66SeFrLrQAe/zUQIoI3eCmZ8NHLB/ywhh6WbW8ZfKC6OV4IjcL7B1jOUqAIm3T8
         VZlhnnzqRC3uX037XpFsLr1xsDEaq0gMXOiOUyy+dKT6JyRaLP4l6H/C1k2zps8dG97r
         8g2g==
X-Gm-Message-State: AFqh2koq/z8oCMn0UUZpDKgADH60IlpUKGT/7C/rqEMK5meN58FitKY7
        6FRXCOl8b9sBM+Zd5fLvJ1znnYUuChSkz6cnzIc=
X-Google-Smtp-Source: AMrXdXv67vMbODP0AV8UY1VaJMIAXCnCSZ37HRDttvtoW/LQw/cxxsyMC7mP95TtxWEuTYzf1xghRCSfhM6gL0SAhuA=
X-Received: by 2002:a17:906:1443:b0:7b2:7b45:2bf6 with SMTP id
 q3-20020a170906144300b007b27b452bf6mr2129310ejc.467.1672201109799; Tue, 27
 Dec 2022 20:18:29 -0800 (PST)
MIME-Version: 1.0
Reply-To: oliviasayouba@gmail.com
Sender: mrsaishagaddaffi@gmail.com
Received: by 2002:a05:6f02:a38e:b0:27:376d:66d5 with HTTP; Tue, 27 Dec 2022
 20:18:28 -0800 (PST)
From:   mrs olivia sayouba <oliviasayouba@gmail.com>
Date:   Wed, 28 Dec 2022 04:18:28 +0000
X-Google-Sender-Auth: xkBlN5H_Gu1NxWU1-1zFRwvF3z0
Message-ID: <CAAQaxX=+xqrW2J1_jOkssshJo9ZRL1NhftackFv4df2xnWPr2w@mail.gmail.com>
Subject: =?UTF-8?B?4LmA4Lij4Li14Lii4LiZ4LiB4Liy4Lij4LmA4Lil4Li34Lit4LiB4LiC4Lit4LiH4Lie?=
        =?UTF-8?B?4Lij4Liw4LmA4LiI4LmJ4Liy?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ICAg4LiJ4Lix4LiZ4LmA4LiC4Li14Lii4LiZ4LiI4LiU4Lir4Lih4Liy4Lii4LiZ4Li14LmJ4LiW
4Li24LiH4LiE4Li44LiT4LiU4LmJ4Lin4Lii4LiZ4LmJ4Liz4LiV4Liy4LiX4Li14LmI4LiE4Lil
4Lit4LmA4Lia4LmJ4Liy4LmB4Lil4Liw4LmA4Liq4Li14Lii4LmD4LiI4Lit4Lii4LmI4Liy4LiH
4Lih4Liy4LiBDQrguYPguJnguYPguIjguILguK3guIfguInguLHguJkg4LiJ4Lix4LiZ4LiK4Li3
4LmI4Lit4LiZ4Liy4LiH4LmC4Lit4Lil4Li04LmA4Lin4Li14LiiIOC4i+C4suC5guC4ouC4muC4
siDguInguLHguJnguKHguLLguIjguLLguIHguJXguLnguJnguLTguYDguIvguLXguKLguYHguKXg
uLDguInguLHguJnguYDguJvguYfguJkNCuC4leC4tOC4lOC4leC5iOC4reC4hOC4uOC4k+C4iOC4
suC4geC5guC4o+C4h+C4nuC4ouC4suC4muC4suC4peC5g+C4meC4muC4ueC4o+C5jOC4geC4tOC4
meC4suC4n+C4suC5guC4iyDguInguLHguJnguJXguYnguK3guIfguIHguLLguKPguJrguK3guIHg
uITguLjguJPguJnguLXguYkNCuC5gOC4nuC4o+C4suC4sOC4ieC4seC4meC5hOC4oeC5iOC4oeC4
teC4leC4seC4p+C5gOC4peC4t+C4reC4geC4reC4t+C5iOC4meC4meC4reC4geC4iOC4suC4geC4
muC4reC4geC5gOC4mOC4reC4leC4suC4oeC4l+C4teC5iOC4ieC4seC4meC4o+C4ueC5ieC4quC4
tuC4geC4m+C4o+C4sOC4l+C4seC4muC5g+C4iA0K4LmA4Lib4Li04LiU4LmD4LiI4LmD4Lir4LmJ
4LiB4Lix4Lia4LiE4Li44LiTIOC4ieC4seC4meC5geC4leC5iOC4h+C4h+C4suC4meC4geC4seC4
muC4hOC4uOC4k+C4i+C4suC4ouC4ueC4muC4siDguJrguKPguLLguKfguJnguYwg4LiL4Li24LmI
4LiH4LiX4Liz4LiH4Liy4LiZ4LiB4Lix4Lia4LiV4Li54LiZ4Li04LmA4LiL4Li14LiiDQrguYDg
uK3guIHguK3guLHguITguKPguKPguLLguIrguJfguLnguJXguJvguKPguLDguIjguLPguJrguLng
uKPguYzguIHguLTguJnguLLguJ/guLLguYLguIvguYDguJvguYfguJnguYDguKfguKXguLIgMTUg
4Lib4Li1IOC4geC5iOC4reC4meC5gOC4quC4teC4ouC4iuC4teC4p+C4tOC4leC5g+C4meC4m+C4
tSAyNTU5IOC5gOC4o+C4sg0K4LmB4LiV4LmI4LiH4LiH4Liy4LiZ4LiB4Lix4LiZ4Liq4Li04Lia
4LmA4Lit4LmH4LiU4Lib4Li14LmC4LiU4Lii4LmE4Lih4LmI4Lih4Li14Lil4Li54LiBDQoNCiAg
4LmA4LiC4Liy4LmA4Liq4Li14Lii4LiK4Li14Lin4Li04LiV4Lir4Lil4Lix4LiH4LiI4Liy4LiB
4LmA4LiI4LmH4Lia4Lib4LmI4Lin4Lii4LiK4Lix4LmI4Lin4LiE4Lij4Li54LmI4LiL4Li24LmI
4LiH4LiB4Li04LiZ4LmA4Lin4Lil4Liy4LmA4Lie4Li14Lii4LiH4Liq4Liy4Lih4Lin4Lix4LiZ
IOC4leC4seC5ieC4h+C5geC4leC5iOC5gOC4guC4sg0K4LiE4Lin4Liy4Lih4LiV4Liy4LiiIOC4
ieC4seC4meC4leC4seC4lOC4quC4tOC4meC5g+C4iOC5hOC4oeC5iOC5geC4leC5iOC4h+C4h+C4
suC4meC5g+C4q+C4oeC5iA0K4LmA4Lih4Li34LmI4Lit4Liq4Liy4Lih4Li14Lic4Li54LmJ4Lil
4LmI4Lin4LiH4Lil4Lix4Lia4LiC4Lit4LiH4LiJ4Lix4LiZ4Lii4Lix4LiH4Lih4Li14LiK4Li1
4Lin4Li04LiV4Lit4Lii4Li54LmI4LmA4LiC4Liy4Lid4Liy4LiBDQrguKPguKfguKHguKHguLng
uKXguITguYjguLIgOC41MDAuMDAwIOC4peC5ieC4suC4meC5gOC4q+C4o+C4teC4ouC4jeC4quC4
q+C4o+C4seC4kCAo4LmB4Lib4LiU4Lil4LmJ4Liy4LiZ4Lir4LmJ4Liy4LmB4Liq4LiZDQrguJTg
uK3guKXguKXguLLguKPguYwpIOC5g+C4meC4mOC4meC4suC4hOC4suC4o+C5g+C4meC4p+C4suC4
geC4suC4lOC4ueC4geC4uSDguYDguKHguLfguK3guIfguKvguKXguKfguIfguILguK3guIfguJrg
uLnguKPguYzguIHguLTguJnguLLguJ/guLLguYLguIvguJfguLLguIfguJXguLDguKfguLHguJng
uJXguIENCuC5geC4reC4n+C4o+C4tOC4geC4si4g4Lib4Lix4LiI4LiI4Li44Lia4Lix4LiZ4LmA
4LiH4Li04LiZ4LiZ4Li14LmJ4Lii4Lix4LiH4LiE4LiH4Lit4Lii4Li54LmI4LmD4LiZ4LiY4LiZ
4Liy4LiE4Liy4LijIOC5gOC4guC4suC4l+C4s+C5gOC4h+C4tOC4meC5hOC4lOC5ieC5gOC4l+C5
iOC4suC4meC4teC5iQ0K4Lie4Lij4LmJ4Lit4Lih4Liq4Liz4Lir4Lij4Lix4Lia4LiB4Liy4Lij
4Liq4LmI4LiH4Lit4Lit4LiB4LiX4Lit4LiH4LiE4Liz4LiI4Liy4LiB4LiB4Liy4Lij4LiC4Li4
4LiUIEJ1cmtpbmEgRmFzbw0KDQogIOC5gOC4oeC4t+C5iOC4reC5gOC4o+C5h+C4pyDguYYg4LiZ
4Li14LmJ4LmB4Lie4LiX4Lii4LmM4LiC4Lit4LiH4LiJ4Lix4LiZ4Lia4Lit4LiB4LiJ4Lix4LiZ
4Lin4LmI4Liy4LiJ4Lix4LiZ4LiI4Liw4LmE4Lih4LmI4Lit4Lii4Li54LmI4LmD4LiZ4LiK4LmI
4Lin4LiH4LmA4LiI4LmH4LiU4LiC4Lin4LiaDQrguYDguJTguLfguK3guJnguYDguJnguLfguYjg
uK3guIfguIjguLLguIHguKHguLDguYDguKPguYfguIfguYDguKHguYfguJTguYDguKXguLfguK3g
uJTguYHguKXguLDguYLguKPguITguKvguKXguK3guJTguYDguKXguLfguK3guJTguKrguKHguK3g
uIfguYHguJXguIEg4LmE4LiU4LmJ4Lij4Li54LmJ4LiI4Lix4LiB4LiC4LmJ4Liy4Lie4LmA4LiI
4LmJ4LiyDQrguYDguIfguLfguYjguK3guJnguYTguIIg4LiJ4Lix4LiZ4LiV4Lix4LiU4Liq4Li0
4LiZ4LmD4LiI4Lih4Lit4Lia4LmA4LiH4Li04LiZ4LiZ4Li14LmJ4LmD4Lir4LmJ4LiE4Li44LiT
4LiU4Li54LmB4LilDQrguITguJnguJTguYnguK3guKLguYLguK3guIHguLLguKrguITguLjguJPg
uIjguLDguYPguIrguYnguYDguIfguLTguJnguJnguLXguYnguYPguJnguYHguJrguJrguJfguLXg
uYjguInguLHguJnguIHguLPguKXguLHguIfguIjguLDguJfguLMNCuC4quC4seC5iOC4h+C4quC4
reC4meC5g+C4meC4l+C4teC5iOC4meC4teC5iS4g4LiJ4Lix4LiZ4LiV4LmJ4Lit4LiH4LiB4Liy
4Lij4LmD4Lir4LmJ4LiE4Li44LiT4LmA4Lit4Liy4LmA4LiH4Li04LiZIDMwIOC5gOC4m+C4reC4
o+C5jOC5gOC4i+C5h+C4meC4leC5jOC4guC4reC4h+C5gOC4h+C4tOC4meC4l+C4seC5ieC4h+C4
q+C4oeC4lA0K4LiC4Lit4LiH4LmD4LiK4LmJ4Liq4LmI4Lin4LiZ4LiV4Lix4LinIOC5g+C4meC4
guC4k+C4sOC4l+C4teC5iCA3MCUg4LiC4Lit4LiH4LmA4LiH4Li04LiZ4LiX4Li14LmI4LiE4Li4
4LiT4LiI4Liw4LmA4Lit4Liy4LmE4Lib4Liq4Lij4LmJ4Liy4LiH4Liq4LiW4Liy4LiZ4LmA4Lil
4Li14LmJ4Lii4LiH4LmA4LiU4LmH4LiB4LiB4Liz4Lie4Lij4LmJ4LiyDQrguJrguYnguLLguJng
uYPguJnguIrguLfguYjguK3guKrguLLguKHguLXguJzguLnguYnguKXguYjguKfguIfguKXguLHg
uJrguILguK3guIfguInguLHguJkg4LmB4Lil4Liw4LiK4LmI4Lin4Lii4LmA4Lir4Lil4Li34Lit
4Lic4Li54LmJ4Lii4Liy4LiB4LmE4Lij4LmJ4LiV4Liy4Lih4LiX4LmJ4Lit4LiH4LiW4LiZ4LiZ
IOC4ieC4seC4mQ0K4LmA4LiV4Li04Lia4LmC4LiV4LiC4Li24LmJ4LiZ4Lih4Liy4LmD4LiZ4LiQ
4Liy4LiZ4Liw4LmA4LiU4LmH4LiB4LiB4Liz4Lie4Lij4LmJ4Liy4LmB4Lil4Liw4LiJ4Lix4LiZ
4LiB4LmH4LmE4Lih4LmI4Lih4Li14LmD4LiE4Lij4LmA4Lib4LmH4LiZ4Liq4Lih4Liy4LiK4Li0
4LiB4LmD4LiZ4LiE4Lij4Lit4Lia4LiE4Lij4Lix4Lin4LiC4Lit4LiH4LiJ4Lix4LiZ4LmA4Lil
4LiiDQrguJ7guKLguLLguKLguLLguKHguJTguLnguYHguKXguKPguLHguIHguKnguLLguJ7guKPg
uLDguJnguLTguYDguKfguKjguILguK3guIfguJ7guKPguLDguYDguIjguYnguLIg4LiJ4Lix4LiZ
4LiB4Liz4Lil4Lix4LiH4LiX4Liz4Liq4Li04LmI4LiH4LiZ4Li14LmJ4LmA4LiB4Li14LmI4Lii
4Lin4LiB4Lix4LiaDQrguITguKfguLLguKHguJvguKPguLLguKPguJbguJnguLLguILguK3guIfg
uKrguLLguKHguLXguJzguLnguYnguKXguYjguKfguIfguKXguLHguJrguILguK3guIfguInguLHg
uJkg4LiE4Lin4Liy4Lih4LmA4LiI4LmH4Lia4Lib4LmI4Lin4Lii4LiZ4Li14LmJ4Liq4LmI4LiH
4Lic4Lil4LiB4Lij4Liw4LiX4Lia4LiV4LmI4Lit4LiJ4Lix4LiZ4Lih4Liy4LiBDQrguInguLHg
uJnguYDguJ7guLXguKLguIfguYHguITguYgNCuC5gOC4q+C4oeC4t+C4reC4meC4leC4suC4ouC4
l+C4seC5ieC4h+C5gOC4m+C5h+C4mQ0KDQogIOC4l+C4seC4meC4l+C4teC4l+C4teC5iOC4ieC4
seC4meC5hOC4lOC5ieC4o+C4seC4muC4geC4suC4o+C4leC4reC4muC4geC4peC4seC4muC4guC4
reC4h+C4hOC4uOC4kyDguInguLHguJnguIjguLDguYPguKvguYnguITguLjguJPguJXguLTguJTg
uJXguYjguK3guJjguJnguLLguITguLLguKPguYPguJkNCuC4muC4ueC4o+C5jOC4geC4tOC4meC4
suC4n+C4suC5guC4iyDguYHguKXguLDguInguLHguJnguIjguLDguKrguLHguYjguIfguYPguKvg
uYnguJzguLnguYnguIjguLHguJTguIHguLLguKPguJjguJnguLLguITguLLguKPguK3guK3guIHg
uYDguIfguLTguJnguYPguKvguYnguITguLjguJPguJTguYnguKfguKINCuC4q+C4meC4seC4h+C4
quC4t+C4reC4oeC4reC4muC4reC4s+C4meC4suC4iOC4l+C4teC5iOC4iOC4sOC4nuC4tOC4quC4
ueC4iOC4meC5jOC4p+C5iOC4suC4hOC4uOC4k+C5gOC4m+C5h+C4meC4nOC4ueC5ieC4o+C4seC4
muC4nOC4peC4m+C4o+C4sOC5guC4ouC4iuC4meC5jOC5g+C4meC4m+C4seC4iOC4iOC4uOC4muC4
seC4mQ0K4LmD4LiZ4LiY4LiZ4Liy4LiE4Liy4LijIOC4meC4seC5iOC4meC4hOC4t+C4reC4luC5
ieC4suC4hOC4uOC4k+C4o+C4seC4muC4o+C4reC4h+C4geC4seC4muC4ieC4seC4meC4p+C5iOC4
suC4hOC4uOC4k+C4iOC4sOC4m+C4j+C4tOC4muC4seC4leC4tOC4leC4suC4oeC4ieC4seC4mQ0K
4Lij4Liw4Lia4Li44LmE4Lin4LmJ4LmD4LiZ4LiX4Li14LmI4LiZ4Li14LmJDQoNCiAg4LiI4Liy
4LiB4LiZ4Liy4LiH4LmC4Lit4Lil4Li04LmA4Lin4Li14LiiIOC4i+C4suC5guC4ouC4muC4sg0K
