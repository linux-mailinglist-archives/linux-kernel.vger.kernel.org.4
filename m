Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A5468B7EB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjBFJD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjBFJD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:03:27 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A131B542
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 01:03:26 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id hv11-20020a17090ae40b00b002307b580d7eso7072137pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 01:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bjlnPGg9nNmO0H7RRiJn0H4Htz9UMoA/kY/Gl2WERDY=;
        b=YjR/sEknnaYnbri/ihmOP1tGYIFb+0ebiO3aRmh75j2Dk9yxxOJghVobaWO1L3R0N2
         GKeZWx/WrJ6sA8KBHx7NwzA3Bi/M6bsquK3+yp9CPpTZSR+VfpA3WWQ8/yIOt9bxMWw6
         t59sQRvk8IFoSWqcxyyeoHXD/1rsD3XEbxhlI+uUpPVQpagapzeW1qF2VjqBcjxE9LQA
         O1VcPqPBm+5bBFYAzYwOnymewaevFDMjPeu6GXy/103EuyXsFg3ZO8EJVlehqCNjBrtf
         PBMtpLjkRchImWh5PXcMkP/k/SRxcQlWWJKSwzxx9KwqJ/1Cx3RwZOJT+jARKiKXjnk5
         NeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjlnPGg9nNmO0H7RRiJn0H4Htz9UMoA/kY/Gl2WERDY=;
        b=ho/lpLZYzE1aDSrdI6TGKm6rLUnRce5PzMqrLqBErmG+tSUiI+fG/mlHE0O4fPH+Zf
         yPysFhoNxhLIJLOQDbnXXl9iRgwoH0WFyRnjlhRutRB/d2Pjk4pm+SmD5xME2KEIrKEd
         tcsNOD3X3GmsC64R6rDfVRNxRuJOL9XI+1KOzJzQh5tdBmRq6ZW2hu3LbV9yJaQ2ifm1
         MWyPeYpSYa6W8AjhQSC4J3ONzNZzWiL91aKhAXoVZz6AuPWOc/KovRtZyUNE0FWbJUs4
         wOVDeZ/xgGYW53geBKGqa77nk/9cpNNJSr6D7AehET+7fyIjcE+R121rYgV2j1dDQnlg
         tJ0Q==
X-Gm-Message-State: AO0yUKVS7AfMEKQwdGr/dTZYI1Ag3AlMu8TddPbNj53G8YHQCVTkD5BF
        z379uBYUWRgvDdEZ2JQwFfR0Am8AfiIPqtTauNY=
X-Google-Smtp-Source: AK7set9Xx7RsDrVmUVU/dEVlcWCuur5ejKIQ63BtcY4MGjDnWzI6yqXX1yTKfSmhBFtjBcE55cOVHwGiTTBYK8DsHYQ=
X-Received: by 2002:a17:90a:313:b0:230:c24b:f22c with SMTP id
 19-20020a17090a031300b00230c24bf22cmr454287pje.53.1675674206036; Mon, 06 Feb
 2023 01:03:26 -0800 (PST)
MIME-Version: 1.0
Sender: sovonbebe@gmail.com
Received: by 2002:a05:6a10:afce:b0:3b7:c63d:e9b with HTTP; Mon, 6 Feb 2023
 01:03:23 -0800 (PST)
From:   Kayla Manthey <sergeantkayllamanthey@gmail.com>
Date:   Mon, 6 Feb 2023 09:03:23 +0000
X-Google-Sender-Auth: VpTmb84M_hXfG5Q2PYp3Zum71_8
Message-ID: <CAKFxk5gNoofDeCJfbJkdRSvxg_8-RhU=OQ7taG5Ctioa76H2PA@mail.gmail.com>
Subject: 
To:     mail@tanyabonakdargallery.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dia duit, a st=C3=B3r, an bhfuair t=C3=BA mo r=C3=ADomhphost roimhe seo le =
do thoil?
Go raibh maith agat.
