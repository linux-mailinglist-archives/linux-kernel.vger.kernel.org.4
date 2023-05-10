Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B296FE130
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 17:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237331AbjEJPI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 11:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236672AbjEJPIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 11:08:55 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AA5E4
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:08:55 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6435bbedb4fso7928779b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683731334; x=1686323334;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ISNEZENIG6K3IyfhajA3k/qhhHWtHVV6rKzQTcXTN74=;
        b=eSNGpnZob1N6NvKSRItpN5FKrkUL3QRuF2vJVxZAvSr0qq6KO077KassFOMkOVrQ8e
         ffrirAM5v461+Urxohi5sOtjnGAIaA+Jy90m4AfWgTlkmG86W/D6kJqn8Nikg+DR9RfY
         4CrrN8+mCYGWuvxKinSzkB66Um3HYsbDROl2n1PsU//deaojS6WQs647/oS1rCOERRvj
         EMkArPQLd5jF9u+Q5Qo7UW7GCojGaTOXqMe8Tc5WGg/fF7u7EhlID98APoQ/slvnzOT/
         oCpGaHETsvWcZp5pyMnRuSeX7gS7X77XlekN94Z7xXt0O8DXImVYH/QmlKK5SDBjQWL3
         LAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683731334; x=1686323334;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ISNEZENIG6K3IyfhajA3k/qhhHWtHVV6rKzQTcXTN74=;
        b=RgRQyQL2jdfniZtMasxoOcMUrBYVMo5hvmjlufM/OA8EFDsO66MW3eOuhDOgLHuPUA
         mc3/qZaCpd7KH/mE1DGyCWuH1OsO12MrrRFQdfiYb67rbhXA16wHTbbMnSaXfajADjSP
         GAwWKzAY+QdgkgoFm0A6iT6Eguw52EsxZ0voTUZGIeubMl7Y3LV9aZRigtrHsvHaEDqH
         cJmtdkecRKvRlNn8bv5ATpPh17fmsStA6MBDOmoVqDMIkfqsN+L3u/kkdBJuad1ZPN57
         ppeMUV7yhx5LxqZMoS6JlCO37Q+1rkrjGqQiANlRcwWUDldmewsAb5k7zZtEXibTkj4p
         /msA==
X-Gm-Message-State: AC+VfDzJ9W6u0aqC/xYNGmX8I0ICdtD/d+5dG01LJo/1PtyaVk9hwADi
        CG2Udln32eZ66sBJjvdPoIc=
X-Google-Smtp-Source: ACHHUZ5OKb+xGZ0+LVt5TlLyoXHbLdDwHqsFFp5uVw69JE4irlr+jT+179PZOynhNCkE4by/dJrfmA==
X-Received: by 2002:a05:6a00:1acf:b0:643:d40c:7da0 with SMTP id f15-20020a056a001acf00b00643d40c7da0mr18027552pfv.31.1683731334516;
        Wed, 10 May 2023 08:08:54 -0700 (PDT)
Received: from pop-os.localdomain ([103.251.210.208])
        by smtp.gmail.com with ESMTPSA id j11-20020a62e90b000000b00571cdbd0771sm3636931pfh.102.2023.05.10.08.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 08:08:53 -0700 (PDT)
Date:   Wed, 10 May 2023 20:38:49 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] staging: rtl8192e: Trivial code cleanup patches
Message-ID: <cover.1683730854.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variables in function _rtl92e_dm_tx_power_tracking_cb_thermal
and Refactor variable assignment to avoid checkpatch complains.
The patches are required to be applied in sequence.

Yogesh Hegde (4):
  staging: rtl8192e: Rename tmpRegA and TempCCk
  staging: rtl8192e: Rename tmpOFDMindex and tmpCCKindex
  staging: rtl8192e: Rename tmpCCK20Mindex and tmpCCK40Mindex
  staging: rtl8192e: Refactor tmp_ofdm_index variable assignment

 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 68 +++++++++++-----------
 1 file changed, 34 insertions(+), 34 deletions(-)

-- 
2.34.1

