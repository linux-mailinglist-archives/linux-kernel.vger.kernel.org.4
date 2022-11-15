Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CEC629C18
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiKOO1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbiKOO06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:26:58 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7182C2C64D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:26:57 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id j2so17328512ybb.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 06:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j1fPL+nMBhiiMv7wUlO9WZriEt9grZuM8SVZB1W8ZQ4=;
        b=ZzKTg2VuuE4zDNV3L5L5O16hzsai3ckr5TdkpaGgUcNB+AkyEI9DLpgBMcztzKoX9D
         oDxSbafMVP/NV9zLz3+UN6kTcrqDRE00/5u6nBJcNC3OQ2Sx9x+zUFal+G1siv2NBq4p
         8CP+K8Szarczz4qv+OVbIMfVlRmQ3G7jo7oZwgCLgGJhGU3zGlsBgYJ8D1VfcgBf3TTX
         4YV4nz3p4ka8RVsee5wiyD7P05VKdFuSx8MeWA/qzWIOsDq0z1n8Y9Imvq2vpP36cgwR
         97nwTWOlV4TIOXY9ClFE+6oHJbbhsZJ65RbxJUa1JKp7FhSx/5spWR4HtTGDkIt1En3o
         abfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1fPL+nMBhiiMv7wUlO9WZriEt9grZuM8SVZB1W8ZQ4=;
        b=6dGkeGyBFpwPM8yewFqLo513nOM9Qdsy09xpfSn81mrP/9UCVUP1RE/JqnYTJjagTS
         SZHrqcpKCEDo+7AkUJ5d5vk3SSXJZgpFkEyMx/pYsYbODKZcO/YCOewWF7mucBJk1N+0
         3KGWDk1IHj0FcgwsecoH5gmIeWhxuhpeNziVfMAu+/wzUb0R/xf5YLFDeURPgDpe9r/5
         U8l5SDhW/33gVWX82Z4dKq4VgeQ1PCFFwo59PVUDJOzRU82dvbUDR3lahlbB5Rqrfj12
         pyAknzBIMuAOVMP4pn4vfOpolrWNmRcZqJKU9A9vG2MTasKcpqtO2vXWzP/easf3GiW7
         ZcTw==
X-Gm-Message-State: ANoB5pmpMZgVrnP+fbubQcrxEpl5JsfqLqT0WcCZR1EogyTEiYPUqGPo
        JXpHhRnW9Qheym8YSD8p89keFEh3yFXDS/nFCaQ=
X-Google-Smtp-Source: AA0mqf7YlPlYGt8iBJlgnTAY5SDEpWcWWxsYF30t2hExH1Z06LSVFPfYyFZbINreAtelhU+xTRI5pTlOtPOnmLoigLY=
X-Received: by 2002:a25:324d:0:b0:6cb:e8f7:933f with SMTP id
 y74-20020a25324d000000b006cbe8f7933fmr17946626yby.452.1668522416503; Tue, 15
 Nov 2022 06:26:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6919:c70d:b0:f0:aad8:4678 with HTTP; Tue, 15 Nov 2022
 06:26:56 -0800 (PST)
