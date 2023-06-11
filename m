Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E89172AFFF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 04:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjFKCMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 22:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjFKCMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 22:12:44 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BD73595
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 19:12:43 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d75a77b69052e-3f6a494810fso25032531cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 19:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686449562; x=1689041562;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eHgHDIfPsbLwHrOLOgwM6Gxgc+BbmIDY++L7flC9JxU=;
        b=EB5aFYe2Nz/Kn8psWMSwvSZRy7ejMzFCx5VnlgthA4xv02Awth5dY71NigzZv/RLyo
         o4VpLKHj2IVGV949yT9dhEgZQ9vX6E7v11yGlI02bXB06nx0mhQJafHhWyf94YLMncSO
         IzmQB0TkJ25mziDT2SmzTM7fScMaSaAZn+OzNZGZOcyYDIqpxVoJZc6SfjFQEgyLDO/V
         TcP3/+J8LZqsghzKn/Llzt56mjY6JzXyMNIV/d02f8JROcAUZW3MDoG8au8dUv4vd+K6
         5EtfacnL9DtwNrzAQNZbWrjkbs5KGVzm7ojpETxpMCQDKsQUHjiq02mzZ2UwaWUTUE24
         uNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686449562; x=1689041562;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eHgHDIfPsbLwHrOLOgwM6Gxgc+BbmIDY++L7flC9JxU=;
        b=VdyQybULaGi8cebYCpFEUWdPS8GBI1qjVwLbMawqrrx/zDVXjy6CCQQlBVeqYRnFvm
         uiOl2WIHUJxj5fHl9A7jZH7IYiyfvBar+a235rebpVEizXUZgG2P5uW7TgOZPG3iC7zm
         Edm57ElQfuv9AWigQh19PBCX+4gsalgmzKajQpZVnOF7NnH/08axjs5d4hy0Rm4i8rwg
         aO6gQbsilkQH6jz+9kzIYLyEiKuvBnbUherkqBphg/h0p/qOssLajQKqgtzh6qdMzG78
         WhD5y1cfhIqpLjjzv/IPEfyVLPxDHGY/9yJ4IBJdgRUnLYbZGfe/R5yF7xBeVxjSTwa2
         WbJA==
X-Gm-Message-State: AC+VfDyLmJbYSMIyIcAr8dD4uPl0l7W2/uTnqBQg+fB505Pw9ttyTheS
        E2SbjpsrP8RwqhXz903UUjidIMkS7+rEU0tgiiU=
X-Google-Smtp-Source: ACHHUZ7AVE9c/wqegPLEU7mXF4yVXpRB0F5jObwOPZnvCLyycyF7gyqEsHk7SWeIqrutqs6xmaebIaVR6yXIlNfMdm4=
X-Received: by 2002:ac8:7d42:0:b0:3f9:e6ac:f315 with SMTP id
 h2-20020ac87d42000000b003f9e6acf315mr3778958qtb.48.1686449562277; Sat, 10 Jun
 2023 19:12:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:afa2:0:b0:3d6:22a9:9d1a with HTTP; Sat, 10 Jun 2023
 19:12:41 -0700 (PDT)
