Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DAF737798
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 00:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjFTWul convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Jun 2023 18:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjFTWuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 18:50:39 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CDD10F1;
        Tue, 20 Jun 2023 15:50:39 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-77e3ba2fbbfso127793539f.1;
        Tue, 20 Jun 2023 15:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687301438; x=1689893438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmW8lXIaP8PwEo3dSA48LLiV2xfz+uHaKuQPPpRKTPE=;
        b=ZZ7H8LAS7uaOB0/TtE6kHnwZfDKDmk9TTGCj9C57dCyzAcl8E44HFXSacFfsF2OXWr
         EeDRWwyFH5R6+mVro9ON5cKU9TiS4K4g7wKmcnR7bF+Dijtamf0C7sFY3e456amEPC37
         W9EJ785nXeCSj22iY8Si7is2ilmOnMbp8+DCvGCcEAeb+pSitK0B9LRTicuQHvFDSV2V
         gq4/8UXn09QXLXCYFKk401lZNVBxbrusIPN9ToFAjRSjpAWWS8illp7tHZf9N+boUYk3
         Y0JGsaQ0JBCTEUI8UfrvoJTa2t87Hm/Fo4pWgkPT6YiqVKCIdxO1o87UGUZcCni7tVKh
         2rYw==
X-Gm-Message-State: AC+VfDwcJZlhJTFrcA2MBpG7u3knp9WrNGXPlwY8ym5fEcp7yztF+8Cl
        gXepKBiqaVfTzRnouHGJt7SDsSHzVPhcvI9pp8/0vjyU
X-Google-Smtp-Source: ACHHUZ4anAk43NhBtl2TgAB7Q2c6dBrGPEX3igWbtzYnc3AywzQ8UqLeAW1Sul2ClLHi+Uo1Zbo8C1niYk4voog61N4=
X-Received: by 2002:a5e:db05:0:b0:778:82d1:39a3 with SMTP id
 q5-20020a5edb05000000b0077882d139a3mr12741055iop.13.1687301438410; Tue, 20
 Jun 2023 15:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230614080937.54937-1-luojianhong@cdjrlc.com> <2c733a91717eae93119ba2226420fd8f@208suo.com>
In-Reply-To: <2c733a91717eae93119ba2226420fd8f@208suo.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 20 Jun 2023 15:50:26 -0700
Message-ID: <CAM9d7chMMQcnV+hTwyEDbcQrO0ELtQTnhQ5bZptF6g_k+m0mAg@mail.gmail.com>
Subject: Re: [PATCH] perf parse-events: Remove unneeded semicolon
To:     baomingtong001@208suo.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, zhengjun.xing@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Jun 14, 2023 at 1:13 AM <baomingtong001@208suo.com> wrote:
>
> ./tools/perf/util/parse-events.c:1466:2-3: Unneeded semicolon
>
> Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
> ---
>   tools/perf/util/parse-events.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/parse-events.c
> b/tools/perf/util/parse-events.c
> index 629f7bd9fd59..42f84f61fabc 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1463,7 +1463,7 @@ static int __parse_events_add_numeric(struct
> parse_events_state *parse_state,
>       if (extended_type && (type == PERF_TYPE_HARDWARE || type ==
> PERF_TYPE_HW_CACHE)) {

The format is broken, please fix your mail client not fix wrap long lines.
This time I fixed it manually, but you need to update your config.

Thanks,
Namhyung


>           assert(perf_pmus__supports_extended_type());
>           attr.config |= (u64)extended_type << PERF_PMU_TYPE_SHIFT;
> -    };
> +    }
>
>       if (head_config) {
>           if (config_attr(&attr, head_config, parse_state->error,
