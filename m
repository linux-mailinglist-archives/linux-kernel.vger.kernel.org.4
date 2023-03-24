Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAA46C7D48
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 12:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjCXLhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 07:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjCXLhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 07:37:34 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7F51D90B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 04:37:33 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so1334822pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 04:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679657853;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ZeK4ZJ1o6tGrUVsDjmi+mms9O6S9hGyBZoeD/hC1EM=;
        b=NQQ9dPB+EcaahwWLFdJbvT0iUxwUAAfJQYR81VAMuLoPaE4TVm1Or6CGRrQQyYhjUG
         ctgl/+nV0Lj89b89P4wYyJkc5HV6MMxKkpnYvCF0nBWpB++ok3Oy0mvVdYn+KKvTW8eG
         d/M6GnvG+AG4voRsGegCjiu/Zyg30/ApdwZTXrqswG5Iof0Bsnfw2clkt46SDt6zAviG
         1DC8eNzJluexbkRz1M+nfL+M4EKFDl2GNUymbKlXeiuu9FwQbnYII1mmLmR4IQ+xF2bu
         /ezFIpDRA+P7LCGRN5mz+YWVS9HgnNIgfYMBRcVAX5uI31MfiqANEwh3dhVF+oaUfFHQ
         UwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679657853;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZeK4ZJ1o6tGrUVsDjmi+mms9O6S9hGyBZoeD/hC1EM=;
        b=8H6qndTENp7cqi53P5/20j8MX3JG5x7LHJfc5QTT0hALBXwvHZ/o0FsEgfZn/LIcdf
         PVx4BSGypVubrIFrQT+6MA2WHum8lyk+jj9517WbNmkN+zGiTys1oVH4v5DKZtDWN7g7
         64a3UeBOY0jJDlm39YxhogdiMAdgZezmfg4XR+JsijMiptlF61UpPwe3seivVl2TMkNU
         FPwjakkS+l3m8YgjjMWKSWJhuygYDr/IfCXt9W3S9DkY5myuMIlLKezo25Pf9boP++TI
         Ffbb4YvHu/ZcwU95l74n17i8Z2NXY+b0n/eZXFOxNmOlMcSgjBNOPohhfqKLPy1VZK7A
         69hA==
X-Gm-Message-State: AAQBX9dRvNevRNHrgn91iUQS1h/Zgm4AHrMylqclFoeT0dwZt7cCjxcO
        W+bQzmaaEmcjTb9p7j2vzm7o15ILMxPr7LOGZaA=
X-Google-Smtp-Source: AKy350YncST/T8n8qWLE9gsBHFnZnOt4Z+nkMHrLd6/skvmJuEEd9roZ7cwEm8eyDL3jdpd+pltkrJQ+WdrzlkaHfqA=
X-Received: by 2002:a17:903:454:b0:1a0:5057:1b77 with SMTP id
 iw20-20020a170903045400b001a050571b77mr696540plb.10.1679657853254; Fri, 24
 Mar 2023 04:37:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:c7c3:b0:40a:64ae:d236 with HTTP; Fri, 24 Mar 2023
 04:37:32 -0700 (PDT)
Reply-To: fionahill.2023@outlook.com
From:   Fiona Hill <kevinhansen8819@gmail.com>
Date:   Fri, 24 Mar 2023 04:37:32 -0700
Message-ID: <CA++QgS9J4Q4dF6bvQ8MiHppzGMiSBOmHQAWm+pLMgFNYQU0QSA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello friend did you receive my message i send to you? please get back to me
