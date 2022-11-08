Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DBC62085F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 05:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbiKHEmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 23:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbiKHEmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 23:42:35 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8842EF30
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 20:42:34 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id v17so13159084plo.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 20:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+VoC5O6h7ZfIBAy9yt0jFTh5sWdzWSPpFHMVA1UnB6o=;
        b=Amgys6yR9ThhrGUWgN0xwAeQVN11/9ieXyMbX53skvp+611RG7k7wb0w0vSOJ3j9s9
         XtkeQ2dDiGvKdp9oPkWiZ86JTtcRE8BNcRAmdLSkzuHwcx/QOOplsvuIJVx9LECxSSLN
         YvS5X40w6psbnkn7hSZM32LWh728Fdq/ep6JZS3rjgHQuKFXc8YaBPq3xHAkEQKxKcuz
         1f4JJMfy+xjUeeJZLZ5S0nLKU2/44tr09WDzvIY4bsstdpbH+ACIM+FcZ5zucOBwGLEm
         g5W5NuZQbt6erB3C5OG47Wa+SPRDsGknZJNCregml6WMAY4rhYbouwhjEl51e0Q41NWv
         hVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+VoC5O6h7ZfIBAy9yt0jFTh5sWdzWSPpFHMVA1UnB6o=;
        b=vUszcy0bgmu8ojnl1Db8VgbpG7DvFBw3odq4b6nBrgHESRciGO4+AqxyS5w0i2xu63
         o6RwzOvEEOPu6tBdHZh05tS6eghvp/56WMROE+C3UiuSonmzDW+bHhrF/Xh7qgeHCAMm
         raq59snCRvdep+1QRBOghnROxiLw4ljoj8MXqX+9IwNbgz89ttPBI/HKi4eL3Gy5eUrY
         oVZRHLaTIZD+pNzPlWBY99vw1HuRJdQJmc8jU1ip/wPqxbomCjx+sPLqzOthZc7EDn5Z
         HqXYSdx/gUTrhZGBquH3fGpuklQxdXpdumyxTnDqEV/Lrexzkw42MTxBmjpybD+D0+yV
         cmfA==
X-Gm-Message-State: ACrzQf1nbGpJGDOwByARUE+tBWhHAlpupzYoc/2wo6uxpsTkh3Exhjrk
        zQm3VucxXYggAG4wx+KHkEDHo3bKdE/hR/gy4rA=
X-Google-Smtp-Source: AMsMyM6Kq3rk40ALl/YgkZXlUCq9NxAtWqN3do0TiYDNdcGLIfZ/Z/Hz1l3Zx0dndk5ZiHl0FiobuSJHCnWiwk+xMn4=
X-Received: by 2002:a17:902:dac5:b0:186:a687:e082 with SMTP id
 q5-20020a170902dac500b00186a687e082mr55171671plx.84.1667882553684; Mon, 07
 Nov 2022 20:42:33 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:522:8e11:b0:472:3709:5064 with HTTP; Mon, 7 Nov 2022
 20:42:33 -0800 (PST)
