Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57586DE447
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 20:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjDKSsv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Apr 2023 14:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjDKSsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 14:48:50 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797E5ED;
        Tue, 11 Apr 2023 11:48:48 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id xi5so22868128ejb.13;
        Tue, 11 Apr 2023 11:48:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681238927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54x2/JEYvrEaTJN6DA0aT7kGvHFezMNdw96cOJ35X8U=;
        b=whj3PNA8gLidG0t55FWke3UR35tntZvGyt8o5+uie4yfmSxPn0ZWOtHWV1rWV0WrZZ
         WoVntQRyrDMae2yu3dLPuVxtMSACz4RKKitcyGK6K7jJOr36SzfBH1A7sHV3nQHTK6/Q
         nYfahZHjZgacJRQz6pztk811MDcUgp8v0iStAXRg1wg/Hjv7VZtoIb695Kt8i5OWc4cJ
         1nBRahq9OUnobS9NdV+k5S+mddj6y6EQ7eUJjaV3qYPmdwHqdnKHdWDt+Cies3Qjjjrt
         8iDth1EM2H6hyGD2QbgFnGEBKhR+Yz6Jsx3u8L3Vwz9bmDZ4uWauCzxkRkc/ftYFi3fk
         7yWQ==
X-Gm-Message-State: AAQBX9fPzf2SKsUJ8qzGUxJlCLS7+M+4sPAajkezvEW9h/f21qyL/xUd
        eAxoQCA0G39mIoOy1pNEBYrhWLgA3G9Q4FVLMg8=
X-Google-Smtp-Source: AKy350YMs966rOFQtr0MX8U+jH+zF0ZJeFHJbznuryh3OaRaTeVGmIWnhp7JUtW+QFFxc14yVViuPq2ENcIfMTkRlxI=
X-Received: by 2002:a17:906:f6ce:b0:947:f389:58ca with SMTP id
 jo14-20020a170906f6ce00b00947f38958camr111936ejb.2.1681238926956; Tue, 11 Apr
 2023 11:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230404003337.1912901-1-trix@redhat.com>
In-Reply-To: <20230404003337.1912901-1-trix@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Apr 2023 20:48:35 +0200
Message-ID: <CAJZ5v0hZazpNfBBEs9U=YAfRdH6o7y77-sowRue0RFkohGDXZw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: amd-pstate: set varaiable mode_state_machine
 storage-class-specifier to static
To:     Tom Rix <trix@redhat.com>
Cc:     ray.huang@amd.com, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023 at 2:33 AM Tom Rix <trix@redhat.com> wrote:
>
> smatch reports
> drivers/cpufreq/amd-pstate.c:907:25: warning: symbol
>   'mode_state_machine' was not declared. Should it be static?
>
> This variable is only used in one file so it should be static.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 6f4b8040d46c..5a3d4aa0f45a 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -904,7 +904,7 @@ static int amd_pstate_change_driver_mode(int mode)
>         return 0;
>  }
>
> -cppc_mode_transition_fn mode_state_machine[AMD_PSTATE_MAX][AMD_PSTATE_MAX] = {
> +static cppc_mode_transition_fn mode_state_machine[AMD_PSTATE_MAX][AMD_PSTATE_MAX] = {
>         [AMD_PSTATE_DISABLE]         = {
>                 [AMD_PSTATE_DISABLE]     = NULL,
>                 [AMD_PSTATE_PASSIVE]     = amd_pstate_register_driver,
> --

Applied as 6.4 material (under edited subject), thanks!
