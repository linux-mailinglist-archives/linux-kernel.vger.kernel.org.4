Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A046B616C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 23:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjCKWSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 17:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCKWSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 17:18:49 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29FB2ED6A
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 14:18:47 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-536c02c9dfbso169902317b3.11
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 14:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678573127;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1I7469JYXIc5gDvGFGnP5+v3tcxVnEceL7ffOs9cWQ=;
        b=c6wf4zx+YKw8C0l2/qdlcjuK6eipFmMTibIUDN6ITuf1H3JZWVAChe7c2e01MfmWrF
         0wa6utq6Gyuv5EKlcbZzgX/IP+Q4RUxo9fzyVjCljlJl5MUnVDUbOaYOAzK8rj6iNs80
         FVXGjfKFXWc2Xt7OVnNXIuCxezzXd6qMtfGiHSaOMsC4FdeQVlEjNlZEtTf/eO7tEZkz
         EsLEyHQmED4cew3HSnqp1ZkBpjv7+Wh9Zzie253MEoYtxIfihRSCWxops/oq+ULjxfxD
         PNFjD+9YoU19sJhtIk7LuoTJu6kFzQ5lIkY61qVQ1FrzrN4dx8gGt3Uk5fDaHuyegCQ/
         JIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678573127;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1I7469JYXIc5gDvGFGnP5+v3tcxVnEceL7ffOs9cWQ=;
        b=RE1da/2un86SZ9xVAx5gUrIbl4ulpY+Xd7Pf4rAJrg17Li48j+A19qTTbtTuuIX9ug
         u26sJOxQk27o2bsrEJjcmtb/6yAeM2IUvkz82KNC3Qt7DX/Rv9PYulGcc8R8PqhJ9iTj
         1AymTS5abzhoK7XQ9EV4qpKJ+McqffEVLJBNQ/VJ+Wl3id+PyJJcmqekm/KCG4DfNnDW
         QsFR7EbI595HO9nhwAkSxaDbwr1h7Sqi8wna1aVuS3x6i+swz7MTLj5CUoYLYvC7Qzzz
         nCGr4Vis3Kftp9D8nHT5tial3kvyR4vmE19YDTuSpNtbG1PI4dPKv/csIIQFH4dkW9m6
         jSBQ==
X-Gm-Message-State: AO0yUKVxXNRv+GysunPCnVqfZMg1l629N75u/O2Gd4pSvjD8eB8WAiDu
        GYP81wPD9DeWutRkPmVkBcj3+fuo423D6+UqwfE=
X-Google-Smtp-Source: AK7set+mpD7W3MlHQv4jHyWrN8h/OD3MxE10d4UXQrBl2jtKOwKJqTES/JrFcvJyNYA4U/h3IwPC8TBrs5ZmQt5izPA=
X-Received: by 2002:a81:af03:0:b0:541:7f7b:a2ff with SMTP id
 n3-20020a81af03000000b005417f7ba2ffmr1052968ywh.8.1678573127223; Sat, 11 Mar
 2023 14:18:47 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7000:8f13:b0:48c:59cf:a118 with HTTP; Sat, 11 Mar 2023
 14:18:44 -0800 (PST)
Reply-To: thajxoa@gmail.com
From:   Thaj Xoa <nassodjokombate@gmail.com>
Date:   Sat, 11 Mar 2023 22:18:44 +0000
Message-ID: <CAPu99ZRxU6dM6ME8ifUGCMBn6-o_L+S9dsOhbwNW1Ps4ZCNN6Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1133 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5005]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [nassodjokombate[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Dear Friend,

 I am Mr. Thaj Xoa from Vietnam, I Have an important message I want to
tell you please reply back for more details.

Regards
Mr. Thaj xoa