Reply-To: westernuniontg453@gmail.com
From:   POST OFFICE <westernuniontogorepublic55@gmail.com>
Date:   Tue, 15 Nov 2022 14:26:56 +0000
Message-ID: <CACT2zkqoxvWuSybNvtPPgV0aNGNGrnGb3b1XXMW1vH9vJahDTA@mail.gmail.com>
Subject: =?UTF-8?B?R8O8bsO8bsO8eiB4ZXlpciDJmXppemlt?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMO2cm3JmXRsaSBFLXBvw6d0IFNhaGliaTsNCg0KQmV5bsmZbHhhbHEgVmFseXV0YSBGb25kdSAo
QlZGKSBiw7x0w7xuIGTJmWzJmWR1emx1cSBxdXJiYW5sYXLEsW5hIHbJmSB0yZlsyZliDQpvbHVu
bWFtxLHFnyB2yZlzYWl0bMmZcmkgb2xhbmxhcmEga29tcGVuc2FzaXlhIMO2ZMmZeWlyIHbJmSBz
aXppbiBlLXBvw6d0DQrDvG52YW7EsW7EsXogdMmZbMmZYiBvbHVubWF5YW4gZm9uZCBzaXlhaMSx
c8SxbmRhIHRhcMSxbGTEsS4gQnUgV2VzdGVybiBVbmlvbg0Kb2Zpc2kgQlZGIHTJmXLJmWZpbmTJ
mW4ga29tcGVuc2FzaXlhbsSxesSxIFdlc3Rlcm4gVW5pb24gTW9uZXkgVHJhbnNmZXINCnZhc2l0
yZlzaWzJmSBzaXrJmSBrw7bDp8O8cm3JmWsgdGFwxZ/EsXLEscSfxLEgdmVyaWIuIEJpeiBhcmHF
n2TEsXJkxLFxIHbJmSBidSBmb25kdW4NCnFhbnVuaSBzYWhpYmkgb2xkdcSfdW51enUgbcO8yZl5
ecmZbiBldGRpay4NCg0KQnVudW5sYSBiZWzJmSwgw7xtdW1pIG3JmWJsyZnEnyA4MDAsMDAwLjAw
IEFCxZ4gZG9sbGFyxLEgdGFtYW1pbMmZIHNpesmZDQprw7bDp8O8csO8bMmZbsmZIHHJmWTJmXIg
Yml6IMO2eiDDtmTJmW5pxZ9pbml6aSBXZXN0ZXJuIFVuaW9uIE1vbmV5IFRyYW5zZmVyDQp2YXNp
dMmZc2lsyZkgaMmZciBnw7xuICQ1MDAwIGvDtsOnw7xybcmZayBxyZlyYXLEsW5hIGfJmWxkaWsu
DQoNCkJpeiBidSDDtmTJmW5pxZ9pIHlhbG7EsXogZS1wb8OndCDDvG52YW7EsW7EsXpsYSBnw7Zu
ZMmZcsmZIGJpbG3JmXnJmWPJmXlpaywgb25hDQpnw7ZyyZkgZMmZIHNpesmZIGfDvG5kyZlsaWsg
NTAwMCBkb2xsYXIgZ8O2bmTJmXLJmWPJmXlpbWl6IHllcsmZIG3JmWx1bWF0xLFuxLF6DQpsYXrE
sW1kxLFyLCBtyZlzyZlsyZluOw0KDQpBbMSxY8SxbsSxbiBhZMSxOiBfX19fX19fX19fX19fX19f
DQrDnG52YW46IF9fX19fX19fX19fX19fX18NCsOWbGvJmTogX19fX19fX19fX19fX19fXw0KUGXF
n8mZOiBfX19fX19fX19fX19fX19fDQpUZWxlZm9uIG7Dtm1yyZlzaTpfX19fX19fX19fX19fX19f
DQrFnsmZeHNpeXnJmXQgdsmZc2lxyZluaXppbiDJmWxhdsmZIGVkaWxtacWfIHN1csmZdGk6IF9f
X19fX19fX19fDQpZYcWfOiBfX19fX19fX19fX19fX19fX19fX19fDQoNCll1eGFyxLFkYWvEsSBt
yZlsdW1hdMSxbsSxesSxIGFsYW4ga2ltaSBrw7bDp8O8cm3JmXnJmSBiYcWfbGF5YWNhxJ/EsXEs
IMaPbGFxyZkNCkUtcG/Dp3R1OiAod2VzdGVybnVuaW9udGc0NTNAZ21haWwuY29tKQ0KDQpzyZlk
YXHJmXRsyZkgdMmZxZ/JmWtrw7xyIGVkaXLJmW0sDQoNClhhbsSxbSBNYXJ0aW5zIE5hbm55LCBX
ZXN0ZXJuIFVuaW9uIE1vbmV5IFRyYW5zZmVyIMWfaXJryZl0aW5pbiBkaXJla3RvcnUsDQpCYcWf
IG9maXMgTG9tZSBUb3FvLg0K
