Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BC568EC36
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjBHJyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjBHJyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:54:38 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B780E25E31
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:54:37 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-16346330067so22562380fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 01:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3oYidZLIIeufrqimC75alngwweIfSpHMuZMsiKxxUjU=;
        b=SK4yg4hZ1/J9ykxuQXuMJ8wTplmXWZ+rUoPXQmXGHLI17Yz0/3kcyZp0WucDCQdTSS
         u5RmtTaXcbeSzbE+OIubLf9bmpQ7aKtVQagpWW38EhSFqRQhaXG+K1NbIppcuF3pl1cb
         JPoQRkqbL5uAiY/dt7zUxvq4LIuJk+rNI4U/NfG7+w68wpdO4H8QiPVgBgpAKCveuzu7
         +aoXN6t/uOgllbiUygZFQBBAcb4NFciPZJCGRsvawHgl2mFVgNNB8AAYUU9/OdGFFMP9
         kgunVNRP8DlhCRZfzxfm/BD4SXUccCfD6VNgv0Sfpk669HM1QLl+D7SuMOKtGoHjxaov
         iCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3oYidZLIIeufrqimC75alngwweIfSpHMuZMsiKxxUjU=;
        b=pYHdcuIV20SYP0B4eTC1Vb8x3/n17TMJTUHcOhmiO5DeyxmHK1EZpbf7SGlDgls2Df
         sjBujIj6nhHD/seCwdhDoED0vKE6AI2Gghe50sVZbUu2OvVmEq8guhlVRDsdMfaQj6Xf
         lM3v7lEtcbMgXUOc7G6CLFJ75NExkVs8lrai9bh084r2hFNSVfJOgzoD5YXMFKh8IH8X
         zrJqpIzRFradc7EpzFaFtC8zCeACsXlAmwseQF7ngxEIlfAxtn9aROEoMU3fysVTsp8W
         Iz3msJOAkSbfk2450RTlfJisiFRp1YbxuLYYq8ZRdWglA2S6aM2Jq0/JgTdPb2048cjB
         nAVg==
X-Gm-Message-State: AO0yUKXR5ecNMWzpGI2eFDpU66RvrfQgaTDu7axaspEhlh3fmitp9+JZ
        JprMzDajrG7oAZjldogFyofAVqz5kcU7xMELqPQ=
X-Google-Smtp-Source: AK7set9Jv3aoswS5ST5xAwLKayC16Z8shntXJ7qWgscb/LsTffeS1YJG1uw6sxAchHLmAvqU06w1+urcXDQ5wWfnJuE=
X-Received: by 2002:a05:6870:808d:b0:16a:441:fb14 with SMTP id
 q13-20020a056870808d00b0016a0441fb14mr269664oab.60.1675850077045; Wed, 08 Feb
 2023 01:54:37 -0800 (PST)
MIME-Version: 1.0
Sender: sbinta301@gmail.com
Received: by 2002:a05:6358:e493:b0:f4:4cdb:bef6 with HTTP; Wed, 8 Feb 2023
 01:54:36 -0800 (PST)
From:   "Mrs. Margaret Christopher" <mrsmargaretchristopher001@gmail.com>
Date:   Wed, 8 Feb 2023 01:54:36 -0800
X-Google-Sender-Auth: saYkpXdgGU6i5PXitLQQP8dVHrw
Message-ID: <CAK8e4Wvp+F0qoKA61acztXR0o9sf6kdkL=QP1Us9TTUMP274zA@mail.gmail.com>
Subject: Humanitarian Project For Less Privileged.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS autolearn=ham autolearn_force=no version=3.4.6
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

Best Regard

Margaret Christopher
