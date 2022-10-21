Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0240E608161
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 00:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJUWS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 18:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiJUWSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 18:18:23 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C242AA17C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 15:18:22 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id h203so3511995iof.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 15:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uHpsc7JDBKBVEVoQqaI+RpbRVw1k3xIZMj5IbmUH4Mc=;
        b=Hoexp24pWxT51sttqrlDPFHZRFrIzEb8pzyrkGC6ZGWWfSNVV+RkZGdG4VRhf4E1Nj
         y3kjqpSed//ZP8syILc0P6fVc33NlVaUYnTc83BtrF8shGFLFz+gsPiI8JGIFqUGCkg5
         t//2Lz8aLeDppPLKEAL4kqI4FAFxmpHNtAwxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uHpsc7JDBKBVEVoQqaI+RpbRVw1k3xIZMj5IbmUH4Mc=;
        b=6gawiTH41Wub4vYTnrR7295LsxXRiCi5bsqPmfyZICWwC+1ra681bjQXHPrL6eqbSg
         kCoqDszRqK6qZRu/WZyXtZrXcnZTeFdOE3RQshbpvDZdcaHdz3lTxI2FioMjfBR/yGlY
         +lXDSePlbiH1bM3mn54hG+Y0H6maSgDoNxDSi6mjQMN6rkAUIwdYFd5g/frKGG7RrhPk
         oVlZnpv97UkZf+Nq5t5mgi2yLvEaw6IpdvlSDgclYueutOnnrZdxlmFXsWnKzo8I+lq9
         olPdILPbPzsGEQY4tGc5zRvn1PS7AYhfjw382sy8cF/tCf1e7B3r7ep0SvSOxpnwr1DG
         dLow==
X-Gm-Message-State: ACrzQf3GOYlL7FI5RmEOSzy2mdDxSCyyW2CMxbxcSFgcSW0ClPJtQSa5
        +6yubtZNefvWqHN3wWvFeznDHg==
X-Google-Smtp-Source: AMsMyM4yUT2UADHDx4i/UAcaFyD9mgwJ8M0/v+PX/Jsf76+6TPqfVY7OnpcFlLP7xUWXjSh2Ek5UBg==
X-Received: by 2002:a6b:680c:0:b0:6bc:211c:15cb with SMTP id d12-20020a6b680c000000b006bc211c15cbmr14441038ioc.192.1666390701464;
        Fri, 21 Oct 2022 15:18:21 -0700 (PDT)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id cp6-20020a056638480600b0036cc14af7adsm430740jab.149.2022.10.21.15.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 15:18:20 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     skhan@linuxfoundation.org, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Enhance watchdog API test coverage 
Date:   Fri, 21 Oct 2022 16:18:15 -0600
Message-Id: <cover.1666390362.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enace watchdog test to improve watchdog API coverage of iocls and
return values.

Shuah Khan (4):
  selftests/watchdog: change to print reset reason info.
  selftests/watchdog: add support for WDIOC_GETSTATUS
  selftests/watchdog: print watchdog_info option strings
  selftests/watchdog: add test for WDIOC_GETTEMP

 .../selftests/watchdog/watchdog-test.c        | 104 +++++++++++++++++-
 1 file changed, 99 insertions(+), 5 deletions(-)

-- 
2.34.1

