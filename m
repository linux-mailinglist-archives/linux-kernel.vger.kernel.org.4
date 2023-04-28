Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC8B6F1080
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 04:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344779AbjD1Cpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 22:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344379AbjD1Cpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 22:45:43 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23122703
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 19:45:41 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 41be03b00d2f7-51fdc1a1270so6672498a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 19:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682649941; x=1685241941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shkjoVKKITZ/5MAi+590OVZBJeowg3PtxdqAgmyjXno=;
        b=VExamBjAnyZ80vWcAl4/fkj+50jfIxFs01f7YACx4pUWweT2aOR13h5b/W1PYkE5ca
         TWUK6/bJ/CSrRqD5DtY4G+eeg/G7euJKNdYbHrh2X8T2R8qXFQmmDsE9dHGdzXZa3+ui
         SgdfBoBjQAhiOHkBwpQevSg9hkw+ZEEIp6JEXoK8nA+VWLswl+/M63aZ2buaDT0UVApf
         Tlq7h/F0M1Y9lkbgKYIvLugTaBGCQreNeKIdH2onO7GBSQsZzpfo6Fh3P5Sf24Hm4hb1
         zxTwDCRxBDJTUI2NtK1iWyLIycJVhs9D7OS5rel3yKXYW9FbdPrXt+xg9icLPMlcED8y
         JkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682649941; x=1685241941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=shkjoVKKITZ/5MAi+590OVZBJeowg3PtxdqAgmyjXno=;
        b=alx/pvnQLklOLU2coZBX7Odq3jJwNRcEl5c71dMmNEMtGGn3FJVNASQsY9c3fkmW3d
         84gM3drWQFHUK7i8Jj0CxI7z4NiNzecPeIzhA0t2JtRkRYtyjt3H1AS3jsEKUD0LAMHf
         tWJCjQsWqF0uMBkzfdjDwKZKh2HQKfiupudSabxB+dhU8De+H9sPdfIpCk77GwaiTDbF
         DKMQFUyOUxYIWQ0lq+uUGO/IuKce6MafZrTnYf6VD8RlNggKrtMgWjwpPuPpikYdtkcI
         P7EL6rku226YQW8m7Cm1VImn+tv4WWI6p3yg3jr0gJl1fXM34sNv27miAzH6rnTQhCt7
         smyg==
X-Gm-Message-State: AC+VfDzoeerMOSVFcQQQNha/FcbhhO5MIdPaNthlUVCoF+tsuU6NLrw2
        Le6amxOJ3AmBsm3khGbyazVCjQz3ApPpl5u2
X-Google-Smtp-Source: ACHHUZ58/0I26sE/2t6q2i3j0e5GQCEuSI5keu9kzniMU/YbvkwOmwqvpo58DO1Qf0gVbc/SPM0Xtw==
X-Received: by 2002:a05:6a20:8412:b0:f3:ac88:c048 with SMTP id c18-20020a056a20841200b000f3ac88c048mr4869137pzd.7.1682649941127;
        Thu, 27 Apr 2023 19:45:41 -0700 (PDT)
Received: from [10.200.10.82] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id e27-20020a630f1b000000b00502e7115cbdsm3996427pgl.51.2023.04.27.19.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 19:45:40 -0700 (PDT)
Message-ID: <c7cb9cc6-591b-413a-2df1-4001ee41dea8@gmail.com>
Date:   Fri, 28 Apr 2023 10:45:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH 21/34] maple_tree: mas_start() reset depth on dead node
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
 <20230425140955.3834476-22-Liam.Howlett@oracle.com>
From:   Peng Zhang <perlyzhang@gmail.com>
In-Reply-To: <20230425140955.3834476-22-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/4/25 22:09, Liam R. Howlett 写道:
> When a dead node is detected, the depth has already been set to 1 so
> reset it to 0.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>   lib/maple_tree.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 35c6e12ca9482..1542274dc2b7f 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -1397,9 +1397,9 @@ static inline struct maple_enode *mas_start(struct ma_state *mas)
>   
>   		mas->min = 0;
>   		mas->max = ULONG_MAX;
> -		mas->depth = 0;
>   
>   retry:
> +		mas->depth = 0;
>   		root = mas_root(mas);
>   		/* Tree with nodes */
>   		if (likely(xa_is_node(root))) {
