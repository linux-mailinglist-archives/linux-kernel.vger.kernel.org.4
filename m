Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F11606591
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiJTQTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiJTQS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:18:59 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C287B18858D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:18:58 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id d26so678235ejc.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4WItWIyPgXs/R6oBIWo9I4nh7TuifrcMi4m2Jb4BDCQ=;
        b=R0iinNvADiMzfX1pv64vP7mJ9k92NZ9PYJrC9DBL8Sxx48kBI65rHgtKBpR9tzvFBu
         uHkEml7l5IKe57yZgnNyPFLUVrdVcocL6RPB0Y4IK8/jXk2M2hrNnbQSlwtyAnG25L0i
         5xzu0G/uhpHNFY52QK9wy2LJWbUz1ftE0sFt0mAB1fOC4l6VPMXUyMn9ndUK5I2pcJLc
         evp79wio1ya5Q3hPsoZIqnMXDocGfwhFKeVXdrNGWdI4CZRteAciJFb/ho4adR8IY+tr
         0ZnRObSZ1s9YHR3v8WD1Q4zcD4LEFMK8HVNkTkT2TOz8gLq5whMrYS3+Ke7ddIG7xBKO
         2fUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4WItWIyPgXs/R6oBIWo9I4nh7TuifrcMi4m2Jb4BDCQ=;
        b=V7jaofbH0GnT71ibfIOXlG/d3+VBIgJVAthwQs+bccSirscv/cantGksa6YDgd9YKs
         0ZRbDRiQN/Tgdg7BxAby3qM7w+2kwTYtQXRpWe0WiT21tnDiQ4rHRZRd6IC6d9+3QEaO
         qD7HaYXpB72BMfMV+AL3frjFHOSPzVB0lhcU7pr0J2hN7000Hg16O/gbILmZLdi5y0J8
         XlfoNsNZs6GVyIRW5UY52N4gs4Jc5sJXASQ2zczSfeVKDlanTzZZKV9m/6fkIuintyov
         2RJYruUOyXzoW7oDbB6bTwWAqMowq9xHTo2O1gdEg4Tx8ICfotPCfV+KVY2DYqFUXV/9
         2v4g==
X-Gm-Message-State: ACrzQf2Abyj0Kb7pb3K1GUc5QoaTJjoFfqbdsilS9qq1A8VxGidvcIK+
        DTUI3K6Ty91K6em1fU45uJbh++2MmQfKeKKwmtIzVwXDXPBjuA==
X-Google-Smtp-Source: AMsMyM7tMEvGlLOgkP3LxInWjp4wp4/OOeicynT0n8ZD3NJXOvefXEy70Vd0E9wPHTMVkFhbOR+Hzj3MVIobKHcs47Q=
X-Received: by 2002:a17:906:fe46:b0:73d:939a:ec99 with SMTP id
 wz6-20020a170906fe4600b0073d939aec99mr11847467ejb.169.1666282726653; Thu, 20
 Oct 2022 09:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20221019195815.1298915-1-dionnaglaze@google.com> <3265d311-0e02-6e98-377a-d93a5d0b90cc@amd.com>
In-Reply-To: <3265d311-0e02-6e98-377a-d93a5d0b90cc@amd.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Thu, 20 Oct 2022 09:18:35 -0700
Message-ID: <CAAH4kHZy-tBzsDUzK+N8_F8AyZP1cvX8zt47_m6eAMw5=QqrEg@mail.gmail.com>
Subject: Re: [PATCH v2] virt/coco/sev-guest: Remove err in handle_guest_request
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> You should include a Fixes: tag.
>
> With that,
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
>
> Also, you may want to base your other series [1] on this one, since you'll
> likely get conflicts if this is applied first.
>
> [1] https://lore.kernel.org/lkml/20221019173537.1238121-1-dionnaglaze@google.com/
>

Let's call this a wash and I'll roll this into that other series then.
By passing through fw_err directly, I get an unsigned long vs unsigned
long long type error (in this v2, mea culpa). So I'll put the rename
and re-typing in the x86 patch before this one.

-- 
-Dionna Glaze, PhD (she/her)
