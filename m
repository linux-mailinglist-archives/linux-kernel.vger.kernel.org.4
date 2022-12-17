Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA5664F8BA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 11:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiLQKoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 05:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLQKoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 05:44:20 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37E8EE1F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 02:44:19 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id bp15so7105598lfb.13
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 02:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAVMql90nO7ZkFcVgMNu6fVpAbtsWgSiB+5IHPtWWmc=;
        b=Coinlc8Gx9sElaqeejBlx239SWzWBt2L0JyObo+oj8zD8XGXHezMkHnqfv2zn2KBWb
         3Bg4/Cpjs51qZYeqqSwGQ0XWqvQpXCM83CC8cpidqeo1TCg557gemSthz9ABlUf8HDFf
         elCfCZZsmlO2VPg9b6pqA2c/D4GfEa46743Kz1MWPOxZ26jc2ttkoaDPzu9Vrj/tnMQh
         LXkHucQPuWbq9xEsNocW//oB/gmJSdZnY070f5022jxUzez0GT6UMRtia/Nj8EjRWOWj
         /73lPajKP2LKOEY7IWh/Dz4OzetCpki4Kc34ry8R/I51hdbw02P+8m9cl02kzTzLUG1P
         Ij2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iAVMql90nO7ZkFcVgMNu6fVpAbtsWgSiB+5IHPtWWmc=;
        b=WOe7AB08fnzceqJPvWgMiHo24dgumkn61d4CEaPOv8a/OO/+WFJ4MQ88kzAY4kSvR8
         es+Qh+eNHMqJqXzr5bSrRe/66pds6bCy/hyYsmaFeecwp2xylhl0P0yQ64A1Ea2apVCV
         xs4z/cTVC7S0B8ZM7bAlOeUT105Az+qEJaRUjjcjdaqOUyq1KRahofnfeiGzpmcGgc3Z
         Yt2rLy/b2lJAF08U9z3OKFMgUt2GfLTzV4Iq+JFsduG41iQ7IhWaHQD3EFx8ogKb80IM
         CnhV6RePndpr0I5XoFh5IDNo+4/SAD+oYhA8E92KGfjTWPDsk+r7FkkmzQ8rvKKqjJrR
         Q2CA==
X-Gm-Message-State: ANoB5plztTXRTYPKycMjdEbIxfWMiFkGN0PByyc2XuVuy9bzHIFLAxJD
        LG2Yk0itJlX+bsEiWYiFeQ5om1ugKJ5Bi7q1bNk=
X-Google-Smtp-Source: AA0mqf4F4oDhNdQ7jw5xPO68GnI6zSEc7HjVN3xrqhOhXQ2SS20RYg2GMblDqDyCwd29jLgBkptSq43WpQgHtqY91zU=
X-Received: by 2002:a05:6512:1093:b0:4b5:5a59:2036 with SMTP id
 j19-20020a056512109300b004b55a592036mr11616744lfg.235.1671273857682; Sat, 17
 Dec 2022 02:44:17 -0800 (PST)
MIME-Version: 1.0
Sender: mrsohallatif20@gmail.com
Received: by 2002:a2e:b614:0:0:0:0:0 with HTTP; Sat, 17 Dec 2022 02:44:17
 -0800 (PST)
From:   H mimi m <mimih6474@gmail.com>
Date:   Sat, 17 Dec 2022 10:44:17 +0000
X-Google-Sender-Auth: XFR_pRD4wtkvp7Orcv6Ch2hPeDc
Message-ID: <CAP+WkJZWg_KB6gJqFznsMPvTu5x3--yiLFmjumnESzwMiw5NoQ@mail.gmail.com>
Subject: REPLY ME
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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
