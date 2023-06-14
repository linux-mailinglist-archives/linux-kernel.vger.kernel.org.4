Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030AB730557
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbjFNQqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236260AbjFNQqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:46:04 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CCF2963
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:45:49 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1a98cf01151so266348fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1686761149; x=1689353149;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pI6QVNoo9K2g9uwZ4VUxHno7kwms3nGxJzTsQ2Z92EU=;
        b=3paQk9bb5D5ndexZa/YdV9X07Z9yzNPgfgLt7KTRPie2JDD66FEj9CxqRyIw/7gRbk
         LU1pP1dkyRj20Rt+ONd/mOwo6X3OCFs8zF+5k45ZIMIcgKXQU8S/Zc9SMNacJ1uEdxz5
         B4QAvgM6OwgihGjjJ9n9fOroxmslA+N1pFbhNry6hBTVqILLqn7j6kZmhQBQDU4wGhgX
         MZEW/eLCWelfb7deBGnr3pR9zelSQ1z+1wE4JZFQqzQXcEtM48zLC3D77PQXH6tzEny4
         NS2XTQVWrmBsUUVatLfkfkFX9+XH0mm/NwK77+ZR/Qvd+pRXvD2j7jfk6my8IVb15vqY
         d3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686761149; x=1689353149;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pI6QVNoo9K2g9uwZ4VUxHno7kwms3nGxJzTsQ2Z92EU=;
        b=a/6YbYfz1J0shkiFjLeRhSdMC/angb6ZmXETuPIEiRj/mRJxDxxll3g5Vtr4mJg9er
         EyeX5Ngj8F2+oeE5NnHdr2h0HzL0aZOKYnMYS8x/RWekY/PAFbgu83qMBtn1oEbJtqvB
         H/5zckItEjR+DzW78B8MGYCjCea8pypgs40IKgkiSuAYE7Yel7sw9Ue39acONUbOmEov
         7qTSWg+eb3TglHfTVu6UNz7ewJTld4iV3zyB+oXDmAwePp4cPNipivG7pR/nev2KSQOI
         phhT8IRI04G1pL9mqMqOTaggIaJI2C+1HbSg/RcvhJ+NS+ozmjRqAmR7GOZz7vap/en6
         IsFg==
X-Gm-Message-State: AC+VfDyclZkbXs7GlM4y/7MGlILYgFP4PTnkJJi1URVUY9gFq+L5LWm8
        h+ALz02DVsgNAror6/wsX2b1fQ==
X-Google-Smtp-Source: ACHHUZ7aZxXTxhB8lC3K3k64H4c3mdgU54OpyD9XFiYMm/doS1FVq6CBIp+TOcFfSSshLcVSAuqq/w==
X-Received: by 2002:a05:6870:772d:b0:184:39e3:9c85 with SMTP id dw45-20020a056870772d00b0018439e39c85mr11654364oab.29.1686761148899;
        Wed, 14 Jun 2023 09:45:48 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:90ea:5d38:822c:1759? ([2804:14d:5c5e:44fb:90ea:5d38:822c:1759])
        by smtp.gmail.com with ESMTPSA id le13-20020a0568700c0d00b001a8f6be7debsm614480oab.28.2023.06.14.09.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 09:45:48 -0700 (PDT)
Message-ID: <02c5d2f3-225f-fd56-6540-00a80326d07f@mojatatu.com>
Date:   Wed, 14 Jun 2023 13:45:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 net-next 9/9] selftests/tc-testing: verify that a qdisc
 can be grafted onto a taprio class
Content-Language: en-US
To:     Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Maxim Georgiev <glipus@gmail.com>
References: <20230613215440.2465708-1-vladimir.oltean@nxp.com>
 <20230613215440.2465708-10-vladimir.oltean@nxp.com>
From:   Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20230613215440.2465708-10-vladimir.oltean@nxp.com>
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

On 13/06/2023 18:54, Vladimir Oltean wrote:
> The reason behind commit af7b29b1deaa ("Revert "net/sched: taprio: make
> qdisc_leaf() see the per-netdev-queue pfifo child qdiscs"") was that the
> patch it reverted caused a crash when attaching a CBS shaper to one of
> the taprio classes. Prevent that from happening again by adding a test
> case for it, which now passes correctly in both offload and software
> modes.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Other than the comment below,

Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>

> ---
> v1->v2: patch is new
> 
>   .../tc-testing/tc-tests/qdiscs/taprio.json    | 50 +++++++++++++++++++
>   1 file changed, 50 insertions(+)
> 
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
> index 58d4d97f4499..47692335bcf1 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
> @@ -179,5 +179,55 @@
>               "$TC qdisc del dev $ETH root",
>               "echo \"1\" > /sys/bus/netdevsim/del_device"
>           ]
> +    },
> +    {
> +        "id": "a7bf",
> +        "name": "Graft cbs as child of software taprio",
> +        "category": [
> +            "qdisc",
> +            "taprio",
> +            "cbs"
> +        ],
> +        "plugins": {
> +            "requires": "nsPlugin"
> +        },
> +        "setup": [
> +            "echo \"1 1 8\" > /sys/bus/netdevsim/new_device",
> +            "$TC qdisc replace dev $ETH handle 8001: parent root stab overhead 24 taprio num_tc 8 map 0 1 2 3 4 5 6 7 queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 base-time 0 sched-entry S ff 20000000 clockid CLOCK_TAI"
> +        ],
> +        "cmdUnderTest": "$TC qdisc replace dev $ETH handle 8002: parent 8001:8 cbs idleslope 20000 sendslope -980000 hicredit 30 locredit -1470",
> +        "expExitCode": "0",
> +        "verifyCmd": "$TC -d qdisc show dev $ETH",
> +        "matchPattern": "qdisc cbs 8002: parent 8001:8 hicredit 30 locredit -1470 sendslope -980000 idleslope 20000 offload 0",
> +        "matchCount": "1",
> +        "teardown": [
> +            "$TC qdisc del dev $ETH root",
> +            "echo \"1\" > /sys/bus/netdevsim/del_device"
> +        ]
> +    },
> +    {
> +        "id": "6a83",
> +        "name": "Graft cbs as child of offloaded taprio",
> +        "category": [
> +            "qdisc",
> +            "taprio",
> +            "cbs"
> +        ],
> +        "plugins": {
> +            "requires": "nsPlugin"
> +        },
> +        "setup": [
> +            "echo \"1 1 8\" > /sys/bus/netdevsim/new_device",
> +            "$TC qdisc replace dev $ETH handle 8001: parent root stab overhead 24 taprio num_tc 8 map 0 1 2 3 4 5 6 7 queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 base-time 0 sched-entry S ff 20000000 flags 0x2"
> +        ],
> +        "cmdUnderTest": "$TC qdisc replace dev $ETH handle 8002: parent 8001:8 cbs idleslope 20000 sendslope -980000 hicredit 30 locredit -1470",
> +        "expExitCode": "0",
> +        "verifyCmd": "$TC -d qdisc show dev $ETH",
> +        "matchPattern": "qdisc cbs 8002: parent 8001:8 hicredit 30 locredit -1470 sendslope -980000 idleslope 20000 offload 0",

Seems like this test is missing the 'refcnt 2' in the match pattern

> +        "matchCount": "1",
> +        "teardown": [
> +            "$TC qdisc del dev $ETH root",
> +            "echo \"1\" > /sys/bus/netdevsim/del_device"
> +        ]
>       }
>   ]

