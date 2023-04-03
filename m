Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F3C6D5067
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjDCSax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbjDCSak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:30:40 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D6E271C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:30:33 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id eh3so120967588edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 11:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680546632;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bw2WLNEsLjqUYtI1zBJeli38GZA8w7Ds7dC+HQd/JU0=;
        b=bpRf0VIPhmF4va3pGlb369EF3+mOiYYv88FJHM+SepFgcdf0NgarzATeIJnuL+krYs
         y0aD91vTsGTOsgOQe5YcHHGSlqJ+YjkRk99byt7BwzhiZrKomvNw3ddSVBSu1/V/CIPk
         cwlW7+Kqa6QBv28aaE+MfZ8B6M6uUybMzCoPZoGjcFpq/G+yLZ71sC5BVdlKBp9anxJO
         SbyEIeDaC0yK3URZbM/oOuShtBB6zg1QoJndI8UW4CXR1ANepMT8hU/dRRYAgqq6A7vx
         tGgQ9FUMONTiUr+r20SlAZh2Rl2VPm7Dt5mBXd+BZwmZKxPHZ/X8ezjTLNIm7YzvkSAt
         nXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680546632;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bw2WLNEsLjqUYtI1zBJeli38GZA8w7Ds7dC+HQd/JU0=;
        b=lGysQ1ZHgg8a94jytjioo1vAZ0CZ5VfbxiIBEsDEOHPp4bGf2p0BjEGCmG09C6GoqO
         u6gBS78P9n2dLLYbjnMgz8NY65WYDpPyjfJ+oa89FY0EmZIxpcryD2BU+xSPENhwO/BK
         5QQrKCHAE7aq/CnhOVXEIlAHlfuqzO41+pkbDbjt9dSGMQbYK3xqXJeTq7rCGrP/zYp7
         P6KzAQZxyTFZxaLfzF+vO/y9D5evVzyxevmCXkPipESqRlMCbgajut89nQrtY7p2yf7L
         8O29QmmDsvYWsYTaprP7Yo4bA6mcrw1KznnyMW/3boeLZ1BsrYWoTaVmbhUkmkdpF7IV
         MjYg==
X-Gm-Message-State: AAQBX9egXJACTy+Ooq/cWjLbbs3Smn2dpfsXrCbQCrGzr68SXijaKM4H
        S1JAR+leaJnVXvVC4Vnsw8hH/3ykUdM0CF/DS2g=
X-Google-Smtp-Source: AKy350bq9r2q1+Z7ukWr1nzfwZTRP3ZUSwFYnTMcJFclVgUNBsLXdQ6CnjX5mGDkByGgdF8N4Wjq5GVCzHba8OMeTi4=
X-Received: by 2002:a17:906:3bd7:b0:93d:8207:777d with SMTP id
 v23-20020a1709063bd700b0093d8207777dmr17737263ejf.4.1680546631505; Mon, 03
 Apr 2023 11:30:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:9b0a:b0:88f:8a47:d461 with HTTP; Mon, 3 Apr 2023
 11:30:30 -0700 (PDT)
Reply-To: mr.alabbashadi@gmail.com
From:   Mr Abbas Hadi <mrbeliyogo1997@gmail.com>
Date:   Mon, 3 Apr 2023 11:30:30 -0700
Message-ID: <CAMV2GXkbMsLwg9MzeYtfGa0xHuitTNbhojyjjUo3VenaTG1k8A@mail.gmail.com>
Subject: WITH ALL DUE RESPECT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Greetings,

I have a Mutual/Beneficial Business Project that would be beneficial
to you. I only have two questions to ask of you, if you are
interested.

1. Can you handle this project?
2. Can I give you this trust?

Please note that the deal requires high level of maturity, honesty and
secrecy. This will involve moving some money from my office, on trust
to your hands or bank account. Also note that i will do everything to
make sure that the money is moved as a purely legitimate fund, so you
will not be exposed to any risk.

I request for your full co-operation. I will give you details and
procedure when I receive your reply, to commence this transaction, I
require you to immediately indicate your interest by a return reply.

I will be waiting for your response in a timely manner.

Best Regard,

Al'Abbas Hadi
