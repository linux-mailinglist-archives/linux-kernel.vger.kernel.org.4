Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F7C61F0F0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbiKGKlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKGKlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:41:12 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1311900F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 02:41:11 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id q9so10210170pfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 02:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEufRRTntxUkAcRUT4L6QYUBosoXo1+hroxdMyZBxDM=;
        b=PnA7GFo5D4nL5XJOksZE+4RMVKV1U1CG4zXsx57EcIlt9icfkb7RUA5IIX/o3vgaoZ
         G0opN7HkRFnO7nm+8ZGa+XxvIqo5XHIrxCx7H/eEx/tQCMEcVfiZZED7MJ8oRm6cKi30
         HrS4ZvKKENQznAXWQvY4AB/vLUrOFMLGSMgLKYh98BrPwG2kXApk8ftTAPU0I+OaOJr7
         YV6EBkPi9bZ3vio2fjKOF6So3GFVqI12Nh0dOIachekWDdMjPDE8SP3x2px2tnm0TX7l
         99E6zxEp0XUsPhy+WOtczf4t7kr61pt6VQqbb9GCNrEAW3XlPUfqK2w7XUWiH37zLkG9
         OdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tEufRRTntxUkAcRUT4L6QYUBosoXo1+hroxdMyZBxDM=;
        b=PeT/8BL0yxqAZoF+vx4ZYU5qxc4xIbOoH4fu0k9J9IZnzp/23uGlwq7REyN4Al+TS/
         A5eSxtc5h/CeYaY4k2D0YBsrejuDXX8I9ll5PyJOs3OW92ukeXiiEnn81+O6owQDorja
         BQFUpCDVe0TMcFo8wKAuwLnttxYQSu4kRbg4Suw3E3bZIjvkPoPz1W2zaBbVqqv6y1De
         jGoAZPKCnOuHIunIxR2Csvwr4Xd4GXINZBl4LUlT0JZZKjh9njXCBDtA4Ay/tFHF97Am
         UT/8DChaYwczWpB85a1VN99wWcJKsJinRv3CEzyzgTx0Z1un6eTUIwngduRwUlrJOUqL
         tNDQ==
X-Gm-Message-State: ACrzQf31CvPQzq9e/F9q9bOTVrwIWke7UmALY9eisMKGu+cGVgZXsUdj
        0YOCyFbnFmw8gxQ70lbwdHQ=
X-Google-Smtp-Source: AMsMyM5+h/uaeniMLrEluJC846E6MxmoYkm+Ihy2TQJwnEL1nL5fIMZsQYtxGfNvPQtJ86tJ23EtXg==
X-Received: by 2002:a05:6a00:1348:b0:56b:f5c0:1d9d with SMTP id k8-20020a056a00134800b0056bf5c01d9dmr49735461pfu.45.1667817670873;
        Mon, 07 Nov 2022 02:41:10 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id l5-20020a622505000000b0056be1581126sm4317626pfl.143.2022.11.07.02.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 02:41:09 -0800 (PST)
Message-ID: <d33440f6-40cf-9747-3340-e54ffaf7afb8@gmail.com>
Date:   Mon, 7 Nov 2022 19:41:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
        Akira Yokosawa <akiyks@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: Duplicate kernel-doc comments for ksize()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

"make htmldocs" reports duplicate C declaration of ksize()
as follows:

/linux/Documentation/core-api/mm-api:43: ./mm/slab_common.c:1428: WARNING: Duplicate C declaration, also defined at core-api/mm-api:212.
Declaration is '.. c:function:: size_t ksize (const void *objp)'.

This is due to the kernel-doc comment for ksize() added in
include/linux/slab.h by a commit you have authored:
  05a940656e1e ("slab:Introduce kmalloc_size_roundup()").

/**
 * ksize - Report actual allocation size of associated object
 *
 * @objp: Pointer returned from a prior kmalloc()-family allocation.
 *
 * This should not be used for writing beyond the originally requested
 * allocation size. Either use krealloc() or round up the allocation size
 * with kmalloc_size_roundup() prior to allocation. If this is used to
 * access beyond the originally requested allocation size, UBSAN_BOUNDS
 * and/or FORTIFY_SOURCE may trip, since they only know about the
 * originally allocated size via the __alloc_size attribute.
 */

There is another kernel-doc comment in mm/slab_common.c (originally
by Manfred, since v2.6.14):

/**
 * ksize - get the actual amount of memory allocated for a given object
 * @objp: Pointer to the object
 *
 * kmalloc may internally round up allocations and return more memory
 * than requested. ksize() can be used to determine the actual amount of
 * memory allocated. The caller may use this additional memory, even though
 * a smaller amount of memory was initially specified with the kmalloc call.
 * The caller must guarantee that objp points to a valid object previously
 * allocated with either kmalloc() or kmem_cache_alloc(). The object
 * must not be freed during the duration of the call.
 *
 * Return: size of the actual memory used by @objp in bytes
 */

I guess the one in slab_common.c is outdated and can be removed.
Can you please take care of it?

        Thanks, Akira
