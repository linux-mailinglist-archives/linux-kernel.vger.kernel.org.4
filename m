Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5FC6CB048
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjC0VCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjC0VCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:02:31 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721ED12F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:02:30 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id eh3so41482118edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679950949; x=1682542949;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VplZUCE/F+ZasISe1VnumDQIHXY4z8OCN0riUDX9NXo=;
        b=NR+8vW0rMBEOyRvzlwqszktNTwI919fiPJfbppGSDeUL3/V7ybiQTJWQgN1N+NUb7H
         5y+Au3GmD2Fr+8IY79MXBt8a0FfhzbWDfKAnK2GMwj2Mbq5cdpMu7pRmjg+cB8JCqAFA
         NJXo7pGPMdu0mhj3d+SsoybmDLl2pNWoY8zPacrj3UULF+fqF9ZublArIJsBEjXTnwDx
         DS33E4jErwKIPXOg2fWzuppNxWEmqCXqwRjdxF5JZeSnzH7/VW/odevWAe8w6GGbTUn0
         XFs6yGgIbeoDJ2AhBL6ggg2gGpV3hffBU7LOoK7jO16PcPOydWw+pgvMv0zcU+wVW9zY
         +LJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679950949; x=1682542949;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VplZUCE/F+ZasISe1VnumDQIHXY4z8OCN0riUDX9NXo=;
        b=gBlcCIlm6c5iJwCMe1BmIGFuwhFzIgu6ZRgMOsE4aXrMJr6LLtkuT5KVkTXM9SnSCW
         NVwsRg0pHjOiBUkgRXw84m0WZDL4y69ZLqO1yDYAdkR+SReM+L2QufDh017oOgz6kxJs
         NBcXS9vii1lV7nWD7tdPtna/VOwzdL2f2p26qnTI41AK5Zu6v8+l08jKy7e4QClgEb7P
         LZkKMUeT2lg+9Mdi7QUHBv8SaWkfCtL/5tvg22WGX9sFShGYj17bixrFxRoELApQwFgj
         Vz0kwdeIjPsSBpLLQpZsVSpWTMrZ2U1/0IPEays7be+7ZdjvCAjk2S6DOSL6VRWz71Kn
         Dvvg==
X-Gm-Message-State: AAQBX9fTRvX7RoNUjvyjQpSoJVtZSJZKgn7RWbFNiqQ2ALLMWNqybB5d
        5mpYvbOdDcQQOahIwa6xNWM=
X-Google-Smtp-Source: AKy350ZV1SG1a821aOVmRUPrdv2s4yPb3AMK0fs99e8CQ0HQQIr4r0nrMyko4ChjytsuACkAAw1vGA==
X-Received: by 2002:a17:906:214:b0:933:23c4:820b with SMTP id 20-20020a170906021400b0093323c4820bmr11951323ejd.4.1679950948706;
        Mon, 27 Mar 2023 14:02:28 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id g4-20020a170906520400b0093a35f65a30sm9262830ejm.41.2023.03.27.14.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 14:02:21 -0700 (PDT)
Date:   Mon, 27 Mar 2023 23:02:08 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] staging: rtl8192e: Remove wireless modes A and N_5G
Message-ID: <cover.1679949171.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove WIRELESS_MODE_N_5G and WIRELESS_MODE_A which are not supported by
hardware to remove dead code and increase readability.

Tested with rtl8192e on wireless modes: B, G, N_24G
Transferred this patch over wlan connection of rtl8192e

Philipp Hortmann (7):
  staging: rtl8192e: Remove rtl92e_config_phy
  staging: rtl8192e: Remove _rtl92e_get_supported_wireless_mode
  staging: rtl8192e: Remove 5G wireless_mode in rtl92e_set_wireless_mode
  staging: rtl8192e: Remove unused if clauses in
    rtl92e_set_wireless_mode
  staging: rtl8192e: Remove wireless modes A, N_5G from _rtl92e_hwconfig
  staging: rtl8192e: Remove wireless modes A, N_5G from
    rtl92e_set_channel
  staging: rtl8192e: Remove wireless mode WIRELESS_MODE_N_5G

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 19 +-------
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 18 --------
 .../staging/rtl8192e/rtl8192e/r8192E_phy.h    |  1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  | 43 ++++---------------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    |  6 +--
 5 files changed, 12 insertions(+), 75 deletions(-)

-- 
2.39.2

