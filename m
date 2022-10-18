Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB38602E8D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbiJROcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiJROcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:32:43 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82452C8947
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:32:36 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id i20so5592113ual.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=447DttLGWlnXVhl3+i4qWwJxEj6tFprhGwRHCuyrWEY=;
        b=oBBsCy6ISl9gtPhcV7dLz4BkVh6F+2c9gD8LeCT2AlvOgAVS60ECD0SwY1gKiuOT6g
         mIsLPTECANZK/H9lboPqPgxCSu8ISGqYSbeFlO2G5zIQHCvTu1xSYznZRNt0v12INqxt
         w+XyiGpI1zpF+zsYqZjZ40efhmuzeadJf0mUo1e35fBz6idd5Tk8M8E0lBlEHNd0/KqW
         Vm/nxv623VQE0qrDz+icVI/ZisJzTkERhJgcjh6YMiNVaH5taq00Jz4z1/2mt3kBbRaJ
         4GnjhEODZfxvRM1qqSfxKqHlXwhlRNS4PMwk0FUH8+miS2Whs6M/KbioR7/bufBdaRLv
         Pawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=447DttLGWlnXVhl3+i4qWwJxEj6tFprhGwRHCuyrWEY=;
        b=3yMLbhTWkwXAiC856OdvwyWfRgGJf4oOG3KNziAeGPEsCiob2b6e+bf+lqYynObwXv
         HyItYmvsm/c165+B9j/GqRnt+fjH1qY/jOjDSRsr6pNV1BIjgV9m0H4Po2XquVC56yNn
         VKiofUZ4XhTbQQrQja34HuiJkY8MjzuEU/ig6WYf0SQ0kr+jhgID3hC+dDoUoqLCQdXv
         lozZO3AG5fiVvRbSza3jV5Kg4qmq9CFsp3YyO6dcZceERTBiF4SBfnm5AAHFmKaYIh+v
         DKO4l4Ya5LsHNT4veKf1KUkjZjrnj+W7j04mjRgyaV1KDtzVwcQHNuIsaizQNb3HvOaU
         +Ekg==
X-Gm-Message-State: ACrzQf2BEv4TMahIbqoBp7ikDBhJWbbXO/FlMdbggDR1BqVA7KWb3I2G
        AeRs+zBleYsxU56GJV3Yg2Puy859SOi7c/Rnj3g=
X-Google-Smtp-Source: AMsMyM46ZboNcmcGSWOpht5nlSGISBx5S1Mp9MstxHi1WGKF0ZghqkTOrpJuyyyIK9m2Dvn/Oxb+wiykIo7nLF2GFGc=
X-Received: by 2002:ab0:25d4:0:b0:3c1:c353:31cb with SMTP id
 y20-20020ab025d4000000b003c1c35331cbmr1695763uan.63.1666103555234; Tue, 18
 Oct 2022 07:32:35 -0700 (PDT)
MIME-Version: 1.0
Sender: fadilaminumuhammad@gmail.com
Received: by 2002:a59:c924:0:b0:31b:d3d3:500e with HTTP; Tue, 18 Oct 2022
 07:32:34 -0700 (PDT)
From:   "Mrs. Margaret Christopher" <mrsmargaretchristopher001@gmail.com>
Date:   Tue, 18 Oct 2022 07:32:34 -0700
X-Google-Sender-Auth: 2uMgSEGpAVQOg6P_NNw0tWmNs1A
Message-ID: <CANJEunA-otqMRcRU-GJof=vsUt6gb0x3z2o+dq3ny0OrvzusVg@mail.gmail.com>
Subject: Humanitarian Project For Less Privileged.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Mrs. Margaret
