Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0616E1D2D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 09:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjDNHcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 03:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDNHcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 03:32:09 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9EF26BA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 00:32:07 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-504ecfdf6b6so2430007a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 00:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681457526; x=1684049526;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=glafSQA65znky9lbZV5oiS9tBrTGkLdTsIzjrYb0APA=;
        b=fYrePsTLgxAL3d1zNf/03MBvvHTz/4ZrlU+vf8429lSImU9zFRd2GDenbQ+4Oaxc/4
         bx6xZXurpG4zu1DrSVrkCNhJMRZYCUK4v90WKQhCDT9zl8wBYVCYqkypps6TlV5kYt1C
         VXwnMO5dahDZleIyYWa0DxcxUvJWWR9Xrt+Ixn+zXhSQe9ynDF78ZkAiqeuCpjDlqGOR
         EBQisYxAr22XZSR+5G2QO/NB5QXT3T0fFVb3i2hasbCJN9i5wej5p2mz5vZ5QMc5oQw5
         AXq1nz7GWBYmcgY2nKM/hv/9roOhp8gcY9Ugej3/oY2DWSlZI0xf9ELB7AU1A+75MgWJ
         u3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681457526; x=1684049526;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=glafSQA65znky9lbZV5oiS9tBrTGkLdTsIzjrYb0APA=;
        b=SbZU5VWt+Yy6cCZ6Qk4Z5tMgRaDiACqcmPjUE+9f2m8j/syAUJA4MRQedcGL3tTVoI
         6LCBJtwI6kmcM0x8w+HP9TvRJXT9KCcl6b0jaQRvURkdNcPvYZMqTg9/FkS8GSukhWZW
         JrLNpJ8VOTWWGfk2xRAzZl6vlc86CMgBni3IxsMJ2pi0qFwcTaYLx85ESEdRn9PVxGLo
         2cByEv0YdFTx5tmTdC/sFK3BxkZYh5Pu0r4Lv7JLj6Vq+GePdOBFIak00ttk7pPYWoAn
         /XtZ3gplnSyT/clK6jsQ8MyBvSAUvmt5FbDuVw3m+NVLeqvArlWf6EvzETBpnVI7qSbo
         0EKA==
X-Gm-Message-State: AAQBX9fXTFn0E8zsFxVmsWf5VdwL9/LzeQGmQmM6t2uyz08zNMiGvm3Q
        bj049jFtVy9REe2Ho/uhkDjDhlyTd80IcCpFAy0=
X-Google-Smtp-Source: AKy350aIe/U/Z94v3Af/w0AAr8l0+0IaQExAXcJBxeG0hF/TrehDe1LGkHmqI2tul+RWBcq9Z3V3nXfLNsur14qFQlg=
X-Received: by 2002:a50:c044:0:b0:502:49bf:7e8d with SMTP id
 u4-20020a50c044000000b0050249bf7e8dmr2635218edd.8.1681457526344; Fri, 14 Apr
 2023 00:32:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:16a7:b0:946:8676:e45c with HTTP; Fri, 14 Apr 2023
 00:32:05 -0700 (PDT)
Reply-To: bernardarnault2011@gmail.com
From:   Bernard Arnault <pricillanjunguna@gmail.com>
Date:   Fri, 14 Apr 2023 08:32:05 +0100
Message-ID: <CADMSzWF4qDKFhJC6O_NwXPX2cDJQ8-JRZg7pK6ddEU-ZzJs3sQ@mail.gmail.com>
Subject: =?UTF-8?B?UmU6INCU0LDRgNC10L3QuNC1?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0gDQrQlNC+0LHRitGAINC00LXQvS4NCg0K0JLQsNGI0LjRj9GCINC40LzQtdC50Lsg0LDQtNGA
0LXRgSDQtSDQuNC30LHRgNCw0L0g0L3QsCDRgdC70YPRh9Cw0LXQvSDQv9GA0LjQvdGG0LjQvyDQ
t9CwINCx0LvQsNCz0L7RgtCy0L7RgNC40YLQtdC70L3Qvg0K0LTQsNGA0LXQvdC40LUg0L7RgiAx
IDcwMCAwMDAg0LXQstGA0L4g0L7RgiDQsy3QvSDQkdC10YDQvdCw0YAg0JDRgNC90L4uINCh0YrQ
vtGB0L3QvtCy0LDRgtC10LssINC/0YDQtdC00YHQtdC00LDRgtC10LsNCtC4INCz0LvQsNCy0LXQ
vSDQuNC30L/RitC70L3QuNGC0LXQu9C10L0g0LTQuNGA0LXQutGC0L7RgCDQvdCwIExWTUggTW/D
q3QgSGVubmVzc3kg4oCTIExvdWlzIFZ1aXR0b24NClNFLCDQvdCw0Lkt0LPQvtC70Y/QvNCw0YLQ
sCDQutC+0LzQv9Cw0L3QuNGPINC30LAg0LvRg9C60YHQvtC30L3QuCDRgdGC0L7QutC4INCyINGB
0LLQtdGC0LAuINC30LANCtCx0LvQsNCz0L7RgtCy0L7RgNC40YLQtdC70L3QuNGPINC/0YDQvtC1
0LrRgiwg0L3QsNGB0L7Rh9C10L0g0LrRitC8INC00L7QutC+0YHQstCw0L3QtSDQvdCwINC20LjQ
stC+0YLQsCDQuCDQv9C+0LTQv9C+0LzQsNCz0LDQvdC1DQrQvdCwINGF0L7RgNCw0YLQsCDQv9C+
INGG0LXQu9C40Y8g0YHQstGP0YIsINC70Y7QsdC10LfQvdC+INGB0LUg0YHQstGK0YDQttC10YLQ
tSDRgQ0KYmVybmFyZGFybmF1bHQyMDExQGdtYWlsLmNvbQ0KDQrQmNC80LXQudC7OiBiZXJuYXJk
YXJuYXVsdDIwMTFAZ21haWwuY29tDQoNCtCX0LAg0LTQsCDQv9C+0LjRgdC60LDRgtC1INGB0LLQ
vtGPINC00LDRgNC40YLQtdC70YHQutC4INGE0L7QvdC0Lg0K
