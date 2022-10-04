Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5155F3BD5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 05:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiJDDtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 23:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJDDss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 23:48:48 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22777C3F
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 20:48:45 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j16so7440362wrh.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 20:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=ZoZVT1Bed88jLyHt6JUUMuuV+5ryqAa3TwA+H7PAOmE=;
        b=GalvLpjLff9ww3OtAreEWU1dXuQ0ZT+jHVb6wvBiOBprrtFWqHDZSbKIxoBBFiK52m
         t9y84v5AGjCYEfZ9DUEfVHbmDkuwhOys30BTPc7Cj6si9uq0DzceMQ4ighlAotPuu9jC
         77hEBlFD+6oLiZ820HMzopMkSH/OAAOG5bmgS4/zul0N+LX/dH/i+ZvqN5jdJMqYLsRc
         Sm5l6TZcnj0jc2nymIl3t6UkeCLXNHe88BFK8n2cEdz8hnuVsdqB0QhL6LJwLd08mR2C
         0X8l1+2dt19kzk2OXyJ43crL+njJhSIqBiI8FxWKltBscYwnTGEO1mACD7bWkIHI3hXu
         KOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=ZoZVT1Bed88jLyHt6JUUMuuV+5ryqAa3TwA+H7PAOmE=;
        b=NmUVp8zYhffNiX3P17tXUE6vz+cbO4EjUgfhDNN7nIiDjKaeShOyplQEKqCce9eOmc
         9yQwDtqj/n6goqhimtNFicCLUx8JNloQWnFP7x6CxmSUVL/7LeLyBM7S1KsWEcf/rR0b
         O0DY4IJZt8hDJVRGajpNFFKMHUkIdnBfwvyQFeHqzafd+7dbx/ET+zpMViz9F/h4lxDs
         VBkOPlF3ik4jY41S1TCuBDOrLv9iKCiSVMsk+QPLJNB7DyjC9b/gGWnDioGAFl/oXT7i
         dWfUiTsb5UC5SNcdlyiPdsHH+Jm/FPNDLcPrzHmrkgfvQiiVHQcY46MFBm4Rpm8o3Ww7
         ioZw==
X-Gm-Message-State: ACrzQf0txb0SwIrBETZnkC7y+JyxX+BSPyHIMFTf+H0GK83cDjS9G4iN
        qQedd5PgaNMrU8Ok2YkngNvl1aEAsJpW3IjLPss=
X-Google-Smtp-Source: AMsMyM65g9oKa+uiUUSH4oPj/lPEIemUx+let+GZzCqPYHMPlEWn+W2S0guBJn5aikF+Gr2SP2iGe1DmM/LtKVM28oM=
X-Received: by 2002:adf:eacf:0:b0:22e:369:2081 with SMTP id
 o15-20020adfeacf000000b0022e03692081mr10927276wrn.339.1664855323901; Mon, 03
 Oct 2022 20:48:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6020:5d95:b0:213:ff7d:1fc2 with HTTP; Mon, 3 Oct 2022
 20:48:41 -0700 (PDT)
From:   i have a deal for you <boersa77@gmail.com>
Date:   Tue, 4 Oct 2022 03:48:41 +0000
Message-ID: <CAHSrfz3pwaCCNbrW_x34ByKJbLC39UzArwMmYWmbAUdD9zmBNA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI
