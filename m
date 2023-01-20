Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5685367512C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjATJcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjATJcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:32:17 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4738D7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 01:31:56 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id x4so3541352pfj.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 01:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YwFnmf7FUeniH9VetJwYc/wM4KHtstuulPOmGbrGWro=;
        b=cB1QiSkmzT3WR3Qp/DYssZIiw81CrMjphhYa0DsXCCdVZ1Ruw7ih3Za0NUqYA/tcOI
         qv51d0yxjtFCzvsPzYny3C1onHD0Md92qj/u8vULjmdugVQIw8MVaaezRJmkgg1Jgt+P
         d8656yvRUAijujGImgcR0aHeZ2xqrOEshEiNbrPizxKwC3d4xuQUU/Z2cSY0oIm8D3zO
         /MkXVgJCIKPSjB8a+JILX4eAmJUK82OaMZTwASpe0Qu04Lo1eFgPlGvK/AzX4qPGSThZ
         Ba9QKsgo/CHoLVrLqGV+8KrYklnfdYuvWoENl8T4+SatpS3IeYNdT2lMZmJ3BRqycGfS
         ZMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YwFnmf7FUeniH9VetJwYc/wM4KHtstuulPOmGbrGWro=;
        b=sCqjvgSjGNcxbyLUJmj63hckqE+EQD5Y0NWCZhVPQB9w2bQTvXRljWYsbrJCka305t
         4s07Ny+5z89nxHKgw9ITFUn33JJ6+idpla9OFBzDdXavKvUniaFyat9YEY6MR+uvT5zp
         lknwknfVqY44PjSdhete4bDGidoJ8GU5pQJqVMbOnMt1ZhSPrKTGEOiZRboRaE9kr7Xd
         zeLjL3Omh21HJHO9sL26RsOpbZDOFkplfodA1pT8tXlZ3V2iW6iG1WBqnlFi1XiIO8xp
         2krT4cCwVkUeeScGQT2ijTP8sIpfluJBD9uBMUsLlzV47HhNykVG1dzODuNiVTD2UGmw
         BE0Q==
X-Gm-Message-State: AFqh2krqwti6J/ivZuMipxnnsI11Z33Ke3qOSLo0/3YLaBTXK9w9mz92
        kDtzwJcV1z1nzTfV+2Lv2gBsy3+W4YGD3B+0fFo=
X-Google-Smtp-Source: AMrXdXuvN7up8GH4rkKqhpP8Pef4EVn2PcNNgFFBBAdTD2wEBVpHnIv6tIURfuWf9BcOKJ24cPcl0QW3xsbc7yq6QZo=
X-Received: by 2002:a62:1a09:0:b0:58d:950b:d72b with SMTP id
 a9-20020a621a09000000b0058d950bd72bmr1481853pfa.59.1674207114926; Fri, 20 Jan
 2023 01:31:54 -0800 (PST)
MIME-Version: 1.0
Sender: gaterefoyiuut@gmail.com
Received: by 2002:a05:7300:72c8:b0:7a:58ce:c095 with HTTP; Fri, 20 Jan 2023
 01:31:54 -0800 (PST)
From:   Felix Joel <attorneyjoel4ever2021@gmail.com>
Date:   Fri, 20 Jan 2023 09:31:54 +0000
X-Google-Sender-Auth: 3wI1jWAAVYVtgxACkCN0JGNiTFI
Message-ID: <CAGU9bY7Ee9ic41Y1jsnAppcRWFzWYYoeH4_mPmfqTC3P74FJ=A@mail.gmail.com>
Subject: =?UTF-8?B?xI1la8OhbSBuYSB2YcWhaSBvZHBvdsSbxI8=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0gDQpExJtkaWNrw70gZm9uZA0KVsOtbSwgxb5lIHRlbnRvIGRvcGlzIHBybyB2w6FzIGJ1ZGUg
cMWZZWt2YXBlbsOtbSwgYWxlIG3DoSB2xJt0xaHDrSDDusSNZWwuIEpzZW0NCm9zb2Juw61tIHBy
w6F2bsOta2VtIGtsaWVudGEgbXlsYXRlLCBrdGVyw70gcMWZacWhZWwgbyDFvml2b3QgcMWZaSBo
cm96bsOpDQphdXRvbmVob2TEmyBzIGNlbG91IHN2b3Ugcm9kaW5vdS4gRG9zdGFsIGpzZW0gb2Qg
dmVkZW7DrSBiYW5reSBwb3bEm8WZZW7DrSwNCmFieWNoIHDFmWVkdmVkbCB6ZXNudWzDqW11IGJs
w616a8OpIG9zb2J5LCBrdGVyw6kgYnVkb3UgbcOtdCBuw6Fyb2sgbmEgZm9uZA0KbmVibyBtdSBi
dWRlIHZ5cHLFoWVuw61tIG1hbmTDoXR1IHphYmF2ZW4uIExhc2thdsSbIHNlIG1pIG9rYW3Fvml0
xJsgdnJhxaV0ZSwNCnBva3VkIG3DoXRlIHrDoWplbSBvIG3Fr2ogbsOhdnJoIHBybyBkYWzFocOt
IHBvZHJvYm5vc3RpIGEgdnlzdsSbdGxlbsOtLg0KVmHFoWkgc3BvbHVwcsOhY2kgc2kgdmVsbWkg
Y2Vuw61tZQ0KQWR2b2vDoXQgRmVsaXggSm9lbC4NClJlcHVibGlrYSBMb23DqS1Ub2dvDQo=
