Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F3C652D05
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 07:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbiLUGrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 01:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbiLUGq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 01:46:57 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A081D336
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:46:56 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id jo4so25640360ejb.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAVMql90nO7ZkFcVgMNu6fVpAbtsWgSiB+5IHPtWWmc=;
        b=LAn8A6q3x/FxImTU7EI//vFipPthxtzU9CCh1UlabVwIoxxqd3FVtp9nlPG3NakRLN
         SYvnKRpPj9rPDJmzRpl2ABWyyAaD8IfdvokDJ9iRekjZOeaVZXE4998zBRpntD0xTo0t
         zWLJ+Yz02YTk8MXQhIRPIuphm3zS3fu2TuR/GnM4DQHuxBe6iUVQWNe6FuFiwyoYqyA3
         5iwNSTJxIaWxf1STTVWEShE9l4tdC+y+yWEOZlJnc2vg8AikhmA3K/6jdaJmkn4OZ6Si
         Tcu3ccyDyds681GzjwZUE4PXEs52QbeiKfsux2FN/Lsy2UN1gVARItqg+CM37mxV/3Cq
         Rd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iAVMql90nO7ZkFcVgMNu6fVpAbtsWgSiB+5IHPtWWmc=;
        b=Tejm+EmRE1q0HGOeODmyCNomBhf3qlXG8bfKFL9oE7ecGwev+mJfig5e5hlBnWkGAx
         ngCwhzKJnS7LJ7GRns9Jenr6AUFm9yWGJ4JkdW3G/5dfVUVNn2SXw30lHo9EBN6ANxlV
         rmsoz93wsBx6P/puILkZnM3e4Z/Hhg3TGAMGY+re9T8xmuA92bQbft4xaRLSdKItBwz/
         rvaVvT4MlEfVfYZ4dHkCJwoHB5jUy9BinI8T4L8+b0/vDyyqLTyBOH4Z3uKSgr23Rwat
         TOYZrApbnapyJ8DuYQB/XOvdI+CnjyyIqtRwPQqrBh64pQUuSoox+S+Dsua1uBWIADJL
         jTFg==
X-Gm-Message-State: AFqh2krZBMxtwekJ36OHQm839ukQehkpBZGnLAr8tf4GccGm7lCsOger
        CgpVa9wYwVeggfviM7skhgZjP2qWVu2uyPWFFsw=
X-Google-Smtp-Source: AMrXdXsy6U3KyN+8+jn5v2xOSWzTtJPiz6KIbtFyXTms7FfdcTs+5eU99zz8pSApZy3b2GiXX5eKzmcSV01kukO30eA=
X-Received: by 2002:a17:906:4f12:b0:77f:9082:73c7 with SMTP id
 t18-20020a1709064f1200b0077f908273c7mr23621eju.517.1671605215225; Tue, 20 Dec
 2022 22:46:55 -0800 (PST)
MIME-Version: 1.0
Sender: goodw771@gmail.com
Received: by 2002:a05:640c:1a0c:b0:189:ab5b:3d94 with HTTP; Tue, 20 Dec 2022
 22:46:54 -0800 (PST)
From:   H mimi m <mimih6474@gmail.com>
Date:   Wed, 21 Dec 2022 06:46:54 +0000
X-Google-Sender-Auth: dp3PlfOk9U9aB-AeJyV_-nRkJqE
Message-ID: <CAM0SVCachfT5FX0dTme0mFfAEGeXC1yPbUMeHuzq7sj2VTQ-dw@mail.gmail.com>
Subject: REPLY ME
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i am Mrs Mimi Hassan Abdul Mohammad and i was diagnosed with cancer
about 2 years
ago,before i go for a surgery  i  have to do this,so  If you are
interested to use the sum of US17.3Million)to help Poor,
Less-privileged and  ORPHANAGES and invest  in your country, get back
to me for more information on how you can  contact the COMPANY in
Ouagadougou Burkina Faso). for where the fund is
Warm Regards,
Mrs Mimi Hassan Abdul Mohammad
