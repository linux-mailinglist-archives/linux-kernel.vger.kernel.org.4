Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FD16F2474
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 13:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjD2L3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 07:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjD2L3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 07:29:53 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7F41FD9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 04:29:51 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-5ef54bcded4so4766546d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 04:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682767790; x=1685359790;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/2kSPjs4lrshG3mnxArnPWo04GDps+mwQUIW9ldmT8=;
        b=gV7wSk7e88IpyFFHXP4Cu68rnBZ8+vdnuC6xXxq2fFjZFRdmWgbITeXP9/TzlnL52X
         fcV1REY/sHyDlUGvYMKcVi4gcLdJaC+0XeYQp5Pow61sFdGjxZtBEs4Gz4NjKed4+jd9
         6RxflKT5jrlt03JvcH7u9Ie3gph3n1QH3lIiEwtuC4ta19wmS9yrQhITQUsCg4Zj8oby
         1DpQT7jwSp0cdXYA4OxTxYpIewhzyTbsvLjmEqh8K00+XcxnUkcPAGK9iTlUimd1Oh/T
         b2dQoc89dwW5VRnjlJWfLfp8xp2eTUKgtDHHEq22OP2UQGYe6kg1UxIIF8WRbFJ9xqyR
         /YPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682767790; x=1685359790;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j/2kSPjs4lrshG3mnxArnPWo04GDps+mwQUIW9ldmT8=;
        b=b5hrAfbKRLvegmjT8T5zn1kT3n+psDyXG6FpWvx18tyZMqm+czmboBHpvrc31L7hMI
         l+vGvdu+4D2V0LjxsRZK6TfcQxTM0Blg7ITHHlPB2RMtGuO6yr8EoDiZmb42pRbPucAg
         l5VmchNstLPp+dhMmjHBnz9RqO23BYgD8w7SQJ8kaHE46NUbZCRt5Hn+XByNXMNwjugb
         BiZ7TFXL6Fxk8PGCyTKdXe3gvpyNQVEFTtPFeiWs83wzldE1S0W+kbZEn8wPMBZzJjSN
         PwGPIsVwM1j9uJ09vKKv9cLPg9rgQqCJh3K3cY8m2hzizkVIGJonpROiAd2HXyqt+UXD
         hDTw==
X-Gm-Message-State: AC+VfDx2v2qMVpz1JiUyD8EItk4tDkByFCUQmdQl+sfZxfMeKFOH/n9n
        1fKtnst5urylWaUfcNOZAYV1crqgbnXb5N10PHY=
X-Google-Smtp-Source: ACHHUZ6Yg3kJ9aMlSMrKZuasGlphpVPNk9so7YJ8TKizdQ/wV6UjlzLMfNR8GsaP6iznHShehm4YGtGQ7my4eDNYnFA=
X-Received: by 2002:a05:6214:19e2:b0:615:a787:6d4a with SMTP id
 q2-20020a05621419e200b00615a7876d4amr14208683qvc.27.1682767790573; Sat, 29
 Apr 2023 04:29:50 -0700 (PDT)
MIME-Version: 1.0
Sender: zaharaddeenhashimfta@gmail.com
Received: by 2002:a0c:e103:0:b0:572:1eb9:66a0 with HTTP; Sat, 29 Apr 2023
 04:29:50 -0700 (PDT)
From:   "Mrs. Margaret Christopher" <mrsmargaretchristopher001@gmail.com>
Date:   Sat, 29 Apr 2023 05:29:50 -0600
X-Google-Sender-Auth: 4VmuJeJF-HqrNcfgrW6BvPNosZM
Message-ID: <CAN+J0jQszag700vPw+uaVNpNB3ZOzQ0CAAuMnSDM6ymnDqfWUA@mail.gmail.com>
Subject: Humanitarian Project For Less Privileged.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_NAME_FM_MR_MRS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear

  Am a dying woman here in the hospital, i was diagnose as a
Coronavirus patient over 2 months ago. I am A business woman who is
dealing with Gold Exportation, I Am 59 year old from USA California i
have a charitable and unfufilling  project that am about to handover
to you, if you are interested to know more about this project please reply me.

 Hope to hear from you

Regards
