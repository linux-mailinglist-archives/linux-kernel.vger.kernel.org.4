Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F776B6C20
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 00:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjCLXA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 19:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjCLXA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 19:00:26 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A47D2CFE7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 16:00:24 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id y10so11567557qtj.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 16:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678662023;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NFj8hwmdox2fPUWNjtNJG87t+emv14/wDoz5EyLA0s4=;
        b=Hj1qum0FNAd0Z0FKkEyjObAX3KK2dns9Pv2Rc3Krfpn/YN9P3N08p3s6qTYAwtbZsE
         YuK+Y69u1L/bn37azJ8xJpzGNHXZ2bd3LNi/i5gOqPNIGSAAzZIsd8vkcBYC/LhJg9Xz
         h03ncqmnB7soRuEhBHK0buezT05OQVVZIBbvSOTGTpA4wCYmEr71s3ZkuqaU2Ra6J1YB
         tAHtoxnQzJt+2QXf981vx4M9Vv7Mxqm8TJWLLx8fP3EfMP41Lt10U3LmL9e/DsgTwSjX
         VrLADdLoXFr3A6a7tM+2D9oIpLqro4u1NQsVQ5dRczhClb1MnESK/o81EIXSvhLZK/TQ
         k33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678662023;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFj8hwmdox2fPUWNjtNJG87t+emv14/wDoz5EyLA0s4=;
        b=s6/pVvymub/WBvBwejU7pjxUcTYtDTLbxQO2sB2oGO6VAp5mF5duM5QfqPPc7pQYMc
         6ncx9SjoV8agLwwYuCXMdDPgJ4dSwq1kKiHSfX//yDZacYRomoXaVw8gU8BMVu4HAyzA
         hDEycba+cU1eoMVH1Q6qNvrqARgNh8YjkynZLQSPTQU++y7Fz0uMdCu0sOjFc14e3CLz
         lf3jm0v/z15ZpRu7AaJXqQZQR+BoicB9pt5x6HWpKm9wbVF8e/7vH6TtHNz65OcUWe2b
         gndRZ3O5yAoamizHxlszrp5m/DEtjsTsqgRq5F3ZrOin5sh7+MkhpppnNEUOTllX2W/g
         hgRA==
X-Gm-Message-State: AO0yUKUjgGJ35UcMkJWxbsPC1mFvpyLLN2t3W9+YNrWcDLp+otYJSS3r
        Whrbumxow4ehQtL+S+1J4uzg8FQeU2xOkgocii4=
X-Google-Smtp-Source: AK7set/KaslS0D8+6xTT+NN2FxhS7ejvhhZvZRzstB4f3w6aLsMnxqR8/s6h0grlLEFe3fBgHsr9F7LFpuSDK5mscBE=
X-Received: by 2002:ac8:82:0:b0:3bf:ba7f:58f8 with SMTP id c2-20020ac80082000000b003bfba7f58f8mr9083179qtg.3.1678662023531;
 Sun, 12 Mar 2023 16:00:23 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkaylama@gmail.com
Sender: abdoulhanantairou@gmail.com
Received: by 2002:ac8:1244:0:0:0:0:0 with HTTP; Sun, 12 Mar 2023 16:00:23
 -0700 (PDT)
From:   sgtkaylama <sgtkaylama@gmail.com>
Date:   Sun, 12 Mar 2023 23:00:23 +0000
X-Google-Sender-Auth: EEoPrdP4yGR0kNXPr0KsetGu9As
Message-ID: <CAETTEK6Mph0b9TJqepVnxN7MSB3axcHpVLpb-zPUGQ_4bZCCKg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_95,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello, did you receive my two previous messages?
