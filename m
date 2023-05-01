Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5CE6F2BF1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 04:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjEACJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 22:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjEACJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 22:09:48 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93607E48;
        Sun, 30 Apr 2023 19:09:47 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b733fd00bso1474742b3a.0;
        Sun, 30 Apr 2023 19:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682906987; x=1685498987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Eyk0PLYhUbjWE4n42jdym7EnheKNlKKYg75uVcYf1E=;
        b=ej2DORolgq6APTgaWGF1rTxecNFSAGY5zNWHqwVAspQ+BEOHZDJl9TcpsOppeV1lAq
         0NUUH7Q+8cV6fMf4exeSQFzbHTefqWRHGfI4I3pS5D5G1B+eAW3KHLMnTY8bRBiH2ksU
         ICcFD4USx3vGd6v3ZKhIPPB1hbPTuyYL0JGin8RwiDqupEd/m0INjonmUH8Udg4KZdmM
         7GNUjQTo614dgYHJyj7Ir67CVRNezwK/NGzh/FdvrLHIkGf/o7N7v28oCEBTDI1Gsqti
         KaWgnbSf6nc1iaFsCd9ZiEB+Mr7zxsQw/xKFyAD/kGm9m+6fhsyENX8wl97fnsCOVCGP
         P3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682906987; x=1685498987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Eyk0PLYhUbjWE4n42jdym7EnheKNlKKYg75uVcYf1E=;
        b=AtDjeH8ceShkKC1dZoYIwHmP5kqnmT0OenPx1M4s78omQeojXH01SLcWT5IeoZJObj
         vo6DiSCCslkpXL2ET4i5JZV6gV8HoO1liYVigu5ZCYjxUoUfiayCA/80GqHUv6FsELJf
         ntsIb1lnI4jidtQky57PQFj1+z9HZESP96KY3FbEHQag7HNKWfBuvC+w1KW+Pxc4YyIK
         9pzrStj7Aglh0rZu4Iz/tz/TmsvA12ZvpMCdM2/iGPy0TtG3u2j04rmIK2JFB4sKWtsA
         0DdAsOl70u5YeyJeSs2t8btXn/sLgV+vACn4a60EbjGriGQLDTJe6LJeJH/zuZ5JbO9O
         Ezfw==
X-Gm-Message-State: AC+VfDwrLO+Iv6Lz8T8WV44vty6rEB9AgKFrlZQ07fIJT3xdT9hXnKYF
        Q9EPxTk/7nOSOytITy1Z1QU=
X-Google-Smtp-Source: ACHHUZ69nIYLcyx16E+QD4v/GxJx1YWnJb6Yvw3BH6GzJZBaGWcw5IirZSSt9zK4kdUWwtnp2goVqg==
X-Received: by 2002:a05:6a20:7f97:b0:f3:67da:9db5 with SMTP id d23-20020a056a207f9700b000f367da9db5mr16782949pzj.38.1682906986948;
        Sun, 30 Apr 2023 19:09:46 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-13.three.co.id. [180.214.232.13])
        by smtp.gmail.com with ESMTPSA id w132-20020a62828a000000b00639eb4480f3sm18879586pfd.76.2023.04.30.19.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Apr 2023 19:09:46 -0700 (PDT)
Message-ID: <87275ef5-11bd-0574-5178-ad6119f3fa33@gmail.com>
Date:   Mon, 1 May 2023 09:09:38 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4/4] riscv: Enable perf counters user access only through
 perf
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230413161725.195417-1-alexghiti@rivosinc.com>
 <20230413161725.195417-5-alexghiti@rivosinc.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230413161725.195417-5-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/23 23:17, Alexandre Ghiti wrote:
> +The default value is 2, it enables the legacy mode, that is user space has
> +direct access to cycle, time and insret CSRs only.
>  

"The default value is 2, which enables legacy mode (user space has direct
access to cycle, time, and insret CSRs only)."

-- 
An old man doll... just what I always wanted! - Clara

