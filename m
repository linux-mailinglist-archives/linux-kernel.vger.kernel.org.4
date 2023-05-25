Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B529710CC9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 15:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241297AbjEYNAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 09:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241193AbjEYNAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 09:00:09 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6DBE41
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 05:59:57 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a640c23a62f3a-96f683e8855so90780666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 05:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685019596; x=1687611596;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cpy7HUUl9JUJVfHeyZRx3CTbUVGObKlyKlmgTELiasw=;
        b=F0j/0BGqkV+g1s//XRbh/qZbYYT/zVg925VF/Y/PwGKL5doE5KF0ftitU2wlO/3iWf
         emtmJabb7vvO7k8Q9o7X80sm6mhMgrHJpNXTxYi7/wSZslLjcL8D8CkRUyjI8WwX+cNP
         K0qTRgIVOeG/5aWzBPLMf3cPR7iLIK0636bqBX2+VKZrTRmZxxxZ8VvoPZYY6HZtwziZ
         6dBcjWyl6cvGIyprCDKGymOhUBkR8kAgA/cHp0FAeePwu+PvMlog+lhj8vG1iVUV8C4i
         /Cavw73D6lN5wi+rsqcE4WdxUOHdbI+Anw3cs2vu0CkY7k7qmOfVY9cHPioHIDyVWC1O
         j0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685019596; x=1687611596;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpy7HUUl9JUJVfHeyZRx3CTbUVGObKlyKlmgTELiasw=;
        b=lNoWeAoNOOgd6W3gl66F4psSzIcWg6WAIiTdab52rm9kn+lW0aBFmUWMwczcVVAaGt
         oqzLVW877SV2866z5n7c6mRBigQV9j+StugMwhSsUPUXmxEtrwkWFoTN7rbAcba9mHMx
         6PRY/+3FZL7MCVFl0oZa43hL8yRbYg6xyXMCfeTfNk0WEMDaEnhNUSI/m2PMyaO46iX9
         9nkwXS6i4lmvKB+Duqs2gaLvTwISbqAgXaR4SyBeP8CLsvQRbFSwtYSsuV6G8SEETxCp
         10NOZWPCgqdF4D7LrnalLK3HLr3ouC589dQwCoMYcsEVr0pqya66eIea4bUkcRAIaJNV
         1WFA==
X-Gm-Message-State: AC+VfDxW88pJEtza7Omf9uTfbOOZVIZPJD54A1fwfS8YwitwVPlFRjZI
        2etea4p7bZGVJKtdbx1FA0NnYK76A4dSiJOc/j0=
X-Google-Smtp-Source: ACHHUZ7vApnlZTNzQwuszyTX9ej/W6Pi9U/c+lzwA29qoCr5/SOJWP/PTLR4mt+fu0KM9v4evFD1McD0XXJUjY8A4RA=
X-Received: by 2002:a17:907:3da3:b0:969:acdc:c4df with SMTP id
 he35-20020a1709073da300b00969acdcc4dfmr1738237ejc.4.1685019595735; Thu, 25
 May 2023 05:59:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:944b:b0:957:1d94:103d with HTTP; Thu, 25 May 2023
 05:59:54 -0700 (PDT)
