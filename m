Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B653C610ECB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiJ1KlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiJ1Kkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:40:32 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E80564F7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 03:40:27 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-13ae8117023so5809043fac.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 03:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tyImlhW5U/w4r3CMUcSsRxgN2Bc9Db0y6N98q/2n1E0=;
        b=6wl2xAI8Kw/bybkWUSqlJIkmtYMiO4vD8mzAOrtLGcat04/Lbo+hGTkyu7kEq2Vc7B
         ZEuWK/Q8Vr/gceFj85auLDbm9HdgImFszZUfz1pHT+caIJAEplOxJgekjZVmPm34tS1d
         P2Y/qZ1tNywM4IezQYvWpRkZQEqdveIFqYi/IMGB997KzqqfGl1DB7+Ewn8FwVuonimt
         Xk0P/XZVX2l+ZyLi1uB6qhKhyQAS/8zrluRwRq5IR38ZGf10cszvxPmDQA4YWzB4hp3k
         rKcTycSPuAtizgAjzym08hOwvsUXIjsiAKExxUD3eWc5FKh+4K5HBnJ9yR93K5j6RApi
         Z8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tyImlhW5U/w4r3CMUcSsRxgN2Bc9Db0y6N98q/2n1E0=;
        b=LwivAocANZ8nohXSYTlaSDr0fgGTw86fgvv80G22hm7D6BhfCdMyzXyaAq4R1ctV5P
         85b1Zl59brAxg/FTht6tL6KVH0E/evbkBI0DapEhqewbcQGzhI7c1xuyRm9qef9iHCQn
         j+PIDGJwf3IqzyBHxoggVO/aDxVoSOmkbLSHfXebMkikrgrqiIy24FTb8FP+BcxW7B58
         XMihFkn3eJktTsn2B9CLUEBDeua5w3EO7SWaoXZHkTe8sjdw2nPyaCsPRnHFB6Pdmp2/
         bwq6UssnZzOcvAOH5jfke9izP5BJdaDl4W9wi8nhD6Z34KmfEazSiCT2CGgYgTKIWBNf
         J+iQ==
X-Gm-Message-State: ACrzQf0mbAn2po+OsNkszwGRMwWna1FPKl/9tgjIxIBj/iyBcjBDUj9w
        UBt+rpYUc8gjLFcKpb8o6JKOzYTnsrkgNWBUeRW7
X-Google-Smtp-Source: AMsMyM4ZevGFeBpqW+DJ8S3551bIe2a35cE4Xe2RC2CsugCmZ45K57nKjHHFzt6+kh9nP6Z+ExWMYg0XY8SA8MF3fIw=
X-Received: by 2002:a05:6870:f299:b0:13b:ad21:934d with SMTP id
 u25-20020a056870f29900b0013bad21934dmr8665556oap.172.1666953626712; Fri, 28
 Oct 2022 03:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221026010634.2936-1-liubo03@inspur.com>
In-Reply-To: <20221026010634.2936-1-liubo03@inspur.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 28 Oct 2022 06:40:15 -0400
Message-ID: <CAHC9VhT7-tHw=Pn-Ha=6T2X8E4U3wjxDOGFKcJAS2zx7XP-Wrg@mail.gmail.com>
Subject: Re: [PATCH v2] audit: Fix some kernel-doc warnings
To:     Bo Liu <liubo03@inspur.com>
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 9:06 PM Bo Liu <liubo03@inspur.com> wrote:
>
> The current code provokes some kernel-doc warnings:
>     security/lsm_audit.c:198: warning: Function parameter or member 'ab' not described in 'dump_common_audit_data'
>
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>  security/lsm_audit.c | 1 +
>  1 file changed, 1 insertion(+)

Merged into lsm/next, thanks.

-- 
paul-moore.com
