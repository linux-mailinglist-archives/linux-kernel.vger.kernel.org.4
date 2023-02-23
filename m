Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1601E6A0377
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbjBWICI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjBWICG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:02:06 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9202E2333D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 00:02:05 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-17211366c6aso13843943fac.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 00:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WZS1hl/5J1jNV9j/uRISv6dQ60VUvSIvv3V4inD1bw8=;
        b=jCdt1gXAdX+p7Hcn+pfhVChOOyFV/sli82vW97pNnEoqw/YqYgciN6zeaPgAIvKJBb
         1jY4PzSotkPnv8Qk3f2C2IL9zQr8kwZVnV9e09Cd9nzIUvEHiOPK46pADYPCfpnbikas
         ZV/h+7pnV20oGNhDG8M6aAxt8To0UrTKhsVVgdhaFUi+6Tsy/K2O5PQCvTvec1B/dUj+
         05I8OrduwF7CoKWPixflx0fD4ZB96O4AC3RRxdV54gCalFU40EgPXwgyMz1p+bo4t6G+
         IOwFckNThkiEDBR2Uur+SReWmA9hBwdlK5AKS/o99PsZq4JIq+NEA7Q21/QhVyAENowe
         Rnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WZS1hl/5J1jNV9j/uRISv6dQ60VUvSIvv3V4inD1bw8=;
        b=AbERfuLz+zNQ/BAj939jARCW4usXauJmJ75Vm3mPpHYXK3En1kf3xYoLINW3KQEu0D
         NHxeA6OGkn1jIQewE5EROmTkb0Kpqb6ox51ctTGgwNvatbrKCmez6FB/lPXXzpEI6S16
         QYzYrkxpRA7aqiwwHJ7/qAftC4bgIjs/0h9J1D9D9dM4sQCKPdspz9erXVUMLmpnm296
         kjOWFlygZ8KPGLav8DlCvJHipXo8AeZNlqKMptitchz2tjjy7xAIiVR3xqi8u/Y5i4fr
         Jw5gm0Rc9gJCJ9m/lQRMYLSrQOR+6m5Kz/6yIp98hDky80/PHGEv0e09aOTcQFl9mQQM
         yOYw==
X-Gm-Message-State: AO0yUKVnu++yb154d5ycHeC//zXxrTNH0x7eagIffl3CZgd1nVHAc1KT
        2G9RYVeLuepEka3GgwXP4gbetEoIq/lpWti4Hy4=
X-Google-Smtp-Source: AK7set/iLyvEt72McVFDDTxRPxbmsj8qBN09ec2hc74/ndxKg/LQpq8NfyeZ0XcoggOa9FNRjr5X2tAuJKTV4MwEm94=
X-Received: by 2002:a05:6870:3448:b0:172:2b2c:e6a2 with SMTP id
 i8-20020a056870344800b001722b2ce6a2mr972748oah.31.1677139324872; Thu, 23 Feb
 2023 00:02:04 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6358:2c41:b0:ed:3ecd:ba7c with HTTP; Thu, 23 Feb 2023
 00:02:04 -0800 (PST)
From:   Frank Hughes <ccmk137@gmail.com>
Date:   Thu, 23 Feb 2023 09:02:04 +0100
Message-ID: <CANqQpXXapohKaiFp3NWN9gM8YrTZ-SMDGT_p5eEQc=GRQGEBEw@mail.gmail.com>
Subject: =?UTF-8?B?2YrZiNmFINis2YrYr9iM?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2YrZiNmFINis2YrYr9iMDQoNCtij2YbYpyDZgdix2KfZhtmDINmH2YrZiNiyLiDZgtin2KbYryDY
s9in2KjZgiDYrtmE2KfZhCDYp9mE2KjYudir2Kkg2KfZhNi52LPZg9ix2YrYqSDYp9mE2KPZhdix
2YrZg9mK2Kkg2YHZig0K2KfZhNi52LHYp9mCLiDYp9mE2KLZhiDZiNmC2K8g2KPZg9mF2YTYqiDY
p9mE2YjZhNin2YrYp9iqINin2YTZhdiq2K3Yr9ipINmF2YfZhdiq2YfYpyDZgdmKDQrYp9mE2LnY
sdin2YIg2Iwg2KPZhtinINin2YTYotmGINmB2Yog2LPZiNix2YrYpyDZhNmF2LLZitivINmF2YYg
2KfZhNmF2YfYp9mFINmE2YPZhtmG2Yog2LPYo9mB2LnZhA0K2LPZitiq2YUg2KrYudmK2YrZhtmH
INmC2LHZitio2YvYpyDZgdmKINmF2LHZg9iyINin2YTYp9iz2KrYudiv2KfYryDYp9mE2YXYtNiq
2LHZgyDZhdiq2LnYr9ivINin2YTYrNmG2LPZitin2KogKEpNUkMpINiMDQoNCtiu2YTYp9mEINmF
2YfZhdiq2Yog2YHZiiDYp9mE2LnYsdin2YIg2Iwg2KrZhdmD2YbYqiDZhdmGINiq2K3ZgtmK2YIg
2YXYrNmF2YjYuQ0KMjUuMDAwLjAwMC4wMCDZhdmE2YrZiNmGINiv2YjZhNin2LEuINmH2LDZhyDY
p9mE2KPZhdmI2KfZhCDYo9iq2Kog2YXZhiDYtdmB2YLYqSDZhtmB2Lcg2Iwg2KPZhtinDQrYtNiu
2LUg2YrYsdiq2K/ZiiDYstmK2Kcg2LnYs9mD2LHZitinINmI2LnZhNmKINij2YYg2KPZgtiv2YUg
2LTYrti12Kcg2YXYpyDYudmE2Ykg2KPZhtmHINij2KzZhtio2YoNCti02LHZitmDLiDYo9mG2Kcg
2KPZhdix2YrZg9mKINmI2LbYp9io2Lcg2YXYrtin2KjYsdin2KouINmE2K/ZiiAxMDDZqg0K2YjY
s9mK2YTYqSDYo9i12YTZitipINmE2LTYrdmGINin2YTYo9mF2YjYp9mEINi52YYg2LfYsdmK2YIg
2KfZhNi02K3ZhiDYp9mE2K/YqNmE2YjZhdin2LPZig0K2LTYsdmD2KkuINij2YbYpyDZgdmC2Lcg
2KjYrdin2KzYqSDYpdmE2Ykg2YXZiNin2YHZgtiq2YMg2YjZg9mEINi02YrYoSDYrNin2YfYsi4N
Cg==
