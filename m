Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65ABF70583C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjEPUDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjEPUDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:03:20 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F0E6195
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:03:18 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-44ff6a049a7so23013e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684267397; x=1686859397;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qOO7BPo0sWWqK0nxPGx3fTC/uh2KWntI/uzgtz6cSGo=;
        b=IaaKPFeTd9RFIxHiLLqmovLVeCtG6Vw0d9u32QS37HK+KDxz119yYJfptHu4zewby0
         YYFwkf5iXQOB9NNg8X43MWhp1YL0w7kqlWdE+at/y4GiRFf/yfywnRGVu6xce9L9cUuu
         TlDPQgAiRwrXmaoOfkVEl2meWyx4bFo39aHqRGkFkmKKvE13hs9G/mHpsUMhkLN/YoMk
         KMbn7/NAwqOO//MIeNCFJ/m+gpucZ221uyOCujhpyeQSaz7wDSO2zpE2PYZWSTh63qFM
         DXC/Ym2w2Mp+irn6dADBGeM0lzGwkrpkjqjQX256BUQr24PrVZkTexMj9CxnrjpzJYBr
         vFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684267397; x=1686859397;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qOO7BPo0sWWqK0nxPGx3fTC/uh2KWntI/uzgtz6cSGo=;
        b=Ui7mU4D1V49BFLqjgGSs6B41WhxylcMzR24suHI7XsDs20swPtPOV8GORBSLdpNtUt
         X/vHs5mLFaOjQZp5H7T43/5ViCFzKvZ3PiYoKwOVClNCcUAEChuMU1e9sYJ+ThcMr9Zs
         3/24LB6vt4gtfkiZoVrKBIuphy8L8+z+FRosZc4cjlhMcPQ9EhQOcpCeRlkvcsXyQ12x
         dJZVUC8ie9nqShRUtPY/vCtAqsMni0/tf+GEhSeQJFHClDIgKaeCtTCq/r1KT5B97no7
         bnXTxJ1RJI/abjOMoMpeGTCCnMOPFXMPJhJeqMALC8+RVJVgG5ENaKIBaiP1z6Xc0dNC
         1ZoQ==
X-Gm-Message-State: AC+VfDzlfV2Yb0muwwk46/+KPVzHM2W3nqaHDSVexcTr60eWm4tQ7YMn
        gXBkfROXZi+jAtp9yld9loDsJRnavI+1fteV5h8=
X-Google-Smtp-Source: ACHHUZ6dcsXxsDTOCcL+kMCx4Dnliphu/hJmlyR3Ea/i3yHQTgb+K/1HrGGK2FYeZwCClnoADKaf70grqKcklYkONTM=
X-Received: by 2002:a67:eb53:0:b0:434:66e3:74b4 with SMTP id
 x19-20020a67eb53000000b0043466e374b4mr15400074vso.8.1684267397333; Tue, 16
 May 2023 13:03:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:ab29:0:b0:3aa:40c5:2e80 with HTTP; Tue, 16 May 2023
 13:03:16 -0700 (PDT)
