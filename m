Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472CE6ADBB0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjCGKVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjCGKVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:21:48 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174341ACF3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 02:21:46 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id z11so7687233pfh.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 02:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678184505;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x50Qlw1MrbKfPc5Y3tqZO5+1c26Aew+5oqPX3JirLAY=;
        b=TE6E5VUw5HBCWcNlpvAPy28hQkL2NkgpzMKvh0VeYw15g57cfFt9feuOD/Ssme4V3o
         Z2nZ6xaG8XjcLVxK5IF8bLf5frNjEr1sgBGVgBZAFwOsbEzcWPBN3dbeyLWTKd9lCgOV
         ENj2MxgbHzr6pP9V0F7HTP2WObRDe1mEySmG+95zdrEmHC2YNnUPza5rOQftQwe5GtyW
         m95QK2UKZIe4B/N+/kV8XAPuqCucM2a37JwY/ZdSx7Em9eAXBdznSq0ro6u0iePZHiIw
         rCZ8uFOOvhfTYdY12jO2qv7m6PHMiFz6Ow8bpakNu5u5W6WlLiHLjH1BCv8yhoRqh2jA
         knuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678184505;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x50Qlw1MrbKfPc5Y3tqZO5+1c26Aew+5oqPX3JirLAY=;
        b=IrCf78Sr3SDl6rKY4lB49X7eVJbWONoDzOo1/recfrXXm1JRlKF0jO8Fb0Y3uaYETK
         22yKTkgynUOWJwlLb8+FwzKmiGCmCoBFURI3gJx98RZH4J8LKToA/esCMBFVnKamET7G
         vXN5G+aAFRcse2Sk4TrDtx3hdZtEgSwRa0yHSwlaRst85iOB6Qv05W/YyVCuTboR2aAn
         LTJjjCpYrSXiyyg4wyeY85xXtCHkkquVYZmNYALzxOURLngw6WUPQNqBXO2ly44sSvt0
         C6pwbgZ3l3FbromCShMwZt4tJ1fAdric/XLPlH/cOjqEg2mStmQ9L0yYUeFeSGMhbhYP
         AJ7A==
X-Gm-Message-State: AO0yUKUUSED49hKMVpnMiShmwcpiysUYG1v64JTEMADL3MfwcIcqQKTq
        KSVTleA9d91/UuJ9g1XYvWXALf1+vk+f9y06QyU=
X-Google-Smtp-Source: AK7set9HaP/UPgY7K/TxVNqvBBfIPLs5pR7aMpTjNRzw/f+HmV5WnnNYXz0m5+NCwkjkyd+vOX+qBPBn/8SF/6QNv8A=
X-Received: by 2002:a62:ce87:0:b0:606:d488:f058 with SMTP id
 y129-20020a62ce87000000b00606d488f058mr5864753pfg.3.1678184505456; Tue, 07
 Mar 2023 02:21:45 -0800 (PST)
MIME-Version: 1.0
Reply-To: vandekujohmaria@outlook.com
Sender: congo2029@gmail.com
Received: by 2002:a05:6a21:8dc5:b0:cc:1c41:858f with HTTP; Tue, 7 Mar 2023
 02:21:44 -0800 (PST)
From:   Gerhardus Maria <vandekujohmaria@gmail.com>
Date:   Tue, 7 Mar 2023 10:21:44 +0000
X-Google-Sender-Auth: GkOdey-of5QSi38XOtTZhvEkW9k
Message-ID: <CAMe-s-KoPW-t3SXWrxG7dVyODoJsrwS_iTUdf+5J9aOEzbWLCQ@mail.gmail.com>
Subject: Best Regards
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, how are you?  My name is van der kuil Johannes gerhardus Maria.
I am a lawyer from the Netherlands who reside in Belgium and I am
working on the donation file of my client, Mr. Bartos Pierre
Nationality of Belgium.  I would like to know if you will accept my
client's donation Mr. Bartos Pierre?

Waiting to hear from you soon
