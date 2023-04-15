Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D7C6E2E95
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 04:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjDOCYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 22:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjDOCYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 22:24:39 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C578A4EFF;
        Fri, 14 Apr 2023 19:24:38 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id kx14so298112pjb.1;
        Fri, 14 Apr 2023 19:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681525478; x=1684117478;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BqrBTsQCd1zYQLBBnbx9i78rnLPlSR69UKclBOmOyak=;
        b=V/53j83sAyKzQf0cEnoYCDALwJZ8dofdGfd2D47FMx6uKG5QS3ca5lUnhTKIGERUO7
         YPbFrcdPnTvGEEs/+6PG9aCKmsjRsmlxFuwTFmAP4sViWb2MkWBbXgxpXslmFKBsccHb
         +ZmJOjcMz2mC6+E2ZpsWg16q67ZW3UrhXRdJ34BoqofUEmKvZnXNWXJZ1rzYb4hinnxN
         NnH1jwEH2K0JR7Z7Ght4z0jnZ6y/a5TfzX9xc3g9Vi0S2bHF+y2DFufN2ynLsPITJ2R/
         ZxBjH1Hl6HvWATLlpEzoDHpAZ0GtoRSm8HQsHKthrBl6/3Ho8FMMOu4VZYKa5pZrhRjf
         Ejzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681525478; x=1684117478;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BqrBTsQCd1zYQLBBnbx9i78rnLPlSR69UKclBOmOyak=;
        b=Kz9sxZEB6v/S+ZQmscwnAU7uMRvWFkPXrzUVTmulG5CJTKsOUuUDd6LRvRwJGVjcl3
         aQoqHR3WGRgKoe6e/Rq6xJBEkYtCMfQofbnXFdkofCGzTFmRWBLuZbrffsY9uR+xgeI+
         eht1Zb6clFyZzradbg53a2xCIzhNmuEOJl3VYcEoBxLKeKMe0QkZTW2DNULavPqI9EJi
         P5ojQocY/txBLQ9eVdYDLRljXhlVWGfW8CI9y1sKcTJacVu+ZHMUOkjoOQz3UzHISN+S
         4x9Wa2KmRuUP1ECpTnaOk+zt6PaghhEiWiLk8BPuY07xAi51zVcrHlEUTBXV/sd69bvh
         lETQ==
X-Gm-Message-State: AAQBX9fwWkEt/b1phWyArA97XQ9nmB/DK2qYsFWcabgB/OpVmtV3fVtE
        tjMADGiFtlO6KQDtYUha27E=
X-Google-Smtp-Source: AKy350YVtRVHeejbHr380dl3a7mFahL3inmrQvvMV8RLOjHzafex1lS6y4tHSjBMWNkjTVqtlATpxg==
X-Received: by 2002:a17:90b:4a8f:b0:23d:29c7:916f with SMTP id lp15-20020a17090b4a8f00b0023d29c7916fmr7382073pjb.32.1681525478022;
        Fri, 14 Apr 2023 19:24:38 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-91.three.co.id. [180.214.233.91])
        by smtp.gmail.com with ESMTPSA id a11-20020a17090aa50b00b002470e095920sm3313017pjq.40.2023.04.14.19.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 19:24:37 -0700 (PDT)
Message-ID: <cf4fdb30-6f2e-ca3e-fbc0-b48f6949508d@gmail.com>
Date:   Sat, 15 Apr 2023 09:24:28 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2.1 2/2] x86/Documentation: Add documentation about
 cluster
To:     K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, corbet@lwn.net,
        jgross@suse.com, andrew.cooper3@citrix.com, peterz@infradead.org,
        Jason@zx2c4.com, thomas.lendacky@amd.com, puwen@hygon.cn,
        x86@kernel.org, linux-doc@vger.kernel.org, oleksandr@natalenko.name
References: <20230413172918.1500-3-kprateek.nayak@amd.com>
 <20230414031743.875-1-kprateek.nayak@amd.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230414031743.875-1-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/23 10:17, K Prateek Nayak wrote:
> +  - cluster_id:
> +
> +    A per-CPU variable containing:
> +
> +      - Upper bits extracted from the APIC ID.  CPUs which have the same value
> +        in these bits share an L2 and have the same cluster_id.
> +
> +        CPUs for which cluster information is unavailable will show 65535
> +        (BAD_APICID) as the cluster_id.

"... return cluster_id of 65535 (BAD_APICID)."

>      The number of online threads is also printed in /proc/cpuinfo "siblings."
>  
> +  - topology_cluster_cpumask():
> +
> +    The cpumask contains all online threads in the cluster to which a thread
> +    belongs.
> +

Looks OK.

>      The physical package ID to which a thread belongs.
>  
> +  - topology_cluster_id();
> +
> +    The ID of the cluster to which a thread belongs.
> +

Looks OK.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

