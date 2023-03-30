Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22D86D0D97
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjC3SRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 14:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjC3SRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:17:02 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EE9D306
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:16:56 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id x15so18062400pjk.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infob2bdata-com.20210112.gappssmtp.com; s=20210112; t=1680200216;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tbuPvX9KBpITKF+sjIR/341/cPLlmuEGqdIbfikGfdg=;
        b=w42fQUQ5eK0Phf6F7ZHTWgvs+a1t9IVNTiHYnFY5hT4jKA/cIglRHW4g4/fxgnq4sn
         5O/ovDGtbij0/DTAeYp6YwIHHKptbD9jr9FBJSbKf8cM9HF4N5Kbc2WN8rFvh3/ie9m0
         uaGfRJFf8ZwPr7jbjzVKZ6RLCY1WcS7Dv1edRncM6opgLWXkx4/WY/eM/Fhwf7hrLk9i
         mhtVrvFd2BjMRbzsKHyIzGArYRewYVv54/cpvybnekuN2EVnvGkWp90Pm7+1I1q8IBCB
         8SgtLubBePx5BKARd6rMlghfZVVqwDBfNKTHGgWRkRhuDTGKU8Iy2DUFEU5Plvvi+ur+
         deZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680200216;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tbuPvX9KBpITKF+sjIR/341/cPLlmuEGqdIbfikGfdg=;
        b=XCUHHYU79qI3/zx0wPRDtXkH9vNlAxKmOWgGIJykbNpWIKqGlDaOeNLM184q1J8Sgf
         kuUr512QE600vxqUptjr00epGkqeQJK6YO80DfXuvThTpVWyOFbyJ3k2zFo2UGSePjWz
         IarLQE3X8w2uRI3lNmCnoFBoVcC8d2XR1ss/G1HMcCXJ9NuoV6qyWRFMPBKHr4M8rYDe
         0J+Ovg8hQ0rtBa8URAfz3MZCsqHF9OjxrFvk3JppR2wctgVPs1aS7i0Qx2qsXis/FDAt
         QGf/3LQ2m6+d691OZuK5WfCvdgGOJFh8oq2UXQlml4EIim99fsDBtkIgSE7z5bWmeiuh
         Kp7Q==
X-Gm-Message-State: AAQBX9dqEWyKcPpBBJMgQQPXOigGLXXc6ucHWoMUebqXMPZUeCAEL1u0
        vHMJeXbX5Y8VsyUfEAzwaRcYkVdrmsccnaIYpzz4GQ==
X-Google-Smtp-Source: AKy350ahE1wnvvYwydYcNsmrky9JDNMGCZgF/Q0y/4slhb/TM2utRwON+wgywSdQlbWK+Xj1tnFkVqLo35Mt2Zitp4s=
X-Received: by 2002:a17:902:dace:b0:1a0:41ea:b9ba with SMTP id
 q14-20020a170902dace00b001a041eab9bamr9325951plx.8.1680200216015; Thu, 30 Mar
 2023 11:16:56 -0700 (PDT)
MIME-Version: 1.0
From:   Stella Jacob <stella@infob2bdata.com>
Date:   Thu, 30 Mar 2023 13:16:45 -0500
Message-ID: <CADH7MrGf7wFL=A03Uz7L2zmU3EixqYaPPPYKv3H6XJiL_r1nzA@mail.gmail.com>
Subject: RE: RSA Conference Attendees Email List-2023
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        FILL_THIS_FORM,FILL_THIS_FORM_LONG,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Would you be interested in acquiring the RSA Conference 2023 Attendees
Email List?

List Contains: Company Name, Contact Name, First Name, Middle Name,
Last Name, Title, Address, Street, City, Zip code, State, Country,
Telephone, Email address and more=E2=80=A6

Number of Contacts :-35,894
Cost :- USD-1,862

Interested? Let me know your thoughts and advice on the next steps.

Kind Regards,
Stella Jacob
