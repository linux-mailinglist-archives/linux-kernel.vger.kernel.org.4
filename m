Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2629B6DC224
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 02:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjDJAQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 20:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDJAQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 20:16:36 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FF1270F;
        Sun,  9 Apr 2023 17:16:35 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id w13so22910932oik.2;
        Sun, 09 Apr 2023 17:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681085794;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4+fisEuyz2gfHLt3JYIWPhs8SsTmY/+pkrWOFqxJ7Vo=;
        b=OHEa/HVSjeJeD1tyVDbghFF+22wjXiFb2KRwBTHx4d8Qf/q9H7k0lTqulaTHQxjZFA
         kwMTysODgFI9g7wmI3DkS+0QGUA6eiwRAwHTfI9hT0hCDaON8ujXCcs9frjBln4T5KJ9
         j6be/PejSUTxbMHOaX0mUhgoxxobzNHTbeL4UV6ST7+Fwi/FaUpcPnNbLCSMQ6+1ILpO
         WUv12yi456tK175eIDmhqVAnFKoFOHt1+hu3jEY4hk4uy3KbPa5jtV1Fem5MQlQV/rlJ
         nM7gNm6e3GROZ987lyhCJN8v6Dld42lwZtyliZDtvGJbbQoczniX2DzyRab4DncRu0Iz
         eyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681085794;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4+fisEuyz2gfHLt3JYIWPhs8SsTmY/+pkrWOFqxJ7Vo=;
        b=vZrbCGQIcXH3tEJYwUwTtB9txb2IW8V8WrWwhwLgiDsg3TLUf/3cl/YvpnTyvU6Ws4
         yMYJSbWWcrWWIi7w4CQV38r2SAaXMiVvQx3BKnW3xlq4cGJELCawB6iLiS3bR7suwHnc
         zmTdWWO8tQ3Iv2NWGSYSGyLTYTRfhUNcjHspmOQ58F/I3A5MmqrOMWCbQd/q1N6ECo9L
         8nZpGeYTvOWTr58la/tvRUKqTXfkIYVm5OPe+90YUkbz35SQDkfmmt1fQNE3aNK9/iAt
         cekzPzC/swalSBJqphFVZRVvwuM+WH8OVyQ7qDaU4je3ln300rO3nB0+hq8sjNoSgPYX
         heOg==
X-Gm-Message-State: AAQBX9eDVV4ZqIgbFWWISz7dRoRRFrKvq3o4Ns1Da7T0AHg0/iuHTaTi
        +LrvnS+d0ZxY2seQlBaub8D8cuFUp44=
X-Google-Smtp-Source: AKy350bhj/m6K0FfZ8nZnci3FhzBXIPsVdyMYR3Z9YzByKigzTBswZhPYfy+EovZIqXZT2vITCDrPA==
X-Received: by 2002:a05:6808:657:b0:387:4991:46de with SMTP id z23-20020a056808065700b00387499146demr3720533oih.47.1681085793959;
        Sun, 09 Apr 2023 17:16:33 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id o2-20020a0568080bc200b0038413a012dasm3856409oik.4.2023.04.09.17.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 17:16:33 -0700 (PDT)
Message-ID: <6ef506d0-e7d5-e812-ad31-1716507dc9b9@gmail.com>
Date:   Sun, 9 Apr 2023 21:16:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] scripts: read cfgs from Makefile for rust-analyzer
Content-Language: en-US
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
References: <20230223025924.526200-1-yakoyoku@gmail.com>
In-Reply-To: <20230223025924.526200-1-yakoyoku@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/23 23:59, Martin Rodriguez Reboredo wrote:
> Both `core` and `alloc` had their `cfgs` missing in `rust-project.json`,
> to remedy this `generate_rust_analyzer.py` scans the Makefile from
> inside the `rust` directory for them to be added to a dictionary that
> each key corresponds to a crate and each value, to an array of `cfgs`.
> 
> Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> ---
>  scripts/generate_rust_analyzer.py | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
> index ecc7ea9a4dcf..8bfadd688ebc 100755
> --- a/scripts/generate_rust_analyzer.py
> +++ b/scripts/generate_rust_analyzer.py
> @@ -9,6 +9,24 @@ import logging
>  import pathlib
>  import sys
>  
> +def makefile_crate_cfgs(makefile):
> +    # Get configurations from a Makefile.
> +    cfgs = {}
> +    with open(makefile) as fd:
> +        for line in fd:
> +            if line.endswith("-cfgs = \\\n"):
> +                crate = line.replace("-cfgs = \\\n", "")
> +                cfg = []
> +                for l in map(lambda l: l.strip(), fd):
> +                    if not l:
> +                        cfgs[crate] = cfg
> +                        break
> +                    l = l.replace("--cfg ", "")
> +                    l = l.replace(" \\", "")
> +                    cfg.append(l)
> +
> +    return cfgs
> +
>  def generate_crates(srctree, objtree, sysroot_src):
>      # Generate the configuration list.
>      cfg = []
> @@ -24,6 +42,8 @@ def generate_crates(srctree, objtree, sysroot_src):
>      crates = []
>      crates_indexes = {}
>  
> +    makefile_cfgs = makefile_crate_cfgs(srctree / "rust" / "Makefile")
> +
>      def append_crate(display_name, root_module, deps, cfg=[], is_workspace_member=True, is_proc_macro=False):
>          crates_indexes[display_name] = len(crates)
>          crates.append({
> @@ -44,6 +64,7 @@ def generate_crates(srctree, objtree, sysroot_src):
>          "core",
>          sysroot_src / "core" / "src" / "lib.rs",
>          [],
> +        cfg=makefile_cfgs.get("core", []),
>          is_workspace_member=False,
>      )
>  
> @@ -57,6 +78,7 @@ def generate_crates(srctree, objtree, sysroot_src):
>          "alloc",
>          srctree / "rust" / "alloc" / "lib.rs",
>          ["core", "compiler_builtins"],
> +        cfg=makefile_cfgs.get("alloc", []),
>      )
>  
>      append_crate(

Bump, I think this can fit into rust-fixes for 6.3.