Reply-To: info.groupubabank.net@gmail.com
From:   UNITED BANK FOR AFRICA <oliverleonard480@gmail.com>
Date:   Sat, 10 Jun 2023 19:12:41 -0700
Message-ID: <CAM5=D1JCsEQ=XcX6kX7hYRuM3NOxkGGY7sHNZZrE-n=4qRiLfQ@mail.gmail.com>
Subject: =?UTF-8?B?1LzUsdWOINS81YjVktWQ?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1LHWgNWq1bjWgtW11anVqyDVtNWr1bvVodWm1aPVodW11avVtiDVsNWr1bTVttWh1aTWgNWh1bQg
KNSx1YTVgCkNCtWE1avVu9Wh1abVo9Wh1bXVq9W2INW61aHWgNW/1oTVqyDVtNWh1oDVtNWh1bYg
1bTVq9Wh1b7VuNaALA0KIyAxOTAwLCDVhtSx1L3UsdSz1LHVgCDUsdWOLtS01YjVkg0K1YDUsdWC
1LkuIC1YVkdOTjgyMDIzDQoNCtWI1oLVt9Wh1aTWgNW41oLVqdW11bjWgtW2INWA1aHWgNWj1aXV
rNWrINWn1azWg9W41b3Vv9WrINW91aXWg9Wh1a/VodW21aHVv9Wl1oA6DQoNCtWT1aHVvdW/1bjW
gNWl1bYsINW01aXVttaEINW21bjWgNWh1bbVt9Wh1bbVodWvINaG1avVttWh1bbVvdW21aXWgNWr
INW21aHVrdWh1oDVodaA1asg1ocg1YTVq9Wh1b7VuNaA1b7VodWuINWh1abVo9Wl1oDVqw0K1a/V
odWm1bTVodWv1aXWgNW61bjWgtWp1bXVodW2INSx1oDVqtW41oLVtdWp1asg1bTVq9Wh1b7VuNaA
1asg1bLVpdWv1aHVvtWh1oAg1bTVodaA1bTVttWrINWv1bjVstW01avWgSDVrNWr1aHVptW41oDV
vtWh1a4g1aXVttaEDQrVsNWl1b/VodaE1bbVttWl1awg1bnVutWh1bDVodW21bvVvtWh1a4g1bTV
q9W71bjWgdW21aXWgNWoLCDVuNaA1bjVttaEINW+1aHVstW41oLWgSDVutWl1b/WhCDVpyDVsNWh
1bXVv9W21b7VpdW2INWE1avVodW+1bjWgNW+1aHVrg0K1aHVptWj1aXWgNWrINWv1aHVptW01aHV
r9Wl1oDVutW41oLVqdW11aHVtiDVr9Wh1bzVodW+1aHWgNWh1a/VodW2INWm1aHVtNWi1bXVuNaC
1bLVuNaC1bQsINWr1bbVudWoINW/1aHVttW/1aXWgNWl1oDVq9W2DQrVt9aD1bjVqdW41oLVqdW1
1aHVtiDVtNWl1bsg1acg1aPWgdWl1azVnSDVtNW/1aHVrtWl1azVuNW+LCDVuNaAINW21oDVodW2
1oQuINW01aXWgCDVsNWl1b/VodaE1bbVttW41oLVqdW11aHVtiDVqNW21anVodaB1oTVuNaC1bQN
CtWt1aHVotWl1bjWgtWp1bXVodW2INWl1bYg1aXVttWp1aHWgNWv1b7VpdWsINWE1avVodW+1bjW
gNW+1aHVriDVodWm1aPVpdaA1asg1a/VodWm1bTVodWv1aXWgNW61bjWgtWp1bXVodW2INWh1bbV
uNaC1bbVqA0K1oXVo9W/1aHVo9W41oDVrtW41bIg1a3VodWi1aXVotWh1bbVpdaA1ag6INWA1aHV
tNWh1bHVodW11bYg1bTVpdaAINWw1aHVtNWh1a/VodaA1aPVqyDVv9W+1bXVodWs1bbVpdaA1asg
1brVodWw1brVodW21bTVodW2DQrVo9aA1aHVttaB1aHVtNWh1b/VtdWh1bbVq9WdINWx1aXWgCDV
p9WsLtaD1bjVvdW/1asg1bDVodW91oHVpdW41b4sINWB1aXWgCDVvtWz1aHWgNW41oLVtNWoINW2
1aXWgNWh1bzVvtWh1a4g1acgMTUwDQrVt9Wh1bDVodW81bjWgtW21aXWgNWrINaB1aHVttWv1bjW
gtW0LCDVuNaA1bjVttaEINWk1aHVvdWh1a/VodaA1aPVvtWh1a4g1aXVtiDVuNaA1brVpdW9Lg0K
DQrVhNWl1bbWhCwg1asg1abVodaA1bDVuNaC1oDVodW21oQsINWw1aHVtdW/1bbVodWi1aXWgNW4
1oLVtCDVpdW21oQsINW41oAg1bHVpdaAINW+1bPVodaA1bjWgtW01bYg1aHVttWw1aHWgNWv1asN
CtWw1aXVv9Wh1bHVo9W+1aXVrCDVpyDVr9W41bzVuNaC1bTVutWh1oHVvtWh1a4g1LLVodW21a/V
qyDVutWh1bfVv9W41bbVtdWh1bbVpdaA1asg1a/VuNWy1bTVq9aB1Z0g1oPVuNaA1bHVpdWs1bjV
viDVrdWh1aLVpdWsINWx1aXWgA0K1obVuNW21aTVqCwg1avVttW51asg1bDVpdW/1ofVodW21oTV
uNW+INWx1aXWgCDVr9W41bLVtNWr1oEg1bfVodW/INWv1bjWgNW41oLVvdW/1bbVpdaAINWl1bYg
1aXVstWl1awg1ocg1bHVpdaAINW+1bPVodaA1bjWgtW01agNCtW91b/VodW21aHVrNW41oIg1aHV
ttWw1aHWgNWv1asg1bjWgtW31aHWgdW41oLVtNW21aXWgNWoOiDVhNSx1L8t1agg1ocg1LHWgNWq
1bjWgtW11anVqyDVtNWr1bvVodWm1aPVodW11avVtiDVsNWr1bTVttWh1aTWgNWh1bTVqA0KKNSx
1YTVgCkg1ajVttW/1oDVpdWsINWl1bYg1oPVuNWt1bDVodW/1bjWgtaB1bTVodW2INWi1bjVrNW4
1oAg1bTVq9W71bjWgdW21aXWgNWoIDE1MCDVh9Wh1bDVodW81bjWgtW21aXWgNWrDQrVgNW11bjW
gtW91avVvdWh1bXVq9W2INSx1bTVpdaA1avVr9Wh1bXVuNaC1bQsINWA1aHWgNWh1b7VodW11avV
tiDUsdW01aXWgNWr1a/VodW11bjWgtW0LCDUsdW01aXWgNWr1a/VodW11asg1YTVq9Wh1oHVtdWh
1awNCtWG1aHVsNWh1bbVo9W21aXWgNW41oLVtCwg1LXVvtaA1bjVutWh1bXVuNaC1bQg1ocg1LHV
vdWr1aHVtdW41oLVtCDWhyDVodW01aLVuNWy1bsg1aHVt9Wt1aHWgNWw1bjWgtW0INaE1aHWgNW/
1asg1bTVq9W71bjWgdW41b46DQpWaXNhINWi1aHVttWv1bjVtNWh1b/VqCwg1oTVodW21asg1bjW
gCDVvdWhINW+1bPVodaA1bjWgtW01bbVpdaA1asg1bDVodW01aHVt9Wt1aHWgNWw1aHVtdWr1bYg
1b/VpdWt1bbVuNWs1bjVo9Wr1aEg1acsINW41oDVqA0K1anVuNaC1bXVrCDVpyDVv9Wh1azVq9W9
INW91brVodW81bjVstW21aXWgNWr1bYsINWi1avVptW21aXVvdWr1bYsINaG1avVttWh1bbVvdWh
1a/VodW2INWw1aHVvdW/1aHVv9W41oLVqdW11bjWgtW21bbVpdaA1avVtiDWhw0K1a/VodW81aHV
vtWh1oDVuNaC1anVtdW41oLVttW21aXWgNWr1bYg1oXVo9W/1aHVo9W41oDVrtWl1awg1anVvtWh
1bXVq9W2INWh1oDVqtW41oLVtdWp1Z0g1a/VodW21a3Vq9Wv1asg1ocg1bnVpdWv1aXWgNWrDQrW
g9W41a3VodaA1aXVtjoNCg0K1YTVpdW21oQg1a/VodWm1bTVodWv1aXWgNW61aXVrCDVpdW21oQs
INW41oAg1bHVpdaAINW+1bPVodaA1bjWgtW01agg1bHVpdWmINW+1bPVodaA1b7VqyBWaXNhINWi
1aHVttWv1bjVtNWh1b/VodW11avVtg0K1oTVodaA1b/VqyDVtNWr1bvVuNaB1bjVviwg1ocg1aHV
tdW2INWv1b/WgNW+1asg1bHVpdaAINWh1bbVuNaC1bbVuNW+INaHINWv1bjWgtWy1aHWgNWv1b7V
qyDVodW21bTVq9W71aHVutWl1b0g1bHVpdaADQrVsNWh1b3WgdWl1bjVvtWdIERITC3VqyDVr9Wh
1bQg1bHVpdaAINWl1oDVr9aA1bjWgtW0INWw1aHVvdWh1bbVpdWs1asg1oHVodW21a/VodaB1aHV
riDVvdW41oLWgNWw1aHVttWk1aHVr9Wh1bXVq9W2DQrVrtWh1bzVodW11bjWgtWp1bXVodW2INW0
1avVu9W41oHVuNW+OiDVhNWl1aYg1bDVpdW/INWv1aHVutW+1aXVrNW41oLWgSDVsNWl1b/VuCAx
LjUwMC4wMDAuMDAg1LHVhNWGINWk1bjVrNWh1oANCtWj1bjWgtW01aHWgNWoINWv1aPWgNWh1bbW
gdW+1asgVmlzYSDVotWh1bbVr9W41bTVodW/1aHVtdWr1bYg1oTVodaA1b/Vq9W2LCDWhyDVpNWh
INWp1bjWgtW11awg1a/Vv9WhINWv1aHVttWt1avVr9Wh1oHVttWl1awNCtWx1aXWgCDVtNWr1bvV
uNaB1bbVpdaA1agg1bHVpdaAINWl1oDVr9aA1asg1oHVodW21a/VodaB1aHVriDVotWh1bbVr9W4
1bTVodW/1avWgdWdINaF1oDVodWv1aHVtiDVttW+1aHVptWh1aPVuNaC1bXVttWoIDEwLjAwMA0K
1LHVhNWGINWk1bjVrNWh1oDVqyDVr9Wh1bbVrdWr1a/VodaB1bjWgtW01bjVvjog1YHVpdaAINW9
1aHVsNW01aHVttWh1bnVodaD1agg1a/VodaA1bjVsiDVpyDVodW+1aXVrNWh1oHVvtWl1awg1bTV
q9W21bnWhw0KMjAsMDAwLjAwINSx1YTVhiDVpNW41azVodaA1Z0g1ajVvdW/INW61aHVsNWh1bbV
u9WrOiDUsdW11b0g1a/VodW61aHVr9aB1bjWgtWp1bXVodW01aIg1aTVuNaC1oQg1brVpdW/1oQg
1acg1a/VodW61b7VpdaEDQrWhyDVv9aA1aHVtNWh1aTWgNWl1oQg1brVodWw1aHVttW71b7VuNWy
INW/1aXVstWl1a/VodW/1b7VuNaC1anVtdW41oLVttWoINWE1avVu9Wh1abVo9Wh1bXVq9W2INW+
1bPVodaA1bjWgtW01bbVpdaA1asg1ocNCtaD1bjVrdWh1bbWgdW41oLVtNW21aXWgNWrINW/1bbW
hdaA1avVttW41oLVqdW11aHVttWoINWw1aXVv9aH1bXVodWs1bjVvi4NCg0KMS4g1YHVpdaAINWs
1oDVq9W+INWh1bbVuNaC1bbVqCAo1aHVttW41oLVtiDWhyDVodWm1aPVodW21bjWgtW2KQ0KMi4g
1YHVpdaAINWs1oDVq9W+INWi1bbVodWv1bjWgtWp1bXVodW2INWw1aHVvdaB1aXVtiDWhyDVsdWl
1oAg1aXWgNWv1avWgNWoDQozLiDUsdWm1aPVuNaC1anVtdW41oLVtg0KNC4g1L7VttW21aTVtdWh
1bYg1aHVtNW91aHVqdWr1b4gLyDVvdWl1bwNCjUuINS21aLVodWy1bTVuNaC1bbWhA0KNi4g1YDV
pdW81aHVrdW41b0v1obVodaE1b3VqyDVsNWh1bTVodaADQo3LiDVgdWl1oAg1ajVttWv1aXWgNW4
1oLVqdW11aHVtiDVp9Ws4oCkINWw1aHVvdaB1aXVtiAvINSx1bbVsdW21aHVr9Wh1bYg1afVrOKA
pCDVsNWh1b3WgdWl1bbWiQ0KDQrVldWj1b/VodWj1bjWgNWu1aXWhCDVodW11b0g1a7VodWu1a/V
odWj1avWgNWoICjVgNWy1bjWgtW0YCBDTElFTlRFLTk2Ni8xNikg1bjWgNW61aXVvSDVsdWl1oAg
1afVrC7Wg9W41b3Vv9WrDQrVqdWl1bTVodWdINW21bjWgtW11bbVodWv1aHVttWh1oHVtNWh1bYg
1bDVodW01aHWgCDWhyDWg9W41oDVsdWl1oQg1b/WgNWh1bTVodWk1oDVpdWsINW+1aXWgNWoINW2
1bfVvtWh1a4NCtW/1aXVstWl1a/VodW/1b7VuNaC1anVtdW41oLVttWoINW91b/VuNaA1ocg1aPV
v9W21b7VuNWyINWh1bfVrdWh1b/VodWv1avWgdW21aXWgNWr1bbVnSDVsdWl1oAgVmlzYSDVotWh
1bbVr9W41bTVodW/1aHVtdWr1bYNCtaE1aHWgNW/1agg1b/WgNWh1bTVodWk1oDVpdWs1bjWgiDW
hyDVodW81aHWhNWl1azVuNaCINWw1aHVtNWh1oAuDQoNCtWE1aXVttaEINWi1aHVttWv1aHVtdWr
1bYg1aPVuNaA1a7VodWv1aHVrNWr1bYg1a3VuNaA1bDVuNaC1oDVpCDVpdW21oQg1b/VvtWl1awg
1aLVodaB1aXVrCDVodW21bHVttWh1a/VodW2INWn1azWg9W41b3Vv9WrDQrVsNWh1b3WgdWlINW2
1bjWgCDVsNWh1bTVodaA1bjVviwg1bjWgNWoINWp1bjWgtW11awg1a/Vv9WhINW01aXVpiDVvtWl
1oDVodWw1b3Vr9Wl1awg1aHVtdW9INW+1bPVodaA1bjWgtW01agg1ocg1oPVuNWt1aHVttaB1aXV
rA0K1bDVodWy1bjWgNWk1aHVr9aB1bjWgtWp1bXVuNaC1bbVttWl1oDVqNWdINWt1bjWgtW91aHW
g9Wl1azVuNaCINWx1aXWgCDWhtW41bbVpNWrINWw1aXVv9Wh1aPVoSDVuNaC1bfVodaB1bjWgtW0
1bbVpdaA1avWgSDVr9Wh1bQNCtW31aXVstW41oLVtNW21aXWgNWr1oE6INS91bbVpNaA1bjWgtW0
INWl1bbWhCDVr9Wh1bog1bDVodW91b/VodW/1aXVrCDVsdWl1oAgVW5pdGVkIEJhbmst1asg1aPV
uNaA1a7VodWv1aHVrNWrINWw1aXVv9WdDQrVsNWl1b/Wh9W11aHVrCDVr9W41bbVv9Wh1a/Vv9Wh
1bXVq9W2INW/1b7VtdWh1azVttWl1oDVuNW+Lg0KDQrUv9W41bbVv9Wh1a/Vv9WdIE1SLiDVlNS1
1YbUtdS01Lsg1YjVktS21YjUv9SxDQrVk9W41a3VsNWh1b/VuNaC1oHVtNWh1bYg1bTVq9W71bjW
gdW21aXWgNWrINaD1bjVrdWh1bbWgdW01aHVtiDVotWh1arVq9W2ICjUsdaG1oDVq9Wv1aHVtdWr
INWE1avVodaB1bXVodWsINWi1aHVttWvKQ0K1L/VuNW21b/VodWv1b/VodW11avVtiDVp9WsLtaD
1bjVvdW/Lg0KDQrVhNWl1bbWhCDVutWh1bDVodW21bvVuNaC1bQg1aXVttaEINWx1aXWgCDVsNaA
1aHVv9Wh1bog1brVodW/1aHVvdWt1aHVttW2INWh1bXVvSDVp9Ws1oPVuNW91b/Vq9W2LCDVq9W2
1bnVutWl1b0g1bbVt9W+1aHVriDVpw0K1bDVpdW/1aHVo9WhINW41oLVt9Wh1oHVuNaC1bTVttWl
1oDVq9aBINWt1bjWgtW91aHWg9Wl1azVuNaCINWw1aHVtNWh1oA6DQoNCiAg1YDVodaA1aPVodW2
1oTVttWl1oDVuNW+DQogINWP1avVr9Wr1bYg1ZTWgNWr1b3Vv9Wh1azVq9W21aEg1LPVpdW41oDV
o9Wr1ofVoQ0K
