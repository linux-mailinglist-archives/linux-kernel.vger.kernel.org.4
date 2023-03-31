Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA306D174F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 08:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCaGVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 02:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCaGVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 02:21:30 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57153198B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 23:21:29 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id le6so20322990plb.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 23:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680243689;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B81xlViOcuY3fmYoSsyw/29AhQDJsJw7S4k495w2qRw=;
        b=ULzKLTJPJvoGKJ1DWfV6iHr6283bEHrW3MNDSC3Xkzwsk62pvAy+VKkhgTGbNhIODf
         f31yW54MzgIfMw1afnwumRzviGGKuimpVhgoB+SdgOTinprD8/ivHGe7GPQNAC/rcKqB
         Ggq2FKjX9i7a+MeDYIu2JtyTOEp6ZLsMMefbGedoTrfmonOsiJLN+KQvyoe39i2oK9Uy
         PnpLmIldKrNMFbp4y96NeAHstEmkpUNGxKynHb1skYwQ3n9rBrB6MBwHgkLKacNrmKap
         Rhh+U6Hl+5Y4yksOnHJa82skK0CXZs5PyyuUq+hFZ4PxD/0FLHJRYIkyF3PKrQvisXfx
         xAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680243689;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B81xlViOcuY3fmYoSsyw/29AhQDJsJw7S4k495w2qRw=;
        b=qf3QsYNkBLTuzsTn08v9vPp5mfthdeT2o8IGQrxwdhyQIvUDZSmvcfvFzG1BqErqFa
         YB/PN4AWEGqiXfyjXHlUii2QvoEYbzMDB0iamuHOO5HKExlKy7jtylMtolf7szx+PjaH
         WDvwbrcKjrjCxqzkIZC1Xs+Wp5hq64gCrv85leiV4VIzxKNpFAF8VlBId5CJdgeCB4Vd
         S4h24p9hRlQ/NztgIbLlXzICg0ReE/RLSWX9P4CtKpx8GVhHNuyjO1nJWAUP6TmBzgjr
         jUc7Phe7GLYJ3kkrfLUTs+Mcx2OxNLL1dldjP65O8cWs30cPM5iOYSpJJz5EdAzOn5yl
         23Og==
X-Gm-Message-State: AAQBX9e9TbTVjCF7bCRQe64yvqnLs84XGzHuHBtnfsJVeegwGClf3PVA
        8/jrCV2XfBw5J4y/1KoHlPiqlsiys1ENDfeab+s=
X-Google-Smtp-Source: AKy350Yg/OLoP5j4868H1oDmYIGXJ4VByooN3DLqSNCEJObBsUiRrz5oi0r4F9POdorEQpOk8hM1qVw/SaCID+L6x7Y=
X-Received: by 2002:a17:903:2442:b0:19f:3aa9:bbb7 with SMTP id
 l2-20020a170903244200b0019f3aa9bbb7mr9372777pls.13.1680243688602; Thu, 30 Mar
 2023 23:21:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:2d13:b0:b2:11e4:5a35 with HTTP; Thu, 30 Mar 2023
 23:21:27 -0700 (PDT)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.Abraham" <mrdavidkekeli01@gmail.com>
Date:   Fri, 31 Mar 2023 08:21:27 +0200
Message-ID: <CAMsn+iAxC3amdz-SY5suVahPQ8kGXRDPPbBVnSpAxy3ABYp34A@mail.gmail.com>
Subject: hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My Greeting, Did you receive the letter i sent to you. Please answer me.
Regard, Mr.Abraham,
