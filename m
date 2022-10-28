Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2547611B79
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 22:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiJ1UTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 16:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiJ1UTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 16:19:03 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD81A719B0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 13:19:02 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q1so5740144pgl.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 13:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lr8ThsJDDzI0Z5jdVGHzAGzIMwhRINT2tmxbJxyxmp0=;
        b=EovuOzEpBxjR0dVus3vtWug4Yu3hz6q/tySWF8Bk+JTOgvyOPkIGFlmLiyO6WJ65Y+
         ClNrxfVLrlUTN/cGLSyBB4HNo7KphYq/hnc/tlZbYS3lEHHv1Pt6DOePs6pOEbWAxF2p
         EbQiIr/t3pnP3/yRnENPeLs9W8/jwI1aamLlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lr8ThsJDDzI0Z5jdVGHzAGzIMwhRINT2tmxbJxyxmp0=;
        b=cbQ3sS7Tl4WUsj+7dnPjX7CnZzBo1KR+sOhqFi8Oy+gryM3K0NkCZLRo235OqDJnYV
         yQRXc7mtuEW5ZTYb06hECJkQyCBr1EWZQDivehf7pjPQzHQovA9ttDBDfxcanb6Pram5
         ua/n1ABnPtT2FN3M/fWfxYjxF2JxCg7GPB2yJQxcIBBtKvhBXZCRxrqCB2GE/faNeMMd
         5pjdbC6DVXCLhdL9W6MPLI43nvs0PEY9z/6wlzNPMAlp9RDRWFtAXpLKih3x9C9lYbhV
         QSyKHRCRN+2FmAxJTlht7KnKPpfcD0z1rmWd3W+Obt4DoEJ9OnnF03crRcgcFwCtcgHI
         6SZQ==
X-Gm-Message-State: ACrzQf1kv0nXr1TltxAJxOqjxb631f2EKPmo+DizojhqnLWjbpeeokAK
        qjKDdWU7KmHTGpu/LSTsO1pa5A==
X-Google-Smtp-Source: AMsMyM61W7V82VCMR5uiCLHAS++GSrc7zdWwll4AqAy7km0WZfca003z04JS4lv+ISAQWNODUQXuvA==
X-Received: by 2002:a63:8942:0:b0:46e:c02e:2eaf with SMTP id v63-20020a638942000000b0046ec02e2eafmr1114883pgd.394.1666988342302;
        Fri, 28 Oct 2022 13:19:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q19-20020aa78433000000b00562f6df42f1sm3188707pfn.152.2022.10.28.13.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 13:19:01 -0700 (PDT)
Date:   Fri, 28 Oct 2022 13:19:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joey Gouly <joey.gouly@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lennart Poettering <lennart@poettering.net>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Topi Miettinen <toiwoton@gmail.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-abi-devel@lists.sourceforge.net, nd@arm.com, shuah@kernel.org
Subject: Re: [PATCH v1 2/2] kselftest: vm: add tests for
 memory-deny-write-execute
Message-ID: <202210281316.C83D6B5649@keescook>
References: <20221026150457.36957-1-joey.gouly@arm.com>
 <20221026150457.36957-3-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026150457.36957-3-joey.gouly@arm.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 04:04:57PM +0100, Joey Gouly wrote:
> [...]
> +# define PR_MDWE_FLAG_MMAP              1
> [...]
> +	// Enable MDWE and then run the tests again.
> +	ret = prctl(PR_SET_MDWE, PR_MDWE_FLAG_MMAP, 0, 0, 0);
> +	if (ret < 0) {
> +		ksft_print_msg("PR_SET_MDWE failed or unsupported!\n");
> +		goto exit;
> +	}
> +
> +	ret = prctl(PR_GET_MDWE, PR_MDWE_FLAG_MMAP, 0, 0, 0);
> +	if (ret == 0)
> +		ksft_exit_fail_msg("PR_GET_MDWE failed!");

This flag (PR_MDWE_FLAG_MMAP), while defined in uapi, wasn't actually
being used in the proposed prctl() api. :)

-- 
Kees Cook
