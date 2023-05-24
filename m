Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E655070F1FF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240610AbjEXJS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240214AbjEXJS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:18:26 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F658E
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:18:25 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id 4fb4d7f45d1cf-510d8d7f8eeso1731109a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684919904; x=1687511904;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cpy7HUUl9JUJVfHeyZRx3CTbUVGObKlyKlmgTELiasw=;
        b=derKyJRoziyvzklytm4sDMV7BgbDOTtG9eW8z/nmr1h+OunNJWP0ntR/NIKmTW+wlH
         u9EQBQrO6NXY8aKVRuc3GEIrszLGC0ApFGmCH5xYxwWtnp73gI/jOgDKHHvff33uKz6O
         rkx2ecHNQjTNDH/eOfO6ocW2cRnLkOQjgjm1qxEIPn6j7JdCwjHWcmfRnIpODGI+RGxE
         jILVq8CXIQKLZ3rfeuom21NzdvaF+kqiq0P3EaDt68sA/rHjWX3xtu48+NTG8nbqe7wA
         eTTpnnOOH51L06QmihSKEqCc7WS1In034rp9x9jr4FfFR4SNcAeqgVBzGDAXEl64F8AP
         3sxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684919904; x=1687511904;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpy7HUUl9JUJVfHeyZRx3CTbUVGObKlyKlmgTELiasw=;
        b=e7c8H4Wm9Ew3K1+ZlpyLVmlU8Wr8P4X2bfD/xrYTP04tsA/ONNr9UfxOTFtuvcKAgW
         whgFtIHTtIT95H2UqN8s+/LR65NQpSocejCF9JfikVM4JCGxbyVzLuGpBk1YDiIOY25T
         dloCtacfQBaCq4rIE8zlaUOuczCZmNfUqpBsjHdOZ44x9vGDkzn8VtolL3Pog//EHxx1
         9y9laKK9WFTzoIejFqfW5J5TxoZ2CH2zlB40bj1SalgHpoH3N7xcJJF/tPHKwlskGu8v
         nClzWWjfBgX0EJzykZoiJmZrTwO9z9XhSychWYJJ9HMAact2tJMkouTZatgJSzzD3HUd
         1BWQ==
X-Gm-Message-State: AC+VfDy0/ATu+03x0ftUYX79To+FncQMKZqtULnr9w7gHB2gzoyORMpe
        ULIrdIQchr4zNvoCF1CREXjJQBbfPP7R52BmoR0=
X-Google-Smtp-Source: ACHHUZ5PPiqjMgwiWnT6W6KQ01c+bOdrjGnQBywC375EdkQcYDLjsUbkuoh0N6lRkWtm9f8uruDOOD8fGVdarQBJDBM=
X-Received: by 2002:a17:907:7b90:b0:94f:322d:909c with SMTP id
 ne16-20020a1709077b9000b0094f322d909cmr16630436ejc.34.1684919903549; Wed, 24
 May 2023 02:18:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7412:2017:b0:d4:3f30:e96a with HTTP; Wed, 24 May 2023
 02:18:23 -0700 (PDT)
Reply-To: philipsjohnsongoodp@gmail.com
From:   philips <robertandersongood15@gmail.com>
Date:   Wed, 24 May 2023 11:18:23 +0200
Message-ID: <CABEHdUHRLD2YrH4412=7XQ6b9JszyC9QqdNUUgzoq6h=0eFMzQ@mail.gmail.com>
Subject: good
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
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
