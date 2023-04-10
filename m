Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10376DCDAF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 00:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjDJWwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 18:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDJWwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 18:52:10 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AAA1BF1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 15:52:09 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-3287544f0a0so354745ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 15:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1681167128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dCML3GJo02sARUkxvxRac8szR5Qx0GytecSMuFd6SAA=;
        b=KSLa8ViMmYi89N65o0Yb2S2iJIqfk1oDmEi1G2YTQS/ZiNn88L2/qF38e4hVTyqJq3
         FReKiq72zo5KiQ1SMH7f+TmoiNsCa6eGaonecUMzLu/tGB+rVALNEmv6Get4lUNBzLgi
         F9wytHwU+xqnVhCldItDFsKsL15huyEPV6scg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681167128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dCML3GJo02sARUkxvxRac8szR5Qx0GytecSMuFd6SAA=;
        b=wWIlr5+87YAXCjcQbVCbzEdv0W8aPgbnUeLKfuYAHvB8VIqdx/7iFm3RwSN2Tuz9ye
         sfV7KQP2hPiCB0K2iFXjv6RBRp+1Evj1abc6ewu+jwlCPhWK72Pmd6M2HuZDVgrX3xT+
         KcvbdLPgcI+jrVROFL8LsAKIw2ksqqbmOD/uKFj2kPkSNDyHixrz7AsQaDH/8WxBOmX+
         ltI/GhnoHaWKWYOnmE5N8bdnK1mGpOsx/czJvrLO+wlnXqu0a/r3nxeXMw4qHMKdOCf8
         Yd0fur/Q6Xki31vUxAhirSdSpYqCXpbTj/fULN1+BNHZYrTcp7ZJPtDQ2L7EQJibCzjk
         Zm5Q==
X-Gm-Message-State: AAQBX9eJAPaaAqpIIeAl7bjOoo+4MzA/C9HRNySHshUPxszJkzHOrMR+
        btikep9lgVhfgZr7dGZSYuQGZw==
X-Google-Smtp-Source: AKy350ZkD+sGvf5Y8EIkzwr+3AVQrX7AGboJvNIy0Gf8aQFPeYv2t0ztn6JQ83CpFrYnM4YptngO4g==
X-Received: by 2002:a05:6e02:1182:b0:326:1778:fae3 with SMTP id y2-20020a056e02118200b003261778fae3mr3569097ili.2.1681167128633;
        Mon, 10 Apr 2023 15:52:08 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id e32-20020a026d60000000b003bf39936d1esm3517089jaf.131.2023.04.10.15.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 15:52:08 -0700 (PDT)
Message-ID: <0197f2b8-96a3-22f6-aa14-960afdfd2e8d@linuxfoundation.org>
Date:   Mon, 10 Apr 2023 16:52:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] cpupower: Fix cpuidle_set to accept only numeric
 values for idle-set operation.
Content-Language: en-US
To:     Korrapati Likhitha <likhitha@linux.ibm.com>, shuah@kernel.org,
        trenn@suse.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ricklind@linux.vnet.ibm.com, latha@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com,
        Pavithra Prakash <pavrampu@linux.vnet.ibm.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230410121054.61622-1-likhitha@linux.ibm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230410121054.61622-1-likhitha@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/23 06:10, Korrapati Likhitha wrote:
