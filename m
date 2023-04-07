Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE986DB0E3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 18:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjDGQtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 12:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjDGQtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 12:49:51 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8845B92
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 09:49:50 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id k17so49508769ybm.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 09:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680886189;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GwldnxxVZHZIeHVMt8UZiIsJemyEAuafmPtqrxMMBXQ=;
        b=fm3aPjKOiN7zz46dgm5OgJkHb/j5vVxBP9L46iyykJwuq964SPOtaHKC3Dihg0Z7uA
         LF42dRy6BljA/CREmHYnpG4r0YilghWNyGR6Fjjggj6EHiIAdvupZ4qs4BsAaQv0403R
         DECzSzbTKglzhWyjawJmKbtkTPuapphVR9eMdhxw32T+CEroM5QG1IAwRJGHcYrYdeIB
         IlUjxsUzAAlOcDUiIaRq+eaScknOF+x06zxD7/XAkpDjbXOuTdPDeWjTL8jZ/ntRYlmN
         2MsGycUju7BKbtT0DeRQ9CqY9fkPkxX1YP1aXxz2+PEc5LgkqYBiIHxVzLdzrGJMrPnj
         J/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680886189;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GwldnxxVZHZIeHVMt8UZiIsJemyEAuafmPtqrxMMBXQ=;
        b=eozNM1gXv+PJKubvykcwjsylEb/+8MjCJkb+2RAecBOAxzUe634Y5eHfmVrsG91IMA
         sOppuSPakU+X3PqEsShAqAYRGrrrxB2pBrISitLuTbFHble/vYSUWBXZ10+s0SYHcUBO
         tGX/CrvBf8LcZcUdyP7xBgE007VjNaBsd3IXftAh2Yk4ijR8rENhqalztmQdHf+IeSoU
         TiI6AZnS7Y5qMUjEQRCW4cLiYamUbfzuuRbjXnHWp0/aqoxcC8bFDoaDViRnH6TQIQQR
         q+5+69m6E+WkI97io+htkxbJNXOrWx3/D28U8fbQzoeZafRPu5XT/ZeL5RKZl5s0jMH6
         9BOg==
X-Gm-Message-State: AAQBX9e9eqnzpycUjTRldDqTg5wgz1BuIdYca4pGZkRSbw/Eh9caqwUm
        6WOjdYFVEE+NfRYt+NCCHSLq0R2oBhtxhES4mPo=
X-Google-Smtp-Source: AKy350bn7ZeS6/eoNbeILpv+26VTAUuYvuZFYjBl6LQHwVNLxEkN9nQuiC0Vf2bzVKzCHYpY32QIXoYIT7nCB1zv5yI=
X-Received: by 2002:a25:c905:0:b0:b77:81f:42dc with SMTP id
 z5-20020a25c905000000b00b77081f42dcmr2195246ybf.1.1680886189291; Fri, 07 Apr
 2023 09:49:49 -0700 (PDT)
MIME-Version: 1.0
Sender: cd0367815@gmail.com
Received: by 2002:a05:7010:7643:b0:347:aba3:716a with HTTP; Fri, 7 Apr 2023
 09:49:48 -0700 (PDT)
From:   mrs Annie Hyemin kim <mrsanniehyemink@gmail.com>
Date:   Fri, 7 Apr 2023 16:49:48 +0000
X-Google-Sender-Auth: d18MAKNkoCF4FzeyIcL9lx5Huec
Message-ID: <CAJhyzkmCOaR3-NyMV9KUGMcBVsHHEyyU8yy4-b7NUh9M_6ra1g@mail.gmail.com>
Subject: salamlar,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

c2FsYW1sYXIsDQoNCkJ1IG3JmWt0dWJ1IHNpesmZIHNpemlubMmZIGV5bmkgc295YWTEsSBkYcWf
xLF5YW4gbcmZcmh1bSBtw7zFn3TJmXJpbWzJmSBiYcSfbMSxDQp5YXrEsXJhbS4gUsmZaG3JmXRs
aWsgbcO8xZ90yZlyaW0gYXZ0b21vYmlsIHHJmXphc8SxbmRhIGTDvG55YXPEsW7EsSBkyZl5acWf
aWIsDQpxb2h1bWxhcsSxIGlsyZkgaGXDpyBiaXIgxLByYWTJmWTJmW4gyZlsIMOnyZlrbcmZZGl5
aSDDvMOnw7xuIMmZbGFxyZkgc2F4bGF5YQ0KYmlsbWlyyZltIHbJmSBvLCBracOnaWsgdcWfYXEg
aWvJmW4gw7Zsa8mZbcmZIGfJmWxtacWfZGkuIE3JmW4gYnVudSBldG3JmWsNCm3JmWNidXJpeXnJ
mXRpbmTJmXnJmW0sIMOnw7xua2kgYmFua8SxbiBtw7zFn3TJmXJpbWluIHbJmXNhaXRsyZlyaW5p
IHTJmWzJmWINCm9sdW5tYW3EscWfIG1pcmFzIGtpbWkgYmFuayB4yZl6aW7JmXNpbsmZIGvDtsOn
w7xybcmZc2luaSBpc3TJmW3JmXpkaW0gdsmZIGPJmWxiDQpvbHVuYW4gbcmZYmzJmcSfIDYsOCBt
aWx5b24gZG9sbGFyIHbJmSB0yZlobMO8a8mZc2l6IHNheGxhbm1hc8SxIMO8w6fDvG4gYmFua8Sx
bg0KdMmZaGzDvGvJmXNpemxpayDFn8O2YsmZc2luyZkgcW95dWxtdcWfIDI1MCBraWxvcXJhbSBx
xLF6xLFsZMSxci4gTywgaGXDpyBiaXINCnFleWRpeXlhdGRhbiBrZcOnbWnFnyBxb2h1bXUgb2xt
YWRhbiDDtmxkw7wgdsmZIGJlbMmZbGlrbMmZLCBmb25kbGFyIGluZGkNCmHDp8SxcSBiZW5lZmlz
aWFyIG1hbmRhdMSxbmEgbWFsaWtkaXIuIFhvxZ9iyZl4dGxpa2TJmW4sIGjJmXIgaWtpbml6aW4g
c295YWTEsQ0KZXluaWRpciwgb25hIGfDtnLJmSBkyZkgc2l6aSBvbnVuIHLJmXNtaSBxb2h1bXUg
ZXRtyZlrIMOnb3ggYXNhbiBvbGFjYXEuDQrGj2fJmXIgbWFyYXFsYW7EsXJzxLFuxLF6c2EsIG3J
mW7JmSBiaWxkaXJpbiBraSwgc2l6yZkgbsmZIGVkyZljyZl5aW1peiBiYXLJmWTJmQ0KyZl0cmFm
bMSxIG3JmWx1bWF0IHZlcmltLg0KSMO2cm3JmXRsyZksDQpYYW7EsW0gQW5uaWUgSHllbWluIEtp
bQ0K
