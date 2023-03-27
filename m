Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E51A6CAF35
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjC0TzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjC0TzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:55:04 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFE1198C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:55:03 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id bl9so4398715iob.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1679946903;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jIAxQ/0le8FlOj+IPxrPghHwfvROX6X5lZ45OBU9CpE=;
        b=ehHWsi8ogs9OJVu4wXJQKImFL6wt2lQeGAx4d5rNgRPBtYlfI3ZSnHJyzWYEXid4vD
         fs1DCNfa9aNq+LL0N8LVdciV/bUAwVt+vwObrgMCxjDnETDcFujji1OVT9XfM6WbBULd
         huMLkbreYZr6YAkEzzaxyV1sJag91j+Lcm1CA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679946903;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jIAxQ/0le8FlOj+IPxrPghHwfvROX6X5lZ45OBU9CpE=;
        b=7rmlOhunDHNGFz844dXKcNnhSLPyroGgCLS4gMm8IcPsaBExc6K/2vpnaopBf8Av2M
         GSFHiCrBTNwxM2B044ShOhsiGknjK8ARIr5d4NH5ZeAMMebsgRS3p0rVLcz1QvuazNXP
         IsMwhEXcMi0iWlPTFh+H3LkjhhsY5WUDbSTSkigl6aisjZYRoUAITfEds6ssdpwsu1fi
         OrlUupkG5CF7lNvV20aGgURX+zqH5Io3XuHaoFUibdvd5sAkkrzCuNNccumo8Isz1b+P
         d09V00GYxgYNAzp5H+ORg7TImokXVYM6mct/6RRofWqBJdpWq7kR+wm+lDGSs9UruMPM
         fUOQ==
X-Gm-Message-State: AO0yUKVob8lUd+ke0NstB/skzQHnInrXpvxKLdfAVhdI3StEEA4ek9mG
        wOF50nBiD93WX+3Bc6WSAsbwmA==
X-Google-Smtp-Source: AK7set9wLOdd/3cNTHjZbEdlZrWVXGvXa4KBBe1RdlVKD1TsBILNtisys2P7KkX7s08Vc/9+6NSAlQ==
X-Received: by 2002:a05:6602:1301:b0:758:6ae8:8e92 with SMTP id h1-20020a056602130100b007586ae88e92mr7583950iov.1.1679946902905;
        Mon, 27 Mar 2023 12:55:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id p5-20020a02b005000000b004063510ba0esm9181046jah.142.2023.03.27.12.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 12:55:02 -0700 (PDT)
Message-ID: <af254c18-d55b-7343-32f8-d24ef0072e2c@linuxfoundation.org>
Date:   Mon, 27 Mar 2023 13:55:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] selftests: sched: Add more core schedule prctl calls
Content-Language: en-US
To:     Ivan Orlov <ivan.orlov0322@gmail.com>, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        himadrispandya@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230322203724.4757-1-ivan.orlov0322@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230322203724.4757-1-ivan.orlov0322@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan,

On 3/22/23 14:37, Ivan Orlov wrote:
> The core sched kselftest makes prctl calls only with correct
> parameters. This patch will extend this test with more core
> schedule prctl calls with wrong parameters to increase code
> coverage.
> 
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>

Thank you for the patch.

> ---
>   tools/testing/selftests/sched/cs_prctl_test.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
> index 25e0d95d3713..df8e4629b3b5 100644
> --- a/tools/testing/selftests/sched/cs_prctl_test.c
> +++ b/tools/testing/selftests/sched/cs_prctl_test.c
> @@ -334,6 +334,14 @@ int main(int argc, char *argv[])
>   	validate(get_cs_cookie(pid) != 0);
>   	validate(get_cs_cookie(pid) == get_cs_cookie(procs[pidx].thr_tids[0]));
>   
> +	printf("\n## Try to pass wrong subcommand PR_SCHED_CORE_MAX = %d to prctl (shouldn't succeed)\n", PR_SCHED_CORE_MAX);

This message is unnecessary. validate() prints an error message.

> +	validate(_prctl(PR_SCHED_CORE, PR_SCHED_CORE_MAX, 0, PIDTYPE_PGID, 0) < 0
> +		&& errno == EINVAL);
> +
> +	printf("\n## Try to pass not-null uaddr with forbidden command (shouldn't succeed)\n");

Same here.

> +	validate(_prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, 0, PIDTYPE_PGID, 1) < 0
> +		&& errno == EINVAL);
> +
>   	if (errors) {
>   		printf("TESTS FAILED. errors: %d\n", errors);
>   		res = 10;

thanks,
-- Shuah