Reply-To: mrstheresaheidi8@gmail.com
From:   "Ms. Theresa Heidi" <rev.johnpatrick1@gmail.com>
Date:   Mon, 7 Nov 2022 20:42:33 -0800
Message-ID: <CAMiB5XggM2hEnjNkoM+PXcTy4kQE1Jdpw4p-WtpeWs8rd4KUog@mail.gmail.com>
Subject: =?UTF-8?B?56eB44KS5Yqp44GR44Gm44GP44Gg44GV44GE?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=7.9 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:62a listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [rev.johnpatrick1[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [rev.johnpatrick1[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrstheresaheidi8[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5oWI5ZaE5a+E5LuY77yBDQoNCuazqOaEj+a3seOBj+OBiuiqreOBv+OBj+OBoOOBleOBhOOAguOB
k+OBruaJi+e0meOBjOOBguOBquOBn+OBq+OCteODl+ODqeOCpOOCuuOBqOOBl+OBpuWxiuOBj+OB
i+OCguOBl+OCjOOBquOBhOOBk+OBqOOBr+S6i+Wun+OBp+OBmeOAguOBguOBquOBn+OBruWKqeOB
keOBjOW/heimgeOBquOBqOOBjeOBq+OAgeODl+ODqeOCpOODmeODvOODiOaknOe0ouOBp+OBguOB
quOBn+OBrumbu+WtkOODoeODvOODq+mAo+e1oeWFiOOBq+WHuuS8muOBhOOBvuOBl+OBn+OAguen
geOBr+W/g+OBruS4reOBp+OBk+OBruODoeODvOODq+OCkuabuOOBhOOBpuOBhOOBvuOBmeOBjOOA
geOCpOODs+OCv+ODvOODjeODg+ODiOOBr+S+neeEtuOBqOOBl+OBpuacgOmAn+OBrumAmuS/oeaJ
i+auteOBp+OBguOCi+OBn+OCgeOAgeOCpOODs+OCv+ODvOODjeODg+ODiOOCkuS7i+OBl+OBpuOB
guOBquOBn+OBq+mAo+e1oeOBmeOCi+OBk+OBqOOCkumBuOaKnuOBl+OBvuOBl+OBn+OAgg0KDQrn
p4Hjga/nj77lnKjjgIHogrrjgYzjgpPjga7jgZ/jgoHjgqTjgrnjg6njgqjjg6vjga7np4Hnq4vn
l4XpmaLjgavlhaXpmaLjgZfjgabjgYTjgosgNjINCuats+OBruODhuODrOOCteODj+OCpOOCuOWk
q+S6uuOBp+OBmeOAguengeOBrzTlubTliY3jgIHjgZnjgbnjgabjgpLmrovjgZfjgabjgY/jgozj
gZ/lpKvjgYzkuqHjgY/jgarjgaPjgZ/nm7TlvozjgavogrrjgYzjgpPjgajoqLrmlq3jgZXjgozj
gb7jgZfjgZ/jgILnp4Hjga/jgIHogrrjgYzjgpPjga7msrvnmYLjgpLlj5fjgZHjgabjgYTjgovn
l4XpmaLjgafjg6njg4Pjg5fjg4jjg4Pjg5fjgpLmjIHjgaPjgabjgYTjgb7jgZnjgIINCg0K56eB
44Gv5Lqh44GP44Gq44Gj44Gf5aSr44GL44KJ5Y+X44GR57aZ44GE44Gg6LOH6YeR44KS5oyB44Gj
44Gm44GE44G+44GZ44CC44Gd44Gu57eP6aGN44Gv44Gf44Gj44Gf44GuIDEyMCDkuIfjg4njg6sN
CigxMuWEhOexs+ODieODqynjgafjgZnjgILku4rjgIHnp4HjgYzkurrnlJ/jga7mnIDlvozjga7m
l6Xjgavov5HjgaXjgYTjgabjgYTjgovjgZPjgajjga/mmI7jgonjgYvjgafjgZnjgILjgZPjga7j
gYrph5Hjga/jgoLjgYblv4XopoHjgarjgYTjgajmgJ3jgYTjgb7jgZnjgIIu56eB44Gu5Li75rK7
5Yy744Gv44CB56eB44GM6IK644GM44KT44Gu5ZWP6aGM44Gu44Gf44KB44GrDQoxIOW5tOmWk+OB
r+eUn+OBjeOCieOCjOOBquOBhOOBk+OBqOOCkueQhuino+OBleOBm+OBvuOBl+OBn+OAgg0KDQrj
gZPjga7jgYrph5Hjga/jgb7jgaDlpJblm73jga7pioDooYzjgavkv53nrqHjgZXjgozjgabjgYrj
gorjgIHntYzllrbpmaPjga/jgIHnp4HjgYznl4XmsJfjga7jgZ/jgoHjgavmnaXjgovjgZPjgajj
gYzjgafjgY3jgarjgYTjga7jgafjgIHjgYrph5HjgpLlj5fjgZHlj5bjgovjgZ/jgoHjgavliY3j
gavmnaXjgovjgYvjgIHku6Pjgo/jgorjgavoqrDjgYvjgavjgYrph5HjgpLlj5fjgZHlj5bjgovj
gZ/jgoHjga7mib/oqo3mm7jjgpLnmbrooYzjgZnjgovjgojjgYbjgavjgIHnnJ/jga7miYDmnIno
gIXjgajjgZfjgabnp4HjgavmiYvntJnjgpLmm7jjgY3jgb7jgZfjgZ/jgIIu6YqA6KGM44Gu6KGM
5YuV44KS5oCg44KL44Go44CB6LOH6YeR44KS6ZW35pyf6ZaT5L+d566h44GX44Gf44Gf44KB44Gr
6LOH6YeR44GM5rKh5Y+O44GV44KM44KL5Y+v6IO95oCn44GM44GC44KK44G+44GZ44CCDQoNCuOB
k+OBruOBiumHkeOCkuWkluWbveOBrumKgOihjOOBi+OCieW8leOBjeWHuuOBl+OBpuOAgeaBteOB
vuOCjOOBquOBhOS6uuOAheOCkuWKqeOBkeOCi+ODgeODo+ODquODhuOCo+ODvOa0u+WLleOBq+iz
h+mHkeOCkuS9v+eUqOOBmeOCi+OBruOCkuaJi+S8neOBo+OBpuOBj+OCjOOCi+OBi+OBqeOBhuOB
i+OAgeOBneOBl+OBpuiIiOWRs+OBjOOBguOCi+OBquOCieOAgeengeOBr+OBguOBquOBn+OBq+mA
o+e1oeOBmeOCi+OBk+OBqOOBq+axuuOCgeOBvuOBl+OBny7np4HjgavkvZXjgYvjgYzotbfjgZPj
govliY3jgavjgIHjgZPjgozjgonjga7kv6HoqJfln7rph5HjgpLoqqDlrp/jgavlh6bnkIbjgZfj
gabjgbvjgZfjgYQu44GT44KM44Gv55uX44G+44KM44Gf44GK6YeR44Gn44Gv44Gq44GP44CB5a6M
5YWo44Gq5rOV55qE6Ki85oug44GM44GC44KK44CBMTAwJQ0K44Oq44K544Kv44GM44Gq44GP44CB
5Y2x6Zm644Gv44GC44KK44G+44Gb44KT44CCDQoNCuOBiumHkeOBriA1NSUg44Gv5oWI5ZaE5rS7
5YuV44Gr5L2/44KP44KM44CB5ZCI6KiI6YeR6aGN44GuIDQ1JQ0K44Gv44GC44Gq44Gf44Gu5YCL
5Lq655qE44Gq5L2/55So44Gu44Gf44KB44Gr5Y+W44Gj44Gm44G744GX44GELuengeOBr+engeOB
ruacgOW+jOOBrumhmOOBhOOCkuWNsemZuuOBq+OBleOCieOBmeOCiOOBhuOBquOBk+OBqOOBr+S9
leOCguacm+OCk+OBp+OBhOOBquOBhOOBruOBp+OAgeengeOBruW/g+OBi+OCieOBrumhmOOBhOOC
kumBlOaIkOOBmeOCi+OBn+OCgeOBq+OAgeOBguOBquOBn+OBruacgOWkp+mZkOOBruS/oemgvOOB
qOenmOWvhuS/neaMgeOBq+aEn+isneOBl+OBvuOBmS7jgZPjga7miYvntJnjgpLov7fmg5Hjg6Hj
g7zjg6vjgaflj5fjgZHlj5bjgaPjgZ/loLTlkIjjga/jgIHnlLPjgZfoqLPjgYLjgorjgb7jgZvj
gpPjgYzjgIHjgZPjgozjga/jgZPjga7lm73jgafjga7mnIDov5Hjga7mjqXntprjgqjjg6njg7zj
gavjgojjgovjgoLjga7jgafjgZnjgIINCg0K44GC44Gq44Gf44Gu5pyA5oSb44Gu5aa544CCDQrj
g4bjg6zjgrXjg7vjg4/jgqTjgrjlpKvkuroNCg==
