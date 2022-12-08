Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03AB64743D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 17:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiLHQ1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 11:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiLHQ1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 11:27:05 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15F973F52
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 08:27:03 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id j28so1059518ila.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 08:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGASGdT0r7NnaA1e4kT6G5JiKwWgMW8ILoizErp/fuA=;
        b=3cTmyGd7FiNaOd4/sthMFl990S0QTtP747E5NX3mtjTVd8iTdTnwR3pgcy/Qys0cO9
         faIqpdtoDWkJdKzd6wVT4kaXnz7ODbkhdWHZ27ATrsdgYcYqxV5K9JkSEivflyXztXXZ
         981U95OZZptesAhsvqD2D/kjcv0L0l3oxa8T7oTzk4hrRunjRckDcu+wAdA5UcanTc6p
         /jE1RH9RYBN9RCFBB4OJhSa19D6fGkEzRTO9DIccojqIVoiyQhj1GETx0KKUz12wuP3D
         bw7/TYwQGv4Zhwcgt88TAKQQxFEoGfwl3CDKVxjkuFgNu0vW3bi+64K7MXcwE6Zs19LW
         rduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGASGdT0r7NnaA1e4kT6G5JiKwWgMW8ILoizErp/fuA=;
        b=QNWrBPYwBQLjuEZfAoOCZUvHlRgSLurTmEIFySMcuIC63zI3uYNhl0iteu1O78Gno9
         V3jUKVfbLVngHiwHbKAUSQ8RuzlNulHVOKmDSUOZtiNT9bPuY9OvikDebS71nrN5TGv5
         wUlnMKYK328lnuJ6RidMl5VFIGjm12Zw7PpjrGZ42vVyvOMZixO79dMp0B6jTXuw14XP
         /PG0Djnn/3d1siaD3yxLujaStBCm4sm3dpmcDlEaHg8tOEeEJSDGXKS8gb4o2EcJuc7o
         g9kpGZkPgShazhxUfYQpn6T5DuX47KPQ3e0+vwEmDFB/q8NJy9YmQ0TYtNFL3HUvUNiy
         8fTA==
X-Gm-Message-State: ANoB5pkz1hqWtzQQSpAiRUaB16+eQi21NPY6Tmc59Kx/TmZM5ECRLtIN
        MklRwyQa5j0rmEKI7E9lYdwpWA==
X-Google-Smtp-Source: AA0mqf6Ob3YAi8F6yT37MUpRm8pcfPCY/knzinw6rL7EeVxhm+NGLSkCMgPpGmDYfDo8gge8xn3VAQ==
X-Received: by 2002:a05:6602:2109:b0:6e0:194a:4f47 with SMTP id x9-20020a056602210900b006e0194a4f47mr6359294iox.134.1670516823258;
        Thu, 08 Dec 2022 08:27:03 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id l10-20020a92d8ca000000b003030d8b3cb7sm882758ilo.42.2022.12.08.08.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:27:02 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     rostedt@goodmis.org, mhiramat@kernel.org, acme@redhat.com,
        mingo@elte.hu, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Jihong <yangjihong1@huawei.com>
In-Reply-To: <20221122040410.85113-1-yangjihong1@huawei.com>
References: <20221122040410.85113-1-yangjihong1@huawei.com>
Subject: Re: [PATCH] blktrace: Fix output non-blktrace event when blk_classic
 option enabled
Message-Id: <167051682259.135565.3126267294037734458.b4-ty@kernel.dk>
Date:   Thu, 08 Dec 2022 09:27:02 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-50ba3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Nov 2022 12:04:10 +0800, Yang Jihong wrote:
> When the blk_classic option is enabled, non-blktrace events must be
> filtered out. Otherwise, events of other types are output in the blktrace
> classic format, which is unexpected.
> 
> The problem can be triggered in the following ways:
> 
>   # echo 1 > /sys/kernel/debug/tracing/options/blk_classic
>   # echo 1 > /sys/kernel/debug/tracing/events/enable
>   # echo blk > /sys/kernel/debug/tracing/current_tracer
>   # cat /sys/kernel/debug/tracing/trace_pipe
> 
> [...]

Applied, thanks!

[1/1] blktrace: Fix output non-blktrace event when blk_classic option enabled
      commit: f596da3efaf4130ff61cd029558845808df9bf99

Best regards,
-- 
Jens Axboe


