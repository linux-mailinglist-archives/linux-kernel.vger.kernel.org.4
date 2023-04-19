Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AEE6E7CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjDSOaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbjDSO36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:29:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327F310B;
        Wed, 19 Apr 2023 07:29:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0E61611EA;
        Wed, 19 Apr 2023 14:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB3AC4339E;
        Wed, 19 Apr 2023 14:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681914596;
        bh=5N3EpBQ8+tdcc/u8S5fLufyhARxNyKuBZ4a63Z9mYzk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=haROrECKbMWvDzSoqZj35HjHmtvaR1P0XjUQG/sjtMT6x8rQAmFN1HDqOVBUU851o
         G9AaZF3b/doCKg2d09p+PDTtW8G+TP4JEh30wLzAjEibMakZ0rQoQW74xQP/ZaBxwB
         U/Fr3+MnfK5Ece24Cf42i9W1aZfh9oL6wGpqMpwI2f6CdTTaUIAxebuhdh32UDv10K
         dCyoga2HBswd8TxjDMHCkiJozVwd/FQhIWLSFA2wXrJfRRAuMpfdTW6xqD8fKRs/Vx
         aJHyB01A2E9+YmQ2/8HWotPB8Cu51iguIWyktnGhOBCe/q1/K8MO9nvQhvH4egQ6/p
         8ajZKp2eqhXzA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4ec816d64afso13649924e87.1;
        Wed, 19 Apr 2023 07:29:55 -0700 (PDT)
X-Gm-Message-State: AAQBX9dTErxG+P3la3IbvLSoxS9X8t6V2IeLyU7s1xNsIOlwncS9Ys2d
        xjnveORfzpSHaUUkrI7PpzY0HFMoCVbl9zs2JNI=
X-Google-Smtp-Source: AKy350ZYqDM7DrrNyPhusvRFrAhDByNpNuVGb4u4uuu05UYCvr8M0FQE5CYu30AqnuzlPZjcDfHISrzbNxhs13Ut3Tw=
X-Received: by 2002:a05:6512:2823:b0:4eb:412f:9e0e with SMTP id
 cf35-20020a056512282300b004eb412f9e0emr851882lfb.26.1681914594087; Wed, 19
 Apr 2023 07:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <73859c9e-dea0-4764-bf01-7ae694fa2e37@kili.mountain>
In-Reply-To: <73859c9e-dea0-4764-bf01-7ae694fa2e37@kili.mountain>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 19 Apr 2023 16:29:42 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEiF5kZvaQz5FPHONRM9WWugP4CT6yZZVDiw5=s-OZBEw@mail.gmail.com>
Message-ID: <CAMj1kXEiF5kZvaQz5FPHONRM9WWugP4CT6yZZVDiw5=s-OZBEw@mail.gmail.com>
Subject: Re: [PATCH] arm64: delete dead code in this_cpu_set_vectors()
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     James Morse <james.morse@arm.com>, Will Deacon <will@kernel.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Liu Song <liusong@linux.alibaba.com>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2023 at 09:58, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> The "slot" variable is an enum, and in this context it is an unsigned
> int.  So the type means it can never be negative and also we never pass
> invalid data to this function.  If something did pass invalid data then
> this check would be insufficient protection.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/arm64/kernel/proton-pack.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
> index fca9cc6f5581..05f40c4e18fd 100644
> --- a/arch/arm64/kernel/proton-pack.c
> +++ b/arch/arm64/kernel/proton-pack.c
> @@ -966,9 +966,6 @@ static void this_cpu_set_vectors(enum arm64_bp_harden_el1_vectors slot)
>  {
>         const char *v = arm64_get_bp_hardening_vector(slot);
>
> -       if (slot < 0)
> -               return;
> -
>         __this_cpu_write(this_cpu_vector, v);
>
>         /*
> --
> 2.39.2
>