Reply-To: philipsjohnsongoodp@gmail.com
From:   philips <ekesineugwu5@gmail.com>
Date:   Thu, 25 May 2023 14:59:54 +0200
Message-ID: <CALM=UYrzD0kbQeZFYpew1U5zjVwvnnvtqb1=o0rRfdUsKBm6aA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0JTQvtGA0L7Qs9C+0Lkg0LTRgNGD0LMsDQrQnNC10L3RjyDQt9C+0LLRg9GCINCR0LDRgC7QpNC4
0LvQuNC/0YEg0JTQttC+0L3RgdC+0L0sINGPINCw0LTQstC+0LrQsNGCINC4INGH0LDRgdGC0L3R
i9C5DQrQvNC10L3QtdC00LbQtdGAINC/0L4g0YDQsNCx0L7RgtC1INGBINC60LvQuNC10L3RgtCw
0LzQuCDQvNC+0LXQvNGDINC/0L7QutC+0LnQvdC+0LzRgyDQutC70LjQtdC90YLRgy4g0JIgMjAx
NyDQs9C+0LTRgw0K0LzQvtC5INC60LvQuNC10L3RgiDQv9C+INC40LzQtdC90LgNCtCc0LjRgdGC
0LXRgCDQmtCw0YDQu9C+0YEsINGPINGB0LLRj9C30LDQu9GB0Y8g0YEg0LLQsNC80Lgg0L/QviDR
gtC+0Lkg0L/RgNC40YfQuNC90LUsINGH0YLQviDQstGLDQrQvdC+0YHQuNGC0Ywg0L7QtNC90YMg
0YTQsNC80LjQu9C40Y4g0YEg0L/QvtC60L7QudC90YvQvCwg0Lgg0Y8g0LzQvtCz0YMg0L/RgNC1
0LTRgdGC0LDQstC40YLRjCDQstCw0YEg0LrQsNC6DQrQsdC10L3QtdGE0LjRhtC40LDRgCDQuCDQ
sdC70LjQttCw0LnRiNC40Lkg0YDQvtC00YHRgtCy0LXQvdC90LjQuiDRgdGA0LXQtNGB0YLQsiDQ
vNC+0LXQs9C+INC/0L7QutC+0LnQvdC+0LPQviDQutC70LjQtdC90YLQsCwg0YLQvtCz0LTQsCDQ
stGLDQrQstGL0YHRgtGD0L/QuNGC0Ywg0LIg0LrQsNGH0LXRgdGC0LLQtSDQtdCz0L4g0LHQu9C4
0LbQsNC50YjQtdCz0L4g0YDQvtC00YHRgtCy0LXQvdC90LjQutCwINC4INC/0L7RgtGA0LXQsdC+
0LLQsNGC0YwNCtGB0YDQtdC00YHRgtCy0LAuINC+0YHRgtCw0LLQu9GP0YLRjCDQvdCw0LvQuNGH
0L3Ri9C1DQrQvdCw0YHQu9C10LTRgdGC0LLQviDRgdC10LzQuCDQvNC40LvQu9C40L7QvdC+0LIg
0L/Rj9GC0LjRgdC+0YIg0YLRi9GB0Y/RhyDQodC+0LXQtNC40L3QtdC90L3Ri9GFINCo0YLQsNGC
0L7Qsg0K0JTQvtC70LvQsNGA0L7QsiAoNyA1MDAgMDAwLDAwINC00L7Qu9C70LDRgNC+0LIg0KHQ
qNCQKS4g0JzQvtC5INC/0L7QutC+0LnQvdGL0Lkg0LrQu9C40LXQvdGCINC4INC30LDQutCw0LTR
i9GH0L3Ri9C5DQrQtNGA0YPQsyDQstGL0YDQvtGBINCyDQrCq9CU0L7QvCDQsdC10Lcg0LzQsNGC
0LXRgNC4wrsuINCjINC90LXQs9C+INC90LUg0LHRi9C70L4g0L3QuCDRgdC10LzRjNC4LCDQvdC4
INCx0LXQvdC10YTQuNGG0LjQsNGA0LAsINC90Lgg0YHQu9C10LTRg9GO0YnQtdCz0L4NCtGA0L7Q
tNGB0YLQstC10L3QvdC40LrQvtCyINCyINC90LDRgdC70LXQtNGB0YLQstC+INCh0YDQtdC00YHR
gtCy0LAg0L7RgdGC0LDQstC70LXQvdGLINCyINCx0LDQvdC60LUuDQrQktGLINC00L7Qu9C20L3R
iyDRgdCy0Y/Qt9Cw0YLRjNGB0Y8g0YHQviDQvNC90L7QuSDRh9C10YDQtdC3INC80L7QuSDQu9C4
0YfQvdGL0Lkg0LDQtNGA0LXRgSDRjdC70LXQutGC0YDQvtC90L3QvtC5INC/0L7Rh9GC0Ys6DQpw
aGlsaXBzam9obnNvbmdvb2RwQGdtYWlsLmNvbQ0K0KEg0L3QsNC40LvRg9GH0YjQuNC80Lgg0L/Q
vtC20LXQu9Cw0L3QuNGP0LzQuCwNCtCR0LDRgC4g0KTQuNC70LjQv9GBINCU0LbQvtC90YHQvtC9
DQo=
