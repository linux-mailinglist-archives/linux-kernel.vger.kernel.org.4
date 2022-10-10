Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CCB5F9F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 15:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJJNlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 09:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJJNlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 09:41:42 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A795F20C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 06:41:40 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id h8so1293661lja.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 06:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/mk2nPyPDHF2nSoHYsdcPx4I1t1gE9idID2faOY4LJU=;
        b=nQlBVngNS6jdjjoSNjCE8ArZ+rJTFkbZgMSi9LIvsZWVR0Fqr/hdPvjWFhfyBjwwry
         hpbm4Z03SpWIY+cVIAIiZDqwtByCNf37gfgIggBhGi3jK3lfjbJC2AHcRRg1Ji5ZDVIB
         kF8GOiMLoxbLH5io8ya9GU+ELTEShWnsP0bfecOMfm8TucEmnbKREFnZuU2k/KJh7JVZ
         nHf829K8dGf0cwKgHU22Frek+UnZR7xtPeKJU2+wS14wDBY3qHSTSSBjU6eXrFHplkqr
         NuoBdYphRkJsODZ2bTjnGmeE0dCvsrB3OxunF7mfGs1j6ApnLaplqtkCxCiA+21Ijghy
         ENVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mk2nPyPDHF2nSoHYsdcPx4I1t1gE9idID2faOY4LJU=;
        b=i1WeIiLGKDV6nnkdE245NJ7Qpv01Gd76vMBX08N9xHC1NB0nWff5fGBdGUauBw4LMd
         R85H5Md1PLRxSFnQISHZ5tEUdC0QnhMtv9MDtBxhrveaUemPkQPz0F+qD8HWNqjZNsAp
         xkYZqe51l8MeBwOzugu+E1HRepr+Zv5WgKm4id2MnJk2ifIVz7ffzivLsXZE/DgTj2hi
         iomSNPiYaVGE5j7/CTqzxY/6Qvu3OdUffcuGZdcLn5UEhHCdM+tx0qkv/meQJxPDktdh
         N0WXvrnwKz/Od7H4SKjZQkwaj/3/usfKGGajksKGs3yZa7EcDjZwOXLsQf9fqhsDr7ob
         HGZg==
X-Gm-Message-State: ACrzQf3VWbN6gNrzjRjBlhWpn8RuwhltE40w4KnAE/L7kDw5EJNjpMQy
        IGljY27rP3KuEcKiZLj4El8N9hnAfASiyetJIqc=
X-Google-Smtp-Source: AMsMyM6mxStJAOUXUeJGjk20Dm0Vi6Rqx2hCSTNStiWghAPLhAhgWOF5ENn1mYXXhPfY3yssKRWQkeW8ZHrrZ1CIROg=
X-Received: by 2002:a2e:3510:0:b0:26f:aecf:e0c6 with SMTP id
 z16-20020a2e3510000000b0026faecfe0c6mr971421ljz.483.1665409299206; Mon, 10
 Oct 2022 06:41:39 -0700 (PDT)
MIME-Version: 1.0
Sender: essoweatakati@gmail.com
Received: by 2002:a05:6520:68f:b0:1f9:75a5:d7d8 with HTTP; Mon, 10 Oct 2022
 06:41:38 -0700 (PDT)
From:   Miss Katie <katiehiggins302@gmail.com>
Date:   Mon, 10 Oct 2022 13:41:38 +0000
X-Google-Sender-Auth: cOvPCjxCeEUJTzUoUBXK8wseBjs
Message-ID: <CALyJv2r984m=5MCq4-1atv_oU0Ux3PN2DcegCeQ_FdkxeuBiLg@mail.gmail.com>
Subject: RE: HELLO DEAR
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hej,

Modtog du min tidligere besked? Jeg kontaktede dig f=C3=B8r, men beskeden
kom ikke tilbage, s=C3=A5 jeg besluttede at skrive igen. Bekr=C3=A6ft venli=
gst,
om du modtager dette, s=C3=A5 jeg kan forts=C3=A6tte,

venter p=C3=A5 dit svar.

Med venlig hilsen
Fr=C3=B8ken Katie
