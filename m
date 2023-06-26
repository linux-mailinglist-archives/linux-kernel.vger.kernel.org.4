Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013B173E353
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjFZPaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFZPaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:30:13 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5EE11D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:30:11 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51d9c71fb4bso984197a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687793410; x=1690385410;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/1HTC5ZhhMAuXvXN5vNw4RkpUiNDEWqp3tgl9F0VVlg=;
        b=ou6MzCG1frjlgy9qsGRBTds7V6GpVEKsdlQcVd+ItL3tZ3Ah4hi0icMgbvxYtCDk70
         XPppGC2zp9bXdATVl3SnqWKbzZZLd3IJ+BINw1gQN+IKhpuQtIrqdUFFrq0AnLFahSRT
         OEMiE+iRLMAp5CxTQqpv1LjVhtiS4X2p8sARZNrExhbOJyeSop6t4HxtMaTTuN6Va4pM
         q/ZUKqEeiXmKRpofaKeFRyOA1TjjXsADhKnbNNk34krRwvX05JHJeyT2eZU6CgQ4TSxt
         4XhA1PFRjKEO1s8vAlUuXCxMYWO/4pDD5dml3qkrSWnyQL/Lmc1yYRQaDu4JOKdgE8DZ
         Ys0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687793410; x=1690385410;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/1HTC5ZhhMAuXvXN5vNw4RkpUiNDEWqp3tgl9F0VVlg=;
        b=jAEMl5EAMLVM7makeJyz/Xa8izFaEGeyjTKaV7JH8rn3CTsd/mHZcL+E/r6NAkz/YC
         O6wa1FEAL/pfGUeuKy65V50qrW7KO/ZLuBhC1c/Xp56SfUWA/YfviVfoMI4abyNTVz8g
         A9pYsFtAwGDSB9Y5UqysA+NO4O/W3404/yr1C/ImU62rKay2YwIvOKOUBTyCuT6QDULa
         wWmpNB+DKMDnyP3I9A5X8HoA0LiRx445mtP/wgHOjrAgiMKXfZiUUOz0ZqsXmdXSXdEv
         7odD1O0F9bvHUo/rlhmbcYUGUiUR2iW2N5BBeqlyMW2Fby22dVloJ158yl4mZeISj3W4
         AqEQ==
X-Gm-Message-State: AC+VfDxFo2eMAiWhwbGiskJfbQyHlLkqKQyn8w/BmtTg5wwc420JKY7H
        YChHRoNLcms7d4JPSfItfe0a7gWqmOIjOd7v/Oo=
X-Google-Smtp-Source: ACHHUZ7O96ek549hLneb8wz3+qCS5/a22dXEaVThmTsnXsK2GrC9ZGRy2ucV3dxHIyIEhrI8Y4OnJD85ZyHCVT1780Q=
X-Received: by 2002:a05:6402:358:b0:51d:9db4:8201 with SMTP id
 r24-20020a056402035800b0051d9db48201mr1737662edw.7.1687793410006; Mon, 26 Jun
 2023 08:30:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:3144:0:b0:223:f71d:ebef with HTTP; Mon, 26 Jun 2023
 08:30:09 -0700 (PDT)
