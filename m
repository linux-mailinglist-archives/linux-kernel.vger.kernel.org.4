Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724436EA6C4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjDUJSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjDUJSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:18:38 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE35119
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:18:37 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6a5e7482961so767187a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682068717; x=1684660717;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqUW57te8XVUCINitH/B//3QnkXFOyY8kgaQJ/RewGE=;
        b=gcYbTbN7cm4NZQYSIagGKnX05QCO9i/xdnyNYMpWp+RIKP0ACxvionaTnNmcp/vO6g
         PuchEXBNto/hBTmUVdBcJzfkbcRjI5PqEsEIaS7oxK6MTrA340Ni8AQNtkpFG/3eDAQ+
         GRcMqum679TlykHj4NwfN5TYCtDazpT7pxMwzdAkXgOKvRMrwai5DlKKPoH0lbt6qRPv
         JWYOLRPyDb/R9ZVVCTfwt2ibyA/LvYayuZtm8+aF0vUvlFW89PCniEL5Fv808pHMSSvN
         g9HwK25RFf4f/qeMqgvhUojCXxxkBZoc2thpiqkfKIZdSF3ZbLD119nrFhPQzk8JFkcY
         XL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682068717; x=1684660717;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zqUW57te8XVUCINitH/B//3QnkXFOyY8kgaQJ/RewGE=;
        b=cHgJ8xvjUWdv2ML8YZXEPJkpjHms5K0xR2oStUGTa81iE2wTdOfcSK25fVJBaZ2JGB
         RjYHNkaC+mQYz8EUi7wtvN1s7xSjX5scGsZzQTWpU19jTbCfKhsYgxnVPk1oP+vAu6s3
         MXBMrSb+ARIRNftMxLgfAUAGe6hHsJgDoxHFJzt3l/PuV8H1mPGVrvaJYheAI5LviM+N
         HSpdubHBzf88KnLULAROMDacYMLOGMEiNEgAPe3iadZTMcI+ItZY7QPOT73eTG+3U6IK
         TUNQY+UtnA5HkvrMxvW3yGC5NLPovxxaca6F0x17OYyUJ3u1iuinWaXWJzUvb+UhzUFA
         bfcA==
X-Gm-Message-State: AAQBX9f1qAnL9A6uyE6q4TzFh6KqDSHWwnLzOCgFrFpz7E5Lz95LF/Nr
        tz2UGAXMOml4zycJyTrUFshqDUUZeHeX6O3qA8o=
X-Google-Smtp-Source: AKy350Z+JpzJu/DpEB2HlM6/Swyg+JNyju6HXlml9FPVpIJwVS/qK83q2+kwNI/FBSPb5PKrUojYpezvI7RxL+Zj2UM=
X-Received: by 2002:aca:1c15:0:b0:38c:647b:e2a5 with SMTP id
 c21-20020aca1c15000000b0038c647be2a5mr2529156oic.2.1682068716748; Fri, 21 Apr
 2023 02:18:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:7f0e:b0:119:ba98:72e3 with HTTP; Fri, 21 Apr 2023
 02:18:36 -0700 (PDT)
Reply-To: paulsonjessca399@gmail.com
From:   Jessica Paulson <mercydimdeng28@gmail.com>
Date:   Fri, 21 Apr 2023 09:18:36 +0000
Message-ID: <CAHR3bNMx9b0EZbLdkcyr6-2WAS5ziiiE4GwHbLd0Pn80iQ6hWQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I'm Jessica, from the United States, I want to share ideas.