> From: Likhitha Korrapati <likhitha@linux.ibm.com>
> 
> For both the d and e options in 'cpupower idle_set' command, an
> atoi() conversion is done without checking if the input argument
> is all numeric. So, an atoi conversion is done on any character
> provided as input and the CPU idle_set operation continues with
> that integer value, which may not be what is intended or entirely
> correct.
> 
> The output of cpuidle-set before patch is as follows:
> 
> [root@xxx cpupower]# cpupower idle-set -e 1$
> Idlestate 1 enabled on CPU 0
> [snip]
> Idlestate 1 enabled on CPU 47
> 
> [root@xxx cpupower]# cpupower idle-set -e 11
> Idlestate 11 not available on CPU 0
> [snip]
> Idlestate 11 not available on CPU 47
> 
> [root@xxx cpupower]# cpupower idle-set -d 12
> Idlestate 12 not available on CPU 0
> [snip]
> Idlestate 12 not available on CPU 47
> 
> [root@xxx cpupower]# cpupower idle-set -d qw
> Idlestate 0 disabled on CPU 0
> [snip]
> Idlestate 0 disabled on CPU 47
> 
> This patch adds a check for both d and e options in cpuidle-set.c
> to see that the idle_set value is all numeric before doing a
> string-to-int conversion.
> 
> The output of cpuidle-set after the patch is as below:
> 
> [root@xxx cpupower]# ./cpupower idle-set -e 1$
> Bad idle_set value: 1$. Integer expected
> 
> [root@xxx cpupower]# ./cpupower idle-set -e 11
> Idlestate 11 not available on CPU 0
> [snip]
> Idlestate 11 not available on CPU 47
> 
> [root@xxx cpupower]# ./cpupower idle-set -d 12
> Idlestate 12 not available on CPU 0
> [snip]
> Idlestate 12 not available on CPU 47
> 
> [root@xxx cpupower]# ./cpupower idle-set -d qw
> Bad idle_set value: qw. Integer expected
> 
> Signed-off-by: Likhitha Korrapati <likhitha@linux.ibm.com>
> Signed-off-by: Brahadambal Srinivasan <latha@linux.vnet.ibm.com>
> Reported-by: Pavithra Prakash <pavrampu@linux.vnet.ibm.com>
> Reviewed-by: Rick Lindsley <ricklind@linux.vnet.ibm.com>
> ---
> 
> ** changes since v1 [1] **
> 
> - Addressed reviewed comments from v1.
> - Slightly reworded the commit for clarity.
> 
> [1] https://lore.kernel.org/all/20210105122452.8687-1-latha@linux.vnet.ibm.com/
> 
>   tools/power/cpupower/utils/cpuidle-set.c     | 25 ++++++++++++++++----
>   tools/power/cpupower/utils/helpers/helpers.h |  8 +++++++
>   tools/power/cpupower/utils/helpers/misc.c    | 17 +++++++++++++
>   3 files changed, 45 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/cpuidle-set.c b/tools/power/cpupower/utils/cpuidle-set.c
> index 46158928f9ad..1bfe16d27c2d 100644
> --- a/tools/power/cpupower/utils/cpuidle-set.c
> +++ b/tools/power/cpupower/utils/cpuidle-set.c
> @@ -47,7 +47,12 @@ int cmd_idle_set(int argc, char **argv)
>   				break;
>   			}
>   			param = ret;
> -			idlestate = atoi(optarg);
> +			if (is_stringnumeric(optarg))
> +				idlestate = atoi(optarg);
> +			else {
> +				printf(_("Bad idle_set value: %s. Integer expected\n"), optarg);
> +				exit(EXIT_FAILURE);
> +			}

Why can't we do this once instead of duplicating the code under
'd' and 'e'

Also have you tried using isdigit(idlestate) - works just fine
for me.

diff --git a/tools/power/cpupower/utils/cpuidle-set.c b/tools/power/cpupower/utils/cpuidle-set.c
index 46158928f9ad..01b344efc1b1 100644
--- a/tools/power/cpupower/utils/cpuidle-set.c
+++ b/tools/power/cpupower/utils/cpuidle-set.c
@@ -95,6 +95,11 @@ int cmd_idle_set(int argc, char **argv)
  		exit(EXIT_FAILURE);
  	}
  
+	if(!isdigit(idlestate)) {
+		printf("invalid idlestate specified\n");
+		exit(EXIT_FAILURE);
+	}
+
  	get_cpustate();
  
  	/* Default is: set all CPUs */

thanks,
-- Shuah