Reply-To: anapayne80@gmail.com
From:   Ana Payne <kaboreprince3@gmail.com>
Date:   Mon, 26 Jun 2023 08:30:09 -0700
Message-ID: <CAEEqVUeNcD_wg9p3Qsy-W9scphSuVu4u6mHvX+G8q=BBium6fQ@mail.gmail.com>
Subject: =?UTF-8?B?5oiR6ZyA6KaB5L2g55qE5biu5Yqp?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5oiR5biM5pyb5oKo6IO955CG6Kej5oiR55qE5L+h5oGv77yM5Zug5Li65oiR5q2j5Zyo5L2/55So
57+76K+R5Zmo44CCDQoNCuaIkeaYr+WuieWonMK35L2p5oGp5Lit5aOr5aSr5Lq644CCDQoNCuWc
qOe+juWbvemZhuWGm+eahOWGm+S6i+mDqOmXqOOAgiDnvo7lm73vvIzkuIDlkI3kuK3lo6vvvIwz
MiDlsoHvvIzmiJHmnaXoh6rnvo7lm73kv4TkuqXkv4Tlt57lhYvliKnlpKvlhbDvvIzljZXouqvv
vIznm67liY3kuI7lkIzkuovkuIDotbflnKjliKnmr5Tkuprnj63liqDopb/miafooYzkuIDpobnn
ibnmrorku7vliqHjgIINCg0K5oiR5piv5LiA5Liq5YWF5ruh54ix5b+D44CB6K+a5a6e44CB5rex
5oOF55qE5Lq677yM5YW35pyJ6Imv5aW955qE5bm96buY5oSf77yM5oiR5Zac5qyi57uT6K+G5paw
5pyL5Y+L5bm25LqG6Kej5LuW5Lus55qE55Sf5rS75pa55byP77yM5oiR5Zac5qyi55yL5Yiw5aSn
5rW355qE5rOi5rWq44CB5bGx6ISJ55qE576O5Li95Lul5Y+K5aSn6Ieq54S255qE5LiA5YiHDQrm
j5DkvpvjgIIg5b6I6auY5YW05pu05aSa5Zyw5LqG6Kej5oKo77yM5oiR6K6k5Li65oiR5Lus5Y+v
5Lul5bu656uL6Imv5aW955qE5ZWG5Lia5Y+L6LCK44CCDQoNCuaIkeS4gOebtOW+iOS4jeW8gOW/
g++8jOWboOS4uuWkmuW5tOadpeeUn+a0u+WvueaIkeS4jeWFrOW5s++8myDmiJEyMeWygeaXtuWw
seWkseWOu+S6hueItuavjeOAgiDmiJHniLbkurLnmoTlkI3lrZfmmK/luJXnibnph4zlhYvCt+S9
qeaBqe+8jOaIkeeahOavjeS6suaYr+eOm+S4vcK35L2p5oGp44CCDQrmsqHmnInkurrluK7liqnm
iJHvvIzkvYbmiJHlvojpq5jlhbTmiJHnu4jkuo7lnKjnvo7lm73lhpvpmJ/kuK3mib7liLDkuobo
h6rlt7HjgIINCg0K5oiR57uT5ama5LqG77yM5pyJ5LqG5a2p5a2Q77yM5L2G5LuW5Y675LiW5LqG
77yM5LiN5LmF5oiR5LiI5aSr5bCx5byA5aeL5qy66aqX5oiR77yM5omA5Lul5oiR5LiN5b6X5LiN
5pS+5byD5ama5ae744CCDQoNCuaIkeS5n+W+iOW5uOi/kO+8jOWcqOaIkeeahOWbveWutue+juWb
veWSjOWIqeavlOS6muePreWKoOilv+i/memHjO+8jOaIkeaLpeacieeUn+a0u+S4reaJgOmcgOea
hOS4gOWIh++8jOS9huayoeacieS6uue7meaIkeW7uuiuruOAgg0K5oiR6ZyA6KaB5LiA5Liq6K+a
5a6e55qE5Lq65p2l5L+h5Lu777yM5bm25LiU5LuW5Lmf5Lya5bCx5aaC5L2V5oqV6LWE5oiR55qE
6ZKx5o+Q5L6b5bu66K6u44CCIOWboOS4uuaIkeaYr+aIkeeItuavjeWOu+S4luWJjeeUn+S4i+ea
hOWUr+S4gOeahOWls+WtqeOAgg0KDQrmiJHkuI3orqTor4bkvaDmnKzkurrvvIzkvYbmiJHorqTk
uLrmnInkuIDkuKrlgLzlvpfkv6Hku7vnmoTlpb3kurrvvIzlj6/ku6Xlu7rnq4vnnJ/mraPnmoTk
v6Hku7vlkozoia/lpb3nmoTllYbkuJrlj4vosIrvvIzlpoLmnpzkvaDnoa7lrp7mnInor5rlrp7l
kozor5rlrp7nmoTlkI3lo7DvvIzmiJHkuZ/mnInkuIDkupvkuJzopb/lj6/ku6XkuI7kvaDliIbk
uqvjgIINCuebuOS/oeOAgiDlr7nkvaDmnaXor7TvvIzlm6DkuLrmiJHpnIDopoHkvaDnmoTluK7l
iqnjgIINCg0K5oiR5omL6YeM5pyJ5oiR5Lus5Zyo5pGp5rSb5ZOl5omn6KGM5Lu75Yqh5pe25omA
5oul5pyJ55qE5oC76YeR6aKd77yINy4yMDAuMDAwLjAwIOe+juWFg++8ieOAgg0K5oiR5bCG5Zyo
5LiL5LiA5bCB55S15a2Q6YKu5Lu25Lit5ZGK6K+J5oKo5oiR5aaC5L2V6I635b6X6L+Z56yU6LWE
6YeR77yM5LiN6KaB5oOK5oWM77yM5a6D5Lus5piv5peg6aOO6Zmp55qE77yM5oiR6L+Y5Zyo5LiO
57qi6Imy5pyJ5YWz55qE5Lq66YGT5Li75LmJ5Yy755Sf55qE5biu5Yqp5LiL5bCG6L+Z56yU6LWE
6YeR5a2Y5YWl5pGp5rSb5ZOl55qE5LiA5a626ZO26KGM44CCDQrmiJHluIzmnJvmgqjku6XmiJHn
moTlj5fnm4rkurrouqvku73mjqXlj5for6Xln7rph5HvvIzlubblnKjmiJHlnKjliKnmr5Tkuprn
u5PmnZ/lt6XkvZzlkI7lpqXlloTkv53nrqHor6Xln7rph5HvvIzlubbojrflvpfmiJHnmoTlhpvk
uovpgJrooYzor4HvvIzku6Xkvr/lnKjmgqjnmoTlm73lrrbkuI7mgqjkvJrpnaLvvJsNCuS4jeim
geaLheW/g+mTtuihjOS8mumAmui/h+mTtuihjOmXtOi9rOi0puWwhui1hOmHkei9rOe7meaCqO+8
jOi/meWvueaIkeS7rOadpeivtOaXouWuieWFqOWPiOW/q+aNt+OAgg0KDQrnrJTorrA7IOaIkeS4
jeefpemBk+aIkeS7rOimgeWcqOi/memHjOWRhuWkmuS5he+8jOS5n+S4jeefpemBk+aIkeeahOWR
vei/kO+8jOWboOS4uuaIkeWcqOi/memHjOe7j+WOhuS6huS4pOasoeeCuOW8ueiireWHu++8jOi/
meWvvOiHtOaIkeWvu+aJvuS4gOS4quWAvOW+l+S/oei1lueahOS6uuadpeW4ruWKqeaIkeaOpeaU
tuWSjOaKlei1hOWfuumHke+8jOWboOS4uuaIkeWwhuadpeWIsOS9oOS7rOeahOWbveWutg0K5Ye6
6Lqr5oqV6LWE5bm25byA5aeL5paw55qE55Sf5rS777yM5LiN5YaN5b2T5YW144CCDQoNCuWmguae
nOaCqOaEv+aEj+iwqOaFjuWkhOeQhuatpOmXrumimO+8jOivt+WbnuWkjeaIkeOAgiDmiJHkvJrl
kYror4nmgqjmjqXkuIvmnaXnmoTmtYHnqIvlubblkJHmgqjlj5HpgIHmnInlhbPmraTkuqTmmJPn
moTmm7TlpJrkv6Hmga/jgIIg5aaC5p6c5L2g5pyJ5YW06Laj77yM6K+35LiO5oiR6IGU57O744CC
DQo=
