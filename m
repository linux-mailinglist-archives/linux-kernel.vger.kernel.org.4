Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1580C667F9B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjALTsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239799AbjALTrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:47:20 -0500
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C143826F3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 11:43:08 -0800 (PST)
Received: by mail-ua1-x941.google.com with SMTP id f26so4538772uab.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 11:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/krrOzf32PMDRBi/P9qe9m671OONK8NSr+9AstJjJkE=;
        b=Kx9TsVrrvNIl+j7lZ0bMljw/YQeceRN8L3QmQyL3XUAPZt4Vb7MVf8YjXAVSFpzPtj
         5rPgt/opst2NNFu1Xbkb2B95Hcx4gykB/rmBp58jRV5rpqbLo4oOkN/4ZYuX1pmQLSof
         C1doi6q1uF5c7O9iuJAaIkeBnLoJc0xlWLVrj1191QaCrEZ7Cb+/UzNEiQXIV97HZXiH
         Ec1PcDDLNXy7krd2N1IuzzrzeL51z1mBhdJ6j47tsTEaAiF4E4ElNVODVXybL0pQtilF
         3i6x6vdEACnHY7xgbQMq+vR0rqB5iMY8sU6EO/b68NPeafvelhQfIAePkpxXEKhU2tWs
         OdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/krrOzf32PMDRBi/P9qe9m671OONK8NSr+9AstJjJkE=;
        b=1Gpho+XmWGLQ0CrQueeqq5hbXK78NcmtgtNocQ94LCXNk0HldCulJ4DTAPTcX5SU9q
         292GJ/5vppYpDUazkFlQWHIggLXPQ1QogVT39viXa/PwuL52bUgrAKe7s+eQB9CPt2BI
         gELEIoZvZ1tHF67qXlwWkUGjncHtKfDMzWN9om+AdaiQ2N2Np6fw5I1hOh7Ur12E1sTu
         CfB0fCcjite0+1xkDMobx0+GC4BbovaKAtuUIo+OMjscrxAkE2orNPLHmLU3Hold7tyj
         ngMPkyRWvVZU5uq3+U5joF4ipNieNIwayMtKmbqfuDZ9tS69vnIDcQIrZdutOR1RVBJI
         +xmw==
X-Gm-Message-State: AFqh2kpXWoe6EjqmJNYJFV6/OmyvXd4JqJ+Hn+w4Kh0/8Tc5EbNZszKD
        HpSt1U/vrPeIDEFwvzAp8Vl+CKCQ2PTQec+AUSo=
X-Google-Smtp-Source: AMrXdXtIQ2LZK09TdWbOoaNBM9k8uOB2xq4jic4fe0bkgl0CpVNaA+2vIDASpdqbMTKrSfwn87anuRcePwphd06f7mY=
X-Received: by 2002:ab0:5963:0:b0:55b:eea0:1dcd with SMTP id
 o32-20020ab05963000000b0055beea01dcdmr6197742uad.103.1673552587526; Thu, 12
 Jan 2023 11:43:07 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab0:13cf:0:0:0:0:0 with HTTP; Thu, 12 Jan 2023 11:43:06
 -0800 (PST)
Reply-To: avamedicinemed3@gmail.com
From:   Dr Ava Smith <ava0147010@gmail.com>
Date:   Thu, 12 Jan 2023 20:43:06 +0100
Message-ID: <CAD79iHB8_Sg9Oh=zGecAxoALeiqumfQXu68tksAWHs-kouZR3g@mail.gmail.com>
Subject: From Dr Ava Smith in United States
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear
My name is Dr Ava Smith,a medical doctor from United States.
I have Dual citizenship which is English and French.
I will share pictures and more details about me as soon as i get
a response from you
Thanks
Ava