Reply-To: janepayne700@gmail.com
From:   payne jane <abdoulkadrekondombo@gmail.com>
Date:   Tue, 16 May 2023 13:03:17 -0700
Message-ID: <CAPQ73o7g5Ui7VrGM-u0aJBN+_d-btr1ejLWJO0g8h7tLVzsETg@mail.gmail.com>
Subject: =?UTF-8?B?5oiR6ZyA6KaB5L2g55qE5biu5Yqp?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5oiR5biM5pyb5L2g6IO955CG6Kej6L+Z5Liq5raI5oGv77yM5Zug5Li65oiR5q2j5Zyo5L2/55So
57+76K+R5Zmo57uZ5L2g5YaZ5L+h44CCDQoNCuaIkeaYr+eugMK35L2p5oGp5Lit5aOr5aSr5Lq6
44CCDQoNCuWcqOe+juWbvemZhuWGm+eahOWGm+S6i+mDqOmXqOOAgiDnvo7lm73vvIzkuIDlkI3k
uK3lo6vvvIwzMiDlsoHvvIzljZXouqvvvIzmnaXoh6rnvo7lm73kv4TkuqXkv4Tlt57lhYvliKnl
pKvlhbDluILvvIznm67liY3kuI7lkIzkuovkuIDotbflnKjliKnmr5Tkuprnj63liqDopb/miafo
oYzkuIDpobnnibnmrorku7vliqHjgIINCg0K5oiR5piv5LiA5Liq5pyJ54ix5b+D44CB6K+a5a6e
5ZKM5rex5oOF55qE5Lq677yM5pyJ5b6I5aW955qE5bm96buY5oSf77yM5oiR5Zac5qyi57uT6K+G
5paw5pyL5Y+L5bm25LqG6Kej5LuW5Lus55qE55Sf5rS75pa55byP77yM5oiR5Zac5qyi55yL5aSn
5rW355qE5rOi5rWq5ZKM576k5bGx55qE576O5pmv5Lul5Y+K5aSn6Ieq54S255qE5LiA5YiHIOaP
kOS+m+OAgg0K5b6I6auY5YW06IO95pu05aSa5Zyw5LqG6Kej5L2g77yM5oiR6K6k5Li65oiR5Lus
5Y+v5Lul5bu656uL6Imv5aW955qE5ZWG5Lia5Y+L6LCK44CCDQoNCuaIkeS4gOebtOW+iOS4jeW8
gOW/g++8jOWboOS4uuWkmuW5tOadpeeUn+a0u+WvueaIkeS4jeWFrOW5s++8myDmiJHlnKggMjEg
5bKB6YKj5bm05aSx5Y675LqG54i25q+N44CCIOaIkeeItuS6sueahOWQjeWtl+aYr+W4leeJuemH
jOWFi+S9qeaBqeWSjOaIkeeahOavjeS6sueOm+S4veS9qeaBqeOAgg0K5rKh5pyJ5Lq65biu5Yqp
5oiR77yM5L2G5oiR5b6I6auY5YW05oiR57uI5LqO5Zyo576O5Yab5Lit5om+5Yiw5LqG6Ieq5bex
44CCDQoNCuaIkee7k+S6huWpmu+8jOacieS6huWtqeWtkO+8jOS9huS7luWOu+S4luS6hu+8jOS4
jeS5heWQjuaIkeS4iOWkq+W8gOWni+WHuui9qO+8jOaJgOS7peaIkeS4jeW+l+S4jeaUvuW8g+Wp
muWnu+OAgg0KDQrlnKjmiJHnmoTlm73lrrbnvo7lm73lkozliKnmr5Tkuprnj63liqDopb/ov5np
h4zvvIzmiJHkuZ/lvojlubjov5DvvIzmi6XmnInnlJ/mtLvmiYDpnIDnmoTkuIDliIfvvIzkvYbm
sqHmnInkurrnu5nmiJHlu7rorq7jgIIg5oiR6ZyA6KaB5LiA5Liq6K+a5a6e55qE5Lq65p2l5L+h
5Lu75LuW77yM5LuW5Lmf5Lya57uZ5oiR5bu66K6u5aaC5L2V5oqV6LWE44CCDQrlm6DkuLrmiJHm
mK/miJHniLbmr43nlJ/liY3llK/kuIDnlJ/kuIvnmoTlpbPlranjgIINCg0K5oiR5LiN6K6k6K+G
5L2g5pys5Lq677yM5L2G5oiR6K6k5Li65pyJ5LiA5Liq5YC85b6X5L+h6LWW55qE5aW95Lq677yM
5LuW5Y+v5Lul5bu656uL55yf5q2j55qE5L+h5Lu75ZKM6Imv5aW955qE5ZWG5Lia5Y+L6LCK77yM
5aaC5p6c5L2g55yf55qE5pyJ6K+a5a6e5ZKM6K+a5a6e55qE5ZCN5aOw77yM5oiR5Lmf5pyJ5LiA
5Lqb5Lic6KW/6KaB5ZKM5L2g5YiG5LqrDQrnm7jkv6HjgIIg5Zyo5L2g6Lqr5LiK77yM5Zug5Li6
5oiR6ZyA6KaB5L2g55qE5biu5Yqp44CCIOaIkeaLpeacieaIkeWcqOaRqea0m+WTpeaJp+ihjOS7
u+WKoeaXtuWcqOaRqea0m+WTpei1muWIsOeahOaAu+WSjO+8iDU3MA0K5LiH576O5YWD77yJ77yM
5oiR5Lya5Zyo5LiL5LiA5bCB55S15a2Q6YKu5Lu25Lit5ZGK6K+J5L2g5oiR5piv5aaC5L2V5YGa
5Yiw55qE77yM5LiN6KaB5oOK5oWM77yM5a6D5Lus5rKh5pyJ6aOO6Zmp6ICM5LiU5oiRDQrlnKjk
uIDkvY3kuI7nuqLljYHlrZfkvJrmnInogZTns7vnmoTkurrpgZPkuLvkuYnljLvnlJ/nmoTluK7l
iqnkuIvvvIzlpbnov5jlnKjmkanmtJvlk6XnmoTkuIDlrrbpk7booYzlrZjkuobpkrHjgIINCuaI
keW4jOacm+S9oOS9nOS4uuaIkeeahOWPl+ebiuS6uuadpeaOpeaUtuWfuumHke+8jOW5tuWcqOaI
keWujOaIkOi/memHjOeahOW3peS9nOWQjuWmpeWWhOS/neeuoeWug++8jOW5tuiOt+W+l+aIkeea
hOWGm+S6i+mAmuihjOivge+8jOS7peS+v+WcqOS9oOeahOWbveWutuS4juS9oOS8mumdou+8mw0K
5LiN6KaB5ouF5b+D6ZO26KGM5Lya6YCa6L+H6ZO26KGM5Yiw6ZO26KGM6L2s6LSm55qE5pa55byP
5bCG6LWE6YeR6L2s57uZ5oKo77yM6L+Z5a+55oiR5Lus5p2l6K+05pei5a6J5YWo5Y+I5b+r5o23
44CCDQoNCueslOiusDsg5oiR546w5Zyo5Zyo5Yip5q+U5Lqa77yM5oiR5LiN55+l6YGT5oiR5Lus
6KaB5Zyo6L+Z6YeM5b6F5aSa5LmF77yM5oiR5Zyo6L+Z6YeM5Lik5qyh54K45by56KKt5Ye75Lit
5bm45a2Y5LiL5p2l77yM6L+Z6K6p5oiR5oOz5om+5LiA5Liq5YC85b6X5L+h6LWW55qE5Lq65p2l
5biu5Yqp5oiR5o6l5pS25ZKM5oqV6LWE6K+l5Z+66YeR77yM5Zug5Li6DQrmiJHlsIbmnaXliLDk
vaDnmoTnpZblm73mipXotYTlubblvIDlp4vmlrDnmoTnlJ/mtLvvvIzkuI3lho3mmK/kuIDlkI3l
hpvkurrjgIINCg0K5aaC5p6c5oKo5oS/5oSP6LCo5oWO5aSE55CG77yM6K+35Zue5aSN5oiR44CC
IOaIkeS8muWRiuivieS9oOaOpeS4i+adpeeahOa1geeoi++8jOW5tuWQkeS9oOWPkemAgeabtOWk
muacieWFs+WtmOWFpei1hOmHkeeahOmTtuihjOeahOS/oeaBr+OAgg0K5Lul5Y+K6ZO26KGM5bCG
5aaC5L2V5biu5Yqp5oiR5Lus6YCa6L+H6ZO26KGM5Yiw6ZO26KGM6L2s5biQ5bCG6LWE6YeR6L2s
56e75Yiw5oKo5omA5Zyo55qE5Zu95a62L+WcsOWMuuOAgiDlpoLmnpzkvaDmnInlhbTotqPvvIzo
r7fkuI7miJHogZTns7vjgIINCg==
