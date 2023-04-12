Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25656DF7AD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjDLNux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjDLNur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:50:47 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA52F2680
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:50:44 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1878504c22aso276125fac.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681307444; x=1683899444;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HQ3/PENFcKoGmwx/7SbOyLF8CDNOnHG2xDlRT2NQtrg=;
        b=gKnoddJ1Vb75/6PaWvNzi6x5dsoJdhTTXzCxM+fmAIC5Ui9132lQ4e2GHWzK4ewuFW
         EZaIgDCPrzaY71mTyVH+X+VFb5RaUxOYQ5X5KrJLrG6mVS7Ra95J0Mb82TCJFVdD0g7R
         GDOnH5B3lPAo5ujn2uRXbe9v8KQiekxmfJ+wkP5YL18mtFWOpDopG6UqLZYS+LFGheG3
         LWsiIVMV0WV9g/wX3SjP1+5MJTjmtaR/IdWI4T79tS85wh0jYZzaYlEOzE6wx1TBCXGr
         Y6podNB61xNivF8vy9Zku0tzEaaRP+W4J0A5Hq82XQoVa1guYwy6GAsQtWHgaFrUh5bZ
         x4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681307444; x=1683899444;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HQ3/PENFcKoGmwx/7SbOyLF8CDNOnHG2xDlRT2NQtrg=;
        b=ZX/z5GZstQu+FnjsNR7lOxH721FZ7TVgoeRTxQJip1U898ZWYItFyd6aaG7EQ2WepB
         nqQ7ObcjftAO9+F4RxQLVw4pAQ5063pzyryq2XTpuqnrRufSd2JcwE8sugis5DQBLzRz
         gGKN6gqLUmyn4L8yrx9IMrkRJ5KNGq3bU+XpmaCmQGTBCnxfL5DYNhk8NzVmGzeZQ952
         sSY25dOQwVqRdh96QryR4dlW0K+swliYhkwUFihzG7YoPd5L4L2UwvumtRE3ge+VmQ+r
         46lkEBW5bAZGv68Q94fseoqwuzT8kGGcQasdS8F3ByntU5pfC8Ve6NC3TEf37+xZ9eCW
         vY9Q==
X-Gm-Message-State: AAQBX9d2XET4o/bdkHdYeMSjT1OX07Q4w1ii5dcNY8uJaKcoAOxg4lpi
        SNscnEA33qEAVAFOe6rAHMkUFqLAs83BJiAZYAc=
X-Google-Smtp-Source: AKy350ZDO3y9JYY8fci+VYwvs1OGLtm3qbgv38UBzCi7KSsByYifkdIl+hRmpHnh5V8CTHR/loq4FEDQtRyAALIVfq8=
X-Received: by 2002:a05:6870:169d:b0:17e:d308:776f with SMTP id
 j29-20020a056870169d00b0017ed308776fmr6833681oae.1.1681307443841; Wed, 12 Apr
 2023 06:50:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:1888:b0:f6:68c1:ffaf with HTTP; Wed, 12 Apr 2023
 06:50:43 -0700 (PDT)
From:   Frank Hughes <ccmk137@gmail.com>
Date:   Wed, 12 Apr 2023 14:50:43 +0100
Message-ID: <CANqQpXU4HmDVx5CpySVR6xiYnAhxAKp+Oe3g+n8qSwLVGQSLqQ@mail.gmail.com>
Subject: Good Day,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Day,

I'm Frank Hughes. a former commander during the US Military Mission in
Iraq. Now that the United States has completed its mission in
Iraq, I am currently in Syria for more assignments but will
soon be assigned to the Joint Multinational Readiness Center (JMRC),

During my mission in Iraq, I was able to make the sum of
$25,000,000.00 Million Dollars. This money came from an oil deal, I'm
a uniformed person and I have to present someone as my foreign
partner. I am an American and an intelligence officer. I have 100%
authentic means of shipping the money through a diplomatic shipping
company. I just need your acceptance and everything is ready.
