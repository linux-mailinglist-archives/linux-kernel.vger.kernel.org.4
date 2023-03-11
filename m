Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DB26B5CD4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 15:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjCKO0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 09:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCKO0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 09:26:42 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57035104600
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 06:26:39 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-53d277c1834so154861527b3.10
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 06:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678544798;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WvPIjvJySmeyGBuurh091SczFdPjzfvwwQjXNn6vDw=;
        b=mbfY/uAU0W0V/373syWwbCM2ooh1lH0i4liB1mCATKgE7PosYK3GCrv3qWrt2U2VPY
         QInj0VQkdT7+pUCty0D2wGR8qt7qBnr3HQ7dxvymOCqq0iOB5fvnWailAkoegMlWLAUe
         dHMnN5Bv2tdbsaOcrWfJ+KfwPccBT7eGRrqrgFaDD+ZtI8zqPuALU0qz1SS5/yBDkqv2
         oTR+WNUfj9Ugdgc6HFh4lBt28Qr3pcCQY48Migkzdxwt52jjg9n67kRfmktEfrtLwXF6
         a2cQm0ZS1EFZHUqR/B2vqG46sLDltSXolW33jyjfKAVuhGBDdZJ3UC/Pe5n1wh1JL1dy
         oh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678544798;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0WvPIjvJySmeyGBuurh091SczFdPjzfvwwQjXNn6vDw=;
        b=r6Hg422znPltjkKdlTx/8htz71vG2+VUcfYFo4TAxUGD6lYVhL8cEVa9Q+FrpjUHfB
         JCiLOoDSFpz2kgTksS2CmFPJiXEUoI+eC1Xp26o6UlWI8NACXLUAZo/h/nD4ViXj0/J0
         dd3Q4kSLecIyhx8BAmRyEILocbWeAxyzHzcDCq/na4DY539AEp8SGBx9SXEkthFm6Q6l
         n+8W+YWPK0bm66KZ3+Abq4+cKUoFWATZZxwlMcPrNKOvSmih5fessDLXRBz0+T6R09Gp
         A3bOSTeLxMQSto4mfqAE7hCyTsd1K8nXWPjdaQvU+KwWttqlZtdOuUtOnD/OKB9ovZAZ
         npuA==
X-Gm-Message-State: AO0yUKU1ATQEq2YubBpWwdNZ28fJkc8XJJIH8iU9KpOaiM0PuSXuj+Vc
        5j9TcB/Nlbgy0Tb7fTooRR1UMWXarvoeJQoIEM8=
X-Google-Smtp-Source: AK7set8IrudPUQcgWXq+tb72sDTgbgz2mH5dI0SA/SpcFdPzFFWJv7jxZj9eaLTs7GY/X8oOON7zW1IyhSvqQ7JTeTU=
X-Received: by 2002:a81:ad66:0:b0:52e:e8b1:d51e with SMTP id
 l38-20020a81ad66000000b0052ee8b1d51emr4025563ywk.1.1678544798584; Sat, 11 Mar
 2023 06:26:38 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7108:1702:b0:2a3:49cf:c7d2 with HTTP; Sat, 11 Mar 2023
 06:26:38 -0800 (PST)
Reply-To: fionahill.2023@outlook.com
From:   FIONA HILL <dr.sophia.moore@gmail.com>
Date:   Sat, 11 Mar 2023 06:26:38 -0800
Message-ID: <CAJUx1i-Tug72prXQKyeBUK8_p+xfVyM3UMx2RiboEKE1RVk55A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
How are you and your family you receive my message?
