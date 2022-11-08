Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D57621D34
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 20:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiKHTpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 14:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiKHTpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 14:45:34 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8A873748
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 11:45:32 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id cn2-20020a056830658200b0066c74617e3dso8973285otb.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 11:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNUAoA/VVxgq6VMRY/PMxFmzrVNe7fuv+vUDrhL0n0A=;
        b=fTWnKIvV0ZkUcMHvt0BiipUeoem0WozQU55LgrQZ7Hd4Ko39UtyFEjgTtwL9KzwPb0
         EAUaEEeeBZsA6DpPn+ll2BYXpG3XKysMPEBui++yKj6ANkGzlPErZII0zWbhHOXXqjcP
         MfrxWLrNsR3oj97r73mXfQixeGM/adt0w9zPqj1E00reFJ2pkncKrIdKCX+Zyk1Y4sKJ
         ShKDckFS5xZtQugwfCJqb6Lo/WOE2rMn+Ma607snlPQAh58edyHCsa+y0slIGE2WLlYm
         d7NvuTBIAF6EKOY0+uybn0fBtzRPSUM0Mtaq+QfWRGKvhpMjkxXXKg9qdrl/pNNOmtDE
         nGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNUAoA/VVxgq6VMRY/PMxFmzrVNe7fuv+vUDrhL0n0A=;
        b=SFJQ3M5HfEqH8NDlIpSotOZaUlgdl2ogUBBlOeDHgbhT+PfoVH3tbVilj4vvG8l6Wh
         gSlYAowHftLiZB/HrCOWlq4m0F9AGmVATmdeZ0pTYBUTnCTvtC7nk3IVhf5llcSTTupC
         qeVXCRXFtzsM6MpZD0Ty5qzes+jyrVUAS0fuOv0sW3RAR+2G2SxnOXldMUjHAtp3dGNx
         4G2sUPNCwXzN1VDEZB6VgmpSQIT9fJnbya2q6mm1oClhmtr/qNnuEWuEER0R4jz2M4pB
         AGGG2q8bUo5FrVEUJBHxMKv0kUQAUrfkFPOcA/RM3Kr6eROLWVxI5HPR/Z7hWdFhMaGE
         HqOA==
X-Gm-Message-State: ACrzQf35ei/gvOahsPcK5LROq1G34O0+YSg0zrm6TEFE57gbyX+FfB6V
        +Aia8lHgg42eWiYMN5VPLsMw4Rr+rex/BUcCr997IhwC7mw=
X-Google-Smtp-Source: AMsMyM7sCG8ok9tjRjdUg0sQ2jy24IvQBn1MzRXgR7VqyOjkrMx6hDxaz/oJIqXqbtcRJQOxcOQaFmDLzDOjXtAE6o4=
X-Received: by 2002:a9d:70c8:0:b0:66c:3c59:6c3b with SMTP id
 w8-20020a9d70c8000000b0066c3c596c3bmr27625960otj.325.1667936731990; Tue, 08
 Nov 2022 11:45:31 -0800 (PST)
MIME-Version: 1.0
References: <CAF=mWJNojvgYSc9oS+m5By8g4RYN2UcENXunDwF5jukGscQAEg@mail.gmail.com>
In-Reply-To: <CAF=mWJNojvgYSc9oS+m5By8g4RYN2UcENXunDwF5jukGscQAEg@mail.gmail.com>
From:   Jon Maser <jonmaser8@gmail.com>
Date:   Tue, 8 Nov 2022 11:45:21 -0800
Message-ID: <CAF=mWJPjraCj3=n1_V-4qcpMQR141LiXZH1qOg2eprBy3P5hww@mail.gmail.com>
Subject: Fwd: I may have found a way to increase downloads
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sorrey about the shadow fwd accidentally sent as html

---------- Forwarded message ---------
From: Jon Maser <jonmaser8@gmail.com>
Date: Mon, Nov 7, 2022 at 9:08 PM
Subject: I may have found a way to increase downloads
To: LKML <linux-kernel@vger.kernel.org>


I=E2=80=99m on iPad with no engineering experience

But you take a large file and build a hash database full of hex dbases
and stuff like shifting hacks along with parity information (so it
rebuilds when it=E2=80=99s done downloading)

 Could be fun for isos
