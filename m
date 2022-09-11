Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461C45B4D93
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 12:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiIKKpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 06:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiIKKpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 06:45:11 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890FD14D0D
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 03:45:10 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u9so14020409ejy.5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 03:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date;
        bh=qDSVYJsZG02wo93ZACs1cSD7fLGxiL+UEFdO8CcreSI=;
        b=J0fd87jSFhFXz2CvTX2ql6Be9cJyI8s3pAutOye85G/Sp2nJBJDwR//84RNmNnGLFg
         HWcrU4lU42Q/Lwn8kGIpkWuNm6U1n/2URlXe2lLF15QiVpwH6s1TplnO2ea0gqabgn4e
         anfqL0DxoyQGh57Fx39oonulpsS+O5lK8rXa9jJuGaG+FUEyVFGis3XaQn5S09TfxCKH
         b4mUtN00wHJgbq6Lo0Agjne2yzwIqbcp8OGOXVefzPvccoCT8sxQpcth+yAc71jupTD2
         s3VkVce8Ey4m0c8FvopLtrs4bX2C+QOo1lzevQx9WsQjHeFUxWJqcsMjS2uLl3Me9NxM
         ez5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=qDSVYJsZG02wo93ZACs1cSD7fLGxiL+UEFdO8CcreSI=;
        b=UjEzIctjZWPF6lOeXaRtJe59NsCI108uzJ0dcOz09QTg4JsYf4eSQPl0hu/cV6NvHf
         s4tgfgFAjpUA8ZTpPgb7utETB3veMx1be0Wl+5ViDvm6A0i0ARmpU8Vo1DNiIS8XaeYM
         bKlV/FuxvR1YwHiCeDykM93RMKRIwkr/N2FK1YiX3cvpfBhMtp8Pusk3nOC5/c72DX/z
         qMNG9NZVFWSKHavDF2JoK0lxnQW9t/wtuLsFPkVkvQS+FBtQotwLsXCmmvCw0gOsgBhw
         tGpPYa9bqWFSOkt0K3Bc7TiwIzCt48vXmUEP3/c9PIWvdrwlMxFttXaUYxdo2I+EpED5
         3pZQ==
X-Gm-Message-State: ACgBeo2bsexabl3ZxYZ7/e8IK5OGarFb2awdDGKrbBuZxb5/U1ZzHHwo
        jfAgcfpkW+GtfmZzJ4eQyb4=
X-Google-Smtp-Source: AA6agR6brXxcvtDlS4t/C2PiXLs7U+sQJct3A8nrkWWlZym/D1SYRbsasu3Av0sMeqJQuo9TQ59COA==
X-Received: by 2002:a17:907:96a2:b0:776:15f3:1ffe with SMTP id hd34-20020a17090796a200b0077615f31ffemr11190945ejc.406.1662893108999;
        Sun, 11 Sep 2022 03:45:08 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090671ca00b0074150f51d86sm2817124ejk.162.2022.09.11.03.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 03:45:08 -0700 (PDT)
Date:   Sun, 11 Sep 2022 12:45:06 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/12] staging: vt6655: Cleanup and rename functions of mac.h
Message-ID: <cover.1662890990.git.philipp.g.hortmann@gmail.com>
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

Rename functions and local variables to avoid CamelCase which is not
accepted by checkpatch.pl. Remove unnecessary declaration of functions 
and make functions static when possible. Change declaration of local 
variables to shorten code and remove unnecessary line breaks.

Tested with vt6655 on mini PCI Module
Transferred this patch over wlan connection of vt6655

Philipp Hortmann (12):
  staging: vt6655: Cleanup and rename function MACvSetLoopbackMode
  staging: vt6655: Cleanup and rename function MACvSaveContext
  staging: vt6655: Cleanup and rename function MACvRestoreContext
  staging: vt6655: Cleanup and rename function MACbSafeSoftwareReset
  staging: vt6655: Rename function MACbSafeRxOff
  staging: vt6655: Rename function MACbSafeTxOff
  staging: vt6655: Rename function MACbSafeStop
  staging: vt6655: Rename function MACvSetCurrRx0DescAddr
  staging: vt6655: Rename function MACvSetCurrRx1DescAddr
  staging: vt6655: Cleanup and rename function MACvSetCurrTXDescAddr
  staging: vt6655: Rename function MACvSetCurrTx0DescAddrEx
  staging: vt6655: Rename function MACvSetCurrAC0DescAddrEx

 drivers/staging/vt6655/card.c |  8 ++--
 drivers/staging/vt6655/mac.c  | 85 ++++++++++++++++-------------------
 drivers/staging/vt6655/mac.h  | 22 ++-------
 3 files changed, 46 insertions(+), 69 deletions(-)

-- 
2.37.3

