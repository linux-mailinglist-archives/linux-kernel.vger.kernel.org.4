Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5246C736DC7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjFTNtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjFTNtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:49:12 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74422199E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:48:46 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-394c7ba4cb5so3098680b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1687268922; x=1689860922;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+jt+SNzQ8YIqdLszSLIQQyO/8zI8n98Rb2yilfjw5wo=;
        b=jduEXgKYsNDsu2ckNG79TINq2X4lSM7gPrBzARw0VICuNXmyAotvfddwp0q0zEtotQ
         C1Mdff2m3PWr89pG8I3LIr2mT+tq4x5MkKqsJ/zU8ZmqgEQnU/2J1+ARrxXaOYmpIS1D
         KBU4sPWGLervVqZzr44+cVBBCvm767aobmTKAGjdpQF1+27LGg/alyOiouiS3aGVgyIc
         tJsD/ymJ7JhXcN6OFJqGt3VHTDGcR6nFjA559CJHGViymtxY924WaxpAkMYt3oK9EaXR
         cKXMwkbyuRnCSFc11Cru7rJ7TgInUYt/drgDdnMUgRLS0Ok+LOjUU63jQupCXCrOK7od
         dQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687268922; x=1689860922;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+jt+SNzQ8YIqdLszSLIQQyO/8zI8n98Rb2yilfjw5wo=;
        b=Ff6kxTUIY0HrP8m6IcDi6n45NVIa+Xp9XXV5F5lUjKaUyeLqETO0b7rcYalR9LHXt5
         PlLFZOMXMSAEgM/sYlNkDvFOSSQbJRKgFJ9+OTiPHC+4tVv7wA6Z9vCebSxc/7UklHnb
         LwLm2K2K/47V4azxt9LexKi+cYm0uX9pTc5epOaVdBJKSNyHqcAiDdKro3D2z/B7Cf92
         0lLcI35eQxkd1xU2FzjjQlI02EzTXhmo+RR6ircCIWHLfqtA4OcV/cZs0P3adM4O8BJ4
         zDR7tN4VbfAjTH47RnEqf5ACQnEfeKSdl4g2aO3JvKdm4XNB+HrdkNUIUwNkuTylazIj
         yQnA==
X-Gm-Message-State: AC+VfDwMcTndpDrRnL8fKodZzu+TzMFgcmGDzQF1AzPjyHJE8ZA8cp+T
        O5OP04DSv31FhGLQnOBCGtnNBA==
X-Google-Smtp-Source: ACHHUZ6+No+cDZa9+m5diqZQ/9ogy+uAoZXkrMwEDwbgEmrstvSYDeA8mmmDvB3/hFrEr+0KWrbEeA==
X-Received: by 2002:aca:1115:0:b0:39e:cdb4:c469 with SMTP id 21-20020aca1115000000b0039ecdb4c469mr8541279oir.32.1687268922396;
        Tue, 20 Jun 2023 06:48:42 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:687e:840c:e7bd:8b4a? ([2804:14d:5c5e:44fb:687e:840c:e7bd:8b4a])
        by smtp.gmail.com with ESMTPSA id t3-20020a05680800c300b0039a41b57e07sm1058660oic.39.2023.06.20.06.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 06:48:42 -0700 (PDT)
Message-ID: <d893715c-2eea-6dc3-ca27-b19535194a60@mojatatu.com>
Date:   Tue, 20 Jun 2023 10:48:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] selftests: tc-testing: add one test for flushing
 explicitly created chain
Content-Language: en-US
To:     renmingshuai <renmingshuai@huawei.com>, vladbu@nvidia.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     liaichun@huawei.com, caowangbao@huawei.com, yanan@huawei.com,
        liubo335@huawei.com
References: <20230620014939.2034054-1-renmingshuai@huawei.com>
From:   Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20230620014939.2034054-1-renmingshuai@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2023 22:49, renmingshuai wrote:
> Add the test for additional reference to chains that are explicitly created
>   by RTM_NEWCHAIN message.
> The test result:
> 1..1
> ok 1 c2b4 - soft lockup alarm will be not generated after delete the prio 0
>   filter of the chain
> 
> commit c9a82bec02c3 ("net/sched: cls_api: Fix lockup on flushing explicitly
>   created chain")
> Signed-off-by: Mingshuai Ren <renmingshuai@huawei.com>

Acked-by: Pedro Tammela <pctammela@mojatatu.com>

> 
> ---
> V1 -> V2
>    * add the test result
> ---
>   .../tc-testing/tc-tests/infra/filter.json     | 25 +++++++++++++++++++
>   1 file changed, 25 insertions(+)
>   create mode 100644 tools/testing/selftests/tc-testing/tc-tests/infra/filter.json
> 
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/filter.json b/tools/testing/selftests/tc-testing/tc-tests/infra/filter.json
> new file mode 100644
> index 000000000000..c4c778e83da2
> --- /dev/null
> +++ b/tools/testing/selftests/tc-testing/tc-tests/infra/filter.json
> @@ -0,0 +1,25 @@
> +[
> +    {
> +        "id": "c2b4",
> +        "name": "soft lockup alarm will be not generated after delete the prio 0 filter of the chain",
> +        "category": [
> +            "filter",
> +            "chain"
> +        ],
> +        "setup": [
> +            "$IP link add dev $DUMMY type dummy || /bin/true",
> +            "$TC qdisc add dev $DUMMY root handle 1: htb default 1",
> +            "$TC chain add dev $DUMMY",
> +            "$TC filter del dev $DUMMY chain 0 parent 1: prio 0"
> +        ],
> +        "cmdUnderTest": "$TC filter add dev $DUMMY chain 0 parent 1:",
> +        "expExitCode": "2",
> +        "verifyCmd": "$TC chain ls dev $DUMMY",
> +        "matchPattern": "chain parent 1: chain 0",
> +        "matchCount": "1",
> +        "teardown": [
> +            "$TC qdisc del dev $DUMMY root handle 1: htb default 1",
> +            "$IP link del dev $DUMMY type dummy"
> +        ]
> +    }
> +]

